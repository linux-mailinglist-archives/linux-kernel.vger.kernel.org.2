Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEC350CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhDADGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:60449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhDADGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:17 -0400
IronPort-SDR: kOsPqVDWZtPcNpx2DKKtSClgi3cIkz2OJPL/rFoPNbwaazMzcoS/9p3ZA8QDv0pl0nnpVTs72L
 11orjvFy5K0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241098"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192241098"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:16 -0700
IronPort-SDR: YN+hOepqdifNNeU0QR8yFTs+5Wot7KO4t5MXK1i8M0a/f336jHWA5ctRnzjXf1+GqwiYVltbQB
 gSRtzL6WjYtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="416487606"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 835EC580824;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] platform/x86: intel_pmc_core: Show LPM residency in microseconds
Date:   Wed, 31 Mar 2021 20:05:53 -0700
Message-Id: <20210401030558.2301621-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Modify the low power mode (LPM or sub-state) residency counters to display
in microseconds just like the slp_s0_residency counter. The granularity of
the counter is approximately 30.5us per tick. Double this value then divide
by two to maintain accuracy.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++--
 drivers/platform/x86/intel_pmc_core.h |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index ce300c2942d0..ba0db301f07b 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -578,6 +578,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
 	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
@@ -1026,17 +1027,26 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 
+static inline u64 adjust_lpm_residency(struct pmc_dev *pmcdev, u32 offset,
+				       const int lpm_adj_x2)
+{
+	u64 lpm_res = pmc_core_reg_read(pmcdev, offset);
+
+	return GET_X2_COUNTER((u64)lpm_adj_x2 * lpm_res);
+}
+
 static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
+	const int lpm_adj_x2 = pmcdev->map->lpm_res_counter_step_x2;
 	u32 offset = pmcdev->map->lpm_residency_offset;
 	int i, mode;
 
 	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
 
 	pmc_for_each_mode(i, mode, pmcdev) {
-		seq_printf(s, "%-10s %-15u\n", pmc_lpm_modes[mode],
-			   pmc_core_reg_read(pmcdev, offset + (4 * mode)));
+		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
+			   adjust_lpm_residency(pmcdev, offset + (4 * mode), lpm_adj_x2));
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 5a4e3a49f5b1..3800c1ba6fb7 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -188,9 +188,11 @@ enum ppfear_regs {
 #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 
 #define LPM_MAX_NUM_MODES			8
+#define GET_X2_COUNTER(v)			((v) >> 1)
 
 #define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
+#define TGL_PMC_LPM_RES_COUNTER_STEP_X2		61	/* 30.5us * 2 */
 
 /*
  * Tigerlake Power Management Controller register offsets
@@ -263,6 +265,7 @@ struct pmc_reg_map {
 	const u32 pm_vric1_offset;
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
+	const int lpm_res_counter_step_x2;
 	const u32 lpm_en_offset;
 	const u32 lpm_priority_offset;
 	const u32 lpm_residency_offset;
-- 
2.25.1

