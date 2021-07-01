Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3C3B97FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhGAVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:15:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F920C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:12:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so1710480pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvi0/Uw2dxVqLyYuhBYDOKi8MRdtS2MEdkrLX1rOpMM=;
        b=aTOQ76XBlS4toDHAyNex3xlo3HCY45lOXcQMH88x0NS6pEOMHUKH5U90uyA0KPpoGL
         QcK4X2F2zcGEwtq1lAwdxFst/1gu/Q1Cf/HkgQih93ZZKrSGd7qHLdQ1ySaQUcIVOJJf
         kFUrs3It06PWFLMCK6v6i0sXTu9uv+HJSgcCytyl6uzgl4P7QppPkEbWJwJ/o5QuACiw
         CC4JvBReE6lMqi+peE6nqfvAgWI0PmnO2EFYlofWM33yAshVcOYhUbUjwv0p5cD68zAV
         55+eeUpbG2TXTDVjXl18lSJCiwVZFDnn77kkldUiUnilP1+cJmQXgmG+hZlyu3/bFQGK
         l1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mvi0/Uw2dxVqLyYuhBYDOKi8MRdtS2MEdkrLX1rOpMM=;
        b=DYEuaxb5rKfTq2qlc6/JRth8qw1fMhNPcIoMUD2di6iiOyMIIrPveHyZRIGkiem8t8
         +kMcKI6L/4Ovoxn6SD6Cpwz1nHaBc8z17y7F0nvheO0nvSjQAToT0qMCR7otysKDiHfU
         q99ffADp3G47fepFE5npDxjzS3M+PQcA40CsO0Oe+W+l5k0lYm/KEuVulePGtE2r5pqP
         uk657ijCFwSqiogC9KAi7JGzrj1hGKo59tTjnCkENAJLU8eR9f7cSNWQH3HhGFuM8fDd
         kYQccQUj40kl8iYKXvRUDOHCvTZzcFyG16iszSJ+yqdYxInlln18Su9J/nmOaRDB76VS
         EBMA==
X-Gm-Message-State: AOAM533d2v3RiNjb+EVSX/pP0KWmF+4hO2eKlgr6g0hT+/0r41EGO/lK
        5ImAFEKY5Se56Onf2Z7AgbI=
X-Google-Smtp-Source: ABdhPJzvXKoLtHnpD+HepLcQR+OC0563blww+Uw5G1yzrO7VOGPxrfiNga631Pu6CVFbS/JVShqD1Q==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id bg8-20020a1709028e88b029011eb70383f1mr1505675plb.79.1625173949568;
        Thu, 01 Jul 2021 14:12:29 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:71da:9ca:6cdf:6a9e])
        by smtp.gmail.com with ESMTPSA id j17sm886645pfc.139.2021.07.01.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 14:12:28 -0700 (PDT)
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
Subject: [PATCH v5] perf stat: Enable BPF counter with --for-each-cgroup
Date:   Thu,  1 Jul 2021 14:12:27 -0700
Message-Id: <20210701211227.1403788-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
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
 * fix build errors
 * update copyright year
 * call bperf_cgrp__sync_counters during enable
 * change warning when trigger reading failed

 tools/perf/Makefile.perf                    |  17 +-
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 307 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 ++++++++++++
 tools/perf/util/cgroup.c                    |   2 +
 tools/perf/util/cgroup.h                    |   1 +
 7 files changed, 523 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..c63f91409195 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1015,6 +1015,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
 
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
@@ -1028,7 +1029,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
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
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
 
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
index 21c8e71162b1..1d0b9742f727 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -18,6 +18,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "target.h"
+#include "cgroup.h"
 #include "cpumap.h"
 #include "thread_map.h"
 
@@ -742,6 +743,8 @@ struct bpf_counter_ops bperf_ops = {
 	.destroy    = bperf__destroy,
 };
 
+extern struct bpf_counter_ops bperf_cgrp_ops;
+
 static inline bool bpf_counter_skip(struct evsel *evsel)
 {
 	return list_empty(&evsel->bpf_counter_list) &&
@@ -759,6 +762,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
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
index 000000000000..2fee7a027976
--- /dev/null
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2021 Facebook */
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
+	__u32 nr_cpus = evlist->core.all_cpus->nr;
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
+		pr_warning("The kernel does not support test_run for raw_tp BPF programs.\n"
+			   "Therefore, --for-each-cgroup might show inaccurate readings\n");
+		err = 0;
+	}
+
+out:
+	return err;
+}
+
+static int bperf_cgrp__load(struct evsel *evsel,
+			    struct target *target __maybe_unused)
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
+static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
+				  int cpu __maybe_unused, int fd __maybe_unused)
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
+	if (evsel->idx)
+		return 0;
+
+	bperf_cgrp__sync_counters(evsel->evlist);
+
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
index 13f4ea7dfe4c..87bd417d55ab 100644
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

