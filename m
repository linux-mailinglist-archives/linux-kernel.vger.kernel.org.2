Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4D369998
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbhDWS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243621AbhDWS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:28:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d6so18816671qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOlQRp0qgwf6RMZEC/yrU2CkmTY+BN9ZQhLJ2Xhghl0=;
        b=CPLx6Ai0oMGFSSTLSBBKRbMXMFUM2RW5VmGAkiTfC0P6ACsEebX3IdLNXpJn4Em46Q
         QFGClVLEfgnOZpRO2NeqNHYIKIePQAdCcuRGSJ72vZ1VxKrL3W0d2VzcP8DPO8QRc6DF
         0tiHegx2tsJ9lx490en5dMgrQjTCSzblpx9Pv5VX+9W5/OlfNwA7kiWYcRmjKu8bmmf+
         zadEKYNL2kfogVOWkqkkfOMYEKBkxPov7/U6pAYW8T2S8RuT6HuQxaDO5re8BvV7JfZW
         GvL7pwOhZceug1H7kvG6Th5NUbgrXxud987BgrRkM4uuxnjojbAeTZpc+abWQILp1pGX
         Wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eOlQRp0qgwf6RMZEC/yrU2CkmTY+BN9ZQhLJ2Xhghl0=;
        b=pCW7VT/K3Fb5iFUP8UJhY5iznHgR2Tp+nb1qcJV6V73/Yf/G90HfLXKrfwej+3XvOJ
         yC8bb2yP1+KbgSdNoorGuzutyCUtN65HdUc5lb6EhoyqunaSsLXx9laBzc/DsQRq92W8
         7aDcswJOR2mfGjRlbEjFOzbOlQ0Hd7rQYVKCGTRlM06T9XvvcgxMQkh5IdngNdUsQMIr
         NUJjpr3UFmfrPxqgvN/BTA91hz10yS7oBFD1Tzfw1oGe9DLT8mr/c+LrXcVc7w+6QMCJ
         mzmdJp/TY11+0PU5u8TiIto+Z4i8lEFDK8VzsFyiPFzwWsL1F8qqfICthffBEnQzAZmu
         0DYQ==
X-Gm-Message-State: AOAM533AodG3mmv+sgX3LB1u7rSwq+DFFwFRTZuYKBvMlUh39vbmY4B4
        ME3Wu5q0o2/8WYOyr1NSTAA=
X-Google-Smtp-Source: ABdhPJzPNv9KsEsr/wp7zra7MDMR8hACA6rGRNSJfwiMLe9tPELDQT/SCazG7KIYXmLNDa6zprSKPQ==
X-Received: by 2002:a05:622a:188:: with SMTP id s8mr5092845qtw.42.1619202502261;
        Fri, 23 Apr 2021 11:28:22 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:21 -0700 (PDT)
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
Subject: [PATCH 4/5] perf report: Add --skip-empty option to suppress 0 event stat
Date:   Fri, 23 Apr 2021 11:28:12 -0700
Message-Id: <20210423182813.1472902-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the output more readable, I think it's better to remove 0's in
the output.  Also the dummy event has no event stats so it just wasts
the space.  Let's use the --skip-empty option to suppress it.

  $ perf report --stat --skip-empty

  Aggregated stats:
             TOTAL events:      16530
              MMAP events:        226
              COMM events:       1596
              EXIT events:          2
          THROTTLE events:        121
        UNTHROTTLE events:        117
              FORK events:       1595
            SAMPLE events:        719
             MMAP2 events:      12147
            CGROUP events:          2
    FINISHED_ROUND events:          2
        THREAD_MAP events:          1
           CPU_MAP events:          1
         TIME_CONV events:          1
  cycles stats:
            SAMPLE events:        719

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  3 +++
 tools/perf/builtin-annotate.c            |  4 ++--
 tools/perf/builtin-report.c              | 16 ++++++++++++----
 tools/perf/ui/stdio/hist.c               |  5 ++++-
 tools/perf/util/events_stats.h           |  3 ++-
 tools/perf/util/hist.c                   |  6 +++++-
 tools/perf/util/hist.h                   |  3 ++-
 tools/perf/util/session.c                |  5 +++--
 tools/perf/util/session.h                |  3 ++-
 9 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f51f0000676e..24efc0583c93 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -571,6 +571,9 @@ include::itrace.txt[]
 			    sampled cycles
 	'Avg Cycles'      - block average sampled cycles
 
