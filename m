Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C1356175
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbhDGCpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:45:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:37632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233974AbhDGCpo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:45:44 -0400
IronPort-SDR: mBrTv+1deeG7EI7L2Xh42HBykX8e5yHrtKPrXh+d1yAFb43dKnY0ADm0WZ4oDIYnlk7XqvMhEi
 oI60gwi17EoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="257191032"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="257191032"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 19:45:35 -0700
IronPort-SDR: G8Cynnx7DEL7E976YgHFPEy8fviGxx+mWGqunE/qTl6pzFG9Xuhut5K0ytU2dsz+TfC0GAGiIX
 iK97iddxVOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519266455"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2021 19:45:32 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Fix wrong LBR block sorting
Date:   Wed,  7 Apr 2021 10:44:52 +0800
Message-Id: <20210407024452.29988-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When '--total-cycles' is specified, it supports sorting for all blocks
by 'Sampled Cycles%'. This is useful to concentrate on the globally
hottest blocks.

'Sampled Cycles%' - block sampled cycles aggregation / total sampled cycles

But in current code, it doesn't use the cycles aggregation. Part of 'cycles'
counting is possibly dropped for some overlap jumps. But for identifying
the hot block, we always need the full cycles.

  # perf record -b ./triad_loop
  # perf report --total-cycles --stdio

Before:

  #
  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                                   [Program Block Range]         Shared Object
  # ...............  ..............  ...........  ..........  ......................................................................  ....................
  #
              0.81%             793        4.32%         793                                    [setup-vdso.h:34 -> setup-vdso.h:40]            ld-2.27.so
              0.49%             480        0.87%         160                             [native_write_msr+0 -> native_write_msr+16]     [kernel.kallsyms]
              0.48%             476        0.52%          95                               [native_read_msr+0 -> native_read_msr+29]     [kernel.kallsyms]
              0.31%             303        1.65%         303                                       [nmi_restore+0 -> nmi_restore+37]     [kernel.kallsyms]
              0.26%             255        1.39%         255               [nohz_balance_exit_idle+75 -> nohz_balance_exit_idle+162]     [kernel.kallsyms]
              0.24%             234        1.28%         234                                [end_repeat_nmi+67 -> end_repeat_nmi+83]     [kernel.kallsyms]
              0.23%             227        1.24%         227                     [__irqentry_text_end+96 -> __irqentry_text_end+126]     [kernel.kallsyms]
              0.20%             194        1.06%         194                      [native_set_debugreg+52 -> native_set_debugreg+56]     [kernel.kallsyms]
              0.11%             106        0.14%          26                         [native_sched_clock+0 -> native_sched_clock+98]     [kernel.kallsyms]
              0.10%              97        0.53%          97                     [trigger_load_balance+0 -> trigger_load_balance+67]     [kernel.kallsyms]
              0.09%              85        0.46%          85                      [get-dynamic-info.h:102 -> get-dynamic-info.h:111]            ld-2.27.so
  ...
              0.00%           92.7K        0.02%           4                                    [triad_loop.c:64 -> triad_loop.c:65]            triad_loop

The hottest block '[triad_loop.c:64 -> triad_loop.c:65]' is not at
the top of output.

After:

  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                                   [Program Block Range]         Shared Object
  # ...............  ..............  ...........  ..........  ......................................................................  ....................
  #
             94.35%           92.7K        0.02%           4                                    [triad_loop.c:64 -> triad_loop.c:65]            triad_loop
              0.81%             793        4.32%         793                                    [setup-vdso.h:34 -> setup-vdso.h:40]            ld-2.27.so
              0.49%             480        0.87%         160                             [native_write_msr+0 -> native_write_msr+16]     [kernel.kallsyms]
              0.48%             476        0.52%          95                               [native_read_msr+0 -> native_read_msr+29]     [kernel.kallsyms]
              0.31%             303        1.65%         303                                       [nmi_restore+0 -> nmi_restore+37]     [kernel.kallsyms]
              0.26%             255        1.39%         255               [nohz_balance_exit_idle+75 -> nohz_balance_exit_idle+162]     [kernel.kallsyms]
              0.24%             234        1.28%         234                                [end_repeat_nmi+67 -> end_repeat_nmi+83]     [kernel.kallsyms]
              0.23%             227        1.24%         227                     [__irqentry_text_end+96 -> __irqentry_text_end+126]     [kernel.kallsyms]
              0.20%             194        1.06%         194                      [native_set_debugreg+52 -> native_set_debugreg+56]     [kernel.kallsyms]
              0.11%             106        0.14%          26                         [native_sched_clock+0 -> native_sched_clock+98]     [kernel.kallsyms]
              0.10%              97        0.53%          97                     [trigger_load_balance+0 -> trigger_load_balance+67]     [kernel.kallsyms]
              0.09%              85        0.46%          85                      [get-dynamic-info.h:102 -> get-dynamic-info.h:111]            ld-2.27.so
              0.08%              82        0.06%          11          [intel_pmu_drain_pebs_nhm+580 -> intel_pmu_drain_pebs_nhm+627]     [kernel.kallsyms]
              0.08%              77        0.42%          77                          [lru_add_drain_cpu+0 -> lru_add_drain_cpu+133]     [kernel.kallsyms]
              0.08%              74        0.10%          18                        [handle_pmi_common+271 -> handle_pmi_common+310]     [kernel.kallsyms]
              0.08%              74        0.40%          74                      [get-dynamic-info.h:131 -> get-dynamic-info.h:157]            ld-2.27.so
              0.07%              69        0.09%          17          [intel_pmu_drain_pebs_nhm+432 -> intel_pmu_drain_pebs_nhm+468]     [kernel.kallsyms]

Now the hottest block is reported at the top of output.

Fixes: b65a7d372b1a ("perf hist: Support block formats with compare/sort/display")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 423ec69bda6c..5ecd4f401f32 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -201,7 +201,7 @@ static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 	double ratio = 0.0;
 
 	if (block_fmt->total_cycles)
-		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
+		ratio = (double)bi->cycles_aggr / (double)block_fmt->total_cycles;
 
 	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
 }
@@ -216,9 +216,9 @@ static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
 	double l, r;
 
 	if (block_fmt->total_cycles) {
-		l = ((double)bi_l->cycles /
+		l = ((double)bi_l->cycles_aggr /
 			(double)block_fmt->total_cycles) * 100000.0;
-		r = ((double)bi_r->cycles /
+		r = ((double)bi_r->cycles_aggr /
 			(double)block_fmt->total_cycles) * 100000.0;
 		return (int64_t)l - (int64_t)r;
 	}
-- 
2.17.1

