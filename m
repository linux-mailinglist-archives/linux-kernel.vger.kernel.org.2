Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE1414128
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhIVFO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:29329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhIVFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012048"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012048"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107703"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:14 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: [RFC 7/7] dma/idxd: Use dma-iommu PASID API instead of SVA lib
Date:   Tue, 21 Sep 2021 13:29:41 -0700
Message-Id: <1632256181-36071-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Showcase a partial usage of the new PASID DMA API, it replaces SVA
lib API in terms of obtaining system PASID and addressing mode setup.
But the actual work submission is not included.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/idxd.h |  4 +++-
 drivers/dma/idxd/init.c | 36 ++++++++++++++++--------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 507f5d5119f9..eaedaf3c3e3b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/perf_event.h>
 #include <linux/idxd.h>
+#include <linux/dma-iommu.h>
 #include "registers.h"
 
 #define IDXD_DRIVER_VERSION	"1.00"
@@ -253,7 +254,8 @@ struct idxd_device {
 
 	struct iommu_sva *sva;
 	unsigned int pasid;
-
+	enum iommu_dma_pasid_mode spasid_mode;
+	struct iommu_domain *domain; /* For KVA mapping */
 	int num_groups;
 
 	u32 msix_perm_offset;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c404a1320536..8f952a4c8909 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/intel-svm.h>
 #include <linux/iommu.h>
+#include <linux/dma-iommu.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
 #include "../dmaengine.h"
@@ -32,6 +33,11 @@ static bool sva = true;
 module_param(sva, bool, 0644);
 MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 
+static int spasid_mode = IOMMU_DMA_PASID_IOVA;
+module_param(spasid_mode, int, 0644);
+MODULE_PARM_DESC(spasid_mode,
+		 "Supervisor PASID mode (1: pass-through,2: DMA API)");
+
 #define DRV_NAME "idxd"
 
 bool support_enqcmd;
@@ -519,35 +525,25 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	int flags;
-	unsigned int pasid;
-	struct iommu_sva *sva;
-
-	flags = SVM_FLAG_SUPERVISOR_MODE;
-
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
-	if (IS_ERR(sva)) {
-		dev_warn(&idxd->pdev->dev,
-			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
-		return PTR_ERR(sva);
-	}
+	int pasid;
+	struct iommu_domain *domain = NULL;
 
-	pasid = iommu_sva_get_pasid(sva);
-	if (pasid == IOMMU_PASID_INVALID) {
-		iommu_sva_unbind_device(sva);
+	pasid = iommu_dma_pasid_enable(&idxd->pdev->dev, &domain, spasid_mode);
+	if (pasid == INVALID_IOASID) {
+		dev_err(&idxd->pdev->dev, "No DMA PASID in mode %d\n", spasid_mode);
 		return -ENODEV;
 	}
-
-	idxd->sva = sva;
 	idxd->pasid = pasid;
-	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
+	idxd->spasid_mode = spasid_mode;
+	idxd->domain = domain;
+
 	return 0;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
 {
-
-	iommu_sva_unbind_device(idxd->sva);
+	/* TODO: remove sva, restore no PASID PT and PASIDE */
+	iommu_dma_pasid_disable(&idxd->pdev->dev, idxd->domain);
 	idxd->sva = NULL;
 }
 
-- 
2.25.1

