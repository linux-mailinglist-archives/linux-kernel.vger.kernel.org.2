Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C825F3CF0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbhGSXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349399AbhGSWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:07:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144BC0604DE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y4so17929097pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ure4PJDnW+TdrRHxUVXLP2Q7FtH2grzURki2f6baSRU=;
        b=i3w/gnLpoOU9Yisq3IC42kjBGyFAUHpq/t6ivTh3GrbonEB7lfLoeJ3o7/2HBcwrxT
         0Yp+zwctUraRFhXDGJ/GB1S/B34h3Hc/E4r4fsfP2NJBJudpCu0YmHxfzwFkaSC5ysVv
         cQ/UKfD7SfdZAhfY29t7DhkftNssiHtha26GQ6OYHauu+CaA2Im/LtstLrD/W/Ap+RRN
         iQpc4NW6PBJWeSxDt5+cwBSBzXdo1Z5gp+8f5FBtrO8LFIkEWwT2/hIoHiSQhi7GaPgk
         yFb+odfrrU8BUYGdVERN5AiTLr/XW/Kv3Ux8ofjUJcQYot4/GOQfuX9/MRDl9Ygk1fh0
         3G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ure4PJDnW+TdrRHxUVXLP2Q7FtH2grzURki2f6baSRU=;
        b=ACu/uok9dVPH/FJ6ON0/6SqTUhk73PkyqOK1zA6Z176iEhEC5wkJ2TB64WwxCKZaDT
         V56Mt3X9sKxZ7MZ4Ko11ZwyM/b3hDcV2vXOljIIa+5nvY3MTbi6RCvS4t++68qkQnWBq
         jRk/p7RRsxB6M1l11BXR45Ra3eOEmyhfZmQh2IR7zdiHi2Q8pRNXNkL6rMcNoJbnt1Ud
         /pGIvK2QUroQqgMcoGTaYbzSehxO+Ou5lk4I1s4GSyMH57G1voEEzCnlNCf6tIc/u2Vr
         UjwouU2txqFAPibbBb8wgy1u+14r/Hiyxu8bPUXL+ydNDvVrfLVJRCU/7vtiWqA8mOUe
         Xs/w==
X-Gm-Message-State: AOAM533s/T6q1TXH7fNcBseZ/M6RiE2IgYv1VqJZ2v1DYiZzm5/dmyKM
        Q9WVOdV9rNTxQhNLZyUmgP0=
X-Google-Smtp-Source: ABdhPJzuFXtp9oUjhBFXagxsqcpl1ZedcNwCcp2M8CgHhA0Dkh8PEVa9SI8zGxDc3HvqQ0mnU++0CA==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr27318875pgv.447.1626733923275;
        Mon, 19 Jul 2021 15:32:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:02 -0700 (PDT)
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
Subject: [PATCH 1/5] perf tools: Remove repipe argument from perf_session__new()
Date:   Mon, 19 Jul 2021 15:31:49 -0700
Message-Id: <20210719223153.1618812-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The repipe argument is only used by perf inject and the all others
passes 'false'.  Let's remove it from the function signature and add
__perf_session__new() to be called from perf inject directly.

This is a preparation of the change the pipe input/output.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/synthesize.c       |  4 ++--
 tools/perf/builtin-annotate.c       |  2 +-
 tools/perf/builtin-buildid-cache.c  |  2 +-
 tools/perf/builtin-buildid-list.c   |  2 +-
 tools/perf/builtin-c2c.c            |  2 +-
 tools/perf/builtin-diff.c           |  4 ++--
 tools/perf/builtin-evlist.c         |  2 +-
 tools/perf/builtin-inject.c         |  3 ++-
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/builtin-kvm.c            |  4 ++--
 tools/perf/builtin-lock.c           |  2 +-
 tools/perf/builtin-mem.c            |  3 +--
 tools/perf/builtin-record.c         |  2 +-
 tools/perf/builtin-report.c         |  2 +-
 tools/perf/builtin-sched.c          |  4 ++--
 tools/perf/builtin-script.c         |  4 ++--
 tools/perf/builtin-stat.c           |  4 ++--
 tools/perf/builtin-timechart.c      |  3 +--
 tools/perf/builtin-top.c            |  2 +-
 tools/perf/builtin-trace.c          |  2 +-
 tools/perf/tests/topology.c         |  4 ++--
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  2 +-
 tools/perf/util/session.c           |  5 +++--
 tools/perf/util/session.h           | 12 ++++++++++--
 25 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index b2924e3181dc..05f7c923c745 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -117,7 +117,7 @@ static int run_single_threaded(void)
 	int err;
 
 	perf_set_singlethreaded();
