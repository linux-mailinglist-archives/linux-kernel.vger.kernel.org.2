Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053033A5A55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFMUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:23:08 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:52838 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhFMUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:23:06 -0400
Received: by mail-pj1-f41.google.com with SMTP id h16so8550308pjv.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJ/b1NH1eDgVY3S9D04ArPmOuA07C/XCj5obcqwr1nc=;
        b=jk3WYbLKXEXrCbygCWuhEG+kRrOivglHHBJwafbcyKBtoHWjkLWnbUfBWXQYR0eACa
         GZtnDqA+YCOyOFwfBpN20GoCx6KphmwdNtArUuXAfLsym4LKYBTmZL/WaJ+hzJTu5YAB
         YHHaSDPMtxH7KXVjItQmeznLNw4KM5DYgwtOnlSCh84xYSyp3gBL8IcRH3QII0/KsNiv
         6bCmoh5iFhgU067X3Sajsrr/mOEGONymjZCxZipyE0dpG7KEaHuGK8EybhogXKJC8MR1
         FPp+bdKClaxBcmn9davswqNREP4fuZpiSqhpQWdb8FTuiXOvNJGpBlR2Mc5OxBnm6vu4
         GaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BJ/b1NH1eDgVY3S9D04ArPmOuA07C/XCj5obcqwr1nc=;
        b=HrOJc8vt4lFxLd54smB9N7izKeOOQOVy+aTjf/4MQ3dKgV8DtbxzrWGT15f/Rdda0a
         CX5a0mftJaFr/N+AhW1/p4ikv0xPTQXhDx+kBdZjIN9eV0RNhcFZjciNSJ1W1Me818iC
         sdeqMiNOq8ulKGHBOkfXutxi5omGUmOLiinFgAm+BDVpS8oO9iy6XxJ35JXjRvOEhEwR
         voS6aaHM9UidDXW0Id3pPfHuWCuihZcOA2MeJrQmSg06ZKMUKUtkBzKPZnl+TXd8RZO3
         zqyaf7nAQI+sWlMntctqNjvHCQxl9NjxjSg8EB9gqotheUYSik8qsS4O1jgW6tFV0G63
         NaVw==
X-Gm-Message-State: AOAM533cw7OHnTKxKPolA4y56NnuRpwOmMScQtszcGERtzGe13s8ffc/
        CPMmtOGTMtoMX1jt6+tzPh0=
X-Google-Smtp-Source: ABdhPJwl43RhK3HkDYDKPFrhLCAlmLNa6CHgPQaMqMUYo1yPVasidBO+pFRkFY7w8/yDHmy9vGLE4w==
X-Received: by 2002:a17:90b:4504:: with SMTP id iu4mr15481047pjb.110.1623615604658;
        Sun, 13 Jun 2021 13:20:04 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:d4f4:222c:bec4:5307])
        by smtp.gmail.com with ESMTPSA id x8sm12512545pje.52.2021.06.13.13.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:20:04 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 2/2] perf stat: Enable BPF counter with --for-each-cgroup
Date:   Sun, 13 Jun 2021 13:20:00 -0700
Message-Id: <20210613202000.540674-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210613202000.540674-1-namhyung@kernel.org>
References: <20210613202000.540674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bperf was added to use BPF to count perf events for various
purposes.  This is an extension for the approach and targetting to
cgroup usages.

When --for-each-cgroup is used with --bpf-counters, it will open
cgroup-switches event per cpu internally and attach the new BPF
program to read given perf_events for cgroups.

Unlike the other bperf, it doesn't share the events with other
processes but it'd reduce unnecessary events (and the overhead of
multiplexing) for each monitored cgroup within the perf session.

Current limitations are:
 * bpf_get_cgroup_current_id() works for cgroup v2 only
 * it doesn't support cgroup hierarchy

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                    |   1 +
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 316 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 118 ++++++++
 tools/perf/util/cgroup.c                    |   2 +
 tools/perf/util/cgroup.h                    |   1 +
 7 files changed, 444 insertions(+)
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
index 000000000000..707f65893704
--- /dev/null
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -0,0 +1,316 @@
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
index 000000000000..8d07f83cdde4
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2021 Facebook
+// Copyright (c) 2021 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+	__uint(map_flags, BPF_F_PRESERVE_ELEMS);
+} prev_readings SEC(".maps");
+
+// aggregated event values for each cgroup
+// will be read from the user-space
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(map_flags, BPF_F_PRESERVE_ELEMS);
+} cgrp_readings SEC(".maps");
+
+const volatile __u32 num_events = 1;
+const volatile __u32 num_cpus = 1;
+
+int enabled = 0;
+
+// This will be attached to cgroup-switches event for each cpu
+SEC("perf_events")
+int BPF_PROG(on_switch)
+{
+	register __u32 idx = 0;  // to have it in a register to pass BPF verifier
+	struct bpf_perf_event_value val, *prev_val, *cgrp_val;
+	__u32 cpu = bpf_get_smp_processor_id();
+	__u64 cgrp = bpf_get_current_cgroup_id();
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
+		if (!prev_val)
+			continue;
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
index ef18c988c681..c825127edc04 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -17,6 +17,7 @@
 #include <regex.h>
 
 int nr_cgroups;
+bool cgrp_event_expanded;
 
 /* used to match cgroup name with patterns */
 struct cgroup_name {
@@ -465,6 +466,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 	}
 
 	ret = 0;
+	cgrp_event_expanded = true;
 
 out_err:
 	evlist__delete(orig_list);
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 707adbe25123..f8916a8c754a 100644
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

