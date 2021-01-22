import subprocess

from flask import Flask, render_template, redirect

app = Flask(__name__)

@app.route('/jobs', methods=['POST', 'GET'])
def jobs():
    return render_template('jobs.html')

@app.route('/start/<string:app>', methods=['GET', 'POST'])
def start(app):
    command = "/usr/share/app-manager/start.sh -a %s -f start" % (app)
    subprocess.call(command, shell=True)
    print(command)
    return redirect('/jobs')

@app.route('/stop/<string:app>', methods=['GET', 'POST'])
def stop(app):
    command = "/usr/share/app-manager/start.sh -a %s -f stop" % (app)
    subprocess.call(command, shell=True)
    print(command)
    return redirect('/jobs')

@app.route('/launch/<string:app>', methods=['GET', 'POST'])
def launch(app):
    command = "/usr/share/app-manager/start.sh -a %s -f launch" % (app)
    subprocess.call(command, shell=True)
    print(command)
    return redirect('/jobs')


if __name__  == "__main__":
    app.run(debug=True)
