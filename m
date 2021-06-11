Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB63A4352
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFKNwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:52:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:52:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lrhYG-00074P-Qe; Fri, 11 Jun 2021 13:50:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/vt-d: Fix dereference of pointer info before it is null checked
Date:   Fri, 11 Jun 2021 14:50:24 +0100
Message-Id: <20210611135024.32781-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of iommu from info->iommu occurs before info is null checked
hence leading to a potential null pointer dereference issue. Fix this by
assigning iommu and checking if iommu is null after null checking info.

Addresses-Coverity: ("Dereference before null check")
Fixes: 4c82b88696ac ("iommu/vt-d: Allocate/register iopf queue for sva devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iommu/intel/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bd93c7ec879e..76a58b8ad6c3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5329,10 +5329,14 @@ static int intel_iommu_disable_auxd(struct device *dev)
 static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
-	struct intel_iommu *iommu = info->iommu;
+	struct intel_iommu *iommu;
 	int ret;
 
-	if (!info || !iommu || dmar_disabled)
+	if (!info || dmar_disabled)
+		return -EINVAL;
+
+	iommu = info->iommu;
+	if (!iommu)
 		return -EINVAL;
 
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
-- 
2.31.1

