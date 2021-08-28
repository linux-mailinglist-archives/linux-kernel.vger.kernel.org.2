Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55B3FA677
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhH1PjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:39:13 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57757 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231368AbhH1PjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:39:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id ECEF7580A77;
        Sat, 28 Aug 2021 11:38:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 28 Aug 2021 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=D4PCd0JOhWxqQ
        0FHLtGzqrwB4RN73vh1ozYKHe2Vr6c=; b=rp/coHPSJpRsYRFZEpxdqPJWHVy1/
        XP9fwqWZkTA8puZ+wweuwWDcMD67nLgqnPSHJCIU9HbeplW1+CFC3vJC4ylxReTq
        pGaCDh2vbyxbGMPn6Ypq7LDPFmOIEg5m2V1ozmjMgzprAyIlgflFoqqyEPOu9iDy
        yXNiPgA7x9MaaN+9ErygG1PfLAZb3gaphcZSh72f09ujk6WWHCrZH9vMkOJON/YC
        deWzL+nzhPh9/drASa48mKmF1AbhTXEXAPMCsOpTB2NAuwYYLy+miV+SUYT4tL7p
        4anGIrlSdzZbEH/oRU/YmGz7t+/NdHX0xwVZKt2Hcys98kqJ77AWMIrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=D4PCd0JOhWxqQ0FHLtGzqrwB4RN73vh1ozYKHe2Vr6c=; b=Qln4h02r
        1mZd5/ji4lV6ubnGH9nj1q/ACldcUehel8GJW/hLWalmYvgJ5kNCy7lLfMBLY3mm
        BII5kQpsvlRJcSECkXQrBTNHDK52ENw5BnzU/O6RdkgK7mKgH56p0iJqsNyhQMTd
        nsiqvnzhXMd6zww7OefKdMKLuwP9cynksTGGU2ze69TEnlH4Q5QugSZj3val11/k
        AqRMVmjsAuxTTxXMVy16Y7UHiPa0YZz19AF2VNtBO42hK3TL6bU0DALSLnaZrR+C
        7DNvcKokMZVnoez4zz94gTEcVeot+0BOEqotY0zRAMNYKeDAPgGHnu5mztkBkU+S
        qLW68lDpKaYngA==
X-ME-Sender: <xms:aFgqYaN54exDeEWwPDDEhtgbSLcuhElr4yWCxE8N-nNcH4VVtMjG4Q>
    <xme:aFgqYY9YgzOICuV-7sF6H9eeK-5_stAPt94x2pqiZT7AK4JXP3yhmj0mGbF7GhamD
    s9yxQ2W4Y2ejcTLvTg>
X-ME-Received: <xmr:aFgqYRSHsY2Q0sTbjGABPgnF_YRscfGNJc5IL24JVLuaj5wujUUQV-G1bBfWGAqyrM6CNJnYf17Kh9-mqkqrUDLFrC204MSZjx5FelbNNkChk5-Eb0waSSC9d5Zjtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:aFgqYavnRfdZAWJi3gj1b8ZzyXLzjPS-L1Cp1X4QYYBYe1ktEmkANQ>
    <xmx:aFgqYScKzy49E_g5Z5KJdzYCuhH0z4DuszYUJumYsp4rQk3A7Ban7w>
    <xmx:aFgqYe34IKB52NzVpJH4x8dVxXzcPtIQ8KgRrV3OYkFpoDGJ11Srfg>
    <xmx:aVgqYS5JIIsMO3NHrU_7qWnBqT-AZ36xXmwBrFTJZH2khQLLZJDkVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:15 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] iommu/dma: Fail unaligned map requests for untrusted devs
Date:   Sat, 28 Aug 2021 17:36:36 +0200
Message-Id: <20210828153642.19396-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If swiotlb is enabled we should never try to create any mappings that
would expose more memory than requested to the device.
WARN_ON and refuse those mappings just in case.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e8eae34e9e4f..d6e273ec3de6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -534,13 +534,20 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
+	size_t size_aligned = iova_align(iovad, size + iova_off);
 	dma_addr_t iova;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
-	size = iova_align(iovad, size + iova_off);
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev)) {
+		if (WARN_ON(iova_off))
+			return DMA_MAPPING_ERROR;
+		if (WARN_ON(size_aligned != size))
+			return DMA_MAPPING_ERROR;
+	}
+	size = size_aligned;
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
-- 
2.25.1

