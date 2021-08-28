Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F43FA680
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhH1PjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:39:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59579 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234470AbhH1PjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:39:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9842A580A70;
        Sat, 28 Aug 2021 11:38:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 28 Aug 2021 11:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=PwFP4HxzvK7Rc
        gD49PhDeopMka3fjX2dpZ9I2SZ3weU=; b=PFErue+NMN/w4km2ChFvzfPySAnh0
        FBKLGJBUIN3AN6tHZXztsT3wcGs1byVNHn3jXe79yHaIQnB79awWuH0EA+6+KeyS
        U6Bcu3n+fVXIzOwrYXI22JJwSmxMBEuYX9xM76tWN0zs2+gjoWBt/xeOZyTCIpUF
        ivVcGHuXfAWYHF4OiqfGS9n73U3YUdjc+Ftyx8XKHiEuYGXeltSL8i38U45osa0z
        rVgFG+tFDEWq0nkpCrc7sinsLIl7gDwbgLSLCSJsVKg7+FOwZ0w6bGClwcNxrP84
        1Qo7UX7i5vGG7CU8JSK78B9lb2XoG8u49h2R+koSOq38+lbp31317Qkhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=PwFP4HxzvK7RcgD49PhDeopMka3fjX2dpZ9I2SZ3weU=; b=s04JViXx
        /FbAdZ6nCpHBnbia4qXypuoKF9fliCl5/YhXhg2oSV36ZOfsZR7AcID/XqKlXKJK
        zz8W6rIsFbcUfRRVCkjEwfJNthF9SzF0ZP+XYkoASJjM5szdCBfI6EDKy83uisnf
        6ds5BEsVl4A6wUeV8USEsFZv9wj5qhnfZdGEjJeoniBr8V7G7UHoP7CWUiYUpPDS
        YzCrwhnj6w8fa1yj9p+3mTjRmXcuH62YQh2Wm4BnBvcM2+KXwvyYR8Wndzj8mhY+
        Ma9+A4aDf3HaZRO9liimSfG2jGEAtjHVSerzjemxYiqTaj2zFKsuhFKHPTLyiOQ1
        wkWHmu38lWaL6w==
X-ME-Sender: <xms:bVgqYQFEG5G9OICsXZ_g_3WHR6wlcZkoKEHL5IRjIllzNBC5v9lh0Q>
    <xme:bVgqYZX2lh6IgJhKlYQv-W8ScJJ16jdXkYJJaXyb1kto1it34mOHy_zYYFO2UBrj7
    acGaOyuyL2c3GZqe88>
X-ME-Received: <xmr:bVgqYaIzjSb81IkDOorJTGtpLOeRyb6A1J8CjRC2UqpxzhWvCQAqi-hjceGRh45Bxw-QfNuOww0AE5rZFwbnjH4w1GU7NDJH1hheFQJDj8KDDxNncxFeWceLsPQcTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:bVgqYSH0vaDpgPtTALhF3ztwtbYF4id_clj6GoVvfC6W8qGNEtx7yQ>
    <xmx:bVgqYWVc5gLn0dUoPt0yQObgpOxH4zPyyWEQFRyYVab4Tox8i5_yPg>
    <xmx:bVgqYVOxGneOov6SmST3PCisbBkj-INZVB_aaxND20-cuTnEkQNBqA>
    <xmx:bVgqYSRfLGhCnUOafyBKTr_Ixb7NYZbSFwBXYH67ZSQclmrzlVOsrQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:19 -0400 (EDT)
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
Subject: [PATCH v2 4/8] iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
Date:   Sat, 28 Aug 2021 17:36:38 +0200
Message-Id: <20210828153642.19396-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to iommu_dma_map_sg's impedance matching to also align
sg_lists correctly when the IOMMU granule is larger than PAGE_SIZE.

Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 64fbd9236820..a091cff5829d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -932,8 +932,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
-		s->offset += s_iova_off;
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
+			    s_iova_off & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
@@ -977,10 +977,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+			sg_set_page(s,
+				    phys_to_page(sg_phys(s) + sg_dma_address(s)),
+				    sg_dma_len(s),
+				    sg_dma_address(s) & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1056,15 +1057,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	 * stashing the unaligned parts in the as-yet-unused DMA fields.
 	 */
 	for_each_sg(sg, s, nents, i) {
-		size_t s_iova_off = iova_offset(iovad, s->offset);
+		phys_addr_t s_phys = sg_phys(s);
+		size_t s_iova_off = iova_offset(iovad, s_phys);
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;
 
 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
-		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(s_phys - s_iova_off),
+			    s_length, s->offset & ~s_iova_off);
 
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
-- 
2.25.1

