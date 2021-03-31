Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3138634BB96
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC1HlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 03:41:14 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40485 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhC1Hki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 03:40:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C2336580832;
        Sun, 28 Mar 2021 03:40:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=FbUZQ9FrBqVlB
        HDujKZen+1NIj/M3bRfEtKExFUix1U=; b=iKDzZYT1QYBmQLjm3EsaiaVx0cb50
        1/yIw+j7gxfRgLASLdyDapVFvo9yF+fLJsPIb74PJwHd2ewdO2133vV70fcsaKuR
        tMc9BM8QWx/UV4YCaI4SfJl9gWVStKHUntZr6DuoyHix4yffBByjNqOagfpHR1fh
        QPEfIEvirnf/+J9vdta4nGwqQx54IqO9CVnLArMnNr5TiCnO8LYvl8fI8Q0uA7cT
        AZuhdgfhUh/zs04yqpZr4UR7KnBiaCX17f1ViwQp4kBwGhnRgpK7hABDvF/y7jln
        5WLK/r/uZrgoYXoQJlAZGGxywyGnkMlsyxa0ZOMjCLaulNtG4YnRnqQmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FbUZQ9FrBqVlBHDujKZen+1NIj/M3bRfEtKExFUix1U=; b=vlBjORCF
        sI0HuEx+vtl2V0vwhCgOFqtO8p0sd5WXpqgqSgS8A+0hVL3FMlnNixSDq47fqfbR
        JoujyrwmDtgZOdAZLCz/Kjnn/ss3YD3q/FCvxyPgJKLjQZZmC/3qPLmm9SKermt5
        5QlYug5lS1k6T2rCTVb6l3YLOPLB0USjkz2/GBdVLvEl+snFQwnZgN6HJU7eHboJ
        vkP8qAEVuYrwUsiK/1U+MZFjN9IqjvtN3A3XBEbGCBGfLxQ9v6Ojm0Cxv7nK+Bg1
        BEN0LqmmIegN6luattt0sizt1pyzE3toElPhtn7iwy5XSQlTS2KkneOmQuGbIuCL
        eENUKzmRkUG8eA==
X-ME-Sender: <xms:9TJgYCb_I6iS7fs7yfmwQNTYm03miUtsUgGEbYAoKpde65Dq_xJfwA>
    <xme:9TJgYFbjjWEtERhN2CfmJiet1Tbk1juLe4G0NaVUi3yUxfzCvOerz8OJLBXVmzSsb
    j5I3njQ8atj2Nghxe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucfkphepudejiedrudelledrvddutddrudehieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:9TJgYM9nUSKjNZ9pSK0Er3zrYmAVcOOJJVg8F2716_yRgRF6VqhyTQ>
    <xmx:9TJgYEqZpDnczUr12QndrVBljjdle5iZKjqZAEC-DsIGfMSOZ418iQ>
    <xmx:9TJgYNqESSVLD5-tbtCA3Kw5iIla7fRpOBqfPeMtTIejc5uyZWqg2w>
    <xmx:9TJgYLj48slBIGTDaUOuy-WXcFZUWHiT5WfT7z7rr-s_br6rzUadpmYuCMI>
Received: from localhost.localdomain (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2639A240057;
        Sun, 28 Mar 2021 03:40:35 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Date:   Sun, 28 Mar 2021 09:40:07 +0200
Message-Id: <20210328074009.95932-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210328074009.95932-1-sven@svenpeter.dev>
References: <20210328074009.95932-1-sven@svenpeter.dev>
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
 drivers/iommu/io-pgtable-arm.c | 59 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  6 ++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..2f63443fd115 100644
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
@@ -1043,6 +1055,48 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_lpae_io_pgtable *data;
+
+	if (cfg->ias > 36)
+		return NULL;
+	if (cfg->oas > 36)
+		return NULL;
+
+	if (!cfg->coherent_walk)
+		return NULL;
+
+	cfg->pgsize_bitmap &= SZ_16K;
+	if (!cfg->pgsize_bitmap)
+		return NULL;
+
+	if (cfg->quirks)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	data->start_level = 2;
+	data->pgd_bits = 11;
+	data->bits_per_level = 11;
+
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
+					   cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	cfg->apple_dart_cfg.ttbr = virt_to_phys(data->pgd);
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
@@ -1068,6 +1122,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
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
index 6e9917ce980f..6ec75f3e9c3b 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -27,6 +27,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_AMD_IOMMU
 	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
 #endif
+	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
 };
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..b06925eb20d3 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	ARM_APPLE_DART,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -136,6 +137,10 @@ struct io_pgtable_cfg {
 			u64	transtab;
 			u64	memattr;
 		} arm_mali_lpae_cfg;
+
+		struct {
+			u64 ttbr;
+		} apple_dart_cfg;
 	};
 };
 
@@ -250,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.25.1

