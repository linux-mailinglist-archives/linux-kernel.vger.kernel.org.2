Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C350C34C471
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhC2HCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhC2HCA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:00 -0400
IronPort-SDR: MdPSgrmuPFMdOBroao0jR5a0Vdfd6NTUUiLRhGKkYSwgF/RgD7Lclz2wFNtPYAkJdvwHmVBySg
 HBXXGqK29sZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590410"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:00 -0700
IronPort-SDR: hbgbCFBVmS8BTIMk2L8io7xpNVBIP3DrzXmDwkcm4+JjkmRq0H2D+tBwSUZZF1HixqfGEQP1SE
 zQtoCb/+90fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677340"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:57 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 07/27] perf stat: Uniquify hybrid event name
Date:   Mon, 29 Mar 2021 15:00:26 +0800
Message-Id: <20210329070046.8815-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to tell user the pmu which the event belongs to.
perf-stat has supported '--no-merge' option and it can print the pmu
name after the event name, such as:

"cycles [cpu_core]"

Now this option is enabled by default for hybrid platform but change
the format to:

"cpu_core/cycles/"

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/builtin-stat.c      |  4 ++++
 tools/perf/util/stat-display.c | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4bb48c6b6698..7b2dfe21c5a8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -68,6 +68,7 @@
 #include "util/affinity.h"
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
+#include "util/pmu-hybrid.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -2371,6 +2372,9 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (perf_pmu__has_hybrid())
+		stat_config.no_merge = true;
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7f09cdaf5b60..161826938a00 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -17,6 +17,7 @@
 #include "cgroup.h"
 #include <api/fs/fs.h>
 #include "util.h"
+#include "pmu-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -526,6 +527,7 @@ static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
+	int ret;
 
 	if (counter->uniquified_name ||
 	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
@@ -540,8 +542,15 @@ static void uniquify_event_name(struct evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
-		if (asprintf(&new_name,
-			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
+		if (perf_pmu__has_hybrid()) {
+			ret = asprintf(&new_name, "%s/%s/",
+				       counter->pmu_name, counter->name);
+		} else {
+			ret = asprintf(&new_name, "%s [%s]",
+				       counter->name, counter->pmu_name);
+		}
+
+		if (ret) {
 			free(counter->name);
 			counter->name = new_name;
 		}
-- 
2.17.1

