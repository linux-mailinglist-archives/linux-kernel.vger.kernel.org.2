Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DE36BCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbhD0BiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhD0BiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C454C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q136so37618978qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McqY80Z+s7Fc8tAuXhHzUSG+PRbMAxWTjhOQENdMp/U=;
        b=dp6NfBKT/OrUDBSpwp7uSvToCyREOSdodRFM9mPR6zDgSV46JBte5isY79rEpHyhD5
         O7/lkwy9Nz3V3DIra4Qth4JHJy1Itlp0WpJ1klunuLiEh2WLVnNacBh9vl4Q6+W0ei8l
         3q1LPpkdr2EPeyuJqG5r5+PNI1y1CgTnlvnNsapHnG59YCb/DGlVTIY3QWp6fvrxoexd
         7asaGmrLmFYkiICajr+drdq/O5hMI5DR0yKxP2pwGOa8tdFcsHsbqhGliqUtduMSbs4R
         Lf7pKgNm157ICiBE3diSr3CYGTCIMN0HqgnYcSEUIxYxnsnD4w5nWtdwRHcw2NrRtkW9
         9nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=McqY80Z+s7Fc8tAuXhHzUSG+PRbMAxWTjhOQENdMp/U=;
        b=VMG54R8ojhBBZ2HPLzsrAkzkV+NDJWDwey8ltv0FjOmtJZRerDlJtY5A3p9+AV/D2e
         vZ55QNNjM1Rcaoi2qfRal9wVPpAuB6E8cMyxS1Cy1uqWNAQnUsuX0iZTJFLljswBq1oK
         EqsvmMfbou3Bc5KkUtnrLW5csLjC5P1XzFJGChoJgqXokO/M9p2LMQPa3ukHsGlooOyg
         GQZ7n+pckRY+W7EjQxcKpSqKnYRMZObKl//M6pPm85DxIQaovZQzZyM5rMJSVypd497/
         SCR99LVkPvjtRY3Y9RqZI97PPdgwqhYwcs2S3BabvKFpjg3faq/pXBW0R7EDQ/aCrff/
         GpRw==
X-Gm-Message-State: AOAM530yzGFPuCt+WssQbjkA87cMO5vr3GAcE6yTSCYOaEyY63vbcnpw
        jSp5aMQa2Bn4Jy8tbsLpIas8hXalvzkgxSM/
X-Google-Smtp-Source: ABdhPJxgiT/uODz+KdeohqnX6xSFG/R7x6SNojKot6Apejq842YI2Ia/VZFsJlyr3bDe6zx+O7aH3w==
X-Received: by 2002:ae9:e417:: with SMTP id q23mr18513356qkc.248.1619487444552;
        Mon, 26 Apr 2021 18:37:24 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/6] perf hists: Split hists_stats from events_stats
Date:   Mon, 26 Apr 2021 18:37:13 -0700
Message-Id: <20210427013717.1651674-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each struct hists have events_stats but most of the fields were not
used.  It's to count number of samples and periods whether filtered or
not.  And other fields are used only by evlist.

