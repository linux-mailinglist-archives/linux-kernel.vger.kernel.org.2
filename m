Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B63B3D42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFYHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhFYHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:20:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C8DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e20so6882384pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nM21tGvONbXtorDKJ190uKPZFNyZX5aakoj7flo3Nc=;
        b=UO8Euuch3TCdQHdTp69JrQinNs/2x7nL2C1WGpa/spYRHn9i9SkneLdXKXRwAmMi3e
         5Y9YN6c5Sk5+l2wQ6epLTbdE+gaa5s33GGGA1ruVeqFGiu9PX0Qnfes7hZnIxKS3yVwJ
         sSBR+Bxs07KKlyvpWi1CLGHFgHBYHOO745F9JqXBCK6ONyA5sPd7qqa0+U8Zdqgm04bw
         YTn/dKJBT2qFP2JVVlHMIGgBfrMLqcBQUW6U92W0IfLu4T8Ej+Nh6jBsPmXzECHfABFN
         kMt42YKtg98i+405JyOL1HGKFRPDW2O0q7VV/ZpwnULkuy0E01iN4DvvmVqnTEUQQhT7
         ssAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+nM21tGvONbXtorDKJ190uKPZFNyZX5aakoj7flo3Nc=;
        b=dXxXnKxai3NxEeOKEmccGOUYsRqC/ReckdnmACsTnvrDHLRmUeOB2Q3+nvDkc3oqnL
         ZBY22cVra5kcvEJmcxCwWnfsk77RXyJTDdG7oPbY64viDwOO7wXlxJpCKpJFG461ODJv
         5lCD1tgCBg0e8B+KgHQcYeAr71DOY05sOyAv8w9JHMayiC3h0QQIzgDK/6D1XsRUUpIc
         ptQ74CjfGvZI8BcheFZfPcsPqfr/errFbhsaGXRtQEedcKn6Yymijy39qNnzDWs3utXT
         dSruiJh28aotBumt7HITDA9WMBevTnYtfxZQSKv61vlDEuZHjx8D/0By+Su050vV6EWC
         9DRA==
X-Gm-Message-State: AOAM533ybqS+02+MfG0G3rFBBAmgoKcS20QmoPSlwaSXGHg72QSXhHVW
        PiNtEhreIbGsOJ88Ttxw/FsGrBy4fEPy9w==
X-Google-Smtp-Source: ABdhPJz7TPEXl17KOiQeleSgdESfxUnwsFxUaZh31EIm4/sXbg67GYRqi3rTNRV0KlKS3xhBRLr16w==
X-Received: by 2002:a63:5b51:: with SMTP id l17mr8297821pgm.408.1624605514625;
        Fri, 25 Jun 2021 00:18:34 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:1b9c:b593:f9be:6b24])
        by smtp.gmail.com with ESMTPSA id c68sm4759176pfc.75.2021.06.25.00.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:18:34 -0700 (PDT)
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
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
Date:   Fri, 25 Jun 2021 00:18:26 -0700
Message-Id: <20210625071826.608504-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210625071826.608504-1-namhyung@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bperf was added to use BPF to count perf events for various
purposes.  This is an extension for the approach and targetting to
cgroup usages.

Unlike the other bperf, it doesn't share the events with other
processes but it'd reduce unnecessary events (and the overhead of
multiplexing) for each monitored cgroup within the perf session.

When --for-each-cgroup is used with --bpf-counters, it will open
cgroup-switches event per cpu internally and attach the new BPF
program to read given perf_events and to aggregate the results for
cgroups.  It's only called when task is switched to a task in a
different cgroup.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                    |  17 +-
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 299 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 +++++++++++++
 tools/perf/util/cgroup.c                    |   2 +
 tools/perf/util/cgroup.h                    |   1 +
 7 files changed, 515 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..b03a803d466d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1015,6 +1015,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
 
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
@@ -1032,7 +1033,21 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
 
