Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5832D3D3E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhGWQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhGWQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1439C061799
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so9828862pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slYU5MKZy1pznr8txKKfecz25fYTNW0V6jsxSivepmk=;
        b=eNqSDwzZspgyoWvb541jLbHpFMYfhzKhc+j3JuBGS+aRfE/7v+YmsqJSLKU1DKI1JS
         7DmX0XKHQtdAYUJ2BkOhliZDqBENPAkOFI5s+xQ7rECm3jcibM4tNRgjmDRJ0iwDIpaP
         Sq+ObbeqLwddjeit86X8AFTKxjFx39qaCuNYhRaPvf/KkHyGdQB7DpFlobwELlk9rW34
         rFOApBAfNnaLxSvkpUpPfyZfvoVyImhpDkt9p+wwTiB6gjTZ0u0ngP6MZSIJbNelxEld
         qWVDX6ESlBPso7gJsOMhrv76pRy6ChT68Xp7Nc1FyeThoQLYh5cDptCcKqUJ4M3dhtNp
         QV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slYU5MKZy1pznr8txKKfecz25fYTNW0V6jsxSivepmk=;
        b=dVhmtb3Ksr2yBAzU5PmG+0PAgFU3ekESC7SGtaSAFSNqKGJnDJDy7wH1cfaT3GFCSl
         8hSkQNDfdgvhE9Kh9HQ7mjEt0okSInO7Ffg/lRNL0yrRj2t9FMijcYVi9VkmYtYhqQ/q
         aHMWGWpVveU3gKDB8GE7hsu2SkdWXfshAiSLS3yZyuj6xXZTeoDP52C0fpS+q0fic7S0
         JogDE0xt0IYcQnj/+7YQckk5iu/oMP8rYSYwZpcftOPYf7XcLcQOmleCcX1Uv4sBV+UC
         o19txIZRmhT1Sjh6AGL3C9I+XLDXaswrj5nOuVCFPKyXsu7OgsZO6BZJzhFlvcObycAY
         R4Rw==
X-Gm-Message-State: AOAM533El978F4OCcFzHXxJNZfyhgEqK+Ur2nPaeGAoI4zMRX79Y6StJ
        ESp9KiqEvVx5t+ntDfTmqek=
X-Google-Smtp-Source: ABdhPJzmDny3ny6U0xrtZ/luyrjS4pHkXAVQ+nbzP6NjpbxaTALEi/JwKIlJ8ArHJ8/6RkWsrKCUDg==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr4473243plr.7.1627059727165;
        Fri, 23 Jul 2021 10:02:07 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:02:06 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] iommu/amd: Sync once for scatter-gather operations
Date:   Fri, 23 Jul 2021 02:32:08 -0700
Message-Id: <20210723093209.714328-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
index f5d5f2124391..7846fcb1e92b 100644
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

