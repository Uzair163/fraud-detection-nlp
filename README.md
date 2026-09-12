# fraud-detection-nlp
# Detecting Fraudulent Job Postings Using Machine Learning and Text Mining

MSc Business Analytics dissertation, Queen's Business School (2024). An independent
research project that builds an NLP-based classifier to flag fraudulent job
advertisements, motivated by the real financial and reputational harm counterfeit job
posts cause to job seekers and platforms.

**Portfolio angle:** Education/Academic-Research — Data Analyst. Full independent research
lifecycle, from literature review to a validated model and a written research report.

## Problem

Fraudulent job postings are hard to spot manually at scale. The project asks whether
text and metadata features from a job listing can reliably predict whether it's genuine
or fraudulent, and which features matter most.

## Approach

- Literature review on counterfeit job advertisement detection and existing ML approaches
- Text pre-processing and feature engineering on job posting text (NLP)
- Supervised classification, trained and evaluated against held-out data
- Full write-up as a proposal, technical report and final 7,800-word research report

## Tools

Python, NLP libraries, Jupyter/R for supporting analysis, Excel for processed data review

## Files in this repo

- `report/Research-Report.pdf` — final dissertation write-up
- `report/Dissertation-Proposal.pdf` — the original project proposal
- `report/Technical-Report.pdf` — technical methodology report
- `code/` — analysis code
- `data/processed_data_sample.xlsx` — a trimmed sample of the processed dataset (see note)

## A note on the data

The full processed dataset and raw dataset were large coursework files; this repo includes
a representative sample so the code is runnable and the data shape is clear, rather than
the full multi-hundred-thousand-row files.

## Reproducing this

```bash
pip install -r requirements.txt
jupyter notebook code/
```
