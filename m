Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90E4368CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbhDWFhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:9279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240663AbhDWFhc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:32 -0400
IronPort-SDR: ShKkxAReFjWtZT187KtqlI/vW8iSHU2DPdut2oCwnb+bHpZp2yHLHPsWN6AdpNR/QsV5Tn5Lus
 3Y8v5aiwB0EQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501794"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:36:56 -0700
IronPort-SDR: UkxhYQDJzt25Fv9s7WXWC6aps//dlx5LVFOzZUbKAEY2sBMCogmLtcWHDuEbjsKk64pTEv0pGq
 VjfLIlX3k64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293586"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:53 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 07/26] perf stat: Uniquify hybrid event name
Date:   Fri, 23 Apr 2021 13:35:22 +0800
Message-Id: <20210423053541.12521-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to let user know the pmu which the event belongs to.
perf-stat has supported '--no-merge' option and it can print the pmu
name after the event name, such as:

"cycles [cpu_core]"

Now this option is enabled by default for hybrid platform but change
the format to:

"cpu_core/cycles/"

If user configs the name, we still use the user specified name.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - Move 'evsel->use_config_name = true;' from
   '[PATCH v5 12/26] perf parse-events: Support event inside hybrid pmu'
   to the patch.

v4:
 - If user configs the name, we still use the user specified name.

v3:
 - No change.

 tools/perf/builtin-stat.c      |  4 ++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c |  3 +++
 tools/perf/util/stat-display.c | 15 +++++++++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2a2c15cac80a..1255af4751c2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -68,6 +68,7 @@
 #include "util/affinity.h"
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
+#include "util/pmu-hybrid.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -2378,6 +2379,9 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (perf_pmu__has_hybrid())
+		stat_config.no_merge = true;
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eccc4fd5b3eb..d518da2fd2eb 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -115,6 +115,7 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
+	bool			use_config_name;
 	struct hashmap		*per_pkg_mask;
 	struct evsel		*leader;
 	struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8123d218ad17..b5edcd6452b8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1567,6 +1567,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (!evsel)
 		return -ENOMEM;
 
+	if (evsel->name)
+		evsel->use_config_name = true;
+
 	evsel->pmu_name = name ? strdup(name) : NULL;
 	evsel->use_uncore_alias = use_uncore_alias;
 	evsel->percore = config_term_percore(&evsel->config_terms);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d3137bc17065..5255d78b1c30 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -17,6 +17,7 @@
 #include "cgroup.h"
 #include <api/fs/fs.h>
 #include "util.h"
+#include "pmu-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -532,6 +533,7 @@ static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
+	int ret = 0;
 
 	if (counter->uniquified_name ||
 	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
@@ -546,8 +548,17 @@ static void uniquify_event_name(struct evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
-		if (asprintf(&new_name,
-			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
+		if (perf_pmu__has_hybrid()) {
+			if (!counter->use_config_name) {
+				ret = asprintf(&new_name, "%s/%s/",
+					       counter->pmu_name, counter->name);
+			}
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

