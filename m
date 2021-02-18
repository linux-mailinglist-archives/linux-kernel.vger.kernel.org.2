Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9175331F501
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBSGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:07:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:39962 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBSGH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:07:29 -0500
IronPort-SDR: ko85Mm1F56+GLAUm7H3fnVpfGHUQ+2svOhzA/L47Vb+UCNc2Ikyac2EKpwhxwVGMY6Nj20+0DJ
 3GZrRrVbHxrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="171424155"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171424155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:02:29 -0800
IronPort-SDR: s+fIb4QD/vBaxgq18YunFtfCEmI1STTMWABa4tRhkWoJlKIPQQxjw1HCF6U2gdksyNKviA1V/P
 iqyqzS80+y5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="362829355"
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
Subject: [PATCH 4/4] iommu/vt-d: Calculate and set flags for handle_mm_fault
Date:   Thu, 18 Feb 2021 13:31:18 -0800
Message-Id: <1613683878-89946-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

