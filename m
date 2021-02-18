Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E231F4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBSGHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:07:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:39731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBSGHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:07:01 -0500
IronPort-SDR: GtOIzxEPC0daXCOrdUIoC5xogj3/OwMuimx65e65tyX7i5Qa5kMp64qT5V17YRAjfJRUjipa4/
 vC27zqAAbL7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="171424154"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171424154"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:02:29 -0800
IronPort-SDR: XQw/6G0ph2O1Y6a0jvL080Eu9m5E4qPpB4jhUj1UDJUDsMTs6fKeXQZGlgI3+YILCiRCzndCjr
 4FlUQPJZ9XdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="362829352"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2021 22:02:29 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Reject unsupported page request modes
Date:   Thu, 18 Feb 2021 13:31:17 -0800
Message-Id: <1613683878-89946-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When supervisor/privilige mode SVM is used, we bind init_mm.pgd with
a supervisor PASID. There should not be any page fault for init_mm.
Execution request with DMA read is also not supported.

This patch checks PRQ descriptor for both unsupported configurations,
reject them both with invalid responses.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a1e4f58c54..ff7ae7cc17d5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1113,7 +1113,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			       ((unsigned long long *)req)[1]);
 			goto no_pasid;
 		}
-
+		/* We shall not receive page request for supervisor SVM */
+		if (req->pm_req && (req->rd_req | req->wr_req)) {
+			pr_err("Unexpected page request in Privilege Mode");
+			/* No need to find the matching sdev as for bad_req */
+			goto no_pasid;
+		}
+		/* DMA read with exec requeset is not supported. */
+		if (req->exe_req && req->rd_req) {
+			pr_err("Execution request not supported\n");
+			goto no_pasid;
+		}
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
 			svm = ioasid_find(NULL, req->pasid, NULL);
-- 
2.25.1

