Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2E3D44AF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 06:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGXDVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhGXDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:21:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E4C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 21:01:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i10so2251368pla.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJr+oOn2kzfFr95dbii2sDJLx3MlairPe7CB6pB0iVo=;
        b=rvfpXUneFylzXmhG+Vn5BVvUlocS2doNWsq8mYo+r+o++PdCpeWeW3Uni7D9haTHwh
         hK4jtByRiwH50L/hlVTXQb640u7ESKJB8ZsDc0uzjUiG7/xjDAdWNPdljJBwoBxQUebP
         wOUtpugVGOpBBpCl9b2+CX21MOICxUZ+v1n8r7IBYCwDu3Gr/dya3iejx/XltCeC76jb
         eACWt0sfNHbeeJFKnsVBcdVCpYocXdP4ITydYL0RJE+QY//hRBN4qSMDSKnf26beeClg
         n/hZnrzGy+zYBinNCQiOvqjSVvsXiyrn9Pgi9+U0PXXftqHLzDBXQWVXohxulmdON8R1
         X75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mJr+oOn2kzfFr95dbii2sDJLx3MlairPe7CB6pB0iVo=;
        b=lsK4RUFJMVjUBX8wT+I1Fa5fYtX0QCX6V1daNxwTtcOAoK8QpBceaxz9HCN2kozIhz
         DeDPcQnvYKSY/X8CO2YaY5/SfREazkFZA/Kro4B5mUAKcPImSU1IaxK/J/Ny2gdKXpky
         Mv/aDRzRPtY0S3BUXN3B9QMmK/IqBWKWHoPxKnN7Vv2p5w4QyenxB5AZuTXufYve+zsY
         77j6CtAo27Wv/DQpCAFTJ36a4C/FuIxOyhsv8p4QioJmPu3CPyPLWOjUHWL9sE32V40t
         kxtULFhRKORET/PoFZorh7L3WS8jh1G5CtB6GZk2yvPuzTxJ+8/d8bVA0xCNWwVImUrS
         T4eg==
X-Gm-Message-State: AOAM532scvAOBKqkIPpOx7kMT8kkrF/zXt4/98BS9voLdcd1AiPSS9gG
        hCYpQLnt0qdG/8DPJtC2gIMuHJGEsQc=
X-Google-Smtp-Source: ABdhPJwpLazcNmWHoWt4ExjZ3wc1bU60R/7/AAVpPKZJCqbraNHCl14gw1qTv9dhkJVjVA+kunLtPA==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr7705309pgf.1.1627099293911;
        Fri, 23 Jul 2021 21:01:33 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:301a:22b9:cd4b:11f9])
        by smtp.gmail.com with ESMTPSA id x18sm34008217pfh.48.2021.07.23.21.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 21:01:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf record: Add --synth option
Date:   Fri, 23 Jul 2021 21:01:29 -0700
Message-Id: <20210724040129.2268452-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210724040129.2268452-1-namhyung@kernel.org>
References: <20210724040129.2268452-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to control synthesize behavior.

    --synth <no|all|task|mmap|cgroup>
                      Fine-tune event synthesis: default=all

This can be useful when we know it doesn't need some synthesis like
in a specific usecase and/or when using pipe:

  $ perf record -a --all-cgroups --synth cgroup -o- sleep 1 | \
  > perf report -i- -s cgroup

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  9 +++++
 tools/perf/builtin-record.c              | 48 +++++++++++++++++++-----
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/synthetic-events.c       | 28 ++++++++++++++
 tools/perf/util/synthetic-events.h       | 12 ++++++
 5 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..03a41bec0583 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -596,6 +596,15 @@ options.
 'perf record --dry-run -e' can act as a BPF script compiler if llvm.dump-obj
 in config file is set to true.
 
