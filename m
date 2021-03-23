Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38163454D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCWBQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhCWBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:49 -0400
IronPort-SDR: epwHDP8Ejt8zb3/flKdmWAflaSnzKdhEcv6NyInKtplUf3Y9jJvw05eR943U+xRtYG89DkDJln
 G6575VVFIeqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455665"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:48 -0700
IronPort-SDR: 4+4KfI+Pz943ysW2ZNCFvJKqkFD2FDX6ZdAAjrewftqd6cyCg+j/mTnkP0mIqE0OhtIKJuFwHa
 sz+sX/wuF2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362487"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Make unnecessarily global functions static
Date:   Tue, 23 Mar 2021 09:06:00 +0800
Message-Id: <20210323010600.678627-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some functions static as they are only used inside pasid.c.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 4 ++--
 drivers/iommu/intel/pasid.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f2c747e62c6a..c896aef7db40 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -230,7 +230,7 @@ struct pasid_table *intel_pasid_get_table(struct device *dev)
 	return info->pasid_table;
 }
 
-int intel_pasid_get_dev_max_id(struct device *dev)
+static int intel_pasid_get_dev_max_id(struct device *dev)
 {
 	struct device_domain_info *info;
 
@@ -241,7 +241,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 	return info->pasid_table->max_pasid;
 }
 
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
+static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 90a3268d7a77..079534fcf55d 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -102,8 +102,6 @@ extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
-int intel_pasid_get_dev_max_id(struct device *dev);
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
 				  u32 pasid, u16 did, int flags);
-- 
2.25.1

