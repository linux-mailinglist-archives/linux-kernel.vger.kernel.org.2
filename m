Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AC40B650
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhINR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:58:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:8655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhINR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:58:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="220210782"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220210782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 10:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="472100820"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2021 10:56:49 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.c, ak@linux.intel.comom,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 1/3] Fix filter_tid mask for CHA events on Skylake Server
Date:   Tue, 14 Sep 2021 20:56:44 +0300
Message-Id: <20210914175646.35437-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210914175646.35437-1-alexander.antonov@linux.intel.com>
References: <20210914175646.35437-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

According Uncore Reference Manual: any of the CHA events may be filtered
by Thread/Core-ID by using tid modifier in CHA Filter 0 Register.
Update skx_cha_hw_config() to follow Uncore Guide.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 5ddc0f30db6f..9cc65a4194ce 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3607,7 +3607,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	struct extra_reg *er;
-	int idx = 0;
+	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
+	int idx = !!(event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN) ?
+		     SKX_CHA_MSR_PMON_BOX_FILTER_TID : 0;
 
 	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
 		if (er->event != (event->hw.config & er->config_mask))
-- 
2.21.3

