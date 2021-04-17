Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FB362D21
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhDQDNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:24049 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235502AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: T+dSyH+xEV44HeXw+hOQb8q6iA9j8GK4BrrMzAD3KfaiQFIf1PaTmXbv03g3nVe5TAcb15MtMO
 /A5q1gznE9CQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195251087"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="195251087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:49 -0700
IronPort-SDR: S6OM14m0PUf+FqLn3mjU2G1HDDVkP3Q9bt3Ap9JqLYLlk1WsV4SQvihnN6yhSrvHGr4jnI+bD4
 mpH6RXPlyyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="383226953"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2021 20:12:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 920945808F0;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/9] platform/x86: intel_pmc_core: Add requirements file to debugfs
Date:   Fri, 16 Apr 2021 20:12:49 -0700
Message-Id: <20210417031252.3020837-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2:	No change

 drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 97efe9a6bd01..684f13f0c4a5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1241,6 +1241,86 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
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
@@ -1360,6 +1440,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
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

