Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A59389BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhETDSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:58839 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhETDS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:29 -0400
IronPort-SDR: a8rhcJ20RvFq8OtGQmT+MCHokAyII6X2keqRr2ZPBkay+G83u1cE3bhlBp5WfxtLAqucOaDxYq
 g/nM3NKM3tLA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659660"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659660"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:17:08 -0700
IronPort-SDR: bMo4NlikG9RSHX9r02ONlQP6J8/Lya9jVWYKEwNzQ8jEKfITOoxLDnOpGN8FBOEK/vN+AC2hbb
 ctN5Cy+vlaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527314"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:17:06 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 10/11] iommu/vt-d: Add cache invalidation latency sampling
Date:   Thu, 20 May 2021 11:15:30 +0800
Message-Id: <20210520031531.712333-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued invalidation execution time is performance critical and needs
to be monitored. This adds code to sample the execution time of IOTLB/
devTLB/ICE cache invalidation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1e31e6799d5c..59ea07d5d70a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -34,6 +34,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
+#include "perf.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
@@ -1340,15 +1341,33 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options)
 {
 	struct q_inval *qi = iommu->qi;
+	s64 devtlb_start_ktime = 0;
+	s64 iotlb_start_ktime = 0;
+	s64 iec_start_ktime = 0;
 	struct qi_desc wait_desc;
 	int wait_index, index;
 	unsigned long flags;
 	int offset, shift;
 	int rc, i;
+	u64 type;
 
 	if (!qi)
 		return 0;
 
+	type = desc->qw0 & GENMASK_ULL(3, 0);
+
+	if ((type == QI_IOTLB_TYPE || type == QI_EIOTLB_TYPE) &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_IOTLB))
+		iotlb_start_ktime = ktime_to_ns(ktime_get());
+
+	if ((type == QI_DIOTLB_TYPE || type == QI_DEIOTLB_TYPE) &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_DEVTLB))
+		devtlb_start_ktime = ktime_to_ns(ktime_get());
+
+	if (type == QI_IEC_TYPE &&
+	    dmar_latency_enabled(iommu, DMAR_LATENCY_INV_IEC))
+		iec_start_ktime = ktime_to_ns(ktime_get());
+
 restart:
 	rc = 0;
 
@@ -1423,6 +1442,18 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	if (rc == -EAGAIN)
 		goto restart;
 
+	if (iotlb_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_IOTLB,
+				ktime_to_ns(ktime_get()) - iotlb_start_ktime);
+
+	if (devtlb_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_DEVTLB,
+				ktime_to_ns(ktime_get()) - devtlb_start_ktime);
+
+	if (iec_start_ktime)
+		dmar_latency_update(iommu, DMAR_LATENCY_INV_IEC,
+				ktime_to_ns(ktime_get()) - iec_start_ktime);
+
 	return rc;
 }
 
-- 
2.25.1

