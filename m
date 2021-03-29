Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC134C46F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhC2HC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhC2HBz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:01:55 -0400
IronPort-SDR: MGuhptFoX6ogeM+wuHOxOTMGelj1mIUV5KKjMxPxiH/HfM1VxG+sgXrhZIoUvwbXb6KsCNHoMX
 nayDXW2+AQBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590392"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:01:55 -0700
IronPort-SDR: sOdfv2iST9xwQHOFIR2KU3wD4x4sNpLk+DZc2/KBdsTmqSMNld8X+jMADkdeSVNfgSVRN08L3u
 RXALHsPYvsww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677313"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:52 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 05/27] perf pmu: Save detected hybrid pmus to a global pmu list
Date:   Mon, 29 Mar 2021 15:00:24 +0800
Message-Id: <20210329070046.8815-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We identify the cpu_core pmu and cpu_atom pmu by explicitly
checking following files:

For cpu_core, checks:
"/sys/bus/event_source/devices/cpu_core/cpus"

For cpu_atom, checks:
"/sys/bus/event_source/devices/cpu_atom/cpus"

If the 'cpus' file exists, the pmu exists.

But in order not to hardcode the "cpu_core" and "cpu_atom",
and make the code in a generic way. So if the path
"/sys/bus/event_source/devices/cpu_xxx/cpus" exists, the hybrid
pmu exists. All the detected hybrid pmus are linked to a
global list 'perf_pmu__hybrid_pmus' and then next we just need
to iterate the list to get all hybrid pmu by using
perf_pmu__for_each_hybrid_pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/util/Build        |  1 +
 tools/perf/util/pmu-hybrid.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu-hybrid.h | 18 ++++++++++++++++++
 tools/perf/util/pmu.c        |  9 ++++++++-
 tools/perf/util/pmu.h        |  4 ++++
 5 files changed, 66 insertions(+), 1 deletion(-)
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
index 000000000000..7316bf46e54b
--- /dev/null
+++ b/tools/perf/util/pmu-hybrid.c
@@ -0,0 +1,35 @@
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
+
+	if (strncmp(name, "cpu_", 4))
+		return false;
+
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return false;
+
+	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
+	return file_available(path);
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
index 10709ec1cc3e..35e9660c3904 100644
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
@@ -946,6 +949,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
+	pmu->is_hybrid = perf_pmu__hybrid_mounted(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
@@ -957,6 +961,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
+	if (pmu->is_hybrid)
+		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
+
 	pmu->default_config = perf_pmu__get_default_config(pmu);
 
 	return pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8493b1719e10..29289e7c2649 100644
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

