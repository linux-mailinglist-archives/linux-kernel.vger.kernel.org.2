Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D93FA682
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhH1Pj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:39:27 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49661 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234505AbhH1PjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:39:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 31173580A70;
        Sat, 28 Aug 2021 11:38:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 28 Aug 2021 11:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iBZuNFnMAvAXF
        VZFIFKfDQcXdgvOjdknTaSW4E1ZtzY=; b=c/VwfpjRKGKyjAnHha0tIGkrNmWyq
        0g3szPYIKnzu4aAfk80wCEnn66CGQJeQsyJ5K0Jy6vTchiUFKgmSvX40FeCVkJ1Z
        Gf+IoW0tbRtXQsFnByhX2t52e2sBnB0JFHBMN7Ftwryi9bXrh0dz0eZMblKyQbjV
        uvHB9ArRdLD2w7khy7O+JhmiqPG1TSnH3al+efim+J/zNWjXuS6U+llxy2/VnLUw
        rKrtp46xJLZOzYYk+FHnXRwillocXYCR5/M5xrmv2pBQd6hXZc9ajFtWWJyQWPpC
        BcMf/jUQBDc7NGrzEFTdfVtMDxUULXkq4oyyCp5tPDJMhOFwCVRM9oeTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iBZuNFnMAvAXFVZFIFKfDQcXdgvOjdknTaSW4E1ZtzY=; b=tAu3pq1n
        ozKuH7rLXQa2DquSzgz7ffOBjSG4J8xzN1yte5s0Il7oI15Oh7vNf6BWyQtCdZUh
        r07hGHCLi9umT3pKd2003R97lkHRFRPz9NFAM1jqXdA2rknmAVWYf0NjfmSHOyxv
        qfTa3uYtLs7zwJ4p5QqOhupE9AOyYeBRk5u4K2MqhryfhT8v6htchX58y7jRqFpT
        CAT2cSYQ0BRbnslSt4AQMSMCHPee+wLDGfn2RwlzizifA3cWH5vcVAaHumEfEo+4
        VjhZMDczeIfET3ceaTNARgllIcYgtBlg/xrXaoYyrSoIwb0cc9b9h+vWr4iMzAqT
        FJNjCS1CXFfhTA==
X-ME-Sender: <xms:dFgqYY6oxTEvTI5-lcJnP9kyW8hvF9vEt_cAZVrM_a7JRyOb6m5sfw>
    <xme:dFgqYZ50dpVDdC5bbj3w4vTGmpxloKDo3xNIeRw1gr1fIEg-dwWDZoteKT7Ij_ACy
    hlh83K873t3h7X1MMs>
X-ME-Received: <xmr:dFgqYXfzPY0QKbktuOe26EOLihFxeB3nFNGGSlkyo-h7SVpHnGrR9FPcmI3xnYg8Ds84SIqLkOWQQxsuD6XMZ2tOu7-u1gpfpYQjHpZg7HZBJc41Gpy4OIbpGDQ-og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:dFgqYdL_tLT1z-xAFc7xo1yfEzexv5NBXE6jWNp-d-pEYU7wS5D4sg>
    <xmx:dFgqYcJcw7xFOZDFBaMIpfQMNJtdGOnkyvwjtbtEbA5LnyPgYso44A>
    <xmx:dFgqYexmQyQN3QzD772rrf7f5plTPyTz9zEy7BfqhUlKzXJUBTxATQ>
    <xmx:dFgqYRW5MRT5a6MnumCSoDCD32Zh4hjCOCT10mF23qENrtzz71x13g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:26 -0400 (EDT)
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
Subject: [PATCH v2 7/8] iommu: Introduce __IOMMU_DOMAIN_LP
Date:   Sat, 28 Aug 2021 17:36:41 +0200
Message-Id: <20210828153642.19396-8-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__IOMMU_DOMAIN_LP (large pages) indicates that a domain can handle
conditions where PAGE_SIZE might be smaller than the IOMMU page size.
Always allow attaching devices to such domains and set the flag for
IOMMU_DOMAIN_DMA, which can now handle these situations.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f02b727d3054..77d1ee14c7d0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1980,6 +1980,8 @@ static int iommu_check_page_size(struct iommu_domain *domain)
 {
 	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
 		return 0;
+	if (domain->type & __IOMMU_DOMAIN_LP)
+		return 0;
 
 	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
 		pr_warn("IOMMU page size cannot represent CPU pages.\n");
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6633040a13f9..40c1ad6be4e7 100644
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
-- 
2.25.1

