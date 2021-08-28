Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97A73FA684
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhH1Pjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:39:32 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58081 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234569AbhH1PjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:39:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 446FB580A77;
        Sat, 28 Aug 2021 11:38:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 Aug 2021 11:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XZQg+0zFS2CpV
        gEtfLzvy7d7UeLR2l4fefdb0n1QThA=; b=axWy0Gmip4RJeRjzrqOkd0MzACiTI
        kZnXyK3zrM8t4vxgw3h4hsTrZXlqAUNhAJO2Hkdv9Djq6R35gUQ4m6jd5ranXhkz
        Cuf5yPL/yOS2v3tm40xIrWckWlM7b3fn3ZurlACAx7kzSMsMKo/iF+ntbMahGL6E
        aMGe1vVK5Ac+HDcHsrNc/bR74tMMJ5CBkRwReTtp5Ma54x8k52AEWYarQOlt1z8m
        0VVkJLeNY5d1VcAanrhJwp7n0Cqm0TLK/3V0YFij1TqsCh6XD/aNvb5IYWklOBma
        OnHX68j9vrJT/PC/IGN/zdrw+GkF0J2XF9jPPKPp9WDpcULty4YuaMczg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XZQg+0zFS2CpVgEtfLzvy7d7UeLR2l4fefdb0n1QThA=; b=jTAIQyL5
        j7pOaQ6CnELvdglo37lfTxEgP2Dal7vfoMIYZe5hmk9tHSZxevxrtdfyWGnVk2Bd
        WGcSPKar3iBAoGcBx5wVNgOyLN7P20yqA9uLRBDhxuHnsWoU9GKxBPROIq9rhm3o
        sSQb2bXAGlclO1FPxAspc5o+/KBQVhe9xM8nUe2+IG+LGAeMHX0ASofxsmU9oS1R
        MI5lZq3NFakmfNc2P3A5AHCA8qbo1wFiTaAcUk2c4WvOAWucLUeXPvjLbgnTQiVD
        OgTd/G6toYOVsKnF3Khiq23FSM/XujpttD3JE6HSbI3NVZm5bFk7RH0AJigh2eoL
        mzhngXO3dXErTQ==
X-ME-Sender: <xms:dVgqYYtXnAa5MrKZE5ajeEgZTM8p7VyF7PBWGMFWpngH-FeHA7NFAg>
    <xme:dVgqYVdEUs2GN268wrNHikgXM0wd59UtgtAiorWjiRl0mGDUD_PetqZ4St3lJHlz4
    o17Vhgk7kPsOjrY6RU>
X-ME-Received: <xmr:dVgqYTybAb-WIWYKj4EzEWcbtLDOOxoEy_ySmRf9XpZVrsOEepDm55bKNy3SN9EAkC1c8-9dP4WKm8CkPpCTH-tcca8RrAM6l5d_nHP0535QJ6LaIDt0gHdF_Q46eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:dVgqYbNsWi0TMuv551B3TDTcK2GV1m34Ttk6SLvzQIzZJbb7nbQzcg>
    <xmx:dVgqYY_ecDgryvmlAQReQ1SnoDIS-TH3_tdjQlvkg5vB5x8u8rqCMA>
    <xmx:dVgqYTXZvR7RcD-cuMWc8b8KR1JD7-k1xbpes1kXLmhKMElMoAhtrg>
    <xmx:dlgqYTYgALfWfnO-lJruAWoDNkJzptd79KlUH_RhkwzTv9qQTKLt1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 11:38:28 -0400 (EDT)
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
Subject: [PATCH v2 8/8] iommu/dart: Remove force_bypass logic
Date:   Sat, 28 Aug 2021 17:36:42 +0200
Message-Id: <20210828153642.19396-9-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
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
index 559db9259e65..c37fb4790e8a 100644
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
@@ -506,9 +504,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 
-	if (cfg->stream_maps[0].dart->force_bypass &&
-	    domain->type != IOMMU_DOMAIN_IDENTITY)
-		return -EINVAL;
 	if (!cfg->stream_maps[0].dart->supports_bypass &&
 	    domain->type == IOMMU_DOMAIN_IDENTITY)
 		return -EINVAL;
@@ -638,8 +633,6 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
-		if (cfg_dart->force_bypass != dart->force_bypass)
-			return -EINVAL;
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
 	}
@@ -713,8 +706,6 @@ static int apple_dart_def_domain_type(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	if (cfg->stream_maps[0].dart->force_bypass)
-		return IOMMU_DOMAIN_IDENTITY;
 	if (!cfg->stream_maps[0].dart->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
@@ -844,7 +835,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
-	dart->force_bypass = dart->pgsize > PAGE_SIZE;
 
 	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
@@ -868,8 +858,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
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

