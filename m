Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C386350CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhDADGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:60453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhDADGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:21 -0400
IronPort-SDR: KAJlDUXFWVqDusalve5FA+n0fT9aF9wpCK7V1zPhlRM9iFwSdvZnfJ71DaUE8HLxQ2rSe0OH70
 gxqoQH49ueXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241105"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192241105"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:16 -0700
IronPort-SDR: vjTxHOjuwkT2r/Nnx5REnJoYcqYNN8tiVXo2hYUExGIi03RltkU99Sl4rPBw0QEdhKh5sSy7QR
 F9hNAF8d6JvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="416487614"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id A1561580949;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] platform/x86: intel_pmc_core: Add requirements file to debugfs
Date:   Wed, 31 Mar 2021 20:05:55 -0700
Message-Id: <20210401030558.2301621-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Add the debugfs file, substate_requirements, to view the low power mode
(LPM) requirements for each enabled mode alongside the last latched status
of the condition.

After this patch, the new file will look like this:

                    Element |    S0i2.0 |    S0i3.0 |    S0i2.1 |    S0i3.1 |    S0i3.2 |    Status |
            USB2PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |           |
PCIe/USB3.1_Gen2PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |           |
       PCIe_Gen3PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
            OPIOPLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
              OCPLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
            MainPLL_OFF_STS |           |  Required |           |  Required |  Required |           |

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 0ec26a4c715e..0b47a1da5f49 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1122,6 +1122,86 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 
+static void pmc_core_substate_req_header_show(struct seq_file *s)
+{
+	struct pmc_dev *pmcdev = s->private;
+	int i, mode;
+
+	seq_printf(s, "%30s |", "Element");
+	pmc_for_each_mode(i, mode, pmcdev)
+		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
+
+	seq_printf(s, " %9s |\n", "Status");
+}
+
+static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
+	const struct pmc_bit_map *map;
+	const int num_maps = pmcdev->map->lpm_num_maps;
+	u32 sts_offset = pmcdev->map->lpm_status_offset;
+	u32 *lpm_req_regs = pmcdev->lpm_req_regs;
+	int mp;
+
+	/* Display the header */
+	pmc_core_substate_req_header_show(s);
+
+	/* Loop over maps */
+	for (mp = 0; mp < num_maps; mp++) {
+		u32 req_mask = 0;
+		u32 lpm_status;
+		int mode, idx, i, len = 32;
+
+		/*
+		 * Capture the requirements and create a mask so that we only
+		 * show an element if it's required for at least one of the
+		 * enabled low power modes
+		 */
+		pmc_for_each_mode(idx, mode, pmcdev)
+			req_mask |= lpm_req_regs[mp + (mode * num_maps)];
+
+		/* Get the last latched status for this map */
+		lpm_status = pmc_core_reg_read(pmcdev, sts_offset + (mp * 4));
+
+		/*  Loop over elements in this map */
+		map = maps[mp];
+		for (i = 0; map[i].name && i < len; i++) {
+			u32 bit_mask = map[i].bit_mask;
+
+			if (!(bit_mask & req_mask))
+				/*
+				 * Not required for any enabled states
+				 * so don't display
+				 */
+				continue;
+
+			/* Display the element name in the first column */
+			seq_printf(s, "%30s |", map[i].name);
+
+			/* Loop over the enabled states and display if required */
+			pmc_for_each_mode(idx, mode, pmcdev) {
+				if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
+					seq_printf(s, " %9s |",
+						   "Required");
+				else
+					seq_printf(s, " %9s |", " ");
+			}
+
+			/* In Status column, show the last captured state of this agent */
+			if (lpm_status & bit_mask)
+				seq_printf(s, " %9s |", "Yes");
+			else
+				seq_printf(s, " %9s |", " ");
+
+			seq_puts(s, "\n");
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
+
 static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1241,6 +1321,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_l_sts_regs_fops);
 	}
+
+	if (pmcdev->lpm_req_regs) {
+		debugfs_create_file("substate_requirements", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_substate_req_regs_fops);
+	}
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-- 
2.25.1

