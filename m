Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC66C3D31F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhGWCAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhGWCAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:00:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:40:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f1so1642609plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tbRdfF7EeJSYjVcmaZCIfy/MXVMOd9Qy9SamlcKmjA=;
        b=H95Slff61L1H0/RoI9sHOrhecJmk3phs4HhoNmebIuBqTWNwteH4nAqJ9EU7rwEMgL
         8tdRqHn8vI4tLv7ewgGadHutB4IxmKAp2p9tiOZ8/AEsKTWcDVhAYEgqKmg0ODbvD3TR
         EbNH5r+KL1ds0d0rNsDWu7leeSkpi2P7CdpFAqqee9yvqEdhAcyNfBLLqXkWCsmUjaUq
         Ndv5mBm6TmpbIcQyXqHbVutaRbFpbOH2ijqVGIluddceupyvrbfyD+ZMbW57tP6xB5K5
         0poC+cKmWItIKyHxRhXS6sgY9DHnJ3lGPpcmmYflwd0QtAEuWOYliRAl/R2eRXAYYt5X
         nLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5tbRdfF7EeJSYjVcmaZCIfy/MXVMOd9Qy9SamlcKmjA=;
        b=km84kl4fvO65HEiqm8YfV3qlVtZvBYpGewr/Ruq4jEorLj/hV8zOmCIKAI3yhwmXL2
         sc3KXnJugXTSbzGmAIxm5m/tGgHug0gI0yrporoF6//2uJi9mVQ5xpoD5Z6Bz3T4/0Di
         d2G8ciNUsNjbktuwZFbUN2lxnGt1Qz/Ee2seykeP4gJACuU1D49sfgoplG5yb++ol8tK
         RYQAUlweMYCivkCH9XPCZ2lfVQB2dCE3KNfe6ds6AXk5F7WApARNx/Pn5qQCYoGcDw1K
         +t/RnqyxboYblaDlgQUv6sdOy21cmxel/5oTrvQsbcAPQktxkDjAtgQwoppkzC02qq9P
         CAIQ==
X-Gm-Message-State: AOAM533TrtCj5sR0LmfZBRtDTYmPrTAAI/om8nMWRF6W2IoUeNJFNupu
        Dvt/k69iDik9l1qTZDOGLaM=
X-Google-Smtp-Source: ABdhPJwTzSKwaLmhliYTbvgYN72ViTiz6PhguAfAzkTuutErcsSyAOxYYapThW0sBU0jRWDmUu3CUA==
X-Received: by 2002:a63:111a:: with SMTP id g26mr2797623pgl.103.1627008049967;
        Thu, 22 Jul 2021 19:40:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:d872:ce88:5f9f:5b60])
        by smtp.gmail.com with ESMTPSA id j21sm31157902pfn.35.2021.07.22.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 19:40:49 -0700 (PDT)
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
Subject: [PATCH 2/2] perf record: Add --synth option
Date:   Thu, 22 Jul 2021 19:40:45 -0700
Message-Id: <20210723024045.2105375-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723024045.2105375-1-namhyung@kernel.org>
References: <20210723024045.2105375-1-namhyung@kernel.org>
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
 tools/perf/Documentation/perf-record.txt |  4 ++
 tools/perf/builtin-record.c              | 48 +++++++++++++++++++-----
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/synthetic-events.c       | 28 ++++++++++++++
 tools/perf/util/synthetic-events.h       | 12 ++++++
 5 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..421a7b93c4b5 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -596,6 +596,10 @@ options.
 'perf record --dry-run -e' can act as a BPF script compiler if llvm.dump-obj
 in config file is set to true.
 
+--synth=TYPE::
+Collect and synthesize given type of events.  Available types are:
+task, mmap, cgroup, all, no
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

