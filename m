Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD7379F32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEKFc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:32:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:29162 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhEKFcW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:32:22 -0400
IronPort-SDR: qTM7j0nyimf5IkMEl759gzWJ3cZp2JlSbyX+IGhyZUgSgkrQ6lgzKp5rrg9vjxeISEibfENyMH
 cbcVnhBIKO/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284846672"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284846672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:31:16 -0700
IronPort-SDR: XPteq5kE8czyLeiHFy9KXq2Dk1/bO4cNxiwhO9nK+fJGistvpo+7lovJlQlenoac3pebnyQ0O2
 bahyXR44PCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="461769902"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2021 22:31:14 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature
Date:   Tue, 11 May 2021 13:30:03 +0800
Message-Id: <20210511053003.27015-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511053003.27015-1-yao.jin@linux.intel.com>
References: <20210511053003.27015-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf has supported CPU_PMU_CAPS feature to display a list
of cpu PMU capabilities. But on hybrid platform, it may have
several cpu pmus (such as, "cpu_core" and "cpu_atom"). The
CPU_PMU_CAPS feature is hard to extend to support multiple
cpu pmus well if it needs to be compatible for the case that
is old perf data file + new perf tool.

So for better compatibility we now create a new feature
HYBRID_CPU_PMU_CAPS in header.

For the perf.data generated on hybrid platform,

  root@otcpl-adl-s-2:~# perf report --header-only -I

  # cpu_core pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
  # cpu_atom pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA

For the perf.data generated on non-hybrid platform

  root@kbl-ppc:~# perf report --header-only -I

  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY HYBRID_CPU_PMU_CAPS

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 .../Documentation/perf.data-file-format.txt   |  16 ++
 tools/perf/util/env.c                         |   6 +
 tools/perf/util/env.h                         |   9 +
 tools/perf/util/header.c                      | 163 ++++++++++++++++--
 tools/perf/util/header.h                      |   1 +
 5 files changed, 176 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index fbee9e580ee4..e6ff8c898ada 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -419,6 +419,22 @@ Example:
   cpu_core cpu list : 0-15
   cpu_atom cpu list : 16-23
 
+	HEADER_HYBRID_CPU_PMU_CAPS = 31,
+
+	A list of hybrid CPU PMU capabilities.
+
+struct {
+	u32 nr_pmu;
+	struct {
+		u32 nr_cpu_pmu_caps;
+		{
+			char	name[];
+			char	value[];
+		} [nr_cpu_pmu_caps];
+		char pmu_name[];
+	} [nr_pmu];
+};
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 744ae87b5bfa..1bea5b29b12d 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -208,6 +208,12 @@ void perf_env__exit(struct perf_env *env)
 		zfree(&env->hybrid_nodes[i].cpus);
 	}
 	zfree(&env->hybrid_nodes);
+
+	for (i = 0; i < env->nr_hybrid_cpc_nodes; i++) {
+		zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps);
+		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
+	}
+	zfree(&env->hybrid_cpc_nodes);
 }
 
 void perf_env__init(struct perf_env *env __maybe_unused)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e5e5deebe68d..6824a7423a2d 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -42,6 +42,13 @@ struct hybrid_node {
 	char	*cpus;
 };
 
