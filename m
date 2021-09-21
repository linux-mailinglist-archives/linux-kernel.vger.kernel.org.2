Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6025F413657
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhIUPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:41:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51405 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233860AbhIUPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:41:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DEE225C0219;
        Tue, 21 Sep 2021 11:40:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 Sep 2021 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=NeiQiZ92CcyzMH6Gasfs+HCvVC
        zePzXrLSjQOYzGqBw=; b=kQWcAUPqB9sppmE47DfvKxYCcBMpwNv5PqHLy1zBqJ
        mE6b4cmfvlydNJ/8yJqDzTcuPEfiP5kYbncQt6zDhJGNxIT4W+xknSsipOtAQ9qx
        U6y+pkuFDDgy5xVoc117+B27zX59E82QMbN6xrc5VGml2TC8dqUzefh+K09kAgJq
        2lpNgDaa7Pp8yZGBQyFxYq9wuHZItFqcwLwADVk3BxlBvAN0nWvHH0A/Gw5yVX0B
        2pLbF9Z+LhvU0dnf8ifhUT+E3zo2wrUGB0nnHlCq2EKHf2DJv7Fj4preatyDtkUL
        hTV0tAl0pIho0+bPZW7GOtgUSfENQX+13iCSsGgC7yvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NeiQiZ92CcyzMH6Ga
        sfs+HCvVCzePzXrLSjQOYzGqBw=; b=Q5MfkIVh64zoQcghFJBj7Ze+5Whkzzk0L
        bCZvNi4FACRgI8/L2z4Ag1doix6JL5jw004VmSEpxXA4J+diC9jXLFBjocnwCNVb
        k5l/pBLUr/pL4RT4pREiRTL5KllCWD/7UN6MegS45X0/HGONFvGK4izKUX1uDRgq
        IfK3TEY3o/chEJVnGQ/Zlt5ewg00g0UIDPwBXuQEye2A05xG9wjCVWntOBEWgi/+
        6I7L4LrYnV9q7r2A0GvuL24WMuGufxIh8ksh8ZfE3LOnZJ04BKpwpKldgtSb6YTi
        ogx8olPNsgAi1RobBH2P1wmxjpwx8knt/YWj3jShYmzX11gyIPjAw==
X-ME-Sender: <xms:3PxJYX4gxcN4lt-Ue5QakfuYbmQ46itxYJLlg77Fr54a_fZU39y4SQ>
    <xme:3PxJYc4lPvb6Mo3UniX4zikBhlfS1xWEymC7J-ditStRBBJuKiahL2Gubekbn8hXr
    ty16ynrh0laMtM5AWQ>
X-ME-Received: <xmr:3PxJYeeEtSOfux14z-mN5WlWr-2fhvNa15YU0z5bi35wVIYNmBo37Rccw5alAZU3mHBZtFbOEDq6mF9ks1xghnBKCpG09E4d--3vKEq5DQ7P_5LcpU-DXXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeigedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:3PxJYYKMiGURmBDapgMQPSyOV4QTLjhhV3GorhLaxtd45bwDs6H2HA>
    <xmx:3PxJYbJjfGlZ4VEjc1AsKUicULDV6YGVRz0CL9hu5SUjkwzy5ZSufA>
    <xmx:3PxJYRz7hnDw2t4HmwCCagGdaZGvPVs7LCXuCtqr8a8YTP_82pDPIw>
    <xmx:3PxJYYGPRMT-rZ6CdoiLQCVWB3472hPk0Ms0qX_0G5km5Xq-vn0nRA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Sep 2021 11:40:11 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dart: Remove iommu_flush_ops
Date:   Tue, 21 Sep 2021 17:39:34 +0200
Message-Id: <20210921153934.35647-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apple_dart_tlb_flush_{all,walk} expect to get a struct apple_dart_domain
but instead get a struct iommu_domain right now. This breaks those two
functions and can lead to kernel panics like the one below.
DART can only invalidate the entire TLB and apple_dart_iotlb_sync will
already flush everything. There's no need to do that again inside those
two functions. Let's just drop them.

  pci 0000:03:00.0: Removing from iommu group 1
  Unable to handle kernel paging request at virtual address 0000000100000023
  [...]
  Call trace:
   _raw_spin_lock_irqsave+0x54/0xbc
   apple_dart_hw_stream_command.constprop.0+0x2c/0x130
   apple_dart_tlb_flush_all+0x48/0x90
   free_io_pgtable_ops+0x40/0x70
   apple_dart_domain_free+0x2c/0x44
   iommu_group_release+0x68/0xac
   kobject_cleanup+0x4c/0x1fc
   kobject_cleanup+0x14c/0x1fc
   kobject_put+0x64/0x84
   iommu_group_remove_device+0x110/0x180
   iommu_release_device+0x50/0xa0
  [...]

Fixes: 46d1fb072e76b161 ("iommu/dart: Add DART iommu driver")
Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index c37fb4790e8a..47ffe9e49abb 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -181,7 +181,6 @@ struct apple_dart_master_cfg {
 
 static struct platform_driver apple_dart_driver;
 static const struct iommu_ops apple_dart_iommu_ops;
-static const struct iommu_flush_ops apple_dart_tlb_ops;
 
 static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 {
@@ -336,22 +335,6 @@ static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
 }
 
-static void apple_dart_tlb_flush_all(void *cookie)
-{
-	apple_dart_domain_flush_tlb(cookie);
-}
-
-static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
-				      size_t granule, void *cookie)
-{
-	apple_dart_domain_flush_tlb(cookie);
-}
-
-static const struct iommu_flush_ops apple_dart_tlb_ops = {
-	.tlb_flush_all = apple_dart_tlb_flush_all,
-	.tlb_flush_walk = apple_dart_tlb_flush_walk,
-};
-
 static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -433,7 +416,6 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 		.ias = 32,
 		.oas = 36,
 		.coherent_walk = 1,
-		.tlb = &apple_dart_tlb_ops,
 		.iommu_dev = dart->dev,
 	};
 
-- 
2.25.1

