Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F32393A76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhE1AvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:51:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:19706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234366AbhE1AvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:51:03 -0400
IronPort-SDR: K51QGocVCnXIXGvTru60GoEW7nQUwob+iBbgZWCLb+x66j75p6RuyLEdzJ/KOBlap2IDMtDSb3
 /2phDVUt9uBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="266753501"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="266753501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:27 -0700
IronPort-SDR: XNcjk8SNrwlVHE5rbs7fdfsa/X4noQuHIDa/Eum+jcBPl0F0xO/J39Izp4A1NND5yP+MCTeAiC
 UUyCElWyC+pg==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443791880"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:26 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] cxl/mem: Reserve all device regions at once
Date:   Thu, 27 May 2021 17:49:19 -0700
Message-Id: <20210528004922.3980613-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210528004922.3980613-1-ira.weiny@intel.com>
References: <20210528004922.3980613-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to remap individual register sets each bar region must be
reserved prior to mapping.  Because the details of individual register
sets are contained within the BARs themselves, the bar must be mapped 2
times, once to extract this information and a second time for each
register set.

Rather than attempt to reserve each BAR individually and track if that
bar has been reserved.  Open code pcim_iomap_regions() by first
reserving all memory regions on the device and then mapping the bars
individually as needed.

NOTE pci_request_mem_regions() does not need a corresponding
pci_release_mem_regions() because the pci device is managed via
pcim_enable_device().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2f978954daa..33fc6e1634e3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -927,7 +927,7 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
-	int rc;
+	void __iomem *addr;
 
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
@@ -936,13 +936,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 		return IOMEM_ERR_PTR(-ENXIO);
 	}
 
-	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
-	if (rc) {
+	addr = pcim_iomap(pdev, bar, 0);
+	if (!addr) {
 		dev_err(dev, "failed to map registers\n");
-		return IOMEM_ERR_PTR(rc);
+		return addr;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
+		bar, offset);
 
 	return pcim_iomap_table(pdev)[bar] + offset;
 }
@@ -1003,6 +1004,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
+	if (pci_request_mem_regions(pdev, pci_name(pdev)))
+		return -ENODEV;
+
 	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
@@ -1028,8 +1032,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 
 		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
 			base = cxl_mem_map_regblock(cxlm, bar, offset);
-			if (IS_ERR(base))
-				return PTR_ERR(base);
+			if (!base)
+				return -ENOMEM;
 			break;
 		}
 	}
-- 
2.28.0.rc0.12.gb6a658bd00c9

