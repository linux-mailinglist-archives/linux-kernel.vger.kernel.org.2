Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD23C7AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhGNAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhGNAhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:37:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB810C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso2444425pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8SLE9J5N4bPo1hJbSObZGGg+1IXy4PZwpLV/MrblKg=;
        b=jbkypmkufFxdsxFvAXtFbff598NEcOh1S+048BAKnAN4kziASeu4yCKmlugw8jLkli
         +RSmp9YM/IWcuOSxbH1ImeQIdtNKPVnArYzIygT9OGjjwf+3OptSFajetJmWKcyA0b31
         70aTnKkPatOHlM3uIjlMfSruM8Gx2eY9bdKqPXNDYIm4BqZJqzH3SQeZYJEzjifV8QnV
         igtWQ/4jaiOMvI0/dYu4Wujoe4AD8tPcJxer1zAazoAmoxc3X2B1iFS0PX76XSxPnw5p
         VWf69f5kTg37H7qlckLY34GOo2Gcegdtu0D2YQmmNEJo2Ht/j3nNDc4APXgYrf33ZfbZ
         7r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q8SLE9J5N4bPo1hJbSObZGGg+1IXy4PZwpLV/MrblKg=;
        b=U75nKs9WbpxCozBDSk2TJhs5LiHa10w/l+Cy044FTPW9tWOaGMWeDfOm/FfFbDDKI4
         s2PBYcOQwF/sa7RtbG5Z74guXpXLtP57ufaNO83WVyDCKi9DHSfko3ImOhsbioHoHaZS
         eEL6NA7426taHlYKPamLRvAHFdFFMOocG4rpbWoYzRNZBV0vefTP80ETRe/H/ge2SuGY
         o9tIbNO50VfciiaytfMWvp8gOdihQSd/8uts/7IBPtJmTcv6ScyGi8I9eYzguwpDUve2
         y9or8YcXaesgDAX5OeuJ41mcedrFMzqzFjJDBaTzPnZB0lZaDbHdSJa9KYWjmcRehYgt
         YmhQ==
X-Gm-Message-State: AOAM533EWfYO+J0tZ+kWzYVmAJdrSYJzGaVsYHY0060VJ63Kawi6zKXT
        eXQXMSYMX86x6hNCxEhfx8o=
X-Google-Smtp-Source: ABdhPJz1tCm1c8rup9GVJZhDpmkVt7bvmZQ26hvPHXJHdm3PBGy4hzvVQcFTD3cnHQ3xC+gSgVAvjw==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr915241pjs.207.1626222890536;
        Tue, 13 Jul 2021 17:34:50 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:9b12:1fd4:6232:5315])
        by smtp.gmail.com with ESMTPSA id x6sm285896pgq.67.2021.07.13.17.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:34:50 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/5] perf inject: Fix output from a file to a pipe
Date:   Tue, 13 Jul 2021 17:34:41 -0700
Message-Id: <20210714003442.1111502-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210714003442.1111502-1-namhyung@kernel.org>
References: <20210714003442.1111502-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the input is a regular file but the output is a pipe, it should
write a pipe header.  But just repiping would write a portion of the
existing header which is different in 'size' value.  So we need to
prevent it and write a new pipe header along with other information
like event attributes and features.

This can handle something like this:

  # perf record -a -B sleep 1

  # perf inject -b -i perf.data | perf report -i -

Factor out perf_event__synthesize_for_pipe() to be shared between perf
record and inject.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c        | 28 ++++++++++++++--
 tools/perf/builtin-record.c        | 38 +++------------------
 tools/perf/util/synthetic-events.c | 53 +++++++++++++++++++++++++++++-
 tools/perf/util/synthetic-events.h |  6 ++++
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7c126597d3f5..0bdd824d8864 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -918,6 +918,7 @@ int cmd_inject(int argc, const char **argv)
 		.use_stdio = true,
 	};
 	int ret;
+	bool repipe = true;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
@@ -992,10 +993,18 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	data.path = inject.input_name;
-	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe)
+	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe) {
 		inject.is_pipe = true;
+		/*
+		 * Do not repipe header when input is a regular file
+		 * since either it can rewrite the header at the end
+		 * or write a new pipe header.
+		 */
+		if (strcmp(inject.input_name, "-"))
+			repipe = false;
+	}
 
