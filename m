Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B803B53CF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhF0Ojx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:39:53 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49467 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231130AbhF0Oju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:39:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 452C15806DA;
        Sun, 27 Jun 2021 10:37:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 27 Jun 2021 10:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=6dgROPTG2FgZP
        QhdtR6kWJqhz8OvQLzcBN89UwKC3T4=; b=v622dmoMM7/W3OCI/R8QGIKw6vVl7
        NU5dPRqXCz6M4PDrvC3+PC/1Z1xex058OW1ydvH+qE/97e83UOiZOzQMpHwuJuze
        ZmVDmf54wFrVu/qKpTq8iqZGohx28MRq8n2i8x9LImSVwigNdtPXjKHS8IQ/A1xT
        S+hg9JIeH5w1QBVuKn55OIO4IGzlKe7sSk/MWe5nazvig9MFRRvIOlhKcILeo3qE
        grvKG/0S5df19blbtI8LTEVaKDrKXqAUWrTNwfskdpanGj+0SZ9lIKtUxltEXiAR
        TPb7HfVVqXte/J04ZEGKF7QdQy6Mpfeu2pzRU8mh68wXLx6u8K348KGnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6dgROPTG2FgZPQhdtR6kWJqhz8OvQLzcBN89UwKC3T4=; b=gjLKQ1ic
        fguSAuUwVKEenXTzK/coo3q+DXBo++s14UcAE9+vxdUJRvVYoZpqMXVkaCXe6IzV
        fg2gKosTMYMzp1XkpoB9y/CPaODu2kj7F9SgNoSABXtIgc/qJelOFmh3NCR8wJJ5
        we2pQD4uDSDzA+b9+pFpraA6LsPVb6Tigc9v0upeiTidD5d8tmumJNakD5iPyEFL
        MaVEY5dUjmACpRPvSfVLw4qvCFV+xUBEYCELKAHNDYLPe+V4TDpmRAyivaKOZLPT
        PZdj1tRWnChBUziJibXDNrE3Woc1Pe++m/poweQC4SuTtBlDLKTMIduY/2uf6VYg
        Ax2P8LKVNXE6Zw==
X-ME-Sender: <xms:Jo3YYLyoIw1hzPhy7RNh2YXZ-9f412_ERAqNSl6W4ekMvtZ1iHN-3g>
    <xme:Jo3YYDTcDX8GLgCH-bI--UZ-rcXxoHkSTwkXsr2MOuifTtLMLC7lEW36a5oXEhjnE
    eq6BlJTPuphJ_O9jm8>
X-ME-Received: <xmr:Jo3YYFXSDZx8jw6A3PoTMU3fuK_NHR0C6pFI6ECieJd9reJJq_2XmgxLNwg8cIaQZO4qePO6YyMtMH8G9YhRyxCeKu4EdKfbpFWxTV-MmhpXtMcpx4YjGfbsbZ-VEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Jo3YYFhYGr5_sfjoKMF7o7HOPzK_P8NOMRS8-zs-7gUxvJO3nsiA3A>
    <xmx:Jo3YYNBx-plsUf-IrgZDokM7oSWCS5AwQd3NLP059nUSVsOCOqZFsA>
    <xmx:Jo3YYOLxiV5EotCEyb_5msXrkmZKcdWw310eVH0p3F7hd5h_CNqVBA>
    <xmx:Jo3YYPyqyLnTNsL0073osuiGdv195NbZsfrgasm2sURG4-3OKRke7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jun 2021 10:37:23 -0400 (EDT)
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
Subject: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Date:   Sun, 27 Jun 2021 16:34:03 +0200
Message-Id: <20210627143405.77298-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210627143405.77298-1-sven@svenpeter.dev>
References: <20210627143405.77298-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple's DART iommu uses a pagetable format that shares some
similarities with the ones already implemented by io-pgtable.c.
Add a new format variant to support the required differences
so that we don't have to duplicate the pagetable handling code.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 62 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  7 ++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..1dd5c45b4b5b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -127,6 +127,9 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
+#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
+#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 
+	if (data->iop.fmt == ARM_APPLE_DART) {
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
@@ -1043,6 +1055,51 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
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
+	 * Apple's DART always requires three levels with the first level being
+	 * stored in four MMIO registers. We always concatenate the first and
+	 * second level so that we only have to setup the MMIO registers once.
+	 * This results in an effective two level pagetable.
+	 */
+	if (data->start_level < 1)
+		return NULL;
+	if (data->start_level == 1 && data->pgd_bits > 2)
+		return NULL;
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
@@ -1068,6 +1125,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
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
index 6e9917ce980f..fd8e6bd6caf9 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
+	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 4d40dfa75b55..a4bfac7f85f7 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	ARM_APPLE_DART,
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
 
@@ -246,5 +252,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.25.1

