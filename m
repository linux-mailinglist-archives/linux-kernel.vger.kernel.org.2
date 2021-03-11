Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D228336CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhCKHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhCKHI6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:58 -0500
IronPort-SDR: 29cWf3EqmVDepDQrc+dChe7EhNj46ti02CY1ZkdUmSoxWsnlMqJFJopB1eWoiWrwVAj1kGh/u4
 stYWsbn+hOpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246083"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246083"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:58 -0800
IronPort-SDR: w0LDzSuoOXFLP0++21EGcSUZy64hYPdpD7GsHBR+NA8O2+PPs+Imgi0pthfskHEzeb/YyjyVzT
 MXtM3tQ1JiBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937953"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:56 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 16/27] perf evlist: Warn as events from different hybrid PMUs in a group
Date:   Thu, 11 Mar 2021 15:07:31 +0800
Message-Id: <20210311070742.9318-17-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a group has events which are from different hybrid PMUs,
shows a warning.

This is to remind the user not to put the core event and atom
event into one group.

  root@ssp-pwrt-002:~# ./perf stat -e "{cpu_core/cycles/,cpu_atom/cycles/}" -- sleep 1
  WARNING: Group has events from different hybrid PMUs

   Performance counter stats for 'sleep 1':

       <not counted>      cpu_core/cycles/
     <not supported>      cpu_atom/cycles/

         1.002585908 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-record.c |  3 +++
 tools/perf/builtin-stat.c   |  7 ++++++
 tools/perf/util/evlist.c    | 44 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  2 ++
 4 files changed, 56 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 363ea1047148..188a1198cd4b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -929,6 +929,9 @@ static int record__open(struct record *rec)
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
index 7a732508b2b4..6f780a039db0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -239,6 +239,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 	struct evsel *evsel, *pos, *leader;
 	char buf[1024];
 
+	if (evlist__hybrid_exist(evlist))
+		return;
+
 	evlist__for_each_entry(evlist, evsel) {
 		leader = evsel->leader;
 
@@ -726,6 +729,10 @@ enum counter_recovery {
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
index f139151b9433..5ec891418cdd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2224,3 +2224,47 @@ void evlist__invalidate_all_cpus(struct evlist *evlist)
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
+		if (evsel__is_group_leader(evsel) &&
+		    evsel->core.nr_members > 1 &&
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
index 0da683511d98..33dec3bb5739 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -369,4 +369,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 void evlist__invalidate_all_cpus(struct evlist *evlist);
 
 bool evlist__has_hybrid_events(struct evlist *evlist);
+void evlist__warn_hybrid_group(struct evlist *evlist);
+bool evlist__hybrid_exist(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