-	inject.session = __perf_session__new(&data, inject.is_pipe,
+	inject.session = __perf_session__new(&data, repipe,
 					     perf_data__fd(&inject.output),
 					     &inject.tool);
 	if (IS_ERR(inject.session))
@@ -1004,6 +1013,21 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
+	if (!data.is_pipe && inject.output.is_pipe) {
+		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
+		if (ret < 0) {
+			pr_err("Couldn't write a new pipe header.\n");
+			goto out_delete;
+		}
+
+		ret = perf_event__synthesize_for_pipe(&inject.tool,
+						      inject.session,
+						      &inject.output,
+						      perf_event__repipe);
+		if (ret < 0)
+			goto out_delete;
+	}
+
 	if (inject.build_ids && !inject.build_id_all) {
 		/*
 		 * to make sure the mmap records are ordered correctly
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 199320046fff..9297de08b451 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1386,7 +1386,6 @@ static int record__synthesize(struct record *rec, bool tail)
 	struct perf_data *data = &rec->data;
 	struct record_opts *opts = &rec->opts;
 	struct perf_tool *tool = &rec->tool;
-	int fd = perf_data__fd(data);
 	int err = 0;
 	event_op f = process_synthesized_event;
 
@@ -1394,41 +1393,12 @@ static int record__synthesize(struct record *rec, bool tail)
 		return 0;
 
 	if (data->is_pipe) {
-		/*
-		 * We need to synthesize events first, because some
-		 * features works on top of them (on report side).
-		 */
-		err = perf_event__synthesize_attrs(tool, rec->evlist,
-						   process_synthesized_event);
-		if (err < 0) {
-			pr_err("Couldn't synthesize attrs.\n");
-			goto out;
-		}
-
-		err = perf_event__synthesize_features(tool, session, rec->evlist,
+		err = perf_event__synthesize_for_pipe(tool, session, data,
 						      process_synthesized_event);
-		if (err < 0) {
-			pr_err("Couldn't synthesize features.\n");
-			return err;
-		}
+		if (err < 0)
+			goto out;
 
-		if (have_tracepoints(&rec->evlist->core.entries)) {
-			/*
-			 * FIXME err <= 0 here actually means that
-			 * there were no tracepoints so its not really
-			 * an error, just that we don't need to
-			 * synthesize anything.  We really have to
-			 * return this more properly and also
-			 * propagate errors that now are calling die()
-			 */
-			err = perf_event__synthesize_tracing_data(tool,	fd, rec->evlist,
-								  process_synthesized_event);
-			if (err <= 0) {
-				pr_err("Couldn't record tracing data.\n");
-				goto out;
-			}
-			rec->bytes_written += err;
-		}
+		rec->bytes_written += err;
 	}
 
 	err = perf_event__synth_time_conv(record__pick_pc(rec), tool,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 35aa0c0f7cd9..a7e981b2d7de 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only 
 
+#include "util/cgroup.h"
+#include "util/data.h"
 #include "util/debug.h"
 #include "util/dso.h"
 #include "util/event.h"
@@ -16,7 +18,6 @@
 #include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
-#include "util/cgroup.h"
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -2179,3 +2180,53 @@ int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session
 	free(ff.buf);
 	return ret;
 }
+
+int perf_event__synthesize_for_pipe(struct perf_tool *tool,
+				    struct perf_session *session,
+				    struct perf_data *data,
+				    perf_event__handler_t process)
+{
+	int err;
+	int ret = 0;
+	struct evlist *evlist = session->evlist;
+
+	/*
+	 * We need to synthesize events first, because some
+	 * features works on top of them (on report side).
+	 */
+	err = perf_event__synthesize_attrs(tool, evlist, process);
+	if (err < 0) {
+		pr_err("Couldn't synthesize attrs.\n");
+		return err;
+	}
+	ret += err;
+
+	err = perf_event__synthesize_features(tool, session, evlist, process);
+	if (err < 0) {
+		pr_err("Couldn't synthesize features.\n");
+		return err;
+	}
+	ret += err;
+
+	if (have_tracepoints(&evlist->core.entries)) {
+		int fd = perf_data__fd(data);
+
+		/*
+		 * FIXME err <= 0 here actually means that
+		 * there were no tracepoints so its not really
+		 * an error, just that we don't need to
+		 * synthesize anything.  We really have to
+		 * return this more properly and also
+		 * propagate errors that now are calling die()
+		 */
+		err = perf_event__synthesize_tracing_data(tool,	fd, evlist,
+							  process);
+		if (err <= 0) {
+			pr_err("Couldn't record tracing data.\n");
+			return err;
+		}
+		ret += err;
+	}
+
+	return ret;
+}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index e7a3e9589738..c845e2b9b444 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -14,6 +14,7 @@ struct evsel;
 struct machine;
 struct perf_counts_values;
 struct perf_cpu_map;
+struct perf_data;
 struct perf_event_attr;
 struct perf_event_mmap_page;
 struct perf_sample;
@@ -101,4 +102,9 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
+int perf_event__synthesize_for_pipe(struct perf_tool *tool,
+				    struct perf_session *session,
+				    struct perf_data *data,
+				    perf_event__handler_t process);
+
 #endif // __PERF_SYNTHETIC_EVENTS_H
-- 
2.32.0.93.g670b81a890-goog

