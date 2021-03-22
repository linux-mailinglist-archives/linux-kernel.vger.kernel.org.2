Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE7343944
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCVGOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:14:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:15223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCVGOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:14:19 -0400
IronPort-SDR: kOP/yyvGIzphAP1eowPVr59mShALZnzq/6mBBYHIPRRq3mensst0+SO2z8UgrOYPZfcJpYKc/0
 PPTs/VywwRzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="186889252"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="186889252"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 23:14:19 -0700
IronPort-SDR: NVJVdcPeq3P7P7J7HvAupgnGv5EAPpqB3IH/a12aqPnDbLSNSC2HbMwxcUCp+Jk3A+seuMRHlY
 2pRXX1eH0mkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441026269"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2021 23:14:16 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 RESEND 2/5] perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers
Date:   Mon, 22 Mar 2021 14:06:32 +0800
Message-Id: <20210322060635.821531-3-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322060635.821531-1-like.xu@linux.intel.com>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
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

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