So it'd be better to split hists_stats and events_stats to reduce
wasted memory in the struct hists.  This makes the output of event
statistics in the perf report compact by skipping 0 events in each
evsel/hists.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c   |  2 +-
 tools/perf/builtin-report.c     |  4 ++--
 tools/perf/tests/hists_filter.c | 14 +++++++-------
 tools/perf/ui/browsers/hists.c  | 17 +++++++++--------
 tools/perf/util/events_stats.h  | 10 +++++++---
 tools/perf/util/hist.c          | 20 ++++++++++++++------
 tools/perf/util/hist.h          |  4 ++--
 7 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 524e6f0dff22..717efd78eee6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -418,7 +418,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	total_nr_samples = 0;
 	evlist__for_each_entry(session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		u32 nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+		u32 nr_samples = hists->stats.nr_samples;
 
 		if (nr_samples > 0) {
 			total_nr_samples += nr_samples;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0d65c98794a8..b0b9b60f74e5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -436,7 +436,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 {
 	size_t ret;
 	char unit;
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	unsigned long nr_samples = hists->stats.nr_samples;
 	u64 nr_events = hists->stats.total_period;
 	struct evsel *evsel = hists_to_evsel(hists);
 	char buf[512];
@@ -464,7 +464,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 				nr_samples += pos_hists->stats.nr_non_filtered_samples;
 				nr_events += pos_hists->stats.total_non_filtered_period;
 			} else {
-				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
+				nr_samples += pos_hists->stats.nr_samples;
 				nr_events += pos_hists->stats.total_period;
 			}
 		}
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 123e07d35b55..ca6120cd1d90 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -150,13 +150,13 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 		}
 
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
 				hists->stats.total_period == 1000);
 		TEST_ASSERT_VAL("Unmatched nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] ==
+				hists->stats.nr_samples ==
 				hists->stats.nr_non_filtered_samples);
 		TEST_ASSERT_VAL("Unmatched nr hist entries",
 				hists->nr_entries == hists->nr_non_filtered_entries);