+--synth=TYPE::
+Collect and synthesize given type of events (comma separated).
+Available types are:
+  'task'    - synthesize FORK and COMM events for each task
+  'mmap'    - synthesize MMAP events for each process (implies 'task')
+  'cgroup'  - synthesize CGROUP events for each cgroup
+  'all'     - synthesize all events (default)
+  'no'      - do not synthesize any of the above events
+
 --tail-synthesize::
 Instead of collecting non-sample events (for example, fork, comm, mmap) at
 the beginning of record, collect them during finalizing an output file.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 535da4dfd8d3..caaada3594ce 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1254,6 +1254,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 {
 	int err;
 	struct perf_thread_map *thread_map;
+	bool needs_mmap = rec->opts.synth & PERF_SYNTH_MMAP;
 
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
@@ -1265,7 +1266,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 	err = perf_event__synthesize_thread_map(&rec->tool, thread_map,
 						 process_synthesized_event,
 						 &rec->session->machines.host,
-						 true,
+						 needs_mmap,
 						 rec->opts.sample_address);
 	perf_thread_map__put(thread_map);
 	return err;
@@ -1500,20 +1501,26 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
 
-	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
-					     machine);
-	if (err < 0)
-		pr_warning("Couldn't synthesize cgroup events.\n");
+	if (rec->opts.synth & PERF_SYNTH_CGROUP) {
+		err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
+						     machine);
+		if (err < 0)
+			pr_warning("Couldn't synthesize cgroup events.\n");
+	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
 
-	err = __machine__synthesize_threads(machine, tool, &opts->target,
-					    rec->evlist->core.threads,
-					    f, true, opts->sample_address,
-					    rec->opts.nr_threads_synthesize);
+	if (rec->opts.synth & PERF_SYNTH_TASK) {
+		bool needs_mmap = rec->opts.synth & PERF_SYNTH_MMAP;
+
+		err = __machine__synthesize_threads(machine, tool, &opts->target,
+						    rec->evlist->core.threads,
+						    f, needs_mmap, opts->sample_address,
+						    rec->opts.nr_threads_synthesize);
+	}
 
 	if (rec->opts.nr_threads_synthesize > 1)
 		perf_set_singlethreaded();
@@ -2422,6 +2429,26 @@ static int process_timestamp_boundary(struct perf_tool *tool,
 	return 0;
 }
 
+static int parse_record_synth_option(const struct option *opt,
+				     const char *str,
+				     int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *p = strdup(str);
+
+	if (p == NULL)
+		return -1;
+
+	opts->synth = parse_synth_opt(p);
+	free(p);
+
+	if (opts->synth < 0) {
+		pr_err("Invalid synth option: %s\n", str);
+		return -1;
+	}
+	return 0;
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2447,6 +2474,7 @@ static struct record record = {
 		.nr_threads_synthesize = 1,
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
+		.synth               = PERF_SYNTH_ALL,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2662,6 +2690,8 @@ static struct option __record_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
+		     "Fine-tune event synthesis: default=all", parse_record_synth_option),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 68f471d9a88b..ef6c2715fdd9 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -77,6 +77,7 @@ struct record_opts {
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
+	int	      synth;
 };
 
 extern const char * const *record_usage;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 566e0859fcfb..9485d0532b9c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2186,3 +2186,31 @@ int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session
 	free(ff.buf);
 	return ret;
 }
+
+int parse_synth_opt(char *synth)
+{
+	char *p, *q;
+	int ret = 0;
+
+	if (synth == NULL)
+		return -1;
+
+	for (q = synth; (p = strsep(&q, ",")); p = q) {
+		if (!strcasecmp(p, "no") || !strcasecmp(p, "none"))
+			return 0;
+
+		if (!strcasecmp(p, "all"))
+			return PERF_SYNTH_ALL;
+
+		if (!strcasecmp(p, "task"))
+			ret |= PERF_SYNTH_TASK;
+		else if (!strcasecmp(p, "mmap"))
+			ret |= PERF_SYNTH_TASK | PERF_SYNTH_MMAP;
+		else if (!strcasecmp(p, "cgroup"))
+			ret |= PERF_SYNTH_CGROUP;
+		else
+			return -1;
+	}
+
+	return ret;
+}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 61bbdb3b64df..913803506345 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -26,6 +26,18 @@ struct target;
 
 union perf_event;
 
+enum perf_record_synth {
+	PERF_SYNTH_TASK		= 1 << 0,
+	PERF_SYNTH_MMAP		= 1 << 1,
+	PERF_SYNTH_CGROUP	= 1 << 2,
+
+	/* last element */
+	PERF_SYNTH_MAX		= 1 << 3,
+};
+#define PERF_SYNTH_ALL  (PERF_SYNTH_MAX - 1)
+
+int parse_synth_opt(char *str);
+
 typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
 				     struct perf_sample *sample, struct machine *machine);
 
-- 
2.32.0.432.gabb21c7263-goog

