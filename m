Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331D1362D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhDQDNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:44212 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235394AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: kOv0sg55zua+8oIrsNv3BaHCaURR7FgmluPcbbRKrQkk7mltknV0bGYBpMBD4Vw0Aib1hG+bVh
 lW8Fiqqh1DOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="215694721"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="215694721"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:49 -0700
IronPort-SDR: eO7cD53KvQFzWZX/bXMLKzajoquAfhCs3MRr8/zWlemApn0DbvGfEsKKc2kPrjTX2G/plSonmL
 fU0Fkdxla96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="453571055"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2021 20:12:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 4E180580890;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/9] platform/x86: intel_pmc_core: Show LPM residency in microseconds
Date:   Fri, 16 Apr 2021 20:12:47 -0700
Message-Id: <20210417031252.3020837-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
---

V2:	No change

 drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++--
 drivers/platform/x86/intel_pmc_core.h |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index c02f63c00ecc..0e59a84b51bf 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -580,6 +580,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
 	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
@@ -1138,17 +1139,26 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
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
index 2ffe0eba36e1..aa44fd5399cc 100644
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
@@ -268,6 +270,7 @@ struct pmc_reg_map {
 	const u32 pm_vric1_offset;
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
+	const int lpm_res_counter_step_x2;
 	const u32 lpm_en_offset;
 	const u32 lpm_priority_offset;
 	const u32 lpm_residency_offset;
-- 
2.25.1