@@ -175,7 +175,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* normal stats should be invariant */
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
@@ -204,7 +204,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* normal stats should be invariant */
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
@@ -239,7 +239,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* normal stats should be invariant */
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
@@ -268,7 +268,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* normal stats should be invariant */
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
@@ -299,7 +299,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* normal stats should be invariant */
 		TEST_ASSERT_VAL("Invalid nr samples",
-				hists->stats.nr_events[PERF_RECORD_SAMPLE] == 10);
+				hists->stats.nr_samples == 10);
 		TEST_ASSERT_VAL("Invalid nr hist entries",
 				hists->nr_entries == 9);
 		TEST_ASSERT_VAL("Invalid total period",
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index bcfd0a45953b..b72ee6822222 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -682,6 +682,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 	switch (key) {
 	case K_TIMER: {
 		struct hist_browser_timer *hbt = browser->hbt;
+		struct evsel *evsel = hists_to_evsel(browser->hists);
 		u64 nr_entries;
 
 		WARN_ON_ONCE(!hbt);
@@ -696,10 +697,10 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		ui_browser__update_nr_entries(&browser->b, nr_entries);
 
 		if (warn_lost_event &&
-		    (browser->hists->stats.nr_lost_warned !=
-		    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
-			browser->hists->stats.nr_lost_warned =
-				browser->hists->stats.nr_events[PERF_RECORD_LOST];
+		    (evsel->evlist->stats.nr_lost_warned !=
+		     evsel->evlist->stats.nr_events[PERF_RECORD_LOST])) {
+			evsel->evlist->stats.nr_lost_warned =
+				evsel->evlist->stats.nr_events[PERF_RECORD_LOST];
 			ui_browser__warn_lost_events(&browser->b);
 		}
 
@@ -3416,7 +3417,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 	struct hists *hists = evsel__hists(evsel);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
-	unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	unsigned long nr_events = hists->stats.nr_samples;
 	const char *ev_name = evsel__name(evsel);
 	char bf[256], unit;
 	const char *warn = " ";
@@ -3432,7 +3433,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 
 		for_each_group_member(pos, evsel) {
 			struct hists *pos_hists = evsel__hists(pos);
-			nr_events += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
+			nr_events += pos_hists->stats.nr_samples;
 		}
 	}
 
@@ -3441,7 +3442,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 			   unit, unit == ' ' ? "" : " ", ev_name);
 	ui_browser__printf(browser, "%s", bf);
 
-	nr_events = hists->stats.nr_events[PERF_RECORD_LOST];
+	nr_events = evsel->evlist->stats.nr_events[PERF_RECORD_LOST];
 	if (nr_events != 0) {
 		menu->lost_events = true;
 		if (!current_entry)
@@ -3647,7 +3648,7 @@ static int block_hists_browser__title(struct hist_browser *browser, char *bf,
 {
 	struct hists *hists = evsel__hists(browser->block_evsel);
 	const char *evname = evsel__name(browser->block_evsel);
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	unsigned long nr_samples = hists->stats.nr_samples;
 	int ret;
 
 	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 631a4af2ed86..e271c8004c89 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -26,15 +26,12 @@
  * perf_record_sample.period and stash the result in total_period.
  */
 struct events_stats {
-	u64 total_period;
-	u64 total_non_filtered_period;
 	u64 total_lost;
 	u64 total_lost_samples;
 	u64 total_aux_lost;
 	u64 total_aux_partial;
 	u64 total_invalid_chains;
 	u32 nr_events[PERF_RECORD_HEADER_MAX];
-	u32 nr_non_filtered_samples;
 	u32 nr_lost_warned;
 	u32 nr_unknown_events;
 	u32 nr_invalid_chains;
@@ -44,6 +41,13 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
+struct hists_stats {
+	u64 total_period;
+	u64 total_non_filtered_period;
+	u32 nr_samples;
+	u32 nr_non_filtered_samples;
+};
+
 void events_stats__inc(struct events_stats *stats, u32 type);
 
 size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 9299ee535518..691a6a777d14 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2325,14 +2325,19 @@ void events_stats__inc(struct events_stats *stats, u32 type)
 	++stats->nr_events[type];
 }
 
-void hists__inc_nr_events(struct hists *hists, u32 type)
+static void hists_stats__inc(struct hists_stats *stats)
 {
-	events_stats__inc(&hists->stats, type);
+	++stats->nr_samples;
+}
+
+void hists__inc_nr_events(struct hists *hists)
+{
+	hists_stats__inc(&hists->stats);
 }
 
 void hists__inc_nr_samples(struct hists *hists, bool filtered)
 {
-	events_stats__inc(&hists->stats, PERF_RECORD_SAMPLE);
+	hists_stats__inc(&hists->stats);
 	if (!filtered)
 		hists->stats.nr_non_filtered_samples++;
 }
@@ -2677,8 +2682,11 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 	size_t ret = 0;
 
 	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
-		ret += events_stats__fprintf(&evsel__hists(pos)->stats, fp);
+		ret += fprintf(fp, "%16s events: %10d\n",
+			       "SAMPLE", hists->stats.nr_samples);
 	}
 
 	return ret;
@@ -2698,7 +2706,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	const struct dso *dso = hists->dso_filter;
 	struct thread *thread = hists->thread_filter;
 	int socket_id = hists->socket_filter;
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	unsigned long nr_samples = hists->stats.nr_samples;
 	u64 nr_events = hists->stats.total_period;
 	struct evsel *evsel = hists_to_evsel(hists);
 	const char *ev_name = evsel__name(evsel);
@@ -2725,7 +2733,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 				nr_samples += pos_hists->stats.nr_non_filtered_samples;
 				nr_events += pos_hists->stats.total_non_filtered_period;
 			} else {
-				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
+				nr_samples += pos_hists->stats.nr_samples;
 				nr_events += pos_hists->stats.total_period;
 			}
 		}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index e2faa745c8d6..6b0f708f08ac 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -96,7 +96,7 @@ struct hists {
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
 	pthread_mutex_t		lock;
-	struct events_stats	stats;
+	struct hists_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
 	bool			has_callchains;
@@ -196,7 +196,7 @@ struct hist_entry *hists__get_entry(struct hists *hists, int idx);
 u64 hists__total_period(struct hists *hists);
 void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
-void hists__inc_nr_events(struct hists *hists, u32 type);
+void hists__inc_nr_events(struct hists *hists);
 void hists__inc_nr_samples(struct hists *hists, bool filtered);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
-- 
2.31.1.527.g47e6f16901-goog

