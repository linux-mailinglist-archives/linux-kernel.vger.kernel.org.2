Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A034C474
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhC2HCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:52628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhC2HCM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:12 -0400
IronPort-SDR: DAU8sXJfJKceKsEOW+FHb41l/3BiX2kSs55a7L3iQc89E9SNXg5Pd3yQv6dFhYvBx4pXVXBQUk
 fAS86kmkZItQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="171505704"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="171505704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:11 -0700
IronPort-SDR: MYpFq+k7GWUP/CVZ3uN1VKQxTjKYWOn8E1c+rkfySBw3XZub3AmSrzmH3lRfpfw7qQIltP47S9
 wLtxb9lJEjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677451"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:08 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 11/27] perf pmu: Support 'cycles' and 'branches' inside hybrid PMU
Date:   Mon, 29 Mar 2021 15:00:30 +0800
Message-Id: <20210329070046.8815-12-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, user may want to enable the hardware event
only on one PMU. So following syntax is supported:

cpu_core/<hardware event>/
cpu_atom/<hardware event>/

  # perf stat -e cpu_core/cpu-cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

           6,049,336      cpu_core/cpu-cycles/

         1.003577042 seconds time elapsed

It enables the event 'cpu-cycles' only on cpu_core pmu.

But for 'cycles' and 'branches', the syntax doesn't work.

Before:

  # perf stat -e cpu_core/cycles/ -a -- sleep 1
  event syntax error: 'cpu_core/cycles/'
                                \___ unknown term 'cycles' for pmu 'cpu_core'

  # perf stat -e cpu_core/branches/ -a -- sleep 1
  event syntax error: 'cpu_core/branches/'
                                \___ unknown term 'branches' for pmu 'cpu_core'

For 'cpu-cycles', why it works is because the event is defined in
/sys/devices/cpu_core/events/. It's added as alias by
pmu_add_sys_aliases and it's treated as 'event' when parsing the
term->config.

We use a similar idea, create a pme_hybrid_fixup table for
'cycles' and 'branches' and add them as aliases.

After:

  # perf stat -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

           5,769,631      cpu_core/cycles/

         1.003833235 seconds time elapsed

  # perf stat -e cpu_core/branches/ -a -- sleep 1

   Performance counter stats for 'system wide':

             490,951      cpu_core/branches/

         1.003693946 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - New patch in v3.

 tools/perf/util/pmu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index beff29981101..72e5ae5e868e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -916,6 +916,35 @@ static int pmu_max_precise(const char *name)
 	return max_precise;
 }
 
+static void perf_pmu__add_hybrid_aliases(struct list_head *head)
+{
+	static struct pmu_event pme_hybrid_fixup[] = {
+		{
+			.name = "cycles",
+			.event = "event=0x3c",
+		},
+		{
+			.name = "branches",
+			.event = "event=0xc4",
+		},
+		{
+			.name = 0,
+			.event = 0,
+		},
+	};
+	int i = 0;
+
+	while (1) {
+		struct pmu_event *pe = &pme_hybrid_fixup[i++];
+
+		if (!pe->name)
+			break;
+
+		__perf_pmu__new_alias(head, NULL, (char *)pe->name, NULL,
+				      (char *)pe->event, NULL);
+	}
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -955,6 +984,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
 
+	if (pmu->is_hybrid)
+		perf_pmu__add_hybrid_aliases(&aliases);
+
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
 	INIT_LIST_HEAD(&pmu->caps);
-- 
2.17.1

