Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF23B094E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhFVPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232249AbhFVPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsA7hDSzNcMvvvAr6xCcsRvxUTZ2TarX/PiYBQ/6EyQ=;
        b=YLhZvzaP3XrLZwqgacyv9POspk66aQ0NJqROgnPWVK1tDn99o0vfNnp0wDmqMIiLMYcLln
        FFzgf+N0XitypJkRMrSZcmPmSWBP93VEF6gcULs74ZJWV6pb2sh/byktjxOA2ObFmV8rsg
        XA6TWTVfPy2jk8EwtIwr/dOVIetGFLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-tW8f5I46OzC-roBCEWcdjw-1; Tue, 22 Jun 2021 11:39:37 -0400
X-MC-Unique: tW8f5I46OzC-roBCEWcdjw-1
Received: by mail-wr1-f70.google.com with SMTP id l13-20020adfe9cd0000b0290119a0645c8fso9904416wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsA7hDSzNcMvvvAr6xCcsRvxUTZ2TarX/PiYBQ/6EyQ=;
        b=hpEmjPbPp1AORxk0kIAaULY33FGjidudKjrZUjWb1zstO8PO1hZKYncKmY9CCdp6AY
         Clt7xnFoS/Ek/9irtdQsd5dKT6AC7mKSptspehT/sK90XbXNrxi14zkdNzdqxAEMcJZc
         IRYJREhphrXXc9t+jL+l1HemcZB+C6JJgf4VFwcKDGqyslfBoYa5GgoSmJ2B5JHu+QDI
         MTcmhLU8c6eI24H3PEI4JU8UFHO2hkg3+P6ywQwj1o+M7fIjNogGJLNsvfYcFNo6AFoj
         eafqOOGgerTm/A6w/EbI2rKN6ppBsRszBvXsF/foxwWpXO5lqsnb38QE9JgJVoGqaihA
         MkBg==
X-Gm-Message-State: AOAM5329MDlXlCJx5zRRfIs68OhHPz8Kss/k2ZDjka4v50xn3Tj7M2FI
        4TIOq1/1335SRYs2IH0iGzQTP7RJryV9l63J2f2uRlzDVDn9Qv6qliT6KdZMbF4h0FLls1iNMKv
        5Z94OIif5lqBPVET5kJD5kSys
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr5504626wrw.211.1624376376378;
        Tue, 22 Jun 2021 08:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL0Ewmm//MYrek9vcehh9j0M0F2Ht2VRQkDNpdh4NRkn3QToJ5rNXpTjRfIZYJBkAIxy9TDw==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr5504600wrw.211.1624376376163;
        Tue, 22 Jun 2021 08:39:36 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:35 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 07/10] perf record: Add support to read build id fails
