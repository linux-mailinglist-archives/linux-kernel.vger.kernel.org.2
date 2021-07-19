Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC13CF0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379867AbhGSXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442040AbhGSWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:33:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D2C08EC3A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k20so20740671pgg.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCx/2cWci/ra5g0nomW8seQkOUdu/RO5gew4qLc7OCM=;
        b=J1JYv+0nzJE4s3hd7OQUgoOya7bz+9yYxurifX1DUvVgZg2I3RgSVDMfIhA4ug5qsr
         OW7L6rXZ0zwt0cb7Rg8GwBxlXfngbAYK4lo30DXodN9ugmw6ldjsrf2V58TEXkRTllu/
         wN5dI1gZF8287cld+4Z0jDl7vAgnQ/E+AWIdJiJBfKE4nnSJFaXNVXQWDXOSxfg1i0fi
         CSWFj5sZ5C4YKN4rVMWSBa86bsTWv58d55mbdaU8qCIIFgGEx4twubX5vRpOr1HcZXjy
         DWOepVIFtuRkczOQo3agigFPLfa6FgkQ3+1CjynS2GnJyfUyqjk/mmMAnETZ4mNCWZ6E
         TQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TCx/2cWci/ra5g0nomW8seQkOUdu/RO5gew4qLc7OCM=;
        b=eh/4mdPxeHC6C3rI/b5dffDs4i7TmJZHMmAejTqW97xz1Y8ISkXqPFgMnIVI0TBsUt
         zCaS5nN3Uw2eN/RFEFiFEcnP7zj6EjhbXVhVNpaqbCwMWWTfeIvkEYEWX3GTn2PYD9az
         iDDh7aPS5f1PdoLZ4S9Ru9J1P//sOmOUXUx136+ioOHiuBWgNCo1/DKja2b7iwcmjEj0
         OYodGruU/2a1f0xKk1/6IHEguEkZ+9xCwHXrcJrCMMs+xMrYBrmnxO0+niqR31NlT3Xk
         d7pOewHnogynU90/r2ZXAkvKGcacxRWct7O+q5LAczIHsO0LAInyFLtFamFc68NZFSBK
         La+w==
X-Gm-Message-State: AOAM532/OiAh/+Ok+erCJmmn/uZUkO79179BzeDzst1u+uSXD3LIJDKK
        sRce25+tLb/Su1YxqDfQOCk=
X-Google-Smtp-Source: ABdhPJyTodxuPEBElWRaHZy/mj8XDb1JZJ8BAqSHEDLJ7WAvNzqE/qLsrIvIrIoWkoZw2vTinKeiCA==
X-Received: by 2002:a65:60d7:: with SMTP id r23mr26943189pgv.417.1626733928550;
        Mon, 19 Jul 2021 15:32:08 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:07 -0700 (PDT)
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
Date:   Mon, 19 Jul 2021 15:31:52 -0700
Message-Id: <20210719223153.1618812-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
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
index 472cd12f10c6..548c1dbde6c5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1387,7 +1387,6 @@ static int record__synthesize(struct record *rec, bool tail)
 	struct perf_data *data = &rec->data;
 	struct record_opts *opts = &rec->opts;
 	struct perf_tool *tool = &rec->tool;
-	int fd = perf_data__fd(data);
 	int err = 0;
 	event_op f = process_synthesized_event;
 
@@ -1395,41 +1394,12 @@ static int record__synthesize(struct record *rec, bool tail)
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
2.32.0.402.g57bb445576-goog

