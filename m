Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B8350CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhDADGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:60449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232763AbhDADGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:17 -0400
IronPort-SDR: JUQjAphHwptaOx24KLUx0Y5pUTpRIiRaDtwS1pXbvc2C8ib4l8lhpGl+YdGGdHHBZC03d1ZKww
 ZZ66yeXRohQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241100"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192241100"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:16 -0700
IronPort-SDR: QZOWVC6s0Q5InEau380tq4/79ZsBPOb1PIQoMcOrYcC3codWFZHjqnr51iC+BxwQRfM6HcPHH6
 wvfXJcsvX9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="416487611"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 8D14C58094C;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake
Date:   Wed, 31 Mar 2021 20:05:54 -0700
Message-Id: <20210401030558.2301621-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Platforms that support low power modes (LPM) such as Tiger Lake maintain
requirements for each sub-state that a readable in the PMC. However, unlike
LPM status registers, requirement registers are not memory mapped but are
available from an ACPI _DSM. Collect the requirements for Tiger Lake using
the _DSM method and store in a buffer.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 49 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index ba0db301f07b..0ec26a4c715e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -23,7 +23,9 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/uaccess.h>
+#include <linux/uuid.h>
 
+#include <acpi/acpi_bus.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
@@ -31,6 +33,9 @@
 
 #include "intel_pmc_core.h"
 
+#define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
+#define ACPI_GET_LOW_MODE_REGISTERS	1
+
 /* PKGC MSRs are common across Intel Core SoCs */
 static const struct pmc_bit_map msr_map[] = {
 	{"Package C2",                  MSR_PKG_C2_RESIDENCY},
@@ -587,6 +592,46 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
 };
 
+static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	const int num_maps = pmcdev->map->lpm_num_maps;
+	size_t lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
+	union acpi_object *out_obj;
+	struct acpi_device *adev;
+	guid_t s0ix_dsm_guid;
+	u32 *lpm_req_regs;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return;
+
+	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
+				     GFP_KERNEL);
+	if (!lpm_req_regs)
+		return;
+
+	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
+
+	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
+				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
+	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
+		u32 *addr = (u32 *)out_obj->buffer.pointer;
+		int size = out_obj->buffer.length;
+
+		if (size != lpm_size)
+			return;
+
+		memcpy_fromio(lpm_req_regs, addr, lpm_size);
+	} else
+		acpi_handle_debug(adev->handle,
+				  "_DSM function 0 evaluation failed\n");
+
+	ACPI_FREE(out_obj);
+
+	pmcdev->lpm_req_regs = lpm_req_regs;
+}
+
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
 {
 	return readl(pmcdev->regbase + reg_offset);
@@ -1312,10 +1357,14 @@ static int pmc_core_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&pmcdev->lock);
+
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
+	if (pmcdev->map == &tgl_reg_map)
+		pmc_core_get_tgl_lpm_reqs(pdev);
+
 	/*
 	 * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
 	 * a cable is attached. Tell the PMC to ignore it.
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 3800c1ba6fb7..81d797feed33 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -288,6 +288,7 @@ struct pmc_reg_map {
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_modes:		Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @lpm_req_regs:	List of substate requirements
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -304,6 +305,7 @@ struct pmc_dev {
 	u64 s0ix_counter;
 	int num_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
+	u32 *lpm_req_regs;
 };
 
 #define pmc_for_each_mode(i, mode, pmcdev)		\
-- 
2.25.1

