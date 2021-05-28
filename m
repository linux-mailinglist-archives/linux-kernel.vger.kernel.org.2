Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C5393C24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhE1D60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:58:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:23443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE1D6Y (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:58:24 -0400
IronPort-SDR: JSQM6t+ZflweieAvw/2mtumIab2AHUlF0ityfRHjcdaZq2cGch45iKtoUe5yFuM0agSBZqyyzM
 Aj5rkFzQ4S5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202892285"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202892285"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 20:56:50 -0700
IronPort-SDR: oXCYAcHuiermtVnScFgTXfPqAEXEO3Dem1vqeXEuTChy/dC275n3Auo9cCQiPgL98NS22piWtJ
 iwpc+ec9ITTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="548422878"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 20:56:47 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Disable NMI watchdog message on hybrid
Date:   Fri, 28 May 2021 11:55:47 +0800
Message-Id: <20210528035547.19867-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we run a single workload that only runs on big core, there is always a
ugly message about disabling the NMI watchdog because the atom is not
counted.

Before:

  # perf stat ls
  ...

   Performance counter stats for 'ls':

                0.94 msec task-clock                #    0.620 CPUs utilized
                   0      context-switches          #    0.000 /sec
                   0      cpu-migrations            #    0.000 /sec
                 111      page-faults               #  118.603 K/sec
           3,111,368      cpu_core/cycles/          #    3.324 G/sec
       <not counted>      cpu_atom/cycles/                                              (0.00%)
           2,965,942      cpu_core/instructions/    #    3.169 G/sec
       <not counted>      cpu_atom/instructions/                                        (0.00%)
             596,579      cpu_core/branches/        #  637.442 M/sec
       <not counted>      cpu_atom/branches/                                            (0.00%)
              15,744      cpu_core/branch-misses/   #   16.822 M/sec
       <not counted>      cpu_atom/branch-misses/                                       (0.00%)

         0.001509271 seconds time elapsed

         0.001572000 seconds user
         0.000000000 seconds sys

  Some events weren't counted. Try disabling the NMI watchdog:
          echo 0 > /proc/sys/kernel/nmi_watchdog
          perf stat ...
          echo 1 > /proc/sys/kernel/nmi_watchdog

Now we disable the NMI watchdog message on hybrid, otherwise there
are too many false positives.

After:

  # perf stat ls
  ...

   Performance counter stats for 'ls':

                2.32 msec task-clock                #    0.712 CPUs utilized
                   0      context-switches          #    0.000 /sec
                   0      cpu-migrations            #    0.000 /sec
                 110      page-faults               #   47.327 K/sec
           2,313,349      cpu_core/cycles/          #  995.308 M/sec
       <not counted>      cpu_atom/cycles/                                              (0.00%)
           2,986,113      cpu_core/instructions/    #    1.285 G/sec
       <not counted>      cpu_atom/instructions/                                        (0.00%)
             598,861      cpu_core/branches/        #  257.657 M/sec
       <not counted>      cpu_atom/branches/                                            (0.00%)
              16,090      cpu_core/branch-misses/   #    6.923 M/sec
       <not counted>      cpu_atom/branch-misses/                                       (0.00%)

         0.003265716 seconds time elapsed

         0.000000000 seconds user
         0.003307000 seconds sys

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b759dfd633b4..db3c7a105a2b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -465,7 +465,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			config->csv_sep);
 
 		if (counter->supported) {
-			config->print_free_counters_hint = 1;
+			if (!perf_pmu__is_hybrid(counter->pmu_name))
+				config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
 				config->print_mixed_hw_group_error = 1;
 		}
-- 
2.17.1

