Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6D1369996
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbhDWS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbhDWS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:28:56 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3738C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:19 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i9so24062128qvo.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZNjSckzBLVjPdchtgkusZGzCkpQXt7DqycrH5eThYA=;
        b=cGxbYn0jzqbgo3liLH+LhKVEO/UawUSkgNHpUKVoVwOKg4J9WZQDVuT9Fz4HiLzn0k
         paSYeNvGrQVdT05hPVjJHBegZDZwh8shgiyUej9M1aPcfVsP9RJ8I9MPFkDJFpie6VFn
         EycgznJpvBFFR++Q3z7kBb0vjYrrndQQhUr/qKxWx36Mw4q37SQ9jzSnodQ5h/di70gA
         ZyEeJjPN7OjyEgVS17gbuLhv/sIJN9uSooUzg2spX/TcROHu/okbhVyRL7HyJk21Djbj
         0v8hDKt/K958DTb5BKlJANGEhTuUeDPjyw70pCiXEY7qwKxYmlM3xyra4F9ZlPjjHCFj
         UYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xZNjSckzBLVjPdchtgkusZGzCkpQXt7DqycrH5eThYA=;
        b=RFna4wdGYuJqvPdyv21xtFS9FmYq0dqRi62WPY5pQWMsl8jSkIKf6ywoBNhT1OSetm
         RDQuP24ELZyHCueduovZJrHJVJaDbJlF3CqpGgqrqSa4GGa4rUIIePBLmwQRFjCmw7qp
         mol28vOGWBbWjuJzszeVZkEjqyVdTSXBJUmNetBQKmvCfd7r3C0ZTTAnQcs0V4UiSVTB
         JhiEfUImRveMlyI4xguHnoBOcuSyqP28mIZU83X7WIw2achRwRSJ2k9GnufZx9H+goeq
         cZ/EX6kgDshTqz2rkOvFu0KdnsW/FpFUoi/05edwK0qkno6xfNfSjsfC+v21CPHA2QdC
         MmTw==
X-Gm-Message-State: AOAM532jrE2Bn4BkDXHr6OglloZmHxmm3FOheKjDn1ywBi6xOdae8BXb
        1IDZE7MgKFFS+HmcsIRBjFk=
X-Google-Smtp-Source: ABdhPJxReZ3KQ3GCiZP5surlT49XOSKqmu/Ja1IdCKJvQQRBSmkoXbIo5ossgByRXQi4+De5zkyedA==
X-Received: by 2002:ad4:4e01:: with SMTP id dl1mr5711048qvb.9.1619202499261;
        Fri, 23 Apr 2021 11:28:19 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:18 -0700 (PDT)
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
Subject: [PATCH 2/5] perf hists: Split hists_stats from events_stats
Date:   Fri, 23 Apr 2021 11:28:10 -0700
Message-Id: <20210423182813.1472902-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
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
 tools/perf/util/events_stats.h  | 10 +++++++---
 tools/perf/util/hist.c          | 20 ++++++++++++++------
 tools/perf/util/hist.h          |  4 ++--
 6 files changed, 33 insertions(+), 21 deletions(-)

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
2.31.1.498.g6c1eba8ee3d-goog

