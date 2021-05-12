Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78237B65D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELGzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:55:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:47036 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhELGzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:55:15 -0400
IronPort-SDR: jbnc5+LUPPjvs1Lg0OSXJuel7anz8m1aE7uPUg7+E3wjspddMx9mThHx/+4LZi9WCH3COKtx3H
 Lcjy2KuEXYcg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197657902"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="197657902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 23:54:07 -0700
IronPort-SDR: aTqd7fOFpvp5fzKzvPt2+oQwtRv7PGX4WSSynd0r4K98up9P1juiJX7Boevmyleg07BhMFehGp
 sewU67+Xdfpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="537510936"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 23:54:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Select PCI_ATS explicitly
Date:   Wed, 12 May 2021 14:53:13 +0800
Message-Id: <20210512065313.3441309-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel VT-d implementation supports device TLB management. Select
PCI_ATS explicitly so that the pci_ats helpers are always available.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 28a3d1596c76..7e5b240b801d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -14,6 +14,7 @@ config INTEL_IOMMU
 	select SWIOTLB
 	select IOASID
 	select IOMMU_DMA
+	select PCI_ATS
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
-- 
2.25.1

