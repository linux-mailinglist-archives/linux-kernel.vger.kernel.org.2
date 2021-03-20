Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C561342D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCTPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:20:17 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:22609 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCTPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:20:01 -0400
Date:   Sat, 20 Mar 2021 15:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
        s=protonmail3; t=1616253599;
        bh=UmBJ19FRNdQXRczXhAbcIfSvSxmkFnUO3Bq5JKvNzm4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fsOp8RQJauPiKI+aSzOXutFeZjwRHtDBIoMZCO44lpdoyPTgn38/PDhPAwXA9C4Eo
         qG13iUY5rRpS2WrrF4Z/67tO1l7tTZo6qR+6gJ/Ju2OG35nS5Ftt7dr9Rjxx647uLl
         eKue8xA3PtyNAi5seCk6ZGbdxbv+d9CdVl+OmMTlnr9Q0H4mhv6O3W1/AerEXroMRT
         +tXFhO/FXdC5YQdnBejMvFR+ZwMcE2+20nUgUDsbRF2WRXC8ZIi/UBlnVsaVVY5gpF
         MLpH5AILG+0axnQtDjgF7feZiGkA9qfILeWJJcoVgset9eC3HVz3GIF84ThxWV7OOI
         UzrJ19V3e8Prg==
To:     iommu@lists.linux-foundation.org
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
Reply-To: Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 1/3] iommu: io-pgtable: add DART pagetable format
Message-ID: <20210320151903.60759-2-sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple's DART iommu uses a pagetable format that's very similar to the ones
already implemented by io-pgtable.c.
Add a new format variant to support the required differences.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/Kconfig          | 13 +++++++
 drivers/iommu/io-pgtable-arm.c | 70 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  3 ++
 include/linux/io-pgtable.h     |  6 +++
 4 files changed, 92 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..3c95c8524abe 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -39,6 +39,19 @@ config IOMMU_IO_PGTABLE_LPAE
 =09  sizes at both stage-1 and stage-2, as well as address spaces
 =09  up to 48-bits in size.

+config IOMMU_IO_PGTABLE_APPLE_DART
+=09bool "Apple DART Descriptor Format"
+=09select IOMMU_IO_PGTABLE
+=09select IOMMU_IO_PGTABLE_LPAE
+=09depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+=09help
+=09  Enable support for the Apple DART iommu pagetable format.
+=09  This format is a variant of the ARMv7/v8 Long Descriptor
+=09  Format specific to Apple's iommu found in their SoCs.
+
+=09  Say Y here if you have a Apple SoC like the M1 which
+=09  contains DART iommus.
+
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 =09bool "LPAE selftests"
 =09depends on IOMMU_IO_PGTABLE_LPAE
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index 87def58e79b5..18674469313d 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -127,6 +127,10 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF=090x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL

+/* APPLE_DART_PTE_PROT_NO_WRITE actually maps to ARM_LPAE_PTE_AP_RDONLY  *=
/
+#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
+#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))

@@ -381,6 +385,17 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_=
lpae_io_pgtable *data,
 {
 =09arm_lpae_iopte pte;

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+=09if (data->iop.fmt =3D=3D ARM_APPLE_DART) {
+=09=09pte =3D 0;
+=09=09if (!(prot & IOMMU_WRITE))
+=09=09=09pte |=3D APPLE_DART_PTE_PROT_NO_WRITE;
+=09=09if (!(prot & IOMMU_READ))
+=09=09=09pte |=3D APPLE_DART_PTE_PROT_NO_READ;
+=09=09return pte;
+=09}
+#endif
+
 =09if (data->iop.fmt =3D=3D ARM_64_LPAE_S1 ||
 =09    data->iop.fmt =3D=3D ARM_32_LPAE_S1) {
 =09=09pte =3D ARM_LPAE_PTE_nG;
@@ -1043,6 +1058,54 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *c=
fg, void *cookie)
 =09return NULL;
 }

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+=09struct arm_lpae_io_pgtable *data;
+
+=09if (cfg->ias > 38)
+=09=09return NULL;
+=09if (cfg->oas > 36)
+=09=09return NULL;
+
+=09if (!cfg->coherent_walk)
+=09=09return NULL;
+
+=09cfg->pgsize_bitmap &=3D SZ_16K;
+=09if (!cfg->pgsize_bitmap)
+=09=09return NULL;
+
+=09data =3D arm_lpae_alloc_pgtable(cfg);
+=09if (!data)
+=09=09return NULL;
+
+=09/*
+=09 * the hardware only supports this specific three level pagetable layou=
t with
+=09 * the first level being encoded into four hardware registers
+=09 */
+=09data->start_level =3D ARM_LPAE_MAX_LEVELS - 2;
+=09data->pgd_bits =3D 13;
+=09data->bits_per_level =3D 11;
+
+=09data->pgd =3D __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNE=
L,
+=09=09=09=09=09   cfg);
+=09if (!data->pgd)
+=09=09goto out_free_data;
+
+=09cfg->apple_dart_cfg.pgd[0] =3D virt_to_phys(data->pgd);
+=09cfg->apple_dart_cfg.pgd[1] =3D virt_to_phys(data->pgd + 0x4000);
+=09cfg->apple_dart_cfg.pgd[2] =3D virt_to_phys(data->pgd + 0x8000);
+=09cfg->apple_dart_cfg.pgd[3] =3D virt_to_phys(data->pgd + 0xc000);
+
+=09return &data->iop;
+
+out_free_data:
+=09kfree(data);
+=09return NULL;
+}
+#endif
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns =3D {
 =09.alloc=09=3D arm_64_lpae_alloc_pgtable_s1,
 =09.free=09=3D arm_lpae_free_pgtable,
@@ -1068,6 +1131,13 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_=
init_fns =3D {
 =09.free=09=3D arm_lpae_free_pgtable,
 };

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns =3D {
+=09.alloc=09=3D apple_dart_alloc_pgtable,
+=09.free=09=3D arm_lpae_free_pgtable,
+};
+#endif
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST

 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6e9917ce980f..d86590b0673a 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -27,6 +27,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =3D {
 #ifdef CONFIG_AMD_IOMMU
 =09[AMD_IOMMU_V1] =3D &io_pgtable_amd_iommu_v1_init_fns,
 #endif
+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+=09[ARM_APPLE_DART] =3D &io_pgtable_apple_dart_init_fns,
+#endif
 };

 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..19d9b631d319 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 =09ARM_V7S,
 =09ARM_MALI_LPAE,
 =09AMD_IOMMU_V1,
+=09ARM_APPLE_DART,
 =09IO_PGTABLE_NUM_FMTS,
 };

@@ -136,6 +137,10 @@ struct io_pgtable_cfg {
 =09=09=09u64=09transtab;
 =09=09=09u64=09memattr;
 =09=09} arm_mali_lpae_cfg;
+
+=09=09struct {
+=09=09=09u64 pgd[4];
+=09=09} apple_dart_cfg;
 =09};
 };

@@ -250,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpa=
e_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;

 #endif /* __IO_PGTABLE_H */
--
2.25.1


