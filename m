Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF493AFDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFVHPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFVHOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:14:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so1708229pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTeAl/CEgH0816JEw3dElaGz6dNJ7fn8nhOS1M+tX2o=;
        b=s+zPA7okklg/t4krEhYNIvo/V0ZXXTvbkS0Y23FeKyDh5q/M/RHQZs8HA183YcGYuS
         4HchgbCK6Ubj/x6b35axBvT4jFfGDVab7flyRtUy4ZkJhawGV1KYYOMUMufWU3tZ00Fq
         lD3Wsrl5ppOjMm3hM1BfZvSIe6iHB7HtO7W1giuqqvCQ8i+VfyHl07RoM98Jyx3HOr66
         2+M065m7HKBqEInP6dkKMGodGjALaBYXQBARqXUeG2InprksBiASmn7Z8OX2UD/B5IEK
         K3y2aP+jKw/WKda/HD64aXg0P+sHNy7NqqxHnvuNeIjxq/6ya122V0GTcpjRhoZcHGIc
         TSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DTeAl/CEgH0816JEw3dElaGz6dNJ7fn8nhOS1M+tX2o=;
        b=Ot8q9s/oULSHy/BLUkQg19TTJOfc9QMjHyWSxs+lOSfHwiScTxKc1QnKOFoz4dWED5
         aWwN0T2kbop74QH7ne/OgT0V9Zo5jbxwt8/jc1gquTFxdSltKh8Tx4tp+g9OXg3FCwT1
         /n8FiVKa1cPUt5CzNAg5HPg/kJOY1KxQ2qGRfGNTxkmEfHWGaoHGvY0OOM+wRO43qM05
         SLOUdLk+w8W0IC1FHHYY1P1qoc/7Db5J61X4TPx153K+kdnC6o6MowsfesAt2O9jUMnn
         YoQ+fAXtKUB3++k4GMe58+rD1NWCtaQ0Ai4VRLISszG7U23Ddtgq9FMXIIqi/hLdROLN
         YE6w==
X-Gm-Message-State: AOAM530D7M5UPze+7p1OQyoWDHmSE5CjgTKXkriqKfWU3Pb5A+bIF8Dx
        I1y3CWoKv989ymfGAgp0T6w=
X-Google-Smtp-Source: ABdhPJwmDM9WDzoRqqQPMKHR/C5hGEr3LtK5Gx07vFholyHMAQzDt8swzjiGrFOvexuo8BSwHXxzbw==
X-Received: by 2002:a17:90b:2243:: with SMTP id hk3mr1933602pjb.216.1624345949178;
        Tue, 22 Jun 2021 00:12:29 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:62e3:ad14:6151:62fa])
        by smtp.gmail.com with ESMTPSA id j4sm16449129pfj.111.2021.06.22.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:12:28 -0700 (PDT)
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
Date:   Tue, 22 Jun 2021 00:12:21 -0700
Message-Id: <20210622071221.128271-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210622071221.128271-1-namhyung@kernel.org>
References: <20210622071221.128271-1-namhyung@kernel.org>
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
 tools/perf/Makefile.perf                    |   7 +-
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 337 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 207 ++++++++++++
 tools/perf/util/cgroup.c                    |   2 +
 tools/perf/util/cgroup.h                    |   1 +
 7 files changed, 559 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..786cba8f3798 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1015,6 +1015,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
 
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
@@ -1032,7 +1033,11 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
 
-$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
+$(SKEL_OUT)/vmlinux.h:
+	$(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TMP_OUT)/ $(SKEL_TMP_OUT)/vmlinux.h
+	$(Q)mv $(SKEL_TMP_OUT)/vmlinux.h $(SKEL_OUT)/vmlinux.h
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
index 000000000000..86cf26d712b8
--- /dev/null
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -0,0 +1,337 @@
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
+	int map_size, map_fd;
+	int prog_fd, err;
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
+/* trigger the leader program on a cpu */
+static int bperf_trigger_reading(int prog_fd, int cpu)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .ctx_in = NULL,
+			    .ctx_size_in = 0,
+			    .flags = BPF_F_TEST_RUN_ON_CPU,
+			    .cpu = cpu,
+			    .retval = 0,
+		);
+
+	return bpf_prog_test_run_opts(prog_fd, &opts);
+}
+/*
+ * trigger the leader prog on each cpu, so the cgrp_reading map could get
+ * the latest results.
+ */
+static int bperf_sync_counters(struct evlist *evlist)
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
index 000000000000..6d74e93dd1f5
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -0,0 +1,207 @@
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
+	__u32 evt_idx, key, cgrp;
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
+		// read from global event array
+		evt_idx = idx * num_cpus + cpu;
+		err = bpf_perf_event_read_value(&events, evt_idx, &val, sizeof(val));
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
+				key = cgrp * num_cpus * num_events + evt_idx;
+				cgrp_val = bpf_map_lookup_elem(&cgrp_readings, &key);
+				if (cgrp_val) {
+					cgrp_val->counter += delta.counter;
+					cgrp_val->enabled += delta.enabled;
+					cgrp_val->running += delta.running;
+				} else {
+					bpf_map_update_elem(&cgrp_readings, &key, &delta, BPF_ANY);
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
2.32.0.288.g62a8d224e6-goog

