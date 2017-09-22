# # encoding: utf-8

# Inspec test for recipe hms::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe user('root') do
  it { should exist }
  skip 'This is an example test, replace with your own test.'
end

describe port(8080) do
  it { should be_listening }
  skip 'This is an example test, replace with your own test.'
end