-$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../vmlinux					\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+ifeq ($(VMLINUX_H),)
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+else
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(SKEL_OUT)/vmlinux.h | $(BPFTOOL)
 	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
 
 bpf-skel: $(SKELETONS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 95e15d1035ab..700d635448ff 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -140,6 +140,7 @@ perf-y += clockid.o
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 1af81e882eb6..79c19cb8bf2d 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -18,6 +18,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "target.h"
+#include "cgroup.h"
 #include "cpumap.h"
 #include "thread_map.h"
 
@@ -740,6 +741,8 @@ struct bpf_counter_ops bperf_ops = {
 	.destroy    = bperf__destroy,
 };
 
+extern struct bpf_counter_ops bperf_cgrp_ops;
+
 static inline bool bpf_counter_skip(struct evsel *evsel)
 {
 	return list_empty(&evsel->bpf_counter_list) &&
@@ -757,6 +760,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 {
 	if (target->bpf_str)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
+	else if (cgrp_event_expanded && target->use_bpf)
+		evsel->bpf_counter_ops = &bperf_cgrp_ops;
 	else if (target->use_bpf || evsel->bpf_counter ||
 		 evsel__match_bpf_counter_events(evsel->name))
 		evsel->bpf_counter_ops = &bperf_ops;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
new file mode 100644
index 000000000000..327f97a23a84
--- /dev/null
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2019 Facebook */
+/* Copyright (c) 2021 Google */
+
+#include <assert.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/file.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <linux/err.h>
+#include <linux/zalloc.h>
+#include <linux/perf_event.h>
+#include <api/fs/fs.h>
+#include <perf/bpf_perf.h>
+
+#include "affinity.h"
+#include "bpf_counter.h"
+#include "cgroup.h"
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "target.h"
+#include "cpumap.h"
+#include "thread_map.h"
+
+#include "bpf_skel/bperf_cgroup.skel.h"
+
+static struct perf_event_attr cgrp_switch_attr = {
+	.type = PERF_TYPE_SOFTWARE,
+	.config = PERF_COUNT_SW_CGROUP_SWITCHES,
+	.size = sizeof(cgrp_switch_attr),
+	.sample_period = 1,
+	.disabled = 1,
+};
+
+static struct evsel *cgrp_switch;
+static struct bperf_cgroup_bpf *skel;
+
+#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
+
+static int bperf_load_program(struct evlist *evlist)
+{
+	struct bpf_link *link;
+	struct evsel *evsel;
+	struct cgroup *cgrp, *leader_cgrp;
+	__u32 i, cpu;
+	int nr_cpus = evlist->core.all_cpus->nr;
+	int total_cpus = cpu__max_cpu();
+	int map_size, map_fd;
+	int prog_fd, err;
+
+	skel = bperf_cgroup_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open cgroup skeleton\n");
+		return -1;
+	}
+
+	skel->rodata->num_cpus = total_cpus;
+	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
+
+	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
+
+	/* we need one copy of events per cpu for reading */
+	map_size = total_cpus * evlist->core.nr_entries / nr_cgroups;
+	bpf_map__resize(skel->maps.events, map_size);
+	bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
+	/* previous result is saved in a per-cpu array */
+	map_size = evlist->core.nr_entries / nr_cgroups;
+	bpf_map__resize(skel->maps.prev_readings, map_size);
+	/* cgroup result needs all events (per-cpu) */
+	map_size = evlist->core.nr_entries;
+	bpf_map__resize(skel->maps.cgrp_readings, map_size);
+
+	set_max_rlimit();
+
+	err = bperf_cgroup_bpf__load(skel);
+	if (err) {
+		pr_err("Failed to load cgroup skeleton\n");
+		goto out;
+	}
+
+	if (cgroup_is_v2("perf_event") > 0)
+		skel->bss->use_cgroup_v2 = 1;
+
+	err = -1;
+
+	cgrp_switch = evsel__new(&cgrp_switch_attr);
+	if (evsel__open_per_cpu(cgrp_switch, evlist->core.all_cpus, -1) < 0) {
+		pr_err("Failed to open cgroup switches event\n");
+		goto out;
+	}
+
+	for (i = 0; i < nr_cpus; i++) {
+		link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
+						      FD(cgrp_switch, i));
+		if (IS_ERR(link)) {
+			pr_err("Failed to attach cgroup program\n");
+			err = PTR_ERR(link);
+			goto out;
+		}
+	}
+
+	/*
+	 * Update cgrp_idx map from cgroup-id to event index.
+	 */
+	cgrp = NULL;
+	i = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (cgrp == NULL || evsel->cgrp == leader_cgrp) {
+			leader_cgrp = evsel->cgrp;
+			evsel->cgrp = NULL;
+
+			/* open single copy of the events w/o cgroup */
+			err = evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
+			if (err) {
+				pr_err("Failed to open first cgroup events\n");
+				goto out;
+			}
+
+			map_fd = bpf_map__fd(skel->maps.events);
+			for (cpu = 0; cpu < nr_cpus; cpu++) {
+				int fd = FD(evsel, cpu);
+				__u32 idx = evsel->idx * total_cpus +
+					evlist->core.all_cpus->map[cpu];
+
+				err = bpf_map_update_elem(map_fd, &idx, &fd,
+							  BPF_ANY);
+				if (err < 0) {
+					pr_err("Failed to update perf_event fd\n");
+					goto out;
+				}
+			}
+
+			evsel->cgrp = leader_cgrp;
+		}
+		evsel->supported = true;
+
+		if (evsel->cgrp == cgrp)
+			continue;
+
+		cgrp = evsel->cgrp;
+
+		if (read_cgroup_id(cgrp) < 0) {
+			pr_err("Failed to get cgroup id\n");
+			err = -1;
+			goto out;
+		}
+
+		map_fd = bpf_map__fd(skel->maps.cgrp_idx);
+		err = bpf_map_update_elem(map_fd, &cgrp->id, &i, BPF_ANY);
+		if (err < 0) {
+			pr_err("Failed to update cgroup index map\n");
+			goto out;
+		}
+
+		i++;
+	}
+
+	/*
+	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
+	 * whether the kernel support it
+	 */
+	prog_fd = bpf_program__fd(skel->progs.trigger_read);
+	err = bperf_trigger_reading(prog_fd, 0);
+	if (err) {
+		pr_debug("The kernel does not support test_run for raw_tp BPF programs.\n"
+			 "Therefore, --for-each-cgroup might show inaccurate readings\n");
+	}
+
+out:
+	return err;
+}
+
+static int bperf_cgrp__load(struct evsel *evsel, struct target *target)
+{
+	static bool bperf_loaded = false;
+
+	evsel->bperf_leader_prog_fd = -1;
+	evsel->bperf_leader_link_fd = -1;
+
+	if (!bperf_loaded && bperf_load_program(evsel->evlist))
+		return -1;
+
+	bperf_loaded = true;
+	/* just to bypass bpf_counter_skip() */
+	evsel->follower_skel = (struct bperf_follower_bpf *)skel;
+
+	return 0;
+}
+
+static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
+{
+	/* nothing to do */
+	return 0;
+}
+
+/*
+ * trigger the leader prog on each cpu, so the cgrp_reading map could get
+ * the latest results.
+ */
+static int bperf_cgrp__sync_counters(struct evlist *evlist)
+{
+	int i, cpu;
+	int nr_cpus = evlist->core.all_cpus->nr;
+	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
+
+	for (i = 0; i < nr_cpus; i++) {
+		cpu = evlist->core.all_cpus->map[i];
+		bperf_trigger_reading(prog_fd, cpu);
+	}
+
+	return 0;
+}
+
+static int bperf_cgrp__enable(struct evsel *evsel)
+{
+	skel->bss->enabled = 1;
+	return 0;
+}
+
+static int bperf_cgrp__disable(struct evsel *evsel)
+{
+	if (evsel->idx)
+		return 0;
+
+	bperf_cgrp__sync_counters(evsel->evlist);
+
+	skel->bss->enabled = 0;
+	return 0;
+}
+
+static int bperf_cgrp__read(struct evsel *evsel)
+{
+	struct evlist *evlist = evsel->evlist;
+	int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
+	int total_cpus = cpu__max_cpu();
+	struct perf_counts_values *counts;
+	struct bpf_perf_event_value *values;
+	int reading_map_fd, err = 0;
+	__u32 idx;
+
+	if (evsel->idx)
+		return 0;
+
+	bperf_cgrp__sync_counters(evsel->evlist);
+
+	values = calloc(total_cpus, sizeof(*values));
+	if (values == NULL)
+		return -ENOMEM;
+
+	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
+
+	evlist__for_each_entry(evlist, evsel) {
+		idx = evsel->idx;
+		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
+		if (err) {
+			pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
+			       idx, evsel__name(evsel), evsel->cgrp->name);
+			goto out;
+		}
+
+		for (i = 0; i < nr_cpus; i++) {
+			cpu = evlist->core.all_cpus->map[i];
+
+			counts = perf_counts(evsel->counts, i, 0);
+			counts->val = values[cpu].counter;
+			counts->ena = values[cpu].enabled;
+			counts->run = values[cpu].running;
+		}
+	}
+
+out:
+	free(values);
+	return err;
+}
+
+static int bperf_cgrp__destroy(struct evsel *evsel)
+{
+	if (evsel->idx)
+		return 0;
+
+	bperf_cgroup_bpf__destroy(skel);
+	evsel__delete(cgrp_switch);  // it'll destroy on_switch progs too
+
+	return 0;
+}
+
+struct bpf_counter_ops bperf_cgrp_ops = {
+	.load       = bperf_cgrp__load,
+	.enable     = bperf_cgrp__enable,
+	.disable    = bperf_cgrp__disable,
+	.read       = bperf_cgrp__read,
+	.install_pe = bperf_cgrp__install_pe,
+	.destroy    = bperf_cgrp__destroy,
+};
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
new file mode 100644
index 000000000000..292c430768b5
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2021 Facebook
+// Copyright (c) 2021 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
+#define MAX_EVENTS  32  // max events per cgroup: arbitrary
+
+// NOTE: many of map and global data will be modified before loading
+//       from the userspace (perf tool) using the skeleton helpers.
+
+// single set of global perf events to measure
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(int));
+	__uint(max_entries, 1);
+} events SEC(".maps");
+
+// from cgroup id to event index
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1);
+} cgrp_idx SEC(".maps");
+
+// per-cpu event snapshots to calculate delta
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+} prev_readings SEC(".maps");
+
+// aggregated event values for each cgroup (per-cpu)
+// will be read from the user-space
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+} cgrp_readings SEC(".maps");
+
+const volatile __u32 num_events = 1;
+const volatile __u32 num_cpus = 1;
+
+int enabled = 0;
+int use_cgroup_v2 = 0;
+
+static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
+{
+	struct task_struct *p = (void *)bpf_get_current_task();
+	struct cgroup *cgrp;
+	register int i = 0;
+	__u32 *elem;
+	int level;
+	int cnt;
+
+	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
+	level = BPF_CORE_READ(cgrp, level);
+
+	for (cnt = 0; i < MAX_LEVELS; i++) {
+		__u64 cgrp_id;
+
+		if (i > level)
+			break;
+
+		// convert cgroup-id to a map index
+		cgrp_id = BPF_CORE_READ(cgrp, ancestor_ids[i]);
+		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
+		if (!elem)
+			continue;
+
+		cgrps[cnt++] = *elem;
+		if (cnt == size)
+			break;
+	}
+
+	return cnt;
+}
+
+static inline int get_cgroup_v2_idx(__u32 *cgrps, int size)
+{
+	register int i = 0;
+	__u32 *elem;
+	int cnt;
+
+	for (cnt = 0; i < MAX_LEVELS; i++) {
+		__u64 cgrp_id = bpf_get_current_ancestor_cgroup_id(i);
+
+		if (cgrp_id == 0)
+			break;
+
+		// convert cgroup-id to a map index
+		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
+		if (!elem)
+			continue;
+
+		cgrps[cnt++] = *elem;
+		if (cnt == size)
+			break;
+	}
+
+	return cnt;
+}
+
+static int bperf_cgroup_count(void)
+{
+	register __u32 idx = 0;  // to have it in a register to pass BPF verifier
+	register int c = 0;
+	struct bpf_perf_event_value val, delta, *prev_val, *cgrp_val;
+	__u32 cpu = bpf_get_smp_processor_id();
+	__u32 cgrp_idx[MAX_LEVELS];
+	int cgrp_cnt;
+	__u32 key, cgrp;
+	long err;
+
+	if (use_cgroup_v2)
+		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, MAX_LEVELS);
+	else
+		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, MAX_LEVELS);
+
+	for ( ; idx < MAX_EVENTS; idx++) {
+		if (idx == num_events)
+			break;
+
+		// XXX: do not pass idx directly (for verifier)
+		key = idx;
+		// this is per-cpu array for diff
+		prev_val = bpf_map_lookup_elem(&prev_readings, &key);
+		if (!prev_val) {
+			val.counter = val.enabled = val.running = 0;
+			bpf_map_update_elem(&prev_readings, &key, &val, BPF_ANY);
+
+			prev_val = bpf_map_lookup_elem(&prev_readings, &key);
+			if (!prev_val)
+				continue;
+		}
+
+		// read from global perf_event array
+		key = idx * num_cpus + cpu;
+		err = bpf_perf_event_read_value(&events, key, &val, sizeof(val));
+		if (err)
+			continue;
+
+		if (enabled) {
+			delta.counter = val.counter - prev_val->counter;
+			delta.enabled = val.enabled - prev_val->enabled;
+			delta.running = val.running - prev_val->running;
+
+			for (c = 0; c < MAX_LEVELS; c++) {
+				if (c == cgrp_cnt)
+					break;
+
+				cgrp = cgrp_idx[c];
+
+				// aggregate the result by cgroup
+				key = cgrp * num_events + idx;
+				cgrp_val = bpf_map_lookup_elem(&cgrp_readings, &key);
+				if (cgrp_val) {
+					cgrp_val->counter += delta.counter;
+					cgrp_val->enabled += delta.enabled;
+					cgrp_val->running += delta.running;
+				} else {
+					bpf_map_update_elem(&cgrp_readings, &key,
+							    &delta, BPF_ANY);
+				}
+			}
+		}
+
+		*prev_val = val;
+	}
+	return 0;
+}
+
+// This will be attached to cgroup-switches event for each cpu
+SEC("perf_events")
+int BPF_PROG(on_cgrp_switch)
+{
+	return bperf_cgroup_count();
+}
+
+SEC("raw_tp/sched_switch")
+int BPF_PROG(trigger_read)
+{
+	return bperf_cgroup_count();
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e819a4f30fc2..851531102fd6 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -18,6 +18,7 @@
 #include <regex.h>
 
 int nr_cgroups;
+bool cgrp_event_expanded;
 
 /* used to match cgroup name with patterns */
 struct cgroup_name {
@@ -484,6 +485,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 	}
 
 	ret = 0;
+	cgrp_event_expanded = true;
 
 out_err:
 	evlist__delete(orig_list);
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 1549ec2fd348..21f7ccc566e1 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -17,6 +17,7 @@ struct cgroup {
 };
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
+extern bool cgrp_event_expanded;
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
-- 
2.32.0.93.g670b81a890-goog

