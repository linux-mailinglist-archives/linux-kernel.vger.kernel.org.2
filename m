Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3388362D20
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhDQDNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:64780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: 6pIioY6A3GFclLYtVNcb/3mS0kjpv+Hdt9ak9Cvo4sUFfHLeZa2cimwLGq7CdsZO3zkuO5cAe4
 Aeu7/6wvrmyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182636640"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="182636640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:49 -0700
IronPort-SDR: C5O/N3mpen+x4Tja7NuNbL5T69lzUjZrHjHBVhOWIfIvgIA/uW6Ki194jcrDXogrrXCj4U2SbW
 k3xU0k725PLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="419344505"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2021 20:12:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 711CF58090C;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/9] platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake
Date:   Fri, 16 Apr 2021 20:12:48 -0700
Message-Id: <20210417031252.3020837-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2:	- Move buffer allocation so that it does not need to be freed
	  (which was missing anyway) when an error is encountered.
	- Use label to free out_obj after errors
	- Use memcpy instead of memcpy_fromio for ACPI memory

 drivers/platform/x86/intel_pmc_core.c | 56 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  2 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 0e59a84b51bf..97efe9a6bd01 100644
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
@@ -590,6 +595,53 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	const int num_maps = pmcdev->map->lpm_num_maps;
+	size_t lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
+	union acpi_object *out_obj;
+	struct acpi_device *adev;
+	guid_t s0ix_dsm_guid;
+	u32 *lpm_req_regs, *addr;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return;
+
+	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
+
+	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
+				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
+	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
+		int size = out_obj->buffer.length;
+
+		if (size != lpm_size) {
+			acpi_handle_debug(adev->handle,
+				"_DSM returned unexpected buffer size,"
+				" have %d, expect %ld\n", size, lpm_size);
+			goto free_acpi_obj;
+		}
+	} else {
+		acpi_handle_debug(adev->handle,
+				  "_DSM function 0 evaluation failed\n");
+		goto free_acpi_obj;
+	}
+
+	addr = (u32 *)out_obj->buffer.pointer;
+
+	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
+				     GFP_KERNEL);
+	if (!lpm_req_regs)
+		goto free_acpi_obj;
+
+	memcpy(lpm_req_regs, addr, lpm_size);
+	pmcdev->lpm_req_regs = lpm_req_regs;
+
+free_acpi_obj:
+	ACPI_FREE(out_obj);
+}
+
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
 {
 	return readl(pmcdev->regbase + reg_offset);
@@ -1424,10 +1476,14 @@ static int pmc_core_probe(struct platform_device *pdev)
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
index aa44fd5399cc..64fb368f40f6 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -294,6 +294,7 @@ struct pmc_reg_map {
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @lpm_req_regs:	List of substate requirements
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -310,6 +311,7 @@ struct pmc_dev {
 	u64 s0ix_counter;
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
+	u32 *lpm_req_regs;
 };
 
 #define pmc_for_each_mode(i, mode, pmcdev)		\
-- 
2.25.1

