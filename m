Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8136BFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhD0HEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:3195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234898AbhD0HEL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:11 -0400
IronPort-SDR: VRuIkhUpZKUN3DN1AxYsapYgdcJ2d49haioAnEAFAhv4iMPQHQNxvIPak4QTXheCsg7kj0azI0
 knkdBUOY1dgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944191"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944191"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:28 -0700
IronPort-SDR: IsFeZPUrtCqepgQRLIlBUa7+PaUYT/yKKZIx4VMIFG9rjiWTkwZ4BqCnE0zjzScXG5al3qQg4M
 t0wId+wZEsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506656"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:24 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 07/26] perf stat: Uniquify hybrid event name
Date:   Tue, 27 Apr 2021 15:01:20 +0800
Message-Id: <20210427070139.25256-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
 - Rebase to tmp.perf/core branch.

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
index 5ec2190e45cd..835e3696b9ce 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -69,6 +69,7 @@
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
+#include "util/pmu-hybrid.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -2402,6 +2403,9 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (perf_pmu__has_hybrid())
+		stat_config.no_merge = true;
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8f66cdcb338d..ad74c83bd35b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -116,6 +116,7 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
+	bool			use_config_name;
 	struct hashmap		*per_pkg_mask;
 	struct evsel		*leader;
 	struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 46ebd269a98d..f4628c886e30 100644
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
index 98664caef6af..0679129ad05e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -18,6 +18,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
+#include "pmu-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -538,6 +539,7 @@ static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
+	int ret = 0;
 
 	if (counter->uniquified_name ||
 	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
@@ -552,8 +554,17 @@ static void uniquify_event_name(struct evsel *counter)
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

