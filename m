Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E03B77DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhF2Sbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:31:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:12482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235193AbhF2SbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:31:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269341979"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="269341979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="408270502"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2021 11:28:50 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 6/6] perf pmu: Add PMU alias support
Date:   Tue, 29 Jun 2021 11:14:03 -0700
Message-Id: <1624990443-168533-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
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
 $perf stat -e uncore_cha_2/event=1/ -x,
  4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,

Use the alias,
 $perf stat -e uncore_type_0_2/event=1/ -x,
  3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/arch/x86/util/pmu.c | 129 ++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.y |   4 +-
 tools/perf/util/pmu.c          |  23 +++++++-
 tools/perf/util/pmu.h          |   5 ++
 4 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index d48d608..f864ba2 100644
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
+#define TEMPLATE_UNCORE_ALIAS	"%s/bus/event_source/devices/%s/alias"
+
+struct perf_uncore_pmu_name {
+	char *name;
+	char *alias;
+	struct list_head list;
+};
+
+static LIST_HEAD(uncore_pmu_list);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -18,3 +34,114 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 #endif
 	return NULL;
 }
+
+static void setup_uncore_pmu_list(void)
+{
+	char path[PATH_MAX];
+	DIR *dir;
+	struct dirent *dent;
+	const char *sysfs = sysfs__mountpoint();
+	struct perf_uncore_pmu_name *pmu;
+	char buf[MAX_PMU_NAME_LEN];
+	FILE *file;
+	int size;
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
+		    !strcmp(dent->d_name, "..") ||
+		    strncmp(dent->d_name, "uncore_", 7))
+			continue;
+
+		snprintf(path, PATH_MAX,
+			 TEMPLATE_UNCORE_ALIAS, sysfs, dent->d_name);
+
+		if (!file_available(path))
+			continue;
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		memset(buf, 0, sizeof(buf));
+		if (!fread(buf, 1, sizeof(buf), file))
+			continue;
+
+		pmu = zalloc(sizeof(*pmu));
+		if (!pmu)
+			continue;
+
+		size = strlen(buf) - 1;
+		pmu->alias = zalloc(size);
+		if (!pmu->alias) {
+			free(pmu);
+			continue;
+		}
+		strncpy(pmu->alias, buf, size);
+		pmu->name = strdup(dent->d_name);
+		list_add_tail(&pmu->list, &uncore_pmu_list);
+
+		fclose(file);
+	}
+
+	closedir(dir);
+
+}
+
+static char *__pmu_find_real_name(const char *name)
+{
+	struct perf_uncore_pmu_name *pmu;
+
+	/*
+	 * The template of the uncore alias is uncore_type_*
+	 * Only find the real name for the uncore alias.
+	 */
+	if (strncmp(name, "uncore_type_", 12))
+		return strdup(name);
+
+	list_for_each_entry(pmu, &uncore_pmu_list, list) {
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
+	if (strncmp(name, "uncore_", 7))
+		return strdup(name);
+
+	if (cached_list)
+		return __pmu_find_real_name(name);
+
+	setup_uncore_pmu_list();
+	cached_list = true;
+
+	return __pmu_find_real_name(name);
+}
+
+char *pmu_find_alias_name(const char *name)
+{
+	struct perf_uncore_pmu_name *pmu;
+
+	if (strncmp(name, "uncore_", 7))
+		return NULL;
+
+	list_for_each_entry(pmu, &uncore_pmu_list, list) {
+		if (!strcmp(name, pmu->name))
+			return strdup(pmu->alias);
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index aba12a4..bc812af 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -316,7 +316,9 @@ event_pmu_name opt_pmu_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!fnmatch(pattern, name, 0)) {
+
+			if (!fnmatch(pattern, name, 0) ||
+			    (pmu->alias_name && !fnmatch(pattern, pmu->alias_name, 0))) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc..d7fb627 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -921,13 +921,28 @@ static int pmu_max_precise(const char *name)
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
@@ -950,7 +965,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
-	pmu->name = strdup(name);
+	pmu->name = name;
+	pmu->alias_name = pmu_find_alias_name(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
@@ -980,7 +996,8 @@ static struct perf_pmu *pmu_find(const char *name)
 	struct perf_pmu *pmu;
 
 	list_for_each_entry(pmu, &pmus, list)
-		if (!strcmp(pmu->name, name))
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
 
 	return NULL;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a790ef7..87212ec 100644
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
@@ -134,4 +136,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void);
 
+char *pmu_find_real_name(const char *name);
+char *pmu_find_alias_name(const char *name);
+
 #endif /* __PMU_H */
-- 
2.7.4

