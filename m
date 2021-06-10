Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8493A23C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 07:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFJFTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 01:19:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:18943 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJFTo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 01:19:44 -0400
IronPort-SDR: ceusccjUpeLV9LbJ23ntZuRjCv1VXpXhjg45m+4UMWu1gj+VYwszFeXfm5PSflN3BNhE/BwftV
 i+/sZrzYvuQg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192339314"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="192339314"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 22:17:48 -0700
IronPort-SDR: 9+7kCnaNEBxVKdeWAsKnJApnNmSROYtXgjTnOAKEGVbPiI89JlcYLwbXM70HPIN2D8bAFCNnRY
 p8EBROdxryMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="635656565"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2021 22:17:45 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf list: Skip the invalid hybrid pmu
Date:   Thu, 10 Jun 2021 13:16:46 +0800
Message-Id: <20210610051646.4003-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, such as Alderlake, if atom CPUs are offlined,
the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
which indicates this is an invalid pmu.

The perf-list needs to check and skip the invalid hybrid pmu.

Before:

  # perf list
  ...
  branch-instructions OR cpu_atom/branch-instructions/ [Kernel PMU event]
  branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
  branch-misses OR cpu_atom/branch-misses/           [Kernel PMU event]
  branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
  bus-cycles OR cpu_atom/bus-cycles/                 [Kernel PMU event]
  bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
  ...

The cpu_atom events are still displayed even if atom CPUs are offlined.

After:

  # perf list
  ...
  branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
  branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
  bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
  ...

Now only cpu_core events are displayed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu-hybrid.c | 11 +++++++++++
 tools/perf/util/pmu-hybrid.h |  2 ++
 tools/perf/util/pmu.c        |  3 +++
 3 files changed, 16 insertions(+)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index f51ccaac60ee..fcc1182f8fe5 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -87,3 +87,14 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
 	free(pmu_name);
 	return NULL;
 }
+
+bool perf_pmu__is_invalid_hybrid(const char *name)
+{
+	if (strncmp(name, "cpu_", 4))
+		return false;
+
+	if (perf_pmu__hybrid_mounted(name))
+		return false;
+
+	return true;
+}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 2b186c26a43e..8261a312c854 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -30,4 +30,6 @@ static inline int perf_pmu__hybrid_pmu_num(void)
 	return num;
 }
 
+bool perf_pmu__is_invalid_hybrid(const char *name);
+
 #endif /* __PMU_HYBRID_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc60b0..281670e9c4bd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1604,6 +1604,9 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (perf_pmu__is_invalid_hybrid(pmu->name))
+			continue;
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			char *name = alias->desc ? alias->name :
 				format_alias(buf, sizeof(buf), pmu, alias);
-- 
2.17.1

