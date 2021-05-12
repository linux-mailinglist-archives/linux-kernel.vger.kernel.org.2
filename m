Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62637B68D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhELHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:06:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:25761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhELHGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:06:25 -0400
IronPort-SDR: cTzSLAS4r/lirUMcxD1F/fvTS82+QhGT3rqg3G+B5V1Y7ARr1cfcb98uPC7fuCkaHMZfUF8FS0
 b0BNS2Nvk+Sw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199692727"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="199692727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:05:16 -0700
IronPort-SDR: xNTaDUQC4qr8uwbmMVTq+jb6mwNY80ju4g1kFNfVCI+VvbMlpGq8fSsxYfdjzXmv0lAeRt2xT7
 DRfkbUk2DBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="455448336"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2021 00:05:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested capabilities
Date:   Wed, 12 May 2021 15:04:21 +0800
Message-Id: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current VT-d implementation supports nested translation only if all
underlying IOMMUs support the nested capability. This is unnecessary
as the upper layer is allowed to create different containers and set
them with different type of iommu backend. The IOMMU driver needs to
guarantee that devices attached to a nested mode iommu_domain should
support nested capabilility.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f1742da42478..1cd4840e6f9f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4755,6 +4755,13 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
+	    !ecap_nest(iommu->ecap)) {
+		dev_err(dev, "%s: iommu not support nested translation\n",
+			iommu->name);
+		return -EINVAL;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5451,11 +5458,21 @@ static int
 intel_iommu_enable_nesting(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool has_nesting = false;
 	unsigned long flags;
-	int ret = -ENODEV;
+	int ret = -EINVAL;
+
+	for_each_active_iommu(iommu, drhd)
+		if (ecap_nest(iommu->ecap))
+			has_nesting = true;
+
+	if (!has_nesting)
+		return -ENODEV;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	if (nested_mode_support() && list_empty(&dmar_domain->devices)) {
+	if (list_empty(&dmar_domain->devices)) {
 		dmar_domain->flags |= DOMAIN_FLAG_NESTING_MODE;
 		dmar_domain->flags &= ~DOMAIN_FLAG_USE_FIRST_LEVEL;
 		ret = 0;
-- 
2.25.1

