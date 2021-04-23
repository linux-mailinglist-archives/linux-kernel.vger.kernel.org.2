Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF8368CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhDWFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:9279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240561AbhDWFh0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:26 -0400
IronPort-SDR: SoibJmErzh6ZaHs+MNwomPeYQAXXQ6hAIjFDTgbt9CgBRT5DOMCDt/8sUcPGNh9Prs4V6Xr4N9
 /c+vsJPwPrgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501782"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:36:50 -0700
IronPort-SDR: 1pSUfJIgchtVaeZtxPEAOj5ThQJY73LQ/axlOM9B3SO4eb0i/uDnpokM9MEn8Lrrqns+Gm94Bn
 FA4gYIBUBcSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293564"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 05/26] perf pmu: Save detected hybrid pmus to a global pmu list
Date:   Fri, 23 Apr 2021 13:35:20 +0800
Message-Id: <20210423053541.12521-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We identify the cpu_core pmu and cpu_atom pmu by explicitly
checking following files:

For cpu_core, checks:
"/sys/bus/event_source/devices/cpu_core/cpus"

For cpu_atom, checks:
"/sys/bus/event_source/devices/cpu_atom/cpus"

If the 'cpus' file exists and it has data, the pmu exists.

But in order not to hardcode the "cpu_core" and "cpu_atom",
and make the code in a generic way. So if the path
"/sys/bus/event_source/devices/cpu_xxx/cpus" exists, the hybrid
pmu exists. All the detected hybrid pmus are linked to a
global list 'perf_pmu__hybrid_pmus' and then next we just need
to iterate the list to get all hybrid pmu by using
perf_pmu__for_each_hybrid_pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - No change.

v4:
 - Check if 'cpus' file is empty. If so, don't create pmu.

v3:
 - No functional change.

 tools/perf/util/Build        |  1 +
 tools/perf/util/pmu-hybrid.c | 49 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu-hybrid.h | 18 +++++++++++++
 tools/perf/util/pmu.c        |  9 ++++++-
 tools/perf/util/pmu.h        |  4 +++
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/pmu-hybrid.c
 create mode 100644 tools/perf/util/pmu-hybrid.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e3e12f9d4733..37a8a63c7195 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -69,6 +69,7 @@ perf-y += parse-events-bison.o
 perf-y += pmu.o
 perf-y += pmu-flex.o
 perf-y += pmu-bison.o
+perf-y += pmu-hybrid.o
 perf-y += trace-event-read.o
 perf-y += trace-event-info.o
 perf-y += trace-event-scripting.o
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
new file mode 100644
index 000000000000..8ed0e6e1776d
--- /dev/null
+++ b/tools/perf/util/pmu-hybrid.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/list.h>
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <locale.h>
+#include <api/fs/fs.h>
+#include "fncache.h"
+#include "pmu-hybrid.h"
+
+LIST_HEAD(perf_pmu__hybrid_pmus);
+
+bool perf_pmu__hybrid_mounted(const char *name)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	FILE *file;
+	int n, cpu;
+
+	if (strncmp(name, "cpu_", 4))
+		return false;
+
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return false;
+
+	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
+	if (!file_available(path))
+		return false;
+
+	file = fopen(path, "r");
+	if (!file)
+		return false;
+
+	n = fscanf(file, "%u", &cpu);
+	fclose(file);
+	if (n <= 0)
+		return false;
+
+	return true;
+}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
new file mode 100644
index 000000000000..35bed3714438
--- /dev/null
+++ b/tools/perf/util/pmu-hybrid.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PMU_HYBRID_H
+#define __PMU_HYBRID_H
+
+#include <linux/perf_event.h>
+#include <linux/compiler.h>
+#include <linux/list.h>
+#include <stdbool.h>
+#include "pmu.h"
+
+extern struct list_head perf_pmu__hybrid_pmus;
+
+#define perf_pmu__for_each_hybrid_pmu(pmu)	\
+	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
+
+bool perf_pmu__hybrid_mounted(const char *name);
+
+#endif /* __PMU_HYBRID_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44225838eb03..6e49c7b8ad71 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -25,6 +25,7 @@
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
+#include "pmu-hybrid.h"
 
 struct perf_pmu perf_pmu__fake;
 
@@ -613,7 +614,6 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
  */
 #define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
 #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
-#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 
 static struct perf_cpu_map *pmu_cpumask(const char *name)
 {
@@ -645,6 +645,9 @@ static bool pmu_is_uncore(const char *name)
 	char path[PATH_MAX];
 	const char *sysfs;
 
+	if (perf_pmu__hybrid_mounted(name))
+		return false;
+
 	sysfs = sysfs__mountpoint();
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
 	return file_available(path);
@@ -951,6 +954,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
+	pmu->is_hybrid = perf_pmu__hybrid_mounted(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
@@ -962,6 +966,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
+	if (pmu->is_hybrid)
+		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
+
 	pmu->default_config = perf_pmu__get_default_config(pmu);
 
 	return pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 4f100768c264..9a2f89eeab6f 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -5,6 +5,7 @@
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
+#include <linux/list.h>
 #include <stdbool.h>
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
@@ -19,6 +20,7 @@ enum {
 
 #define PERF_PMU_FORMAT_BITS 64
 #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
+#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 
 struct perf_event_attr;
 
@@ -34,6 +36,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	bool is_hybrid;
 	bool auxtrace;
 	int max_precise;
 	struct perf_event_attr *default_config;
@@ -42,6 +45,7 @@ struct perf_pmu {
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
+	struct list_head hybrid_list;
 };
 
 extern struct perf_pmu perf_pmu__fake;
-- 
2.17.1

