Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32CE433C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhJSQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:16 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53761 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234560AbhJSQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD7B1580FA5;
        Tue, 19 Oct 2021 12:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Oct 2021 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mUxFOhf4FPGG2
        wGC5ii+fwrgIB1PK7ggmQy9Gi+FDDc=; b=Bmoc8dCaGevTZngBfyDKv9gFVU3x5
        4szr37nykRc38nZ/BiXYAjopZsOH2GWQb22Wm+RAn9OAZw6hEt9rZoPAG2HJXWRT
        N18URP30eUAlZTVzSAYYLMKclNxMmArMmpMi7ulFd4qfFg2ZoejMfLW1UWkg5AiX
        5XZEk73zHK0Hv8H+I5gFfsr0TiuarD0O/21Pthm/BbwQIZqIj6iRwAL1A5boOxAu
        3eB5jXb6vedd27+nG4kZKYssDr9CKl9LVQtoWIV11oMpq+zIRhOTii1brAN1/Gp0
        iAkWR0bM9nPioCuyb6gPGLVlYu4aCG2oKjAjmleqiz/ZHNT8cQIobRZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mUxFOhf4FPGG2wGC5ii+fwrgIB1PK7ggmQy9Gi+FDDc=; b=nLaaDYZG
        IfDEQ1mQsGdYRxJS8wSes6/Y5ROtxQLResvCXv5qJ14/X4jiZUVc77duxBn0vbl6
        GytzPqo1nvFU+oN5gn5zN0uHdvFD3W9w04kjf6/rJ7pXRV157yNYz0yl3N7ZZp/p
        YIh5Z121W74mxNcNr7+92O61H4Y7qkFoAIEwfmn2O5OxOrIZdc3W82CRSPx/J5n1
        OeJlPxhhsORzsIb0eiCIKM4Y1TaoO7gSVop6onXy8esUuTqOJf+BDRb7HaoFgYhQ
        JZlDCk8kPydUBtUyyQOzaNhu5drV0ytO1SGjPI7Hn4PT9zPDFLbGdfRQiocdJgjc
        pDBvlXYR+c5dCQ==
X-ME-Sender: <xms:ofRuYZ9gcA3St1WGre702N3UPNC6mUo09R3XYnv7ROIXdLBlNER20Q>
    <xme:ofRuYdsZMuzN-smlA7UO4aze64-yNKsOJ_xeLAa2nik84SnR3iCApYVdnabFkZsWR
    dgp5S_q_B8rmc-4UkI>
X-ME-Received: <xmr:ofRuYXAc1Eum-0fuGWasN57ZjusFLsxYq__x5WGQaJQXNU5X5o1W85YLu22zUM28kgf42a4vk2OzrIX-DazMqYsCHA8WoK77fXCDki8w--t5-xI7OLto19E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ofRuYdcnAHfsHVEcAxKJE8q91g1q9cBOPRuFsQthpOkY040GYzurZA>
    <xmx:ofRuYePkUzdc7s8Kf0NPiTblxc7-5kIC8BCDoVjCFjHiewvf_aCAcA>
    <xmx:ofRuYfkCh0r6IQLNzf_CcQsbZfVxnOr0MZEa_4Du1j7NIQpUL8ypaw>
    <xmx:ofRuYfF1WRtVKzEyLR-e3LPSULpmyCsNMIrmGgD2tIOHiyaxf3tV7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:56 -0400 (EDT)
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
Subject: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
Date:   Tue, 19 Oct 2021 18:37:35 +0200
Message-Id: <20211019163737.46269-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iova allocator is capable of handling any granularity which is a power
of two. Remove the much stronger condition that the granularity must be
smaller or equal to the CPU page size from a BUG_ON there.
Instead, check this condition during __iommu_attach_device and fail
gracefully.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/iommu/iova.c  |  7 ++++---
 include/linux/iommu.h |  5 +++++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e453a5..28896739964b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,6 +80,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
@@ -1974,6 +1976,19 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+static int iommu_check_page_size(struct iommu_domain *domain)
+{
+	if (!iommu_is_paging_domain(domain))
+		return 0;
+
+	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
+		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -1983,9 +1998,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-	return ret;
+	if (ret)
+		return ret;
+
+	/*
+	 * Check that CPU pages can be represented by the IOVA granularity.
+	 * This has to be done after ops->attach_dev since many IOMMU drivers
+	 * only limit domain->pgsize_bitmap after having attached the first
+	 * device.
+	 */
+	ret = iommu_check_page_size(domain);
+	if (ret) {
+		__iommu_detach_device(domain, dev);
+		return ret;
+	}
+
+	trace_attach_device_to_domain(dev);
+	return 0;
 }
 
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..707eb0ceb29f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,10 +50,11 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
-	 * supported IOMMU page size; both *must* be capable of
-	 * representing individual CPU pages exactly.
+	 * supported IOMMU page size; while both usually are capable of
+	 * representing individual CPU pages exactly the IOVA allocator
+	 * supports any granularities that are an exact power of two.
 	 */
-	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
+	BUG_ON(!is_power_of_2(granule));
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..cabd25879613 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -101,6 +101,11 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
 }
 
+static inline bool iommu_is_paging_domain(struct iommu_domain *domain)
+{
+	return domain->type & __IOMMU_DOMAIN_PAGING;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
-- 
2.25.1

