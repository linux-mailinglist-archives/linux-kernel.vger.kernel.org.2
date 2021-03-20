Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4182342A16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTCwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:52:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:28795 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTCwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:52:03 -0400
IronPort-SDR: M381lL2TPLkC1EJOToXKDYc/KM9+ksMzZ8p1iR/PDseloStD+hC2M9usZOILtiCFczsB6SBHET
 ztnjMrkOtdsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="187653548"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="187653548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 19:52:03 -0700
IronPort-SDR: qjpDpDNx3t0xf//3uJctk11VldlRpcPSXM8m8qegIoNLYXeQEBsmmf42C8v9j/G3wBJkl7sTtk
 amCNsVEE9i5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="512686651"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2021 19:52:01 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Don't set then clear private data in prq_event_thread()
Date:   Sat, 20 Mar 2021 10:41:56 +0800
Message-Id: <20210320024156.640798-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d specification (section 7.6) requires that the value in the
Private Data field of a Page Group Response Descriptor must match
the value in the Private Data field of the respective Page Request
Descriptor.

The private data field of a page group response descriptor is set then
immediately cleared in prq_event_thread(). This breaks the rule defined
by the VT-d specification. Fix it by moving clearing code up.

Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Log:
v1->v2:
  - v1: https://lore.kernel.org/linux-iommu/20210309004641.3809653-1-baolu.lu@linux.intel.com/
  - Refine the commit title to make the affected field clear.
  - Refine the commit message to declare why the change matters.

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 677d7f6b43bb..5d590d63ab52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1034,12 +1034,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				QI_PGRP_RESP_TYPE;
 			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
 				QI_PGRP_LPIG(req->lpig);
+			resp.qw2 = 0;
+			resp.qw3 = 0;
 
 			if (req->priv_data_present)
 				memcpy(&resp.qw2, req->priv_data,
 				       sizeof(req->priv_data));
-			resp.qw2 = 0;
-			resp.qw3 = 0;
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 prq_advance:
-- 
2.25.1

