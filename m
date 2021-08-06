Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743823E2E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbhHFP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:57:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33547 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244981AbhHFP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:57:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 60A1C5C0145;
        Fri,  6 Aug 2021 11:56:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 06 Aug 2021 11:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ac0VkPJcPS8D0
        RgTUynE5BagCjrgxBKbM+0OG8kQblc=; b=oECjBIGokCcouSFxAf2q+QSngMH7Q
        KWsW0FxjlUcvXleQL8lIBsxutEb5+EhqcqxM6BYsbhys907xdDVLFqUknDBl1GPm
        D1o0Q0QMadk1G8t1DaP2OfE5dG/yaTs/UrBLkxDSvU6qqNs5LZPDOv4gG5C0QlV6
        LhtuBYlUWTCvtVOAfklXD8kNcTocBP2B/F0S2jJ/UurHO21OBER1tJGVzgOuQwOV
        p2I0SqPzbClrawd6y1yMcckquI+4ujSDVUdjsm+9VgvgPI8rlWNxAcRsRzTTSwsT
        qJsZ52SgLv5ktOaxwkrk1s3IgIoIqeyYqUh2mrl1FypTIS5ho9C5dWkJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Ac0VkPJcPS8D0RgTUynE5BagCjrgxBKbM+0OG8kQblc=; b=MmLEs814
        yl8VyDP44YYHQBLyFl27A7lprcRlUd9Rz5jWJ7EdShemU//rN8p2veoPJ5ueJHoA
        USkVZ6lU0t+XL7RmbYhtTqIFhKVHxcj8qxZ9rMOfqLOUg0Vj7WDvi5fYogc+uiUv
        i/uxJtzlSRNqZ6CfsT2lxkW9LnKatN3pH00eHodxUOusvbf0nedg7klB9ZiPaOjL
        sriurZBqIUcbLEQA0noquZX5VNYqzq68noTXezZr6lqJUNLnnaFTYDhxGvcRfu8s
        MDHSWWAdP7in5iPQGEYafFYo/fUzvGSAMMgtr0+2F0smuZ/VvwBp6WlGcXdF3U/V
        7puuZ87PSQOwGg==
X-ME-Sender: <xms:xFsNYbGDe97if07Q2rmBXZXeLqs2qqYxCaKy6eKc4PjXQcuOhjwHyw>
    <xme:xFsNYYU0CuAG8kN_WpTpgf0ge5Osax42xLFEJ4JTMvmzmFlw8K6QJRO7Hav6OZ86M
    AK2n4Xy87zAe5shZzw>
X-ME-Received: <xmr:xFsNYdIyhEfTP9q-6mV0MiP4wMMpZbpoT2wDbcYRbUNPgsuQcmL1Tl6ApgewaOZghB3hOiZLL2C0KDjf0V7Q1C1Y9-_AsliwVHaN1rn7as3YHTy4IlfgZ8XKAlkMKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:xFsNYZG7bXNjL_I5oeymKICiSLS5P09VxG9k0vHevAJhjcmkflJ_1g>
    <xmx:xFsNYRXnLKD5p86MvJm9ebNNYpzr9Bq_KkPtOPw-su6TUZJ7jzh_EA>
    <xmx:xFsNYUPe_UiAFZZtlMCzD7_6zygF2TtWyxvC9OOgazG7Q7cvTUying>
    <xmx:xVsNYdpzzS8DUnzDG2WFQhJtOQRlo4Fcw8qPngN4Zcf2RhO0zaO7eg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 11:56:51 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] iommu: Move IOMMU pagesize check to attach_device
Date:   Fri,  6 Aug 2021 17:55:21 +0200
Message-Id: <20210806155523.50429-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210806155523.50429-1-sven@svenpeter.dev>
References: <20210806155523.50429-1-sven@svenpeter.dev>
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
 drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++++++---
 drivers/iommu/iova.c  |  7 ++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1de503ddb343..5854a4ef5681 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -78,6 +78,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
@@ -1964,6 +1966,18 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+static int iommu_check_page_size(struct iommu_domain *domain)
+{
+	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
+		return 0;
+
+	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
+		pr_warn("IOMMU page size cannot represent CPU pages.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -1973,9 +1987,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
index b6cf5f16123b..e0f8adde0f1b 100644
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
-- 
2.25.1

