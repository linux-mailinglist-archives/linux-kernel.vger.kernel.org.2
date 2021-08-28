Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A893FA679
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhH1PjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:39:19 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49925 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234446AbhH1PjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:39:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C0B68580A6B;
        Sat, 28 Aug 2021 11:38:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 28 Aug 2021 11:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=UYZp9goIX3db+
        451Td4TbHlI8QOyAlCJRHIWbYLh0Pc=; b=rA2AF9SDrVGmgwvvIQ/ymfgLrVxeQ
        j3p0ZFR35MjmK8SpH7uLxjKBpoH4JKOnq/Mq2hI9rCkpKaqf9SExOq4i6uz1OPn7
        YIO8+cW1Yew6yXa5rL2BRToLFy7r9hA8/YUc27LJbqOrFna6xRQNqbMrvlyWRbrW
        GYXO7cPi6UqdsklqFWLG7K/PM76dJiiETa1bS+bEKA7oF+Q573dnAVM4yXkJkLKu
        M+em7l1nlLHZDTT0NJTh/hb3nxH6wrk8nBqaPNXMEl5Cq1PszcR5/LCnSJu99iti
        Aa525AGM7vUOdUe7rSEpUOH1xL4DFFyJGJkG6f+REhCROG4Zmfsitzfzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UYZp9goIX3db+451Td4TbHlI8QOyAlCJRHIWbYLh0Pc=; b=W/mh6OS+
        xmwG76ds68cQl/CY55NldYEJ0Lrlw2hMyV1uiIVdTilvkA5A9sA3X1hq0JKbwEi/
        LnnCCzWtiUGGBVP9G0vsLkR83huQ0TqcWSTrjDRIpTjkho819lt/GLENODEqlUFm
        /AZMUvlLhwbPDZKe0Tm83HPK00AvSE0g0VFZn43RhjRiIK/LD7SXWGKi/ckIKz6b
        TM4tb4R4s0BfeQ+NaeagiFXXq7BU3XvgtmZ/CPESm5p1M0V8PEam01B2faDhqVrx
        zy/VttZwf1q/Us0eoYLbV+JLfNBbmB/3eecg4hRvHyvAEMd2te+XIAxast2he6t6
        PWmuFNTMfVFCOw==
X-ME-Sender: <xms:a1gqYUO-X6cH76PihY0y8R3ZpHBvXbFvPanhK6HzuIgagDZxqckCPQ>
    <xme:a1gqYa9QbhDCyp0k19l_XSuUNBEnAca-HNg3ECEd_bPEHIc-CcnH-w9OQnQzJJCHN
    GjiRScR_WOBvO5SWQg>
X-ME-Received: <xmr:a1gqYbTsKTZnbLmSuwBY-nUKjoDOZghYadN-ehSLyMRv9xBY-dg9Fz8EZ_QSPpfJnwBOO3_S5EKhd-frlv_p3mwU1la-0JnkBcCdLTrhhvYrDI-6kEbT53L2ogsIZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:a1gqYcvsVk3eJpZ_t5zlteGi8fdLla-2808wXzyewFHEH6zg3QcKUQ>
    <xmx:a1gqYcf4KJgkW5jtkNcc_R4FvcWjma-3M-8MFIAlJxOkJ4mgTXGNCg>
    <xmx:a1gqYQ1TTwOae1ubeMP3DkFcYA4W8BJGQBFc2pYvXcSu5LFULLLHMA>
    <xmx:a1gqYU7W_NlHPYmWCohQz921YdfpvQFDZH4Y1ECnPthq1oesmRtM1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:18 -0400 (EDT)
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
Subject: [PATCH v2 3/8] iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
Date:   Sat, 28 Aug 2021 17:36:37 +0200
Message-Id: <20210828153642.19396-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pretend that iommu_dma_get_sgtable is not implemented when
granule > PAGE_SIZE since I can neither test this function right now
nor do I fully understand how it is used.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d6e273ec3de6..64fbd9236820 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1315,9 +1315,15 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct page *page;
 	int ret;
 
+	if (iovad->granule > PAGE_SIZE)
+		return -ENXIO;
+
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
-- 
2.25.1

