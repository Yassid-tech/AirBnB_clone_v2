#!/usr/bin/python3
"""
starts a Flask web application
"""

from flask import Flask, render_template
from models import *
from models import storage
from flask_cors import CORS
app = Flask(__name__)
CORS(app)

@app.route('/hbnb_filters', strict_slashes=False)
def filters():
    """display a HTML page like 6-index.html from static"""
    states = storage.all("State").values()
    amenities = storage.all("Amenity").values()
    return render_template('10-hbnb_filters.html', states=states,
                           amenities=amenities)


@app.teardown_appcontext
def teardown_db(exception):
    """closes the storage on teardown"""
    storage.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000')
