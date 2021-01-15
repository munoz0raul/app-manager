import subprocess

from flask import Flask, render_template, redirect

app = Flask(__name__)

@app.route('/jobs', methods=['POST', 'GET'])
def jobs():
    return render_template('jobs.html')

@app.route('/start/<string:app>', methods=['GET', 'POST'])
def start(app):
    command = "/xpto/command %s" % (app)
    subprocess.call(command, shell=True)
    print(command)
    return redirect('/jobs')

@app.route('/stop/<string:app>', methods=['GET', 'POST'])
def stop(app):
    command = "/xpto/command %s" % (app)
    subprocess.call(command, shell=True)
    subprocess.call(["ls", "-lha"])
    
    print(command)
    return redirect('/jobs')


if __name__  == "__main__":
    app.run(debug=True)
