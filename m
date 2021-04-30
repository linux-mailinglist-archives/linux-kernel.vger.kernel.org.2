Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007B536F6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhD3Ht2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:49:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:32265 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhD3HtZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:49:25 -0400
IronPort-SDR: MhHnqiAi7trrxfgfuVMP77asyUTnxslEF1HyNNvkerFdLdydn8675Sb02/FB+pwZQPyzcinlGR
 FmmocaxHO2ng==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177377170"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="177377170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:46:51 -0700
IronPort-SDR: zs+wuDWUtKbQrabAkuXqbpFCAUJL3eJy+b3WfHbfQURENg47NM9D4KcWTGZtFD7l3wZCo+27tR
 BhlfHA1sx+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="527549160"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2021 00:46:49 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Date:   Fri, 30 Apr 2021 15:46:01 +0800
Message-Id: <20210430074602.3028-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to let user know the hybrid topology.
Adding HYBRID_TOPOLOGY feature in header to indicate the
core cpus and the atom cpus.

With this patch,

For the perf.data generated on hybrid platform,
reports the hybrid cpu list.

  root@otcpl-adl-s-2:~# perf report --header-only -I
  ...
  # cpu_core cpu list : 0-15
  # cpu_atom cpu list : 16-23

For the perf.data generated on non-hybrid platform,
reports the message that HYBRID_TOPOLOGY is missing.

  root@kbl-ppc:~# perf report --header-only -I
  ...
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY

Note that: this patch is on tmp.perf/core.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/cputopo.c    | 80 +++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h    | 13 +++++
 tools/perf/util/env.c        |  6 +++
 tools/perf/util/env.h        |  7 +++
 tools/perf/util/header.c     | 92 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h     |  1 +
 tools/perf/util/pmu-hybrid.h | 11 +++++
 7 files changed, 210 insertions(+)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 1b52402a8923..04abf9344dd7 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -12,6 +12,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
+#include "pmu-hybrid.h"
 
 #define CORE_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
@@ -351,3 +352,82 @@ void numa_topology__delete(struct numa_topology *tp)
 
 	free(tp);
 }
+
+static int load_hybrid_node(struct hybrid_topology_node *node,
+			    struct perf_pmu *pmu)
+{
+	const char *sysfs;
+	char path[PATH_MAX];
+	char *buf = NULL, *p;
+	FILE *fp;
+	size_t len = 0;
+
+	node->pmu_name = strdup(pmu->name);
+	if (!node->pmu_name)
+		return -1;
+
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		goto err;
+
+	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, pmu->name);
+	fp = fopen(path, "r");
+	if (!fp)
+		goto err;
+
+	if (getline(&buf, &len, fp) <= 0) {
+		fclose(fp);
+		goto err;
+	}
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	fclose(fp);
+	node->cpus = buf;
+	return 0;
+
+err:
+	zfree(&node->pmu_name);
+	free(buf);
+	return -1;
+}
+
+struct hybrid_topology *hybrid_topology__new(void)
+{
+	struct perf_pmu *pmu;
+	struct hybrid_topology *tp = NULL;
+	u32 nr = 0, i = 0;
+
+	nr = perf_pmu__hybrid_pmu_num();
+	if (nr == 0)
+		return NULL;
+
+	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0]) * nr);
+	if (!tp)
+		return NULL;
+
+	tp->nr = nr;
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (load_hybrid_node(&tp->nodes[i], pmu)) {
+			hybrid_topology__delete(tp);
+			return NULL;
+		}
+		i++;
+	}
+
+	return tp;
+}
+
+void hybrid_topology__delete(struct hybrid_topology *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->nr; i++) {
+		zfree(&tp->nodes[i].pmu_name);
+		zfree(&tp->nodes[i].cpus);
+	}
+
+	free(tp);
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 6201c3790d86..d9af97177068 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -25,10 +25,23 @@ struct numa_topology {
 	struct numa_topology_node	nodes[];
 };
 
+struct hybrid_topology_node {
+	char		*pmu_name;
+	char		*cpus;
+};
+
+struct hybrid_topology {
+	u32				nr;
+	struct hybrid_topology_node	nodes[];
+};
+
 struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 
 struct numa_topology *numa_topology__new(void);
 void numa_topology__delete(struct numa_topology *tp);
 
+struct hybrid_topology *hybrid_topology__new(void);
+void hybrid_topology__delete(struct hybrid_topology *tp);
+
 #endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9130f6fad8d5..9e05eca324a1 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -202,6 +202,12 @@ void perf_env__exit(struct perf_env *env)
 	for (i = 0; i < env->nr_memory_nodes; i++)
 		zfree(&env->memory_nodes[i].set);
 	zfree(&env->memory_nodes);
