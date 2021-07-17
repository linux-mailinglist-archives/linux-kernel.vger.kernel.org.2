Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30B3CC45E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhGQQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhGQQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:09:24 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B116C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:06:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d15so9536815qte.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXpbRfNhWJ7IW6Gf1J05eWu/7FWhzAgtYkDfpxF/YyI=;
        b=KY/NQ83tTPyfXRlr9NE5vxggxmkdj/X6ii0AtY4KyMMYs5BkccGnsE0BMxe77cC01W
         HApOP3rN2GkBZjwtcQL2Q1fDSwPrdwwMxhmi28sTK+Xy2/xj9opBwJdzSAsGijaSuEys
         mwOiJjFnhaXdbo0kzKJ8QUN1hDhykFRp49XweXWdo1ytHgdbDHfH7UmuELSAB5lbSSva
         sBs8J1PlWr9FJUXIbounbt11eMS/4TMXmZM9eFUFPnfdML81ppKKwNcYZ1xb16KQ0/cP
         FchXBikhQFNHmVsx5aD62OR4gXTuBI7tFjhVgD8aYxEhavNo4MoGL4tNcBmuM6DGAGQU
         JkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXpbRfNhWJ7IW6Gf1J05eWu/7FWhzAgtYkDfpxF/YyI=;
        b=MmXLWkYVC9IKeMzq3akTv1DQ+Bzn8y1gpKkqQmzsMd/ph3u71QIz/S0m6hmfKdT+dD
         ro094L2rPK3kLz25KOyG+vp1RmPTVGu83DNj36eXykahQQcbtKeOUkO10QhxbPPEAVCF
         vMo7yB37VDQEI4m6RhA/iUQ7AHrT5TT9pHcM1HCx9zpICeRQ4WA0xSgmaN5eWZTx4BgP
         p8af2toBC1se2XyOGr22iY2WuwIfR0P2JV1UIxRUMhyspoz3cnDvTRMHluHrg+w/uxOA
         BhsXqT3X6mu/gVY3z3+FHt2IISCU/WS0OJxLcHhnndxPRfiJE77ZxpVrK5DKwTbefz2X
         9aUQ==
X-Gm-Message-State: AOAM532EXQFUudj6CgByYkOAxFZwsJ93/+/Dlb6XqKAFYesKFq7jrfp3
        Y7ja6iygl42h+K8aiM7lNMOgOw==
X-Google-Smtp-Source: ABdhPJw3xzQIvkvzuD1w/1uuDieIE3gnJPa0eHDzNd4qQqgtAwMmeaZQ5ZxrL9tZbk8DzKtH79KKeA==
X-Received: by 2002:a05:622a:1899:: with SMTP id v25mr7755327qtc.233.1626537986573;
        Sat, 17 Jul 2021 09:06:26 -0700 (PDT)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id v20sm4369709qto.89.2021.07.17.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 09:06:26 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Axtens <dja@axtens.net>,
        Huang Pei <huangpei@loongson.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
Date:   Sat, 17 Jul 2021 12:01:15 -0400
Message-Id: <20210717160118.9855-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c742199a breaks arm64 for some configs because it stubs out functions which
should not have been stubbed out.

With 4K pages and ARM64_VA_BITS_39=y, the kernel crashes early on unmapped
1G pages in the linear map caused by pud_set_huge() in alloc_init_pud()
being stubbed out. Reverting c742199a fixes the crash.

Fixes: c742199a ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/mm/mmu.c     | 20 ++++++++------------
 arch/x86/mm/pgtable.c   | 34 +++++++++++++++-------------------
 include/linux/pgtable.h | 26 +-------------------------
 3 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d745865084488..9ff0de1b2b93c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1339,7 +1339,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-#if CONFIG_PGTABLE_LEVELS > 3
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
@@ -1354,16 +1353,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
-int pud_clear_huge(pud_t *pudp)
-{
-	if (!pud_sect(READ_ONCE(*pudp)))
-		return 0;
-	pud_clear(pudp);
-	return 1;
-}
-#endif
-
-#if CONFIG_PGTABLE_LEVELS > 2
 int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
@@ -1378,6 +1367,14 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
+int pud_clear_huge(pud_t *pudp)
+{
+	if (!pud_sect(READ_ONCE(*pudp)))
+		return 0;
+	pud_clear(pudp);
+	return 1;
+}
+
 int pmd_clear_huge(pmd_t *pmdp)
 {
 	if (!pmd_sect(READ_ONCE(*pmdp)))
@@ -1385,7 +1382,6 @@ int pmd_clear_huge(pmd_t *pmdp)
 	pmd_clear(pmdp);
 	return 1;
 }
-#endif
 
 int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3364fe62b9037..3481b35cb4ec7 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -682,7 +682,6 @@ int p4d_clear_huge(p4d_t *p4d)
 }
 #endif
 
-#if CONFIG_PGTABLE_LEVELS > 3
 /**
  * pud_set_huge - setup kernel PUD mapping
  *
@@ -721,23 +720,6 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	return 1;
 }
 
-/**
- * pud_clear_huge - clear kernel PUD mapping when it is set
- *
- * Returns 1 on success and 0 on failure (no PUD map is found).
- */
-int pud_clear_huge(pud_t *pud)
-{
-	if (pud_large(*pud)) {
-		pud_clear(pud);
-		return 1;
-	}
-
-	return 0;
-}
-#endif
-
-#if CONFIG_PGTABLE_LEVELS > 2
 /**
  * pmd_set_huge - setup kernel PMD mapping
  *
@@ -768,6 +750,21 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	return 1;
 }
 
+/**
+ * pud_clear_huge - clear kernel PUD mapping when it is set
+ *
+ * Returns 1 on success and 0 on failure (no PUD map is found).
+ */
+int pud_clear_huge(pud_t *pud)
+{
+	if (pud_large(*pud)) {
+		pud_clear(pud);
+		return 1;
+	}
+
+	return 0;
+}
+
 /**
  * pmd_clear_huge - clear kernel PMD mapping when it is set
  *
@@ -782,7 +779,6 @@ int pmd_clear_huge(pmd_t *pmd)
 
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_X86_64
 /**
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d147480cdefc7..e24d2c992b112 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1397,34 +1397,10 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 }
 #endif /* !__PAGETABLE_P4D_FOLDED */
 
-#ifndef __PAGETABLE_PUD_FOLDED
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
-int pud_clear_huge(pud_t *pud);
-#else
-static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
-{
-	return 0;
-}
-static inline int pud_clear_huge(pud_t *pud)
-{
-	return 0;
-}
-#endif /* !__PAGETABLE_PUD_FOLDED */
-
-#ifndef __PAGETABLE_PMD_FOLDED
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
+int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-#else
-static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
-{
-	return 0;
-}
-static inline int pmd_clear_huge(pmd_t *pmd)
-{
-	return 0;
-}
-#endif /* !__PAGETABLE_PMD_FOLDED */
-
 int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
-- 
2.26.1

