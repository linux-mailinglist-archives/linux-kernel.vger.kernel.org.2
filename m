Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7143D1B83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhGVBGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:06:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:55053 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhGVBGq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:06:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208431628"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="208431628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 18:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="470359857"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2021 18:47:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1] perf pmu: Add PMU alias support
Date:   Thu, 22 Jul 2021 09:45:46 +0800
Message-Id: <20210722014546.11948-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A perf uncore PMU may have two PMU names, a real name and an alias. The
alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
The perf tool should support the alias as well.

Add alias_name in the struct perf_pmu to store the alias. For the PMU
which doesn't have an alias. It's NULL.

Introduce two X86 specific functions to retrieve the real name and the
alias separately.

Only go through the sysfs to retrieve the mapping between the real name
and the alias once. The result is cached in a list, uncore_pmu_list.

Nothing changed for the other ARCHs.

With the patch, the perf tool can monitor the PMU with either the real
name or the alias.

Use the real name,
 $ perf stat -e uncore_cha_2/event=1/ -x,
   4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,

Use the alias,
 $ perf stat -e uncore_type_0_2/event=1/ -x,
   3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,

Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/pmu.c | 109 ++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.y |   3 +-
 tools/perf/util/pmu.c          |  26 +++++++-
 tools/perf/util/pmu.h          |   5 ++
 4 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index d48d608517fd..bb79b1d19b96 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,12 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
-
+#include <stdio.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <fcntl.h>
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
+#include <linux/zalloc.h>
+#include <api/fs/fs.h>
 
 #include "../../../util/intel-pt.h"
 #include "../../../util/intel-bts.h"
 #include "../../../util/pmu.h"
+#include "../../../util/fncache.h"
+
+#define TEMPLATE_ALIAS	"%s/bus/event_source/devices/%s/alias"
+
+struct perf_pmu_alias_name {
+	char *name;
+	char *alias;
+	struct list_head list;
+};
+
+static LIST_HEAD(pmu_alias_name_list);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -18,3 +34,94 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 #endif
 	return NULL;
 }
+
+static void setup_pmu_alias_list(void)
+{
+	char path[PATH_MAX];
+	DIR *dir;
+	struct dirent *dent;
+	const char *sysfs = sysfs__mountpoint();
+	struct perf_pmu_alias_name *pmu;
+	char buf[MAX_PMU_NAME_LEN];
+	FILE *file;
+
+	if (!sysfs)
+		return;
+
+	snprintf(path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+
+	dir = opendir(path);
+	if (!dir)
+		return;
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		snprintf(path, PATH_MAX,
+			 TEMPLATE_ALIAS, sysfs, dent->d_name);
+
+		if (!file_available(path))
+			continue;
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		if (fscanf(file, "%s", buf) != 1)
+			continue;
+
+		pmu = zalloc(sizeof(*pmu));
+		if (!pmu)
+			continue;
+
+		pmu->alias = strdup(buf);
+		if (!pmu->alias) {
+			free(pmu);
+			continue;
+		}
+		pmu->name = strdup(dent->d_name);
+		list_add_tail(&pmu->list, &pmu_alias_name_list);
+		fclose(file);
+	}
+
+	closedir(dir);
+}
+
+static char *__pmu_find_real_name(const char *name)
+{
+	struct perf_pmu_alias_name *pmu;
+
+	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu->alias))
+			return strdup(pmu->name);
+	}
+
+	return strdup(name);
+}
+
+char *pmu_find_real_name(const char *name)
+{
+	static bool cached_list;
+
+	if (cached_list)
+		return __pmu_find_real_name(name);
+
+	setup_pmu_alias_list();
+	cached_list = true;
+
+	return __pmu_find_real_name(name);
+}
+
+char *pmu_find_alias_name(const char *name)
+{
+	struct perf_pmu_alias_name *pmu;
+
+	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu->name))
+			return strdup(pmu->alias);
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9321bd0e2f76..d94e48e1ff9b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!perf_pmu__match(pattern, name, $1)) {
+			if (!perf_pmu__match(pattern, name, $1) ||
+			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44b90d638ad5..cc9af7942e7b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -944,13 +944,28 @@ static int pmu_max_precise(const char *name)
 	return max_precise;
 }
 
-static struct perf_pmu *pmu_lookup(const char *name)
+char * __weak
+pmu_find_real_name(const char *name)
+{
+	return strdup(name);
+}
+
+char * __weak
+pmu_find_alias_name(const char *name __maybe_unused)
+{
+	return NULL;
+}
+
+static struct perf_pmu *pmu_lookup(const char *lookup_name)
 {
 	struct perf_pmu *pmu;
+	char *name;
 	LIST_HEAD(format);
 	LIST_HEAD(aliases);
 	__u32 type;
 
+	name = pmu_find_real_name(lookup_name);
+
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -973,7 +988,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
-	pmu->name = strdup(name);
+	pmu->name = name;
+	pmu->alias_name = pmu_find_alias_name(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
@@ -1003,7 +1019,8 @@ static struct perf_pmu *pmu_find(const char *name)
 	struct perf_pmu *pmu;
 
 	list_for_each_entry(pmu, &pmus, list)
-		if (!strcmp(pmu->name, name))
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
 
 	return NULL;
@@ -1898,6 +1915,9 @@ bool perf_pmu__has_hybrid(void)
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
 {
+	if (!name)
+		return -1;
+
 	if (fnmatch(pattern, name, 0))
 		return -1;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 926da483a141..f6ca9f6a06ef 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -21,6 +21,7 @@ enum {
 #define PERF_PMU_FORMAT_BITS 64
 #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
+#define MAX_PMU_NAME_LEN 128
 
 struct perf_event_attr;
 
@@ -32,6 +33,7 @@ struct perf_pmu_caps {
 
 struct perf_pmu {
 	char *name;
+	char *alias_name;	/* PMU alias name */
 	char *id;
 	__u32 type;
 	bool selectable;
@@ -135,4 +137,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
+char *pmu_find_real_name(const char *name);
+char *pmu_find_alias_name(const char *name);
+
 #endif /* __PMU_H */
-- 
2.17.1

