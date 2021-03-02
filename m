Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80F32AD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837418AbhCBVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:46:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:46932 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581416AbhCBSvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:51:20 -0500
IronPort-SDR: MltmGhhWHl5i2Da+kOStqiL4cfQpCyYC94YTf0dBSMKUbZQA/cIDcDDij22ynktyrFORdy+LP5
 aV9dQLBNqmXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186272521"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="186272521"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 10:45:47 -0800
IronPort-SDR: HAfdzkGPXCjfG1XdJaLDYcrnfRu0D8eePJaFpVbln/KYNF6988EV61wEsfbAhYO3e0glqeAPiF
 +mTlz6vBvn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="406158814"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:47 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 4/4] iommu/vt-d: Calculate and set flags for handle_mm_fault
Date:   Tue,  2 Mar 2021 02:14:00 -0800
Message-Id: <1614680040-1989-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page requests are originated from the user page fault. Therefore, we
shall set FAULT_FLAG_USER. 

FAULT_FLAG_REMOTE indicates that we are walking an mm which is not
guaranteed to be the same as the current->mm and should not be subject
to protection key enforcement. Therefore, we should set FAULT_FLAG_REMOTE
to avoid faults when both SVM and PKEY are used.

References: commit 1b2ee1266ea6 ("mm/core: Do not enforce PKEY permissions on remote mm access")
Reviewed-by: Raj Ashok <ashok.raj@intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ff7ae7cc17d5..7bfd20a24a60 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1086,6 +1086,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
 	int head, tail, handled = 0;
+	unsigned int flags = 0;
 
 	/* Clear PPR bit before reading head/tail registers, to
 	 * ensure that we get a new interrupt if needed. */
@@ -1186,9 +1187,11 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (access_error(vma, req))
 			goto invalid;
 
-		ret = handle_mm_fault(vma, address,
-				      req->wr_req ? FAULT_FLAG_WRITE : 0,
-				      NULL);
+		flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
+		if (req->wr_req)
+			flags |= FAULT_FLAG_WRITE;
+
+		ret = handle_mm_fault(vma, address, flags, NULL);
 		if (ret & VM_FAULT_ERROR)
 			goto invalid;
 
-- 
2.25.1

