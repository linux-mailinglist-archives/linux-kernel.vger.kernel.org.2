Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367B73E2E10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbhHFP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:57:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35565 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245103AbhHFP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:57:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B74EB5C0165;
        Fri,  6 Aug 2021 11:56:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 11:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=MjDkHStOQ/clx
        cFNpVi2F5U4aoR8QeJ+BGXLAvk/tkg=; b=RCt1xOTZ9TmHYCAFogxZycD0nOR+o
        83SDF1fFCjAjN2ErPGE43WnEqUkIYpVOjRE4ZHJ0utLqXeyIG2baKLKl9tO7uq1P
        RrC0e1dsfFvN4pbBFP2AFoJ8RHJ7eVSDkRzJyNX9Cfjx5epPxMVjP5/WdxAvkTO6
        Zdlris+q7LoWz1AKdTrFAxLBSUHI7LzMiLB9kXUMJoTfR4am9LAXqQ7QFwKxJP90
        ZRUNu+r5OXSMNtAvxk+PjsEdVu81cvvJ+nVCgzC+aGQGCT9aYNGtlFNUTb2rw0MB
        RiFatN8Z+l4PVl0DzXyiJsCySWLNEqFcTa5rid/gu3cCehMU1nU6N6rPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=MjDkHStOQ/clxcFNpVi2F5U4aoR8QeJ+BGXLAvk/tkg=; b=hYlOzO1I
        p9szTT5jd2H0Za+UbCJ86nUrzzc65QK54JfUn23K9Djj9tmUGTn80/yA9AXJ99Cl
        Z7oItiq2oKDhj/TMCg+A1QfVxM/aQXVpuCAsPuFj2shidymayNDbdLefK4kuoGHP
        ggjtfp2QJRmvcfnui+Z+hwff9vwHbrK8xSVoCmbU3QpKupMsfsT6O1tNFaKGV3nm
        rbwjb0gh5knlxfuVsG+Bx4BkbFNDkGHLBppppZZjFgAk4OcpCKH32HErYyV1cugU
        biEI+EH1Hl9mABtsk3h7gRXBs0uxQtPNk0dSzE5IEnCg9N0f9JywBB+sZ6+AZc6N
        25Oi/qOGEID3nA==
X-ME-Sender: <xms:yFsNYU36OevGbzCd6dQChzRjyBfY_23dKFI5l73elALSOSesbuKruA>
    <xme:yFsNYfHcgguL0BqxklTm0CjRy1LWSzwo3Fh7qeR6KcQaUJMlu2j0nov9EfsBqZrXE
    aLUG4RTQTX_mJp8Mbc>
X-ME-Received: <xmr:yFsNYc7wxBzuaBzdn8-LhAnf8eAgvA6ZsSPDWc2U65UfCEXVvdGYPwx3C-Wj3lwSQRrWh_4FJw9GKfZM2g4ZFRP__TPsYaXvS1F8EcvenEGLYq7rLVpCgS4rkbOlnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:yFsNYd0H_xYD5vJixoy00mCbyOJm02_aGVm_ctAOf5J19lxm_ilVuQ>
    <xmx:yFsNYXGrpg0474eKInbNIxmUQDqpuJ5u38kn_vWUyJZ5Zs8H_meRWw>
    <xmx:yFsNYW8hERlqwB-UQlGtm9Ab-Bht4CjxcCZFJ0rsqQ_jA9X6uCsKjA>
    <xmx:yFsNYdao6WyIeQoL_Bhsj1HrJjJxr8lcXpemOsJ8PUPDVbNoVxJBRQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 11:56:55 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] iommu: Introduce __IOMMU_DOMAIN_LARGE_PAGES
Date:   Fri,  6 Aug 2021 17:55:23 +0200
Message-Id: <20210806155523.50429-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210806155523.50429-1-sven@svenpeter.dev>
References: <20210806155523.50429-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__IOMMU_DOMAIN_LARGE_PAGES indicates that a domain can handle
conditions where PAGE_SIZE might be smaller than the IOMMU page size.
Always allow attaching devices to such domains and set the flag for
IOMMU_DOMAIN_DMA, which can now handle these situations.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c |  2 ++
 include/linux/iommu.h | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5854a4ef5681..f0bfd76187b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1970,6 +1970,8 @@ static int iommu_check_page_size(struct iommu_domain *domain)
 {
 	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
 		return 0;
+	if (domain->type & __IOMMU_DOMAIN_LARGE_PAGES)
+		return 0;
 
 	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
 		pr_warn("IOMMU page size cannot represent CPU pages.\n");
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e552ecfefcf7..1f97eac8a4b0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -56,10 +56,13 @@ struct iommu_domain_geometry {
 };
 
 /* Domain feature flags */
-#define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
-#define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
-					      implementation              */
-#define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_PAGING       (1U << 0)  /* Support for iommu_map/unmap */
+#define __IOMMU_DOMAIN_DMA_API      (1U << 1)  /* Domain for use in DMA-API
+						   implementation              */
+#define __IOMMU_DOMAIN_PT           (1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_LARGE_PAGES  (1U << 3)  /* Domain can handle IOMMU page
+						  sizes larger than the CPU
+						  page size                   */
 
 /*
  * This are the possible domain-types
@@ -77,7 +80,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
-				 __IOMMU_DOMAIN_DMA_API)
+				 __IOMMU_DOMAIN_DMA_API |       \
+				 __IOMMU_DOMAIN_LARGE_PAGES)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.25.1

