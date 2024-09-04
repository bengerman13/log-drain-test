# log drain test

## what's it for

This is for testing a theory about log drains reflecting to themselves.
We think it's possible that binding a log drain service to the app that backs it
may cause logging about logging, which in turn causes logging about loggging about logging, etc.
This is specifically interesting because of router logs - if this were just app logs
we could turn off logging on the app, but router logs are always on, logging exactly once per
request.

### how's it work

The app simply listens for logs, and stores the last ten messages in memory*.
To run our tests we:

1. Create a test space
1. Push the this app to the test space
1. Create a public route for the app
1. Create the drain
1. Bind the drain to the app
1. Observe the log levels
1. (maybe) poke the app a little to see if the feedback loop needs to be primed

All of this, except the last step, can be handled by the script `deploy-test.sh`.

### results

Pushing this app resulted in relatively normal log levels, until we bound the log drain service to it.
Once the drain was bound, the log level shot up, shipping thousands of logs per minute.