Date:   Tue, 22 Jun 2021 17:39:15 +0200
Message-Id: <20210622153918.688500-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to read build id fails and lost events count
and display it at the end of the record session, when recording
with --buildid-mmap.

  # perf record ...
  ...
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Failed to parse 4 build ids]
  [ perf record: Captured and wrote 0.008 MB perf.data ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evsel.c                    |  6 ++
 tools/lib/perf/include/perf/evsel.h       | 11 ++-
 tools/perf/builtin-record.c               | 90 +++++++++++++++++++++++
 tools/perf/util/evsel.c                   | 12 +++
 tools/perf/util/perf_event_attr_fprintf.c |  3 +-
 5 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 04e8386b3ed4..9d7b2fd49b90 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -248,6 +248,12 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 	if (read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (read_format & PERF_FORMAT_GROUP) {
 		nr = evsel->nr_members;
 		size += sizeof(u64);
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 60eae25076d3..294fc5929e1d 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -12,12 +12,21 @@ struct perf_thread_map;
 
 struct perf_counts_values {
 	union {
+		/* Struct for specific perf interfaces. */
 		struct {
 			uint64_t val;
 			uint64_t ena;
 			uint64_t run;
 		};
-		uint64_t values[3];
+		/*
+		 * Values to store all non-group data:
+		 *   PERF_FORMAT_TOTAL_TIME_ENABLED
+		 *   PERF_FORMAT_TOTAL_TIME_RUNNING
+		 *   PERF_FORMAT_ID
+		 *   PERF_FORMAT_BUILD_ID_FAULTS
+		 *   PERF_FORMAT_LOST
+		 */
+		uint64_t values[6];
 	};
 };
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bc3dd379eb67..bf3958ce18e3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -49,6 +49,8 @@
 #include "util/clockid.h"
 #include "util/pmu-hybrid.h"
 #include "util/evlist-hybrid.h"
+#include "util/counts.h"
+#include "util/stat.h"
 #include "asm/bug.h"
 #include "perf.h"
 
@@ -1226,6 +1228,90 @@ static void record__init_features(struct record *rec)
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
+struct session_stats {
+	u64	build_id_faults;
+	u64	lost;
+};
+
+static int
+evsel__read_session_stats(struct evsel *evsel, struct session_stats *st,
+			  int nr_cpus, int nr_threads)
+{
+	u64 read_format = evsel->core.attr.read_format;
+	int idx = 1, idx_faults = 0, idx_lost = 0;
+	int cpu, thread;
+
+	if (read_format & PERF_FORMAT_GROUP)
+		return 0;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		idx++;
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		idx++;
+	if (read_format & PERF_FORMAT_ID)
+		idx++;
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		idx_faults = idx++;
+	if (read_format & PERF_FORMAT_LOST)
+		idx_lost = idx;
+
+	if (!idx_faults && !idx_lost)
+		return 0;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		for (thread = 0; thread < nr_threads; thread++) {
+			struct perf_counts_values count;
+
+			if (perf_evsel__read(&evsel->core, cpu, thread, &count))
+				return -1;
+
+			if (idx_faults)
+				st->build_id_faults += count.values[idx_faults];
+			if (idx_lost)
+				st->lost += count.values[idx_lost];
+		}
+	}
+
+	return 0;
+}
+
+static int
+evlist__read_session_stats(struct evlist *evlist, struct session_stats *st)
+{
+	int nr_threads = perf_thread_map__nr(evlist->core.threads);
+	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
+	struct evsel *evsel;
+
+	memset(st, 0, sizeof(*st));
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__read_session_stats(evsel, st, nr_cpus, nr_threads)) {
+			pr_err("FAILED to read event stats\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static void read_session_stats(struct record *rec)
+{
+	struct session_stats st;
+
+	if (evlist__read_session_stats(rec->evlist, &st))
+		return;
+
+	if (st.build_id_faults) {
+		fprintf(stderr,	"[ perf record: Failed to parse %lu build ids]\n",
+			st.build_id_faults);
+	}
+
+	if (st.lost) {
+		fprintf(stderr,	"[ perf record: Lost %lu chunks]\n",
+			st.lost);
+	}
+}
+
 static void
 record__finish_output(struct record *rec)
 {
@@ -1244,6 +1330,10 @@ record__finish_output(struct record *rec)
 		if (rec->buildid_all)
 			dsos__hit_all(rec->session);
 	}
+
+	if (rec->buildid_mmap)
+		read_session_stats(rec);
+
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
 
 	return;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f81ac6962aec..f862cae8874f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1239,6 +1239,18 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 			PERF_FORMAT_TOTAL_TIME_RUNNING;
 	}
 
+	/*
+	 * We skip post processing for build_id, so we need
+	 * to read stats via read syscall:
+	 *   - faults for mmap events
+	 *   - lost for each event
+	 */
+	if (attr->build_id)
+		attr->read_format |= PERF_FORMAT_BUILD_ID_FAULTS;
+
+	if (opts->build_id)
+		attr->read_format |= PERF_FORMAT_LOST;
+
 	/*
 	 * XXX see the function comment above
 	 *
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 30481825515b..946073024d7a 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -64,7 +64,8 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define bit_name(n) { PERF_FORMAT_##n, #n }
 	struct bit_names bits[] = {
 		bit_name(TOTAL_TIME_ENABLED), bit_name(TOTAL_TIME_RUNNING),
-		bit_name(ID), bit_name(GROUP),
+		bit_name(ID), bit_name(GROUP), bit_name(BUILD_ID_FAULTS),
+		bit_name(LOST),
 		{ .name = NULL, }
 	};
 #undef bit_name
-- 
2.31.1

