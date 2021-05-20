Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA34F389BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhETDSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:58855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhETDSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:31 -0400
IronPort-SDR: yJZl7AtVFn/7Ma3YjyMYndemxJLlDr9cqdmu5vRxIJ2Rl+wE725KT9MQ5cKUo0i8c4x9bPWM4a
 OwYONHrIvi/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659669"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:17:10 -0700
IronPort-SDR: wYzHUtD07xpb/Z5tvwmKVEb0jJVyC9FFZqjJk9AmnEw5Ivrtykt3SdQSNtM9b7+5FXWPv++7av
 eAKB5YCWEGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527334"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:17:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 11/11] iommu/vt-d: Add PRQ handling latency sampling
Date:   Thu, 20 May 2021 11:15:31 +0800
Message-Id: <20210520031531.712333-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The execution time for page fault request handling is performance critical
and needs to be monitored. This adds code to sample the execution time of
page fault request handling.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d3d028c6a727..6bff9a7f9133 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -24,6 +24,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
+#include "perf.h"
 #include "../iommu-sva-lib.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
@@ -838,8 +839,8 @@ static int prq_to_iommu_prot(struct page_req_dsc *req)
 	return prot;
 }
 
-static int
-intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
+static int intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
+				struct page_req_dsc *desc)
 {
 	struct iommu_fault_event event;
 
@@ -871,6 +872,12 @@ intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 		memcpy(event.fault.prm.private_data, desc->priv_data,
 		       sizeof(desc->priv_data));
+	} else if (dmar_latency_enabled(iommu, DMAR_LATENCY_PRQ)) {
+		/*
+		 * If the private data fields are not used by hardware, use it
+		 * to monitor the prq handle latency.
+		 */
+		event.fault.prm.private_data[0] = ktime_to_ns(ktime_get());
 	}
 
 	return iommu_report_device_fault(dev, &event);
@@ -983,7 +990,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (intel_svm_prq_report(sdev->dev, req))
+		if (intel_svm_prq_report(iommu, sdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 
 		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
@@ -1172,6 +1179,9 @@ int intel_svm_page_response(struct device *dev,
 		if (private_present)
 			memcpy(&desc.qw2, prm->private_data,
 			       sizeof(prm->private_data));
+		else if (prm->private_data[0])
+			dmar_latency_update(iommu, DMAR_LATENCY_PRQ,
+				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
-- 
2.25.1