+struct hybrid_cpc_node {
+	int		nr_cpu_pmu_caps;
+	unsigned int    max_branches;
+	char            *cpu_pmu_caps;
+	char            *pmu_name;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -65,6 +72,7 @@ struct perf_env {
 	int			nr_groups;
 	int			nr_cpu_pmu_caps;
 	int			nr_hybrid_nodes;
+	int			nr_hybrid_cpc_nodes;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -84,6 +92,7 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	struct hybrid_node	*hybrid_nodes;
+	struct hybrid_cpc_node	*hybrid_cpc_nodes;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ebf4203b36b8..f7f2f026bb00 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -49,6 +49,7 @@
 #include "cputopo.h"
 #include "bpf-event.h"
 #include "clockid.h"
+#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1459,18 +1460,14 @@ static int write_compressed(struct feat_fd *ff __maybe_unused,
 	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
 }
 
-static int write_cpu_pmu_caps(struct feat_fd *ff,
-			      struct evlist *evlist __maybe_unused)
+static int write_per_cpu_pmu_caps(struct feat_fd *ff, struct perf_pmu *pmu,
+				  bool write_pmu)
 {
-	struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");
 	struct perf_pmu_caps *caps = NULL;
 	int nr_caps;
 	int ret;
 
-	if (!cpu_pmu)
-		return -ENOENT;
-
-	nr_caps = perf_pmu__caps_parse(cpu_pmu);
+	nr_caps = perf_pmu__caps_parse(pmu);
 	if (nr_caps < 0)
 		return nr_caps;
 
@@ -1478,7 +1475,7 @@ static int write_cpu_pmu_caps(struct feat_fd *ff,
 	if (ret < 0)
 		return ret;
 
-	list_for_each_entry(caps, &cpu_pmu->caps, list) {
+	list_for_each_entry(caps, &pmu->caps, list) {
 		ret = do_write_string(ff, caps->name);
 		if (ret < 0)
 			return ret;
@@ -1488,9 +1485,49 @@ static int write_cpu_pmu_caps(struct feat_fd *ff,
 			return ret;
 	}
 
+	if (write_pmu) {
+		ret = do_write_string(ff, pmu->name);
+		if (ret < 0)
+			return ret;
+	}
+
 	return ret;
 }
 
+static int write_cpu_pmu_caps(struct feat_fd *ff,
+			      struct evlist *evlist __maybe_unused)
+{
+	struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");
+
+	if (!cpu_pmu)
+		return -ENOENT;
+
+	return write_per_cpu_pmu_caps(ff, cpu_pmu, false);
+}
+
+static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
+				     struct evlist *evlist __maybe_unused)
+{
+	struct perf_pmu *pmu;
+	u32 nr_pmu = perf_pmu__hybrid_pmu_num();
+	int ret;
+
+	if (nr_pmu == 0)
+		return -ENOENT;
+
+	ret = do_write(ff, &nr_pmu, sizeof(nr_pmu));
+	if (ret < 0)
+		return ret;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		ret = write_per_cpu_pmu_caps(ff, pmu, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1962,18 +1999,28 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
 }
 
-static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
+				   char *pmu_name)
 {
-	const char *delimiter = "# cpu pmu capabilities: ";
-	u32 nr_caps = ff->ph->env.nr_cpu_pmu_caps;
-	char *str;
+	const char *delimiter;
+	char *str, buf[128];
 
 	if (!nr_caps) {
-		fprintf(fp, "# cpu pmu capabilities: not available\n");
+		if (!pmu_name)
+			fprintf(fp, "# cpu pmu capabilities: not available\n");
+		else
+			fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
 		return;
 	}
 
-	str = ff->ph->env.cpu_pmu_caps;
+	if (!pmu_name)
+		scnprintf(buf, sizeof(buf), "# cpu pmu capabilities: ");
+	else
+		scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
+
+	delimiter = buf;
+
+	str = cpu_pmu_caps;
 	while (nr_caps--) {
 		fprintf(fp, "%s%s", delimiter, str);
 		delimiter = ", ";
@@ -1983,6 +2030,24 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "\n");
 }
 
+static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	print_per_cpu_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
+			       ff->ph->env.cpu_pmu_caps, NULL);
+}
+
+static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	struct hybrid_cpc_node *n;
+
+	for (int i = 0; i < ff->ph->env.nr_hybrid_cpc_nodes; i++) {
+		n = &ff->ph->env.hybrid_cpc_nodes[i];
+		print_per_cpu_pmu_caps(fp, n->nr_cpu_pmu_caps,
+				       n->cpu_pmu_caps,
+				       n->pmu_name);
+	}
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -3088,8 +3153,9 @@ static int process_compressed(struct feat_fd *ff,
 	return 0;
 }
 
-static int process_cpu_pmu_caps(struct feat_fd *ff,
-				void *data __maybe_unused)
+static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
+				    char **cpu_pmu_caps,
+				    unsigned int *max_branches)
 {
 	char *name, *value;
 	struct strbuf sb;
@@ -3103,7 +3169,7 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
 		return 0;
 	}
 
-	ff->ph->env.nr_cpu_pmu_caps = nr_caps;
+	*nr_cpu_pmu_caps = nr_caps;
 
 	if (strbuf_init(&sb, 128) < 0)
 		return -1;
@@ -3125,12 +3191,12 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
 			goto free_value;
 
 		if (!strcmp(name, "branches"))
-			ff->ph->env.max_branches = atoi(value);
+			*max_branches = atoi(value);
 
 		free(value);
 		free(name);
 	}
-	ff->ph->env.cpu_pmu_caps = strbuf_detach(&sb, NULL);
+	*cpu_pmu_caps = strbuf_detach(&sb, NULL);
 	return 0;
 
 free_value:
@@ -3142,6 +3208,64 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
 	return -1;
 }
 
+static int process_cpu_pmu_caps(struct feat_fd *ff,
+				void *data __maybe_unused)
+{
+	int ret;
+
+	ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
+				       &ff->ph->env.cpu_pmu_caps,
+				       &ff->ph->env.max_branches);
+	return ret;
+}
+
+static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
+				       void *data __maybe_unused)
+{
+	struct hybrid_cpc_node *nodes;
+	u32 nr_pmu, i;
+	int ret;
+
+	if (do_read_u32(ff, &nr_pmu))
+		return -1;
+
+	if (!nr_pmu) {
+		pr_debug("hybrid cpu pmu capabilities not available\n");
+		return 0;
+	}
+
+	nodes = zalloc(sizeof(*nodes) * nr_pmu);
+	if (!nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_pmu; i++) {
+		struct hybrid_cpc_node *n = &nodes[i];
+
+		ret = process_per_cpu_pmu_caps(ff, &n->nr_cpu_pmu_caps,
+					       &n->cpu_pmu_caps,
+					       &n->max_branches);
+		if (ret)
+			goto err;
+
+		n->pmu_name = do_read_string(ff);
+		if (!n->pmu_name)
+			goto err;
+	}
+
+	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
+	ff->ph->env.hybrid_cpc_nodes = nodes;
+	return 0;
+
+err:
+	for (i = 0; i < nr_pmu; i++) {
+		free(nodes[i].cpu_pmu_caps);
+		free(nodes[i].pmu_name);
+	}
+
+	free(nodes);
+	return ret;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3204,6 +3328,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
+	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 3f12ec0eb84e..ae6b1cf19a7d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -46,6 +46,7 @@ enum {
 	HEADER_CPU_PMU_CAPS,
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
+	HEADER_HYBRID_CPU_PMU_CAPS,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

