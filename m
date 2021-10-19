Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A143433C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhJSQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:27 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58629 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234528AbhJSQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CCA83580FAA;
        Tue, 19 Oct 2021 12:38:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=a1UTEBM3qu37a
        dXN3TtDd2bHBFc6ZdJD1PMfOV0rBTc=; b=UAH0UejpxJNl4iCrusIzo7Dn9FluB
        e1+UFVdT5oSv1qGWHBdm9Bg4YnWXbDXWdefp4n6elrkicbxO4YVTGGBgt4tNirOc
        rday3uXRmpG7FzYUgNfETlQozJpmSBKyPpiHySyGuLE+mbpaautdMJue4I5DtEZ2
        qJnVsX6QBPUXNHGbi1yOoLhl11L41DJAomSJg75pIA9JlzDUxtZZtj0m6atbVkqV
        QcPBgmWCwQMaGGoYjdHN8fWBvu4P7kRm8xjNphPMOXc4DlAUlhbonRpyqNxXjw0G
        zCsBmU5UAe7/D26YZ63z4FZfJYLzaAja+WE5zOjyfFNxjfffVk3OXKqlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=a1UTEBM3qu37adXN3TtDd2bHBFc6ZdJD1PMfOV0rBTc=; b=QPcnXBkz
        drq90m+57PEPe33fnaqAftQCsD2eSGwpSEAIvgmoER3Cnkloz7rTWm5L4cO+/cjQ
        0yxlKShZxJIvH0KQ04n9XCnuhHTKJJIenvp+zkSugmN0v5bi2+qtgNS/0JnMAsft
        hb1ONrM+Z24sElChIl+2eIP0Jy5x6bqaPA5djv5ifR8kfUvD9aoCIb1GFM04zx0l
        aRTDtGLtSq0NyXUZWA9ohkQW9S8R+fz2WsSLbMyc6CTOrgBcPTSYhHCba5tJxIJa
        jCdRouo3aCMOu1x+NNvSa3YncbpdUP4HDpqxUXYa52zDzTS/j+zDw12BezqYz+Rf
        RGMO5buStwn1Tw==
X-ME-Sender: <xms:o_RuYe9gvls68I_eZ-KqELpREqkwxAtlrgnj6gv06povvNNWYH7IeQ>
    <xme:o_RuYesbcAESiGDwa46uXAyzZEO1M8dH4R8tYYAXtvdwM6yiTo72MLlSq3kcVEEcX
    2gH6fdLpZE1DI0ub6E>
X-ME-Received: <xmr:o_RuYUBd1dM6jYUifrUHUOva7o-H07KwY1EYAUg4uXAQlYG0VV_dyF0kznCWP02ObTZngWSuLbUK_ykpAckYxY4e6v6JvSS27IUsegM1ry-zGH_M870GN3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:o_RuYWegg5_FsC_xtJRvR8lXReC6QJuZ-p_l92_5uLHeDQPFOSRzJA>
    <xmx:o_RuYTOaX5oiSQl-_TQ1VqE7TNBtSzEc4OPWXY3NNLxCzIKDY6duiw>
    <xmx:o_RuYQkWKYH0ptvgGo-vp5OnvDQvVWYG71yMAQ0I7prszdmDBj4AiQ>
    <xmx:o_RuYUEf_YBJUAr-KNa0jN4vW5usDQpApW7rzqZA_VqnAmBMArnMMA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:58 -0400 (EDT)
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
Subject: [PATCH v3 5/6] iommu: Introduce __IOMMU_DOMAIN_LP
Date:   Tue, 19 Oct 2021 18:37:36 +0200
Message-Id: <20211019163737.46269-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__IOMMU_DOMAIN_LP (large pages) indicates that a domain can handle
conditions where PAGE_SIZE might be smaller than the IOMMU page size.
Always allow attaching trusted devices to such domains and set the flag for
IOMMU_DOMAIN_DMA, which can now handle these situations.

Note that untrusted devices are not yet supported. Those require
additional changes to allow aligning swiotlb buffers to granularities
larger than PAGE_SIZE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c |  9 +++++++--
 include/linux/iommu.h | 13 +++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28896739964b..66bba6a6bb28 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1976,10 +1976,15 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-static int iommu_check_page_size(struct iommu_domain *domain)
+static int iommu_check_page_size(struct iommu_domain *domain,
+				struct device *dev)
 {
+	bool trusted = !(dev_is_pci(dev) && to_pci_dev(dev)->untrusted);
+
 	if (!iommu_is_paging_domain(domain))
 		return 0;
+	if (iommu_is_large_pages_domain(domain) && trusted)
+		return 0;
 
 	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
 		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
@@ -2007,7 +2012,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	 * only limit domain->pgsize_bitmap after having attached the first
 	 * device.
 	 */
-	ret = iommu_check_page_size(domain);
+	ret = iommu_check_page_size(domain, dev);
 	if (ret) {
 		__iommu_detach_device(domain, dev);
 		return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cabd25879613..1f1af59d0522 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -62,6 +62,8 @@ struct iommu_domain_geometry {
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_LP	(1U << 4)  /* Support for PAGE_SIZE smaller
+					      than IOMMU page size        */
 
 /*
  * This are the possible domain-types
@@ -81,10 +83,12 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
-				 __IOMMU_DOMAIN_DMA_API)
+				 __IOMMU_DOMAIN_DMA_API |       \
+				 __IOMMU_DOMAIN_LP)
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
-				 __IOMMU_DOMAIN_DMA_FQ)
+				 __IOMMU_DOMAIN_DMA_FQ |        \
+				 __IOMMU_DOMAIN_LP)
 
 struct iommu_domain {
 	unsigned type;
@@ -106,6 +110,11 @@ static inline bool iommu_is_paging_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_PAGING;
 }
 
+static inline bool iommu_is_large_pages_domain(struct iommu_domain *domain)
+{
+	return domain->type & __IOMMU_DOMAIN_LP;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
-- 
2.25.1

