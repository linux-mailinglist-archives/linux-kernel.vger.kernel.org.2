Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0CE313D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhBHSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:22:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:27981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhBHPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:30 -0500
IronPort-SDR: arJErlDH97oS1jO4FoZzb7L+7E7omAYwUjioyhPILy0eMwrdM5e4y5orBipPhtMD7a6CrlUvPS
 JPT9v67q00qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874634"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874634"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: Jm+YjDjj23QyFI6PM4jlZDuOKX8hnFizm+JWTGoHx2/Dy5ALf5FT1RZVP3wPmzvWFz2oe9ljZ6
 swlnHo9hnVIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820938"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 47/49] perf evlist: Warn as events from different hybrid PMUs in a group
Date:   Mon,  8 Feb 2021 07:25:44 -0800
Message-Id: <1612797946-18784-48-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

If a group has events which are from different hybrid PMUs,
shows a warning.

This is to remind the user not to put the core event and atom
event into one group.

root@otcpl-adl-s-2:~# ./perf stat -e "{cpu_core/cycles/,cpu_atom/cycles/}" -- sleep 1
WARNING: Group has events from different hybrid PMUs

 Performance counter stats for 'sleep 1':

     <not counted>      cycles [cpu_core]
   <not supported>      cycles [cpu_atom]

       1.001591674 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-record.c |  3 +++
 tools/perf/builtin-stat.c   |  7 +++++++
 tools/perf/util/evlist.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fd39116..cfc1b90 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -926,6 +926,9 @@ static int record__open(struct record *rec)
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
+
+			if (errno == EINVAL && perf_pmu__hybrid_exist())
+				evlist__warn_hybrid_group(evlist);
 			rc = -errno;
 			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
 			ui__error("%s\n", msg);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d367cfe..87a5f44 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -238,6 +238,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 	struct evsel *evsel, *pos, *leader;
 	char buf[1024];
 
+	if (evlist__hybrid_exist(evlist))
+		return;
+
 	evlist__for_each_entry(evlist, evsel) {
 		leader = evsel->leader;
 
@@ -692,6 +695,10 @@ enum counter_recovery {
 static enum counter_recovery stat_handle_error(struct evsel *counter)
 {
 	char msg[BUFSIZ];
+
+	if (perf_pmu__hybrid_exist() && errno == EINVAL)
+		evlist__warn_hybrid_group(evsel_list);
+
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
 	 * (behavior changed with commit b0a873e).
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8606e82..3bdff5c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2105,3 +2105,46 @@ void evlist__invalidate_all_cpus(struct evlist *evlist)
 	perf_cpu_map__put(evlist->core.all_cpus);
 	evlist->core.all_cpus = perf_cpu_map__empty_new(1);
 }
+
+static bool group_hybrid_conflict(struct evsel *leader)
+{
+	struct evsel *pos, *prev = NULL;
+
+	for_each_group_evsel(pos, leader) {
+		if (!pos->pmu_name || !perf_pmu__is_hybrid(pos->pmu_name))
+			continue;
+
+		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
+			return true;
+
+		prev = pos;
+	}
+
+	return false;
+}
+
+void evlist__warn_hybrid_group(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_group_event(evsel) &&
+		    group_hybrid_conflict(evsel)) {
+			WARN_ONCE(1, "WARNING: Group has events from "
+				     "different hybrid PMUs\n");
+			return;
+		}
+	}
+}
+
+bool evlist__hybrid_exist(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_hybrid_event(evsel))
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c06b9ff..55c944b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -358,4 +358,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 void evlist__invalidate_all_cpus(struct evlist *evlist);
 
 bool evlist__has_hybrid_events(struct evlist *evlist);
+void evlist__warn_hybrid_group(struct evlist *evlist);
+bool evlist__hybrid_exist(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.7.4

