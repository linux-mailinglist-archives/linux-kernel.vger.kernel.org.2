Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595723C75BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhGMR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhGMR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB3CC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k20so15240315pgg.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OnJyiKdawRczHBK8l+xsNJeqd/pB2iob+dpAm/qBJo=;
        b=aeg79t/ohUq0FJbCDzr7a5tw8ItJtyoU4OWrCIh/1+MB/y0nGiUSUyVcgu/eTB5M7o
         fRpxeyz1rvlTkAouc0YlwrqyXaZCoKwgFLQTO18nekT8a2cpexK8SP3Gk5mMaXDJWVoe
         wUzdtLjLMyhTg6y03r21+ZgL7MeMaMhSn9ivdqwAJ4BZY9fcM2Ok0uN1mBNg+HiGrA8+
         VXxeSK6aYyCz33QokEQwXuJEphgtAjoW+d/qE8eIlwPul7YJ1Wvg06Roc2ZSMxtw7fVR
         6dz3CgfV3vguSi9U0KdyimUgYIh2ghXH//sesh4JVPQQS6IxmeUuihnTpuXyUwc1zv97
         un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OnJyiKdawRczHBK8l+xsNJeqd/pB2iob+dpAm/qBJo=;
        b=SLPspFUbTP84KGN9Ts2MGYJNoFLJ0YAHn96v93QWg46xtj7LfSQ791Dcni5Ej2wc0s
         Rxbssw6XEbvIZmuRZr3I+XDfSUVzQHgEh34ewOp13exGFKywvuLNtOyju6gv01HlzveZ
         v3VSbtbaCly93ZreR+HB3FvpIjFfFdTsR7jYUFBg7lz+Vg3TSgC3TzxV9rDBoc2uAhwR
         70P2HYiSeQEpUFXeAxJ7Vf1cPhUKe4ZSrnWxB1y8/4e6XMRHp+3kSC86h2KzSKBW3JhO
         xdtOwCWhxKbkeFKrM76LNrlf6X7BaQuk/uFgdR1kcYFxIgciDrdOP1JHO0oYhPpF97Wx
         R83Q==
X-Gm-Message-State: AOAM5300CW4AN+EVL9OZJeQQMd9NWikRybSUWonLkWp7I6mosMs1HLO8
        tX0rSzs1RVnAE/CNJWZ+LQ0=
X-Google-Smtp-Source: ABdhPJwshrXwPGL19tov8a5uTMLT6la9IlhIdnWkQrxqDkxaa76RMvN0HOBhVnTmoX3Z+QGBkCOUHg==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr5229304pgi.323.1626197097866;
        Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 7/7] iommu/amd: Use only natural aligned flushes in a VM
Date:   Tue, 13 Jul 2021 02:41:51 -0700
Message-Id: <20210713094151.652597-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When running on an AMD vIOMMU, it is better to avoid TLB flushes
of unmodified PTEs. vIOMMUs require the hypervisor to synchronize the
virtualized IOMMU's PTEs with the physical ones. This process induce
overheads.

AMD IOMMU allows us to flush any range that is aligned to the power of
2. So when running on top of a vIOMMU, break the range into sub-ranges
that are naturally aligned, and flush each one separately. This apporach
is better when running with a vIOMMU, but on physical IOMMUs, the
penalty of IOTLB misses due to unnecessary flushed entries is likely to
be low.

Repurpose (i.e., keeping the name, changing the logic)
domain_flush_pages() so it is used to choose whether to perform one
flush of the whole range or multiple ones to avoid flushing unnecessary
ranges. Use NpCache, as usual, to infer whether the IOMMU is physical or
virtual.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c1fcd01b3c40..cb5ea94055e1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1261,15 +1261,52 @@ static void __domain_flush_pages(struct protection_domain *domain,
 }
 
 static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size)
+			       u64 address, size_t size, int pde)
 {
-	__domain_flush_pages(domain, address, size, 0);
+	if (likely(!amd_iommu_np_cache)) {
+		__domain_flush_pages(domain, address, size, pde);
+		return;
+	}
+
+	/*
+	 * When NpCache is on, we infer that we run in a VM and use a vIOMMU.
+	 * In such setups it is best to avoid flushes of ranges which are not
+	 * naturally aligned, since it would lead to flushes of unmodified
+	 * PTEs. Such flushes would require the hypervisor to do more work than
+	 * necessary. Therefore, perform repeated flushes of aligned ranges
+	 * until you cover the range. Each iteration flushes the smaller
+	 * between the natural alignment of the address that we flush and the
+	 * greatest naturally aligned region that fits in the range.
+	 */
+	while (size != 0) {
+		int addr_alignment = __ffs(address);
+		int size_alignment = __fls(size);
+		int min_alignment;
+		size_t flush_size;
+
+		/*
+		 * size is always non-zero, but address might be zero, causing
+		 * addr_alignment to be negative. As the casting of the
+		 * argument in __ffs(address) to long might trim the high bits
+		 * of the address on x86-32, cast to long when doing the check.
+		 */
+		if (likely((unsigned long)address != 0))
+			min_alignment = min(addr_alignment, size_alignment);
+		else
+			min_alignment = size_alignment;
+
+		flush_size = 1ul << min_alignment;
+
+		__domain_flush_pages(domain, address, flush_size, pde);
+		address += flush_size;
+		size -= flush_size;
+	}
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
-	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
+	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1296,7 +1333,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		domain_flush_pages(domain, iova, size, 1);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2200,7 +2237,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.25.1

