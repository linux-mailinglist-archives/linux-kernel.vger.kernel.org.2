Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235D0433C90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhJSQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:29 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34407 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234607AbhJSQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 63B23580FA5;
        Tue, 19 Oct 2021 12:39:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 19 Oct 2021 12:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=K/Q+kXswZ8pNa
        mY2+chOmBmfbuOVgms4J6hIOAdKNjc=; b=hUMMPcmoBJTFgc11T1yAGEgHBGexy
        0MngiwF/KS5UtO6O81W0rYDabqXmXgefUSoPeYn/ERnGdivrfS95eDZfjQfR/iAl
        5AxUiGnR0Wt7Yj7Fyxa6c1ducO0heshTrvtx0YgL8EVEBI4jJHk0fQ8UilKa+cMc
        1HDmpR2XB8WbD+vtKkl7FgFVHzItpcBXy6aZogpkk6Ic0/fS8uf4qDhT3f1FzbEO
        dNOAHexhUbkfOjMFPkY6Mjvd84qBoLJrHVymkT+lJXmF04qHxs0kP+HpKhnA0KXw
        ray6mSebrZrJ+ShgjurvSX3lk6+/netyoKJCLwRtvdX5UcHmZtiUehM+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=K/Q+kXswZ8pNamY2+chOmBmfbuOVgms4J6hIOAdKNjc=; b=ULZxfFz4
        lFeA3KQAcWwvvOS1SMMl3THt+AqJDSzEC9Ob91T278HMm+BkmM0bMBd7XtGt3+1K
        ZGDzGbgiWP+YFEPK4tS0Ia/na/mpa2pxAjnu/dm/TOgoTD3UmjeZlXC517EkO6Yd
        +XuJdIpEMMtF2H51nkAYnr7p+Xx42WWiLi0OKQNrCVHuE4yShWWLSeZyB3KwM7Y4
        JDTdArfdr5GiJNHayFJ7SkZ5ibCCk9DOzmThCW6rLRSVk0G3/Bwk+IbtnAHAYROI
        DZpMhw40WveaymNEtnDDPn8XNlBTvWBIWnAAXv8SzcqMIfN2Th/t+nK0mMvUzE2V
        7IIwPLnGk36jwQ==
X-ME-Sender: <xms:pfRuYXBeZweuYxZvs8IG7GzijaqO1kFRUrUM6zDkb0ujnCrLlk7wuA>
    <xme:pfRuYdjxEX0xx4tXK3Xgcbjnh3nq3dZJxzskgC8EP2WDVmGIO6mEv61RxGpQXw_7k
    cqfbfmfAy-bM74biq0>
X-ME-Received: <xmr:pfRuYSlhbJrRLqjrzhVKVE6mSTDvtY_XzuiqWChTVH6lcHiNCcXF-ONvCn8gYhnAZzYq860qlZI_GlhzDVWIGXEIS93vaplVE75V0LP85o8jfdL13-DZqG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:pfRuYZygH4RRgMJhBugBPmH1_WNAyCRLBayP2MQot6fm5RHmmCvong>
    <xmx:pfRuYcRO1z_lKpbFC2G4llTxkUbWksQHfLqRLUue5GVq6jVo8hGQsw>
    <xmx:pfRuYcY9B7UKVXhNLTrcpaDf1HhMWV8ESfV4IBGK4qN18UpzdIKycQ>
    <xmx:pvRuYRIaf6Uy7AJ9e_LQlv4aRYR2i7b4kuDHtl2RckQnBjXnGHoPjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:59 -0400 (EDT)
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
Subject: [PATCH v3 6/6] iommu/dart: Remove force_bypass logic
Date:   Tue, 19 Oct 2021 18:37:37 +0200
Message-Id: <20211019163737.46269-7-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the dma-iommu API supports IOMMU granules which are larger than
the CPU page size and that the kernel no longer runs into a BUG_ON when
devices are attached to a domain with such a granule there's no need to
force bypass mode anymore.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 280ff8df728d..ce92195db638 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -90,7 +90,6 @@
  * @lock: lock for hardware operations involving this dart
  * @pgsize: pagesize supported by this DART
  * @supports_bypass: indicates if this DART supports bypass mode
- * @force_bypass: force bypass mode due to pagesize mismatch?
  * @sid2group: maps stream ids to iommu_groups
  * @iommu: iommu core device
  */
@@ -107,7 +106,6 @@ struct apple_dart {
 
 	u32 pgsize;
 	u32 supports_bypass : 1;
-	u32 force_bypass : 1;
 
 	struct iommu_group *sid2group[DART_MAX_STREAMS];
 	struct iommu_device iommu;
@@ -488,9 +486,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 
-	if (cfg->stream_maps[0].dart->force_bypass &&
-	    domain->type != IOMMU_DOMAIN_IDENTITY)
-		return -EINVAL;
 	if (!cfg->stream_maps[0].dart->supports_bypass &&
 	    domain->type == IOMMU_DOMAIN_IDENTITY)
 		return -EINVAL;
@@ -619,8 +614,6 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
-		if (cfg_dart->force_bypass != dart->force_bypass)
-			return -EINVAL;
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
 	}
@@ -726,8 +719,6 @@ static int apple_dart_def_domain_type(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (cfg->stream_maps[0].dart->force_bypass)
-		return IOMMU_DOMAIN_IDENTITY;
 	if (!cfg->stream_maps[0].dart->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
@@ -884,7 +875,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
-	dart->force_bypass = dart->pgsize > PAGE_SIZE;
 
 	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
@@ -908,8 +898,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dev_info(
 		&pdev->dev,
-		"DART [pagesize %x, bypass support: %d, bypass forced: %d] initialized\n",
-		dart->pgsize, dart->supports_bypass, dart->force_bypass);
+		"DART [pagesize %x, bypass support: %d] initialized\n",
+		dart->pgsize, dart->supports_bypass);
 	return 0;
 
 err_sysfs_remove:
-- 
2.25.1