-	session = perf_session__new(NULL, false, NULL);
+	session = perf_session__new(NULL, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
 		return PTR_ERR(session);
@@ -161,7 +161,7 @@ static int do_run_multi_threaded(struct target *target,
 	init_stats(&time_stats);
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
-		session = perf_session__new(NULL, false, NULL);
+		session = perf_session__new(NULL, NULL);
 		if (IS_ERR(session))
 			return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index cebb861be3e3..05eb098cb0e3 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -596,7 +596,7 @@ int cmd_annotate(int argc, const char **argv)
 
 	data.path = input_name;
 
-	annotate.session = perf_session__new(&data, false, &annotate.tool);
+	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
 
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index ecd0d3cb6f5c..0db3cfc04c47 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -443,7 +443,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		data.path  = missing_filename;
 		data.force = force;
 
-		session = perf_session__new(&data, false, NULL);
+		session = perf_session__new(&data, NULL);
 		if (IS_ERR(session))
 			return PTR_ERR(session);
 	}
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 833405c27dae..cebadd632234 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -65,7 +65,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 	if (filename__fprintf_build_id(input_name, stdout) > 0)
 		goto out;
 
-	session = perf_session__new(&data, false, &build_id__mark_dso_hit_ops);
+	session = perf_session__new(&data, &build_id__mark_dso_hit_ops);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6dea37f141b2..a812f32cf5d9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2790,7 +2790,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out;
 	}
 
-	session = perf_session__new(&data, 0, &c2c.tool);
+	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
 		pr_debug("Error creating perf session\n");
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 80450c0e8f36..d925096dd7f0 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1156,7 +1156,7 @@ static int check_file_brstack(void)
 	int i;
 
 	data__for_each_file(i, d) {
-		d->session = perf_session__new(&d->data, false, &pdiff.tool);
+		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
 			return PTR_ERR(d->session);
@@ -1188,7 +1188,7 @@ static int __cmd_diff(void)
 	ret = -EINVAL;
 
 	data__for_each_file(i, d) {
-		d->session = perf_session__new(&d->data, false, &pdiff.tool);
+		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
 			ret = PTR_ERR(d->session);
 			pr_err("Failed to open %s\n", d->data.path);
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 4617b32c9c97..b1076177c37f 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -42,7 +42,7 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	};
 	bool has_tracepoint = false;
 
-	session = perf_session__new(&data, 0, &tool);
+	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5d6f583e2cd3..3cffb12f01be 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -991,7 +991,8 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	data.path = inject.input_name;
-	inject.session = perf_session__new(&data, inject.output.is_pipe, &inject.tool);
+	inject.session = __perf_session__new(&data, inject.output.is_pipe,
+					     &inject.tool);
 	if (IS_ERR(inject.session))
 		return PTR_ERR(inject.session);
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 0062445e8ead..da03a341c63c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1953,7 +1953,7 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
-	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
+	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 1105c9e40a80..aa1b127ffb5b 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1093,7 +1093,7 @@ static int read_events(struct perf_kvm_stat *kvm)
 	};
 
 	kvm->tool = eops;
-	kvm->session = perf_session__new(&file, false, &kvm->tool);
+	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
 		return PTR_ERR(kvm->session);
@@ -1447,7 +1447,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	/*
 	 * perf session
 	 */
-	kvm->session = perf_session__new(&data, false, &kvm->tool);
+	kvm->session = perf_session__new(&data, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		err = PTR_ERR(kvm->session);
 		goto out;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 01326e370009..d70131b7b1b1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -868,7 +868,7 @@ static int __cmd_report(bool display_info)
 		.force = force,
 	};
 
-	session = perf_session__new(&data, false, &eops);
+	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
 		return PTR_ERR(session);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 0fd2a74dbaca..fcf65a59bea2 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -271,8 +271,7 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, false,
-							 &mem->tool);
+	struct perf_session *session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 671a21c9ee4d..472cd12f10c6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1681,7 +1681,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
-	session = perf_session__new(data, false, tool);
+	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
 		return PTR_ERR(session);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6386af6a2612..7b36afac7c26 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1405,7 +1405,7 @@ int cmd_report(int argc, const char **argv)
 	data.force = symbol_conf.force;
 
 repeat:
