Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0B3A74D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFODQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhFODQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:16:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:14:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i34so10276052pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+i1x+MfNH322oC7AWw+76RnPrx9TDclPss0wutGXEPQ=;
        b=AbjB2Y2lKEeJdrULMLv3NY5A339sOm32nTGjWs4r5q9u5oDgXMKJiuVGvm3JHXTfcR
         3NMkRxt+gYFxUMZ4+UzmQTljL4RK0il5B/xkcaYvA76urNEdt1hPgpcfCqwfPLXu05kJ
         LG4bDDEKoXF7NAwOxbwfBWA0MMabpFxzBC4TyktsWdNH6tfjdOHg4DcNk4uXsIpiQ1vc
         zPJ5Vb9Go60IQfUJeemInKX/xFBwhJD0uRBpWG7lJYkrfF8ZjVjizDq+H7SecKsiXd9E
         w7s9FaCEwomKHDjQZmLF30b/gMgr/RLo4QKQKSl7d3RkP5iQ2dYKVWOPKeE1LCvQZo2W
         DycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+i1x+MfNH322oC7AWw+76RnPrx9TDclPss0wutGXEPQ=;
        b=VrXaHFGRioTjk4IV4MWN2RpEyAR80WNYtZ1lCYccOyh+sdNcMGinBkXHd1dC+c1ohB
         Qnrv01kJniO5YyU5Jl45nNJkkW6OUEVbTSAuSJL1WqFoYdS5E8CPCMShWD9DU9f7flSy
         GzwxRbuf6ZCb5E29yuYnDtyUbbbUKSh3oQOEDLWqCocrHW7p0p+unclAMFzVAUfvziWF
         kjZ10HhR9YrUFc6wHRDoF7MnovFaEjaGweGeIMEqVsm6pewVso2zyE7qQ5R5ZhTpoVTx
         exEENRLTKM2j2PenEPue+ULs5Pf9K1tpC3Kk3GlKjpbuXkvtJqgDVf7doKKW9Q1dm/fi
         7dDA==
X-Gm-Message-State: AOAM531ea1U51H+5cPcew3nRqr4ivBoGcj/z1xe3GKBL6LvtmfS76LWi
        Z2rXY+8qiEvRLJN8w+6QERNkucW/aNyNhA==
X-Google-Smtp-Source: ABdhPJxaSz0CRhHBBsKbKmxnQ4gVgr0KcnPxq4mQnhgbdTM3h3LuEdgoXBGSlB8vW2d7f+zIMrS0Mw==
X-Received: by 2002:a63:f009:: with SMTP id k9mr17722064pgh.356.1623719851470;
        Mon, 14 Jun 2021 18:17:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:5db9:f2a7:a913:e1ba])
        by smtp.gmail.com with ESMTPSA id z15sm14881758pgu.71.2021.06.14.18.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:17:31 -0700 (PDT)
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
Subject: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Date:   Mon, 14 Jun 2021 18:17:24 -0700
Message-Id: <20210615011724.672612-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615011724.672612-1-namhyung@kernel.org>
References: <20210615011724.672612-1-namhyung@kernel.org>
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

It seems the bpf test run mechanism doens't work for programs attached
the perf_event.  So it's not guaranteed to get the accurate results
using this.  But in practice, perf tools tends to be in a separate
cgroup than the actual works, so having an affinity setting loop at
the end triggers cgroup switches on each cpu.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                    |   1 +
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 319 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 146 +++++++++
 tools/perf/util/cgroup.c                    |   2 +
 tools/perf/util/cgroup.h                    |   1 +
 7 files changed, 475 insertions(+)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..b67099dd2456 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1015,6 +1015,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
 
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
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
index 974f10e356f0..7812c5d9b826 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -22,6 +22,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "target.h"
+#include "cgroup.h"
 #include "cpumap.h"
 #include "thread_map.h"
 
@@ -792,6 +793,8 @@ struct bpf_counter_ops bperf_ops = {
 	.destroy    = bperf__destroy,
 };
 
