Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6B3DEDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhHCMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:17:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45981 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235665AbhHCMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:17:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 055485808B0;
        Tue,  3 Aug 2021 08:17:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Aug 2021 08:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=wxuuox4JmuOEc
        tuYkle5aBoQRKvER5LDLAkku7rIxgo=; b=Xr9K7xFpGqyYnB00R5FSwPAObmmJ5
        G7eVvj7907CkIPPPdhSYU+H15VmEPXzssZGmawMZ/PxM/jlVD7ocDr/0LjtL4U++
        ABawVvafz0+vEWJL5DM9uxx9AuxhFhXcAWqTnVXSv7fJ5UmsnplGvKV/crQrQXqr
        yB5Hr3Evu/JAQdEly+RQk5GWS6WbYv765anL/8Bl3uSe64iYMoNZTerSB2wtmmNT
        HN43d5SjtQoR48ncvIqjxIh+9EaWXzi7XHrFqtAswgT6i3j6HGwVn57KpenAk83d
        IaE5/bb1zdHM+SXnku4Sf8LD7GSBDZnI3AzRxYIqZUhYq3ln0FJTAX0zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wxuuox4JmuOEctuYkle5aBoQRKvER5LDLAkku7rIxgo=; b=Wy7WONJD
        x1ilqxrTmRkXjBl8hToPbV0mF4wSLvuk0Ofhyki00LOR/lx+FxGET6cl65Gh7T12
        sD+GPHNdTOluuLAKJgOAxUQHy/2ZXIgQH8mf7VtdltHm/HMBnXg1gzzL6xsklQh4
        vT66JCiLrZsb468H90oII5MneJ0NDuwrgMzLjNwcUxaULnZQGZD4XwBv4gIytwtt
        EWv52KXIfPSo/j1G6PMSeUVJ/ur5EpWdTtupDImdpisJdtjQOWT9fVpaYRrx0h3+
        CJ9cPYEgcHYO39iFaPcV5eMguI3RvF/mUqRlb9aOvquhoqNz1L7QTFz/M50bTzHR
        xD2c1mIAvlFaCQ==
X-ME-Sender: <xms:yTMJYaUJYuoKsi_Wgpp9yunFMkx5pXVRrjygWWWrN8DxDc6G9SXouA>
    <xme:yTMJYWl1eiJZ33OadiWpIu4jQToDvYm5QLvYpvgfYU8B289v-QSVD28Ojs_tOyruQ
    f6SUh8BznMQ9oPdC5c>
X-ME-Received: <xmr:yTMJYearzPUBZTvCFNZKXRziwUb7TX5b-VghEqlb42bRNxPOYHCblkKmJPWZKU59qh_e7pF_ZFTj7sdWy9WCMN4VkcebV-ttHaOKwMgMCu-iIFbvlBG0b28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:yTMJYRVBgbtbsH3GTXGcn3Og5d9gsYX4hknGTh3k2PV99uLR7bE6-g>
    <xmx:yTMJYUlYIWgdKv7T6f56r2Tb_lXjQjEiGWsSXtjdY_aIiQzU9P49qg>
    <xmx:yTMJYWfJtn30j9EUhdHwGTvE9eLYShSWhnIcvfVi2gqtN0duYjXLtg>
    <xmx:yjMJYe3T6BkA0dZ_Euc3-m6tBJmJo41Qh2bjs_1_lHTrL9nN-jedSQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 08:17:11 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
Subject: [PATCH v5 1/3] iommu/io-pgtable: Add DART pagetable format
Date:   Tue,  3 Aug 2021 14:16:49 +0200
Message-Id: <20210803121651.61594-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210803121651.61594-1-sven@svenpeter.dev>
References: <20210803121651.61594-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple's DART iommu uses a pagetable format that shares some
similarities with the ones already implemented by io-pgtable.c.
Add a new format variant to support the required differences
so that we don't have to duplicate the pagetable handling code.

Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 63 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  7 ++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 053df4048a29..0779eb96bd29 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -130,6 +130,9 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
+#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
+#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -402,6 +405,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 
+	if (data->iop.fmt == APPLE_DART) {
+		pte = 0;
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART_PTE_PROT_NO_READ;
+		return pte;
+	}
+
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
@@ -1102,6 +1114,52 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_lpae_io_pgtable *data;
+	int i;
+
+	if (cfg->oas > 36)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	/*
+	 * The table format itself always uses two levels, but the total VA
+	 * space is mapped by four separate tables, making the MMIO registers
+	 * an effective "level 1". For simplicity, though, we treat this
+	 * equivalently to LPAE stage 2 concatenation at level 2, with the
+	 * additional TTBRs each just pointing at consecutive pages.
+	 */
+	if (data->start_level < 1)
+		goto out_free_data;
+	if (data->start_level == 1 && data->pgd_bits > 2)
+		goto out_free_data;
+	if (data->start_level > 1)
+		data->pgd_bits = 0;
+	data->start_level = 2;
+	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
+	data->pgd_bits += data->bits_per_level;
+
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
+					   cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i)
+		cfg->apple_dart_cfg.ttbr[i] =
+			virt_to_phys(data->pgd + i * ARM_LPAE_GRANULE(data));
+
+	return &data->iop;
+
+out_free_data:
+	kfree(data);
+	return NULL;
+}
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1127,6 +1185,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };
 
+struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
+	.alloc	= apple_dart_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6e9917ce980f..f4bfcef98297 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
+	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index c43f3b899d2a..a738483fb4da 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	APPLE_DART,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -136,6 +137,11 @@ struct io_pgtable_cfg {
 			u64	transtab;
 			u64	memattr;
 		} arm_mali_lpae_cfg;
+
+		struct {
+			u64 ttbr[4];
+			u32 n_ttbrs;
+		} apple_dart_cfg;
 	};
 };
 
@@ -254,5 +260,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.25.1