-	session = perf_session__new(&data, false, &report.tool);
+	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 954ce2f594e9..d4ffc331aacb 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1804,7 +1804,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	};
 	int rc = -1;
 
-	session = perf_session__new(&data, false, &sched->tool);
+	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
 		pr_debug("Error creating perf session");
 		return PTR_ERR(session);
@@ -3011,7 +3011,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	symbol_conf.use_callchain = sched->show_callchain;
 
-	session = perf_session__new(&data, false, &sched->tool);
+	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c03a9862872..f777d7dd2037 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3288,7 +3288,7 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 	char *temp;
 	int i = 0;
 
-	session = perf_session__new(&data, false, NULL);
+	session = perf_session__new(&data, NULL);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -4001,7 +4001,7 @@ int cmd_script(int argc, const char **argv)
 		use_browser = 0;
 	}
 
-	session = perf_session__new(&data, false, &script.tool);
+	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d25cb8088e8c..2c8c1dc7b095 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1996,7 +1996,7 @@ static int __cmd_record(int argc, const char **argv)
 		return -1;
 	}
 
-	session = perf_session__new(data, false, NULL);
+	session = perf_session__new(data, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed\n");
 		return PTR_ERR(session);
@@ -2168,7 +2168,7 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
-	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
+	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4e380e7b5230..43bf4d67edb0 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1598,8 +1598,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.force = tchart->force,
 	};
 
-	struct perf_session *session = perf_session__new(&data, false,
-							 &tchart->tool);
+	struct perf_session *session = perf_session__new(&data, &tchart->tool);
 	int ret = -EINVAL;
 
 	if (IS_ERR(session))
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 02f8bb5dbc0f..a3ae9176a83e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1740,7 +1740,7 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
-	top.session = perf_session__new(NULL, false, NULL);
+	top.session = perf_session__new(NULL, NULL);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
 		goto out_delete_evlist;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7ec18ff57fc4..f963bd61de36 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4205,7 +4205,7 @@ static int trace__replay(struct trace *trace)
 	/* add tid to output */
 	trace->multiple_threads = true;
 
-	session = perf_session__new(&data, false, &trace->tool);
+	session = perf_session__new(&data, &trace->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ec4e3b21b831..870bcc03e977 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -38,7 +38,7 @@ static int session_write_header(char *path)
 		.mode = PERF_DATA_MODE_WRITE,
 	};
 
-	session = perf_session__new(&data, false, NULL);
+	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
 	if (!perf_pmu__has_hybrid()) {
@@ -76,7 +76,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	int i;
 	struct aggr_cpu_id id;
 
-	session = perf_session__new(&data, false, NULL);
+	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 	cpu__setup_cpunode_map();
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index cace349fb700..aa862a26d95c 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1634,7 +1634,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 
 	err = -1;
 	/* perf.data session */
-	session = perf_session__new(&data, 0, &c.tool);
+	session = perf_session__new(&data, &c.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 355cd1948bdf..f1ab6edba446 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -334,7 +334,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 		goto err;
 	}
 
-	session = perf_session__new(&data, false, &c.tool);
+	session = perf_session__new(&data, &c.tool);
 	if (IS_ERR(session)) {
 		fprintf(stderr, "Error creating perf session!\n");
 		goto err_fclose;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9c929a39973..f76b18e3c061 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -185,8 +185,9 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 					   session->tool, event->file_offset);
 }
 
-struct perf_session *perf_session__new(struct perf_data *data,
-				       bool repipe, struct perf_tool *tool)
+struct perf_session *__perf_session__new(struct perf_data *data,
+					 bool repipe,
+					 struct perf_tool *tool)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index e31ba4c92a6c..9d19d2a918c6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -54,8 +54,16 @@ struct decomp {
 
 struct perf_tool;
 
-struct perf_session *perf_session__new(struct perf_data *data,
-				       bool repipe, struct perf_tool *tool);
+struct perf_session *__perf_session__new(struct perf_data *data,
+					 bool repipe,
+					 struct perf_tool *tool);
+
+static inline struct perf_session *perf_session__new(struct perf_data *data,
+						     struct perf_tool *tool)
+{
+	return __perf_session__new(data, false, tool);
+}
+
 void perf_session__delete(struct perf_session *session);
 
 void perf_event_header__bswap(struct perf_event_header *hdr);
-- 
2.32.0.402.g57bb445576-goog

