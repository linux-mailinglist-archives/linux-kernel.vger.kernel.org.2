Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67314306A85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhA1BhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:37:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:43082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhA1Bgl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:36:41 -0500
IronPort-SDR: nzAbKRaS/oK5CZVGkumdEMNUqzBxhLTv4Nw90ArRdvO9UW6XPVObddFqG8ZhBgQ0OnT9hagQR5
 uGTEGPoexMYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167260203"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="167260203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 17:34:52 -0800
IronPort-SDR: pQybuhXOpcp3Q1v2OxK/sPs9y1i4g/ikZelc29b860/ep9/zkSQt+vZOuTyBoEbIb9txirDT01
 7a2UKISJstrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="473369631"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2021 17:34:49 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v9] perf stat: Fix wrong skipping for per-die aggregation
Date:   Thu, 28 Jan 2021 09:34:17 +0800
Message-Id: <20210128013417.25597-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
--per-die aggregation yet.

One issue is found in check_per_pkg() for uncore events running on
AP system. On cascade Lake-AP, we have:

S0-D0
S0-D1
S1-D0
S1-D1

But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
That's not correct.

root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
     1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
     1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
     1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
     1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
     2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
     2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
     2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
     2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
     3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
     3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
     3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
     3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
     4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
     4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
     4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
     4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
     5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
     5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
     5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
     5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read

From above output, we can see S0-D1 and S1-D1 don't report the interval
values, they are continued to grow. That's because check_per_pkg() wrongly
decides to use zero counts for S0-D1 and S1-D1.

So in check_per_pkg(), we should use hashmap(socket,die) to decide if
the cpu counts needs to skip. Only considering socket is not enough.

Now with this patch,

root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
     1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
     1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
     1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
     1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
     2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
     2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
     2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
     2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
     3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
     3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
     3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
     3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
     4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
     4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
     4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
     4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
     5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
     5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
     5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
     5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read

On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
is not changed.

Reported-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v9:
 Rename zero_per_pkg to evsel__zero_per_pkg and move it to evsel.c. Then
 evsel__zero_per_pkg can be called under different code path.

 Call evsel__zero_per_pkg in evsel__exit().

v8:
 Jiri contributes idea and code to allocate 'uint64_t' type hash key for better
 supporting for 64 bits platform and 32 bits platform. I merge Jiri's code in this
 patch. Thanks Jiri!

 Rebase the patch to latest perf/core branch.

v7:
 It reported build error on 32-bit system (such as cross build by mipsel-linux-gnu-gcc).

 In v7,
 1. Use size_t to replace uint64_t.
 2. The hash key is changed from 'die_id << 32 | socket_id' to 'die_id << 16 | socket_id',
    16 bits is enough for socket id , right?

v6:
 Fix the perf test python failure by adding hashmap.c to python-ext-sources.

 root@kbl-ppc:~# ./perf test python
 19: 'import perf' in python                                         : Ok

v5:
 Hash key is changed to die_id << 32 | socket.
 In pkg_id_hash, return (int64_t)key & 0xffffffff; actually it's socket.

v4:
 v3 used unnecessary bool allocatioin. v4 just uses the hash value '(void *)1'.

 v4 is compiled ok with tmp.perf/core.

v3:
 Since for some cpumap functions, the return type is changed from 'int' to
 'struct aggr_cpu_id', the patch needs to be updated as well.

 before:
   d = cpu_map__get_die()

 after:
   d = cpu_map__get_die().die

 v3 is compiled ok with tmp.perf/core.

v2:
 Use hashmap to check the used socket+die pair.

 tools/perf/util/evsel.c            | 18 +++++++++++-
 tools/perf/util/evsel.h            |  4 ++-
 tools/perf/util/python-ext-sources |  1 +
 tools/perf/util/stat.c             | 47 ++++++++++++++++++++++++------
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8b18ec56e266..a8799bfa9fa7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,6 +46,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util.h"
+#include "hashmap.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
@@ -1385,7 +1386,9 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
-	zfree(&evsel->per_pkg_mask);
+	evsel__zero_per_pkg(evsel);
+	hashmap__free(evsel->per_pkg_mask);
+	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
@@ -2757,3 +2760,16 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 
 	return store_evsel_ids(evsel, evlist);
 }
+
+void evsel__zero_per_pkg(struct evsel *evsel)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (evsel->per_pkg_mask) {
+		hashmap__for_each_entry(evsel->per_pkg_mask, cur, bkt)
+			free((char *)cur->key);
+
+		hashmap__clear(evsel->per_pkg_mask);
+	}
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e25594494cf6..ede7c54ddc9c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -19,6 +19,7 @@ struct perf_stat_evsel;
 union perf_event;
 struct bpf_counter_ops;
 struct target;
+struct hashmap;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
@@ -112,7 +113,7 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
-	unsigned long		*per_pkg_mask;
+	struct hashmap		*per_pkg_mask;
 	struct evsel		*leader;
 	struct list_head	config_terms;
 	int			err;
@@ -430,4 +431,5 @@ struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
+void evsel__zero_per_pkg(struct evsel *evsel);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 71b753523fac..845dd46e3c61 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -36,3 +36,4 @@ util/symbol_fprintf.c
 util/units.c
 util/affinity.c
 util/rwsem.c
+util/hashmap.c
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0b3957323f66..a6f1fed995b5 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -13,6 +13,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
+#include "hashmap.h"
 #include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
@@ -273,18 +274,29 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
 	}
 }
 
-static void zero_per_pkg(struct evsel *counter)
+static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
 {
-	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
+	uint64_t *key = (uint64_t *) __key;
+
+	return *key & 0xffffffff;
+}
+
+static bool pkg_id_equal(const void *__key1, const void *__key2,
+			 void *ctx __maybe_unused)
+{
+	uint64_t *key1 = (uint64_t *) __key1;
+	uint64_t *key2 = (uint64_t *) __key2;
+
+	return *key1 == *key2;
 }
 
 static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
-	unsigned long *mask = counter->per_pkg_mask;
+	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
-	int s;
+	int s, d, ret = 0;
+	uint64_t *key;
 
 	*skip = false;
 
@@ -295,7 +307,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(cpu__max_cpu());
+		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
 		if (!mask)
 			return -ENOMEM;
 
@@ -317,8 +329,25 @@ static int check_per_pkg(struct evsel *counter,
 	if (s < 0)
 		return -1;
 
-	*skip = test_and_set_bit(s, mask) == 1;
-	return 0;
+	/*
+	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
+	 * We use hashmap(socket, die) to check the used socket+die pair.
+	 */
+	d = cpu_map__get_die(cpus, cpu, NULL).die;
+	if (d < 0)
+		return -1;
+
+	key = malloc(sizeof(*key));
+	if (!key)
+		return -ENOMEM;
+
+	*key = (uint64_t)d << 32 | s;
+	if (hashmap__find(mask, (void *)key, NULL))
+		*skip = true;
+	else
+		ret = hashmap__add(mask, (void *)key, (void *)1);
+
+	return ret;
 }
 
 static int
@@ -418,7 +447,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	}
 
 	if (counter->per_pkg)
-		zero_per_pkg(counter);
+		evsel__zero_per_pkg(counter);
 
 	ret = process_counter_maps(config, counter);
 	if (ret)
-- 
2.17.1

