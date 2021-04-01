Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273B1350CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhDADGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:2911 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDADGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:20 -0400
IronPort-SDR: 4kudORhVSEU3Fo38wEqZfvZRPBrecvyBXhKV6BI8USblQ2dHuB7lA8tge9Y03YsBxvERKUFhNE
 7VJocOCRLAVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="191619284"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="191619284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:17 -0700
IronPort-SDR: elNTZJ/PxuLiKkV7A7b8Pbr1fuhse5uXczopcvvM9AXburLE797gqOz9m8PFJ9Y+sGRk3iMgud
 2hsfW017QS1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="455778443"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id CDADF58095D;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] platform/x86: intel_pmc_core: Add LTR registers for Tiger Lake
Date:   Wed, 31 Mar 2021 20:05:57 -0700
Message-Id: <20210401030558.2301621-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Just like Ice Lake, Tiger Lake uses Cannon Lake's LTR information
and supports a few additional registers. Hence add the LTR registers
specific to Tiger Lake to the cnp_ltr_show_map[].

Also adjust the number of LTR IPs for Tiger Lake to the correct amount.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 ++
 drivers/platform/x86/intel_pmc_core.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 458c0056e7a1..9168062c927e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -383,6 +383,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 	 * a list of core SoCs using this.
 	 */
 	{"WIGIG",		ICL_PMC_LTR_WIGIG},
+	{"THC0",                TGL_PMC_LTR_THC0},
+	{"THC1",                TGL_PMC_LTR_THC1},
 	/* Below two cannot be used for LTR_IGNORE */
 	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
 	{"AGGREGATED_SYSTEM",	CNP_PMC_LTR_CUR_ASLT},
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index f41f61aa7008..634130b589a2 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -192,8 +192,10 @@ enum ppfear_regs {
 #define ETR3_CLEAR_LPM_EVENTS_BIT		28
 #define LPM_STS_LATCH_MODE_BIT			31
 
-#define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
+#define TGL_PMC_LTR_THC0			0x1C04
+#define TGL_PMC_LTR_THC1			0x1C08
+#define TGL_NUM_IP_IGN_ALLOWED			23
 #define TGL_PMC_LPM_RES_COUNTER_STEP_X2		61	/* 30.5us * 2 */
 
 /*
-- 
2.25.1

