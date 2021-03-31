provider "aws" {
  access_key = "XXXXXXXXX"
  secret_key = "XXXXXXXXX"
  region          = var.aws_region
}

resource "aws_lambda_permission" "logging" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.logging.function_name
  principal     = "logs.us-east-1.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.default.arn}:*"
}

resource "aws_cloudwatch_log_group" "default" {
  name = "/default"
}

resource "aws_cloudwatch_log_subscription_filter" "logging" {
  depends_on      = [aws_lambda_permission.logging]
  destination_arn = aws_lambda_function.logging.arn
  filter_pattern  = ""
  log_group_name  = aws_cloudwatch_log_group.default.name
  name            = "logging_default"
}

resource "aws_lambda_function" "logging" {
  filename      = "lambda_function.zip"
  function_name = "CloudLabFunction"
  handler       = "greet_lambda.lambda_handler"
  role          = aws_iam_role.default.arn
  runtime       = "python2.7"
}

resource "aws_iam_role" "default" {
  name = "iam_for_CloudLabFunction"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


data "archive_file" "lambda_zip" {
    type          = "zip" 
    source_file   = "greet_lambda.py"
    output_path   = "lambda_function.zip"
}



