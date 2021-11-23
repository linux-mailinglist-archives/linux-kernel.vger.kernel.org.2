Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469C945A73D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhKWQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236174AbhKWQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DZeZBzk/Li0jXt7UTCUdw8YEic0QHzT9rWRLvDp1HTM=;
        b=IwnSwHJZjduiS8PAmdlO1zkxnQNWxh+QujmM0M60azwgsUjHnC51i4LRrypapG8XW/AOjy
        LFi649ii91/FnTmQavlGKaJ1Uhb1R+2wEWyuo72oFBsqtg9dWAk6NY8eZi0fNQj9vIXYMg
        w5snfgBtJfnmWXkNYG1dqXNixnRfYiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-FLcy9yl0PJiNN-qiMS50_w-1; Tue, 23 Nov 2021 11:10:48 -0500
X-MC-Unique: FLcy9yl0PJiNN-qiMS50_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2644E8799EC;
        Tue, 23 Nov 2021 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD86460843;
        Tue, 23 Nov 2021 16:10:44 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/5] iommu/amd: restore GA log/tail pointer on host resume
Date:   Tue, 23 Nov 2021 18:10:34 +0200
Message-Id: <20211123161038.48009-2-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will give IOMMU GA log a chance to work after resume
from s3/s4.

Fixes: 8bda0cfbdc1a6 ("iommu/amd: Detect and initialize guest vAPIC log")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1eacd43cb4368..8dae85fcfc2eb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -806,16 +806,27 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
 	u32 status, i;
+	u64 entry;
 
 	if (!iommu->ga_log)
 		return -EINVAL;
 
-	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 	/* Check if already running */
-	if (status & (MMIO_STATUS_GALOG_RUN_MASK))
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
 		return 0;
 
+	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
+	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
+		    &entry, sizeof(entry));
+	entry = (iommu_virt_to_phys(iommu->ga_log_tail) &
+		 (BIT_ULL(52)-1)) & ~7ULL;
+	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
+		    &entry, sizeof(entry));
+	writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
+	writel(0x00, iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
+
+
 	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
 	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
 
@@ -825,7 +836,7 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 			break;
 	}
 
-	if (i >= LOOP_TIMEOUT)
+	if (WARN_ON(i >= LOOP_TIMEOUT))
 		return -EINVAL;
 #endif /* CONFIG_IRQ_REMAP */
 	return 0;
@@ -834,8 +845,6 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
-	u64 entry;
-
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return 0;
 
@@ -849,16 +858,6 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	if (!iommu->ga_log_tail)
 		goto err_out;
 
-	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
-	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
-		    &entry, sizeof(entry));
-	entry = (iommu_virt_to_phys(iommu->ga_log_tail) &
-		 (BIT_ULL(52)-1)) & ~7ULL;
-	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
-		    &entry, sizeof(entry));
-	writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
-	writel(0x00, iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
-
 	return 0;
 err_out:
 	free_ga_log(iommu);
-- 
2.26.3

