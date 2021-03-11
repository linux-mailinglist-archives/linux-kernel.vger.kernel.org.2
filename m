Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A818B336CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCKHJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhCKHIi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:38 -0500
IronPort-SDR: Su8z6nYHnKtOJn70rERqmcA2NMMiVjxBKnf+VHSX4DCiB/MioycxLmxbpLlCEVKtgBl1U5XUFL
 Yeuhrz9TdGrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246045"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:38 -0800
IronPort-SDR: YlkUpQeC1kx9OJ/tey6AvKkooA90TXWAH650L6hlGdCsFKrbZ8KREdMvR347vuB6gnEiEYXVDa
 p5lnNEIB5b8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937877"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:36 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 08/27] perf stat: Uniquify hybrid event name
Date:   Thu, 11 Mar 2021 15:07:23 +0800
Message-Id: <20210311070742.9318-9-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
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
 tools/perf/builtin-stat.c      |  3 +++
 tools/perf/util/stat-display.c | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68ecf68699a9..6c0a21323814 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2390,6 +2390,9 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (perf_pmu__hybrid_exist())
+		stat_config.no_merge = true;
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7f09cdaf5b60..ed37d8e7ea1a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -526,6 +526,7 @@ static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
+	int ret;
 
 	if (counter->uniquified_name ||
 	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
@@ -540,8 +541,15 @@ static void uniquify_event_name(struct evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
-		if (asprintf(&new_name,
-			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
+		if (perf_pmu__hybrid_exist()) {
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

