/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Locals configuration
 *****************************************/
locals {
  schema = "${file("${var.schema_file}")}"
}

resource "google_bigquery_dataset" "main" {
  dataset_id    = "${var.dataset_id}"
  friendly_name = "${var.dataset_name}"
  description   = "${var.description}"
  location      = "${var.location}"

  default_table_expiration_ms = "${var.expiration}"
  project                     = "${var.project_id}"
  labels                      = "${var.dataset_labels}"
}

resource "google_bigquery_table" "main" {
  dataset_id = "${google_bigquery_dataset.main.dataset_id}"
  table_id   = "${var.table_id}"
  project    = "${var.project_id}"

  time_partitioning {
    type = "${var.time_partitioning}"
  }

  labels = "${var.table_labels}"

  schema = "${local.schema}"
}
