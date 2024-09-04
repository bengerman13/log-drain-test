from collections import deque
from flask import Flask, request
from flask.logging import default_handler

app = Flask(__name__)
app.logger.removeHandler(default_handler)

# this doesn't work with gunicorn because of the worker model
# I left it in to be accurate to the state when I ran this test.
log = deque(maxlen=10)

@app.get("/")
def get_log():
    return str(log)

@app.post("/")
def put_log():
    log.append(request.get_data(as_text=True))
    return "ok"
