Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A429433C87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhJSQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:09 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55081 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234471AbhJSQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 06463580FA7;
        Tue, 19 Oct 2021 12:38:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=K2t/DvVPjAuEc
        abBFkidRQEXkrnP10k3G+xp4Jju30k=; b=Qckc3S1ICYXDedKw5rojS5l69V79n
        ir2oCC9nBcTO25+dNHSJIzXzTHfEA86hADdP2vpXzfJNky6m73bzE5L459bMQYfR
        pD5dlypiWD1El7Il4X3Dzvr3+OC7jPywhZcMxGR4FKBj8otoXFhbpLt7ZiltgHl3
        KRcTlnKFuoI1wwoKKKOmw2ecdtYaqYNuPHECVU30u0V3dWIF9WPNXL8nFR5C4Pjz
        Qpqo8oDDpCQUukG0gD1MdxHFaxzaW55okjDXsQPfaeqED71NK7asjcdZJcuYZHPo
        wZ6b//OB+YesEwdmobHJSNBnbZ71YHsiLlzMvGu1hHZOsdS3X4W72V90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=K2t/DvVPjAuEcabBFkidRQEXkrnP10k3G+xp4Jju30k=; b=HNhByT1o
        QJZwdx0azEx4sBkS25JeAjznTDNWcQDf2KQsXnsjvz+22mXLMizu1i4Xl5Acu9Od
        REmgaIVBYhUnncZFUFdcjj26Sqi/6KKsXl1qg1yvfBeNoei88rR8H1kffD7UOCSF
        aUcCWd7/NULCbmwZNMx4TFRyFWgk5fEa3azAWRCNoL3XhncqYyNITnAN0IVPNhRe
        yrO55S5oECRtllYYB/95J/O2GKtDW/M23xcs7U8UZcFNReexL4EsVTZolmr6Q+Yn
        LU2HPr34Nm76pFBnxGljsVRSmV7jKu/SL6yVkYaxmJ/XwN9P9GcZxHCerEuHsVY2
        dMbNnyCCksi9Ig==
X-ME-Sender: <xms:nfRuYSqpJD94VLvq-JjC1nUYILHEvPwfvp88HXlecEzfMqHkL4II7A>
    <xme:nfRuYQrfRXla6-MqOxJRvjj9htIobr6bR4RNP8NrObvyeiy4ZHxcJKPa9ZBN9ZWyX
    Hy1OE2agjXwavBED04>
X-ME-Received: <xmr:nfRuYXNLu6konw67nz8hYgl9UkuOWprBTNIEbkwb6-iLbsd_QTJN0vmSe2HYOB29oogh_1HNiMSidOW6l3o-5Kg8WH2tXUtOMUi80sCaTj7XBWiXbj1q4mI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:nfRuYR7ebxcCbu6ulGB_xDaC5ulxnsUGf1o2P484s4VNtLerOmqqeQ>
    <xmx:nfRuYR5LHIDOXroh9SQclW8LHz9U7RMHZ7V_x-alHqtQvHtcdz9izA>
    <xmx:nfRuYRiMF7x-EHG2CDNzupyGXQJml7GdYeYc_5wJGCcnytiWzxqipA>
    <xmx:nvRuYezgw5lMdemCGRpCEkNPUMZksU3ta_AsplCzpyKzm2HZ0m8RZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:52 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
Date:   Tue, 19 Oct 2021 18:37:33 +0200
Message-Id: <20211019163737.46269-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
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
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 17f25632a0d6..ea799e70fc98 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/pfn.h>
 #include <linux/pci.h>
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
@@ -878,8 +879,9 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
 
-		s->offset += s_iova_off;
-		s->length = s_length;
+		sg_set_page(s,
+			    pfn_to_page(PHYS_PFN(sg_phys(s) + s_iova_off)),
+			    s_length, s_iova_off & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
@@ -920,13 +922,17 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void __invalidate_sg(struct scatterlist *sg, int nents)
 {
 	struct scatterlist *s;
+	phys_addr_t orig_paddr;
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
-		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+		if (sg_dma_len(s)) {
+			orig_paddr = sg_phys(s) + sg_dma_address(s);
+			sg_set_page(s,
+				    pfn_to_page(PHYS_PFN(orig_paddr)),
+				    sg_dma_len(s),
+				    sg_dma_address(s) & ~PAGE_MASK);
+		}
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1003,15 +1009,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
+		sg_set_page(s, pfn_to_page(PHYS_PFN(s_phys - s_iova_off)),
+			    s_length, s->offset & ~s_iova_off);
 
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
-- 
2.25.1

