Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC844588F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhKVFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKVFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:32:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:29:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so13099470plf.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=uPLgIBlHzlDQAOxeK/1rgfm4GBYhPTkogYnAxbthSW4=;
        b=amL2AcIf4MijIAxFlA4zp8S+pih7hjHTs+2DPv7zcdL6CSlJvsWw9D/BbIkvgnJQPP
         EC2dZNRKYEwtlxQSjemxgTb42pAN67c7IBWHvvmBYvc2+cDIk889jYsCtF5vD2+l5COR
         vHINg8Jqj4lZUuHNw7WXZ+uYI9miAmX5jhOC1SnTM+QFCypuIuCVTQ+R1ilGkt5Bv7dh
         9uBiKm+SWdLG/fVCRGpeXG+PNIcxMD6jWbvh80/4PVuSlhD0cCc+3LiqEzdrj35/+j1z
         vnwEmhyKpRJi5lQXijSjvsCTPliOtt3ZhkL/pKZH05v3fzAHVmBAtTFw3But/sJp6mDL
         3pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=uPLgIBlHzlDQAOxeK/1rgfm4GBYhPTkogYnAxbthSW4=;
        b=Vgc0FYdPNKuuq0PMDi2xZ/EFxwa/mit8LDQcp7aNqADjOWfWW7X8gMeMFRsH6b1fDY
         qIPGv3RkNT77eWDYaLvsyLFVI5+xVnuXFzyFZ521KHL6iyThLcouSsZADd72XEASn2pC
         k8VgT+CV9QSg3KhoMjq/BLxw7ixUNdS1ZoZHsn+g9Uouly7c4kSUstMUgM7FauQa2qwz
         J5LrqaJrwaEpsoIjGqpe1oNrDSBSVlTYZMAP8UAxMm+d4ZPiWevIt6gZwpcNoA5CWjSq
         pkcPXT3Qqrp9YAqIzALBOG4ilvAO5CJxf0Pr1hMN5eMaPNIC4gGFVfnnhLzH7uFL2msQ
         hx2g==
X-Gm-Message-State: AOAM532yocBzz9C26jG6ZoBGjyGHzi97XOwJQ4NzWL0r0KXkD8BsiL/z
        nj8gi9XawdeWBlfo38R+3Q6oLz4xOEFzKg==
X-Google-Smtp-Source: ABdhPJwzZQByaR18uPu69Kq/3ouZzOAOpUx9v+kDWevWfW8GYWYxEoicSE+M8rNxgkhr890XjMhybQ==
X-Received: by 2002:a17:902:e405:b0:141:b2fa:b00 with SMTP id m5-20020a170902e40500b00141b2fa0b00mr103683808ple.22.1637558949950;
        Sun, 21 Nov 2021 21:29:09 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g21sm7592725pfc.95.2021.11.21.21.29.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 21:29:09 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arch: arm64: introduce RODATA_FULL_USE_PTE_CONT
Date:   Mon, 22 Nov 2021 13:28:49 +0800
Message-Id: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Kernel linear mapping will be split to the smallest granularity when
RODATA_FULL applied, which could lead to TLB pressure. Introduce a method
to apply PTE_CONT on pte.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/Kconfig       |  9 +++++++++
 arch/arm64/mm/mmu.c      | 10 ++++++++--
 arch/arm64/mm/pageattr.c |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fee914c..3f8fbf0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1198,6 +1198,15 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config RODATA_FULL_USE_PTE_CONT
+       bool "Apply PTE_CONT when RODATA_FULL_DEFAULT_ENABLED enabled"
+       depends on RODATA_FULL_DEFAULT_ENABLED
+       default y
+       help
+         Apply PTE_CONT on linear mapping as much as we can when
+         RODATA_FULL_DEFAULT_ENABLED enabled which could decrease the
+         impaction on performance by small pte granularity.
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb..8017b17 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -124,15 +124,21 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	 * The following mapping attributes may be updated in live
 	 * kernel mappings without the need for break-before-make.
 	 */
+#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
 	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
+#else
+	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG | PTE_CONT;
+#endif
 
 	/* creating or taking down mappings is always safe */
 	if (old == 0 || new == 0)
 		return true;
 
 	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
+#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
+	if (old | new) & PTE_CONT)
 		return false;
+#endif
 
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
@@ -206,7 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (IS_ENABLED(CONFIG_RODATA_FULL_USE_PTE_CONT) || (flags & NO_CONT_MAPPINGS) == 0))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(pmdp, addr, next, phys, __prot);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd7..88a87eb 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -99,6 +99,15 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
 		for (i = 0; i < area->nr_pages; i++) {
+#ifdef CONFIG_RODATA_FULL_USE_PTE_CONT
+			unsigned long cont_pte_low_bound;
+			unsigned long addr;
+
+			addr = (u64)page_address(area->pages[i]);
+			cont_pte_low_bound = addr & CONT_PTE_MASK;
+			__change_memory_common(cont_pte_low_bound,
+					       (~CONT_PTE_MASK + 1), __pgprot(0) , __pgprot(PTE_CONT));
+#endif
 			__change_memory_common((u64)page_address(area->pages[i]),
 					       PAGE_SIZE, set_mask, clear_mask);
 		}
-- 
1.9.1

