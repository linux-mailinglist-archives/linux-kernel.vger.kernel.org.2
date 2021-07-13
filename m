Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBD3C75BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhGMR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhGMR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B8C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o201so15217871pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGMXQG/SqUWotpOKfxzjkS1Emk7piwJc2wdJhidrZfg=;
        b=ZEV18InabLpWrAb67fVZJkuR2TAwzNK6FqkD40QkjWHrjwFIY9iEaxWbOvDlOZLJ+q
         yyoM7ONIbK40p50r9EuJyH0rqJ3YZrQX8pb0cfy2M+Acy4S9KTxg1tQct3gnHEsOsfFG
         oYKuTqDcNr/1QLaMfpXBQcq0PfzUbnImRYhh6A60fTrUJcihSLhxNx2c/z14SkPzljJL
         5KwM2+R6etqtZs2U/6eB8m5eOdfd4IM1nly2bgJApR/6AiBjno76ukTmMkLrwBPf/otD
         zUi58KVzB43GrTONwonJceDjKHprQVwzvkzX2c8YlHNdRVzxpKsAAZNIPsFx6qLHWAaj
         5PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGMXQG/SqUWotpOKfxzjkS1Emk7piwJc2wdJhidrZfg=;
        b=Hbj36sgm1DMf6ytksTaNEw8EmrDikfMOM7hvdbvmN1FwKbmVtEnVKEwxj8mrMaoGGc
         PPOQeIOXPNEzSD1JWeTypt4gr3wLuE/SUe8PouriR3ydSBquJLeg/EGMOr9WDQvG+Q0m
         hiDDCG3EyVWocIbCDoyvSSYgaS/FW82s/451KZvKcSle1Xy7fwC04+nG+qNCSlJt1GHw
         L4Jdi9xe/pwkunqsds5OShgNV2mHfIPEnpMpr68NfwS4zxyGvOzRGE7hFvRqBbqSwGSu
         64tLm+SkrxncqgJyhvTn6GGnj7zEvZ5LHIgYyZIAqe/s2LFaw/Plc9vCPOsV8VGhByf2
         Xagw==
X-Gm-Message-State: AOAM530Wp64O2K0Fbd4ep1wwAfqc0NKBgipo4pSyvysDIDgokwGjy2Js
        0BF9t24q/LMM3WDYuP/YtsCml89I5M8+0D7i
X-Google-Smtp-Source: ABdhPJz8tmgNddXfz/JOUXuDuG3No6nG/oP/t1VQKl8vVn8WD3JmEF4dP30YfBLvpzOKB6AqOWDETw==
X-Received: by 2002:a63:1622:: with SMTP id w34mr5265386pgl.354.1626197096460;
        Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] iommu/amd: Sync once for scatter-gather operations
Date:   Tue, 13 Jul 2021 02:41:50 -0700
Message-Id: <20210713094151.652597-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

On virtual machines, software must flush the IOTLB after each page table
entry update.

The iommu_map_sg() code iterates through the given scatter-gather list
and invokes iommu_map() for each element in the scatter-gather list,
which calls into the vendor IOMMU driver through iommu_ops callback. As
the result, a single sg mapping may lead to multiple IOTLB flushes.

Fix this by adding amd_iotlb_sync_map() callback and flushing at this
point after all sg mappings we set.

This commit is followed and inspired by commit 933fcd01e97e2
("iommu/vt-d: Add iotlb_sync_map callback").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cc55c4c6a355..c1fcd01b3c40 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2022,6 +2022,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
+static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				     unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+
+	if (ops->map)
+		domain_flush_np_cache(domain, iova, size);
+}
+
 static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 phys_addr_t paddr, size_t page_size, int iommu_prot,
 			 gfp_t gfp)
@@ -2040,10 +2050,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	if (ops->map) {
+	if (ops->map)
 		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
-		domain_flush_np_cache(domain, iova, page_size);
-	}
 
 	return ret;
 }
@@ -2223,6 +2231,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.probe_device = amd_iommu_probe_device,
-- 
2.25.1

