Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212F230D3F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhBCHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:12:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:46958 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhBCHLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:11:54 -0500
IronPort-SDR: k0E+btjE/NS1F3mKPZ+J/dbCXbncj2gx5qeGo1MKShQ4LIutnWdX67brrl+B3aNWRGVFLKT73W
 kAiLbG6c+fCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181142960"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="181142960"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 23:10:09 -0800
IronPort-SDR: 8NUQ5n3RpCX0YEfPh8wwnjxS+HtI23P6xqwIngwh4Mv6blce6EVc5Q7BnTowGRIlRC3YUIiN7x
 VyxMZegTEnMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="392301015"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2021 23:10:07 -0800
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers
Date:   Wed,  3 Feb 2021 15:03:37 +0800
Message-Id: <20210203070337.329511-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the platform supports LBR_INFO register, the x86_pmu.lbr_info will
be assigned in intel_pmu_?_lbr_init_?() and it's safe to expose LBR_INFO
in the x86_perf_get_lbr() directly, instead of relying on lbr_format check.

Also Architectural LBR has IA32_LBR_x_INFO instead of LBR_FORMAT_INFO_x
to hold metadata for the operation, including mispredict, TSX, and
elapsed cycle time information.

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890dacfcfe..355ea70f1879 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1832,12 +1832,10 @@ void __init intel_pmu_arch_lbr_init(void)
  */
 int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
-	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
-
 	lbr->nr = x86_pmu.lbr_nr;
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
-	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
+	lbr->info = x86_pmu.lbr_info;
 
 	return 0;
 }
-- 
2.29.2