+
+	for (i = 0; i < env->nr_hybrid_nodes; i++) {
+		perf_cpu_map__put(env->hybrid_nodes[i].map);
+		zfree(&env->hybrid_nodes[i].pmu_name);
+	}
+	zfree(&env->hybrid_nodes);
 }
 
 void perf_env__init(struct perf_env *env __maybe_unused)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ca249bf5e984..9ca7633787e1 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -37,6 +37,11 @@ struct memory_node {
 	unsigned long	*set;
 };
 
+struct hybrid_node {
+	char	*pmu_name;
+	struct perf_cpu_map	*map;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -59,6 +64,7 @@ struct perf_env {
 	int			nr_pmu_mappings;
 	int			nr_groups;
 	int			nr_cpu_pmu_caps;
+	int			nr_hybrid_nodes;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -77,6 +83,7 @@ struct perf_env {
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
+	struct hybrid_node	*hybrid_nodes;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index aa1e42518d37..dff89c0be79c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -932,6 +932,40 @@ static int write_clock_data(struct feat_fd *ff,
 	return do_write(ff, data64, sizeof(*data64));
 }
 
+static int write_hybrid_topology(struct feat_fd *ff,
+				 struct evlist *evlist __maybe_unused)
+{
+	struct hybrid_topology *tp;
+	int ret;
+	u32 i;
+
+	tp = hybrid_topology__new();
+	if (!tp)
+		return -1;
+
+	ret = do_write(ff, &tp->nr, sizeof(u32));
+	if (ret < 0)
+		goto err;
+
+	for (i = 0; i < tp->nr; i++) {
+		struct hybrid_topology_node *n = &tp->nodes[i];
+
+		ret = do_write_string(ff, n->pmu_name);
+		if (ret < 0)
+			goto err;
+
+		ret = do_write_string(ff, n->cpus);
+		if (ret < 0)
+			goto err;
+	}
+
+	ret = 0;
+
+err:
+	hybrid_topology__delete(tp);
+	return ret;
+}
+
 static int write_dir_format(struct feat_fd *ff,
 			    struct evlist *evlist __maybe_unused)
 {
@@ -1623,6 +1657,19 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
 		    clockid_name(clockid));
 }
 
+static void print_hybrid_topology(struct feat_fd *ff, FILE *fp)
+{
+	int i;
+	struct hybrid_node *n;
+
+	for (i = 0; i < ff->ph->env.nr_hybrid_nodes; i++) {
+		n = &ff->ph->env.hybrid_nodes[i];
+
+		fprintf(fp, "# %s cpu list : ", n->pmu_name);
+		cpu_map__fprintf(n->map, fp);
+	}
+}
+
 static void print_dir_format(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_session *session;
@@ -2849,6 +2896,50 @@ static int process_clock_data(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_hybrid_topology(struct feat_fd *ff,
+				   void *data __maybe_unused)
+{
+	struct hybrid_node *nodes, *n;
+	u32 nr, i;
+	char *str;
+
+	/* nr nodes */
+	if (do_read_u32(ff, &nr))
+		return -1;
+
+	nodes = zalloc(sizeof(*nodes) * nr);
+	if (!nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < nr; i++) {
+		n = &nodes[i];
+
+		n->pmu_name = do_read_string(ff);
+		if (!n->pmu_name)
+			goto error;
+
+		str = do_read_string(ff);
+		if (!str)
+			goto error;
+
+		n->map = perf_cpu_map__new(str);
+		free(str);
+		if (!n->map)
+			goto error;
+	}
+
+	ff->ph->env.nr_hybrid_nodes = nr;
+	ff->ph->env.hybrid_nodes = nodes;
+	return 0;
+
+error:
+	for (i = 0; i < nr; i++)
+		free(nodes[i].pmu_name);
+
+	free(nodes);
+	return -1;
+}
+
 static int process_dir_format(struct feat_fd *ff,
 			      void *_data __maybe_unused)
 {
@@ -3117,6 +3208,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(COMPRESSED,	compressed,	false),
 	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
+	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 2aca71763ecf..3f12ec0eb84e 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -45,6 +45,7 @@ enum {
 	HEADER_COMPRESSED,
 	HEADER_CPU_PMU_CAPS,
 	HEADER_CLOCK_DATA,
+	HEADER_HYBRID_TOPOLOGY,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index d0fa7bc50a76..2b186c26a43e 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -19,4 +19,15 @@ struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
 char *perf_pmu__hybrid_type_to_pmu(const char *type);
 
+static inline int perf_pmu__hybrid_pmu_num(void)
+{
+	struct perf_pmu *pmu;
+	int num = 0;
+
+	perf_pmu__for_each_hybrid_pmu(pmu)
+		num++;
+
+	return num;
+}
+
 #endif /* __PMU_HYBRID_H */
-- 
2.17.1