+--skip-empty::
+	Do not print 0 results in the --stat output.
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 717efd78eee6..49627a7bed7c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -404,8 +404,8 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		goto out;
 
 	if (dump_trace) {
-		perf_session__fprintf_nr_events(session, stdout);
-		evlist__fprintf_nr_events(session->evlist, stdout);
+		perf_session__fprintf_nr_events(session, stdout, false);
+		evlist__fprintf_nr_events(session->evlist, stdout, false);
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index be56f3efa413..4910194acaa6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -85,6 +85,7 @@ struct report {
 	bool			group_set;
 	bool			stitch_lbr;
 	bool			disable_order;
+	bool			skip_empty;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -530,6 +531,9 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 			continue;
 
+		if (rep->skip_empty && !hists->stats.nr_samples)
+			continue;
+
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 
 		if (rep->total_cycles_mode) {
@@ -731,8 +735,8 @@ static int stats_print(struct report *rep)
 {
 	struct perf_session *session = rep->session;
 
-	perf_session__fprintf_nr_events(session, stdout);
-	perf_evlist__fprintf_nr_events(session->evlist, stdout);
+	perf_session__fprintf_nr_events(session, stdout, rep->skip_empty);
+	evlist__fprintf_nr_events(session->evlist, stdout, rep->skip_empty);
 	return 0;
 }
 
@@ -944,8 +948,10 @@ static int __cmd_report(struct report *rep)
 			perf_session__fprintf_dsos(session, stdout);
 
 		if (dump_trace) {
-			perf_session__fprintf_nr_events(session, stdout);
-			evlist__fprintf_nr_events(session->evlist, stdout);
+			perf_session__fprintf_nr_events(session, stdout,
+							rep->skip_empty);
+			evlist__fprintf_nr_events(session->evlist, stdout,
+						  rep->skip_empty);
 			return 0;
 		}
 	}
@@ -1313,6 +1319,8 @@ int cmd_report(int argc, const char **argv)
 		    "Sort all blocks by 'Sampled Cycles%'"),
 	OPT_BOOLEAN(0, "disable-order", &report.disable_order,
 		    "Disable raw trace ordering"),
+	OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
+		    "Do not display empty (or dummy) events in the output"),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 2ab2af4d4849..d9e634406175 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -897,7 +897,8 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 	return ret;
 }
 
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
+			     bool skip_empty)
 {
 	int i;
 	size_t ret = 0;
@@ -908,6 +909,8 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
 		name = perf_event__name(i);
 		if (!strcmp(name, "UNKNOWN"))
 			continue;
+		if (skip_empty && !stats->nr_events[i])
+			continue;
 
 		ret += fprintf(fp, "%16s events: %10d\n", name, stats->nr_events[i]);
 	}
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index e271c8004c89..3480bafd414b 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -50,6 +50,7 @@ struct hists_stats {
 
 void events_stats__inc(struct events_stats *stats, u32 type);
 
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
+			     bool skip_empty);
 
 #endif /* __PERF_EVENTS_STATS_ */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 691a6a777d14..65fe65ba03c2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,7 +2676,8 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 	}
 }
 
-size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
+size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
+				 bool skip_empty)
 {
 	struct evsel *pos;
 	size_t ret = 0;
@@ -2684,6 +2685,9 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		if (skip_empty && !hists->stats.nr_samples)
+			continue;
+
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
 		ret += fprintf(fp, "%16s events: %10d\n",
 			       "SAMPLE", hists->stats.nr_samples);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6b0f708f08ac..5343b62476e6 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -202,7 +202,8 @@ void hists__inc_nr_samples(struct hists *hists, bool filtered);
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
 		      bool ignore_callchains);
-size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp);
+size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
+				 bool skip_empty);
 
 void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index eba3769be3f1..a6659b616e6d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2352,7 +2352,8 @@ size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp
 	return machines__fprintf_dsos_buildid(&session->machines, fp, skip, parm);
 }
 
-size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
+size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
+				       bool skip_empty)
 {
 	size_t ret;
 	const char *msg = "";
@@ -2362,7 +2363,7 @@ size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
 
 	ret = fprintf(fp, "\nAggregated stats:%s\n", msg);
 
-	ret += events_stats__fprintf(&session->evlist->stats, fp);
+	ret += events_stats__fprintf(&session->evlist->stats, fp, skip_empty);
 	return ret;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index f76480166d38..e31ba4c92a6c 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -113,7 +113,8 @@ size_t perf_session__fprintf_dsos(struct perf_session *session, FILE *fp);
 size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp,
 					  bool (fn)(struct dso *dso, int parm), int parm);
 
-size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp);
+size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
+				       bool skip_empty);
 
 struct evsel *perf_session__find_first_evtype(struct perf_session *session,
 					    unsigned int type);
-- 
2.31.1.498.g6c1eba8ee3d-goog