+extern struct bpf_counter_ops bperf_cgrp_ops;
+
 static inline bool bpf_counter_skip(struct evsel *evsel)
 {
 	return list_empty(&evsel->bpf_counter_list) &&
@@ -809,6 +812,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
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
index 000000000000..0ec5be75b860
--- /dev/null
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -0,0 +1,319 @@
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
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
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
+static struct xyarray *cgrp_prog_fds;
+static struct bperf_cgroup_bpf *skel;
+
+#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
+#define PROG(cpu)    (*(int *)xyarray__entry(cgrp_prog_fds, cpu, 0))
+
+static void set_max_rlimit(void)
+{
+	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &rinf);
+}
+
+static __u32 bpf_link_get_prog_id(int fd)
+{
+	struct bpf_link_info link_info = {0};
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.prog_id;
+}
+
+static int bperf_load_program(struct evlist *evlist)
+{
+	struct bpf_link *link;
+	struct evsel *evsel;
+	struct cgroup *cgrp, *leader_cgrp;
+	__u32 i, cpu, prog_id;
+	int nr_cpus = evlist->core.all_cpus->nr;
+	int map_size, map_fd, err;
+
+	skel = bperf_cgroup_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open cgroup skeleton\n");
+		return -1;
+	}
+
+	skel->rodata->num_cpus = nr_cpus;
+	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
+
+	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
+
+	/* we need one copy of events per cpu for reading */
+	map_size = nr_cpus * evlist->core.nr_entries / nr_cgroups;
+	bpf_map__resize(skel->maps.events, map_size);
+	bpf_map__resize(skel->maps.cpu_idx, nr_cpus);
+	bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
+	/* previous result is saved in a per-cpu array */
+	map_size = evlist->core.nr_entries / nr_cgroups;
+	bpf_map__resize(skel->maps.prev_readings, map_size);
+	/* cgroup result needs all events */
+	map_size = nr_cpus * evlist->core.nr_entries;
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
+	map_fd = bpf_map__fd(skel->maps.cpu_idx);
+	if (map_fd < 0) {
+		pr_err("cannot get cpu idx map\n");
+		goto out;
+	}
+
+	cgrp_prog_fds = xyarray__new(nr_cpus, 1, sizeof(int));
+	if (!cgrp_prog_fds) {
+		pr_err("Failed to allocate cgroup switch prog fd\n");
+		goto out;
+	}
+
+	for (i = 0; i < nr_cpus; i++) {
+		link = bpf_program__attach_perf_event(skel->progs.on_switch,
+						      FD(cgrp_switch, i));
+		if (IS_ERR(link)) {
+			pr_err("Failed to attach cgroup program\n");
+			err = PTR_ERR(link);
+			goto out;
+		}
+
+		/* update cpu index in case there are missing cpus */
+		cpu = evlist->core.all_cpus->map[i];
+		bpf_map_update_elem(map_fd, &cpu, &i, BPF_ANY);
+
+		prog_id = bpf_link_get_prog_id(bpf_link__fd(link));
+		PROG(i) = bpf_prog_get_fd_by_id(prog_id);
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
+				__u32 idx = evsel->idx * nr_cpus + cpu;
+				int fd = FD(evsel, cpu);
+
+				bpf_map_update_elem(map_fd, &idx, &fd, BPF_ANY);
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
+			pr_debug("Failed to get cgroup id\n");
+			err = -1;
+			goto out;
+		}
+
+		map_fd = bpf_map__fd(skel->maps.cgrp_idx);
+		bpf_map_update_elem(map_fd, &cgrp->id, &i, BPF_ANY);
+
+		i++;
+	}
+
+	pr_debug("The kernel does not support test_run for perf_event BPF programs.\n"
+		 "Therefore, --for-each-cgroup might show inaccurate readings\n");
+	err = 0;
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
+static int bperf_sync_counters(struct evlist *evlist)
+{
+	struct affinity affinity;
+	int i, cpu;
+
+	/* change affinity to rotate all cpus to trigger cgroup-switches (hopefully) */
+	if (affinity__setup(&affinity) < 0)
+		return -1;
+
+	evlist__for_each_cpu(evlist, i, cpu)
+		affinity__set(&affinity, cpu);
+
+	affinity__cleanup(&affinity);
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
+	bperf_sync_counters(evsel->evlist);
+
+	skel->bss->enabled = 0;
+	return 0;
+}
+
+static int bperf_cgrp__read(struct evsel *evsel)
+{
+	struct evlist *evlist = evsel->evlist;
+	int i, nr_cpus = evlist->core.all_cpus->nr;
+	struct perf_counts_values *counts;
+	struct bpf_perf_event_value values;
+	struct cgroup *cgrp = NULL;
+	int cgrp_idx = -1;
+	int reading_map_fd, err = 0;
+	__u32 idx;
+
+	if (evsel->idx)
+		return 0;
+
+	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (cgrp != evsel->cgrp) {
+			cgrp = evsel->cgrp;
+			cgrp_idx++;
+		}
+
+		for (i = 0; i < nr_cpus; i++) {
+			idx = evsel->idx * nr_cpus + i;
+			err = bpf_map_lookup_elem(reading_map_fd, &idx, &values);
+			if (err)
+				goto out;
+
+			counts = perf_counts(evsel->counts, i, 0);
+			counts->val = values.counter;
+			counts->ena = values.enabled;
+			counts->run = values.running;
+		}
+	}
+
+out:
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
+	free(cgrp_prog_fds);
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
index 000000000000..5b520821c4b7
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2021 Facebook
+// Copyright (c) 2021 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
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
+// from logical cpu number to event index
+// useful when user wants to count subset of cpus
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1);
+} cpu_idx SEC(".maps");
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
+// aggregated event values for each cgroup
+// will be read from the user-space
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
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
+static inline get_current_cgroup_v1_id(void)
+{
+	struct task_struct *p = (void *)bpf_get_current_task();
+
+	return BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup, kn, id);
+}
+
+// This will be attached to cgroup-switches event for each cpu
+SEC("perf_events")
+int BPF_PROG(on_switch)
+{
+	register __u32 idx = 0;  // to have it in a register to pass BPF verifier
+	struct bpf_perf_event_value val, *prev_val, *cgrp_val;
+	__u32 cpu = bpf_get_smp_processor_id();
+	__u64 cgrp;
+	__u32 evt_idx, key;
+	__u32 *elem;
+	long err;
+
+	// map the current CPU to a CPU index, particularly necessary if there
+	// are fewer CPUs profiled on than all CPUs.
+	elem = bpf_map_lookup_elem(&cpu_idx, &cpu);
+	if (!elem)
+		return 0;
+	cpu = *elem;
+
+	if (use_cgroup_v2)
+		cgrp = bpf_get_current_cgroup_id();
+	else
+		cgrp = get_current_cgroup_v1_id();
+
+	elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp);
+	if (elem)
+		cgrp = *elem;
+	else
+		cgrp = ~0ULL;
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
+			bpf_map_update_elem(&prev_readings, &key, val, BPF_ANY);
+
+			prev_val = bpf_map_lookup_elem(&prev_readings, &key);
+			if (!prev_val)
+				continue;
+		}
+
+		// read from global event array
+		evt_idx = idx * num_cpus + cpu;
+		err = bpf_perf_event_read_value(&events, evt_idx, &val, sizeof(val));
+		if (err)
+			continue;
+
+		if (enabled && cgrp != ~0ULL) {
+			// aggregate the result by cgroup
+			evt_idx += cgrp * num_cpus * num_events;
+			cgrp_val = bpf_map_lookup_elem(&cgrp_readings, &evt_idx);
+			if (cgrp_val) {
+				cgrp_val->counter += val.counter - prev_val->counter;
+				cgrp_val->enabled += val.enabled - prev_val->enabled;
+				cgrp_val->running += val.running - prev_val->running;
+			} else {
+				val->counter -= prev_val->counter;
+				val->enabled -= prev_val->enabled;
+				val->running -= prev_val->running;
+
+				bpf_map_update_elem(&cgrp_readings, &evt_idx, &val, BPF_ANY);
+
+				val->counter += prev_val->counter;
+				val->enabled += prev_val->enabled;
+				val->running += prev_val->running;
+			}
+		}
+
+		*prev_val = val;
+	}
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 48ec79211270..f7d07b365401 100644
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
2.32.0.272.g935e593368-goog

