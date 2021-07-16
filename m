Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7053CBBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhGPSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:44:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:56652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhGPSoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:44:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="191144874"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="191144874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="460843469"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2021 11:41:42 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 2/5] platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver
Date:   Fri, 16 Jul 2021 11:38:34 -0700
Message-Id: <9ca82f6b45d4bb5fe8806ad1759d93c2bdb2bd31.1626459866.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626459866.git.gayatri.kammela@intel.com>
References: <cover.1626459866.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alder Lake client and mobile support to pmc core driver.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 68 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  2 +
 2 files changed, 70 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index f9de78b08e5d..d4be15897d04 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -645,6 +645,73 @@ static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
+/* Alder Lake: PGD PFET Enable Ack Status Register(s) bitmap */
+static const struct pmc_bit_map adl_pfear_map[] = {
+	{"SPI/eSPI",		BIT(2)},
+	{"XHCI",		BIT(3)},
+	{"SPA",			BIT(4)},
+	{"SPB",			BIT(5)},
+	{"SPC",			BIT(6)},
+	{"GBE",			BIT(7)},
+
+	{"SATA",		BIT(0)},
+	{"HDA_PGD0",		BIT(1)},
+	{"HDA_PGD1",		BIT(2)},
+	{"HDA_PGD2",		BIT(3)},
+	{"HDA_PGD3",		BIT(4)},
+	{"SPD",			BIT(5)},
+	{"LPSS",		BIT(6)},
+
+	{"SMB",			BIT(0)},
+	{"ISH",			BIT(1)},
+	{"ITH",			BIT(3)},
+
+	{"XDCI",		BIT(1)},
+	{"DCI",			BIT(2)},
+	{"CSE",			BIT(3)},
+	{"CSME_KVM",		BIT(4)},
+	{"CSME_PMT",		BIT(5)},
+	{"CSME_CLINK",		BIT(6)},
+	{"CSME_PTIO",		BIT(7)},
+
+	{"CSME_USBR",		BIT(0)},
+	{"CSME_SUSRAM",		BIT(1)},
+	{"CSME_SMT1",		BIT(2)},
+	{"CSME_SMS2",		BIT(4)},
+	{"CSME_SMS1",		BIT(5)},
+	{"CSME_RTC",		BIT(6)},
+	{"CSME_PSF",		BIT(7)},
+
+	{"CNVI",		BIT(3)},
+
+	{"HDA_PGD4",		BIT(2)},
+	{"HDA_PGD5",		BIT(3)},
+	{"HDA_PGD6",		BIT(4)},
+	{}
+};
+
+static const struct pmc_bit_map *ext_adl_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	adl_pfear_map,
+	NULL
+};
+
+static const struct pmc_reg_map adl_reg_map = {
+	.pfear_sts = ext_adl_pfear_map,
+	.slp_s0_offset = ADL_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.msr_sts = msr_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+};
+
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
 {
 	return readl(pmcdev->regbase + reg_offset);
@@ -1574,6 +1641,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index e8dae9c6c45f..c0ca20b32c6b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -197,6 +197,8 @@ enum ppfear_regs {
 #define TGL_NUM_IP_IGN_ALLOWED			23
 #define TGL_PMC_LPM_RES_COUNTER_STEP_X2		61	/* 30.5us * 2 */
 
+#define ADL_PMC_SLP_S0_RES_COUNTER_OFFSET	0x1098
+
 /*
  * Tigerlake Power Management Controller register offsets
  */
-- 
2.25.1

