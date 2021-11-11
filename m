Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599644D0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhKKESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhKKESH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA5C0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so7567862ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UqQ1CAHDKzNIHLLK4QSZngjkwRJTSigVp7v0+NSGo7s=;
        b=iCTrg5hHtKFPWug2bcoGi1y0JSa/3ibgMhmXVbdRD8JMGzVbhCPL8gwxwh6Hd6I0m4
         cxsZfNdVwtSrDVKdEp3d9cqbPMulbzip+86pdgV4njqKhDOi3BIQnPGMz2aT0ZKPV96n
         xK+tc14myylCnDee3S0ioGi+PpuCZd9TMCv5IHtHpbPhSglKW+PxgU9vaBXFQI4HSxux
         t/DwjX34g7G80VP9EDeyeShh1C+RWvkNa6UjlGUFqMsDUdu/+mJdn5Mu1DSLhFDu8QPN
         mMRo4OdwQjqUK31qpe28XbPEKhUEnh0Yicb9/nDJgtLVccFoGmVcmDKfZD7e9ulZQDEX
         4kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UqQ1CAHDKzNIHLLK4QSZngjkwRJTSigVp7v0+NSGo7s=;
        b=rMbAMJdDBywJgXxa34PW94Qd+GOT5949DSNeP2yJWXcy6Q3niEhRCFCmsv5FVVC+5d
         CMAah0xkNIUxd41pdCs/C3ShPnq6V50DvAYZsmORowOGpxn+Sabjjg8S4EOGKSbvP/Nm
         t3JAhvo7+KjDIA8cA9S9Kiw7WWablmNY5gVgH9du+sr3BTPj9GdzEzWU5T9TbbNes7V+
         6h3LeFo+SHOem59sq0nQZCJ6azqKzeUOilPZ4CtFgx9qxDz9OB0m8anTBouCPvj1hfpj
         LI2+8kFe7w6WVdn2XcfjNa2VIrp0glIW5MByaGP7wtRa0Od2o7gdiuTVnq6ZNk2poYZR
         2o1w==
X-Gm-Message-State: AOAM531jJTvTFn9cmhb10HLUB5g4YNoM7qAukWVuA696P3GP1iqv6OZ6
        Lb+eY0igxNQjWIRhOwCK+y0gKWT1fbc=
X-Google-Smtp-Source: ABdhPJwuPl9PJhP6Upxe5eqWLpjhaqFw0snAdbggMzVCEnomOiwgAM1BKhvsCadbArbOq/ns603ARh86ExE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a25:c70f:: with SMTP id w15mr5226488ybe.167.1636604118332;
 Wed, 10 Nov 2021 20:15:18 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:02 -0700
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
Message-Id: <20211111041510.402534-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 02/10] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support the accessed bit on non-leaf PMD entries,
e.g., x86_64 sets the accessed bit on a non-leaf PMD entry when using
it as part of linear address translation [1]. As an optimization, page
table walkers who are interested in the accessed bit can skip the PTEs
under a non-leaf PMD entry if the accessed bit is cleared on this PMD
entry.

Although an inline function may be preferable, this capability is
added as a configuration option to look consistent when used with the
existing macros.

[1]: Intel 64 and IA-32 Architectures Software Developer's Manual
     Volume 3 (June 2021), section 4.8

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 arch/Kconfig                   | 9 +++++++++
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 3 ++-
 arch/x86/mm/pgtable.c          | 5 ++++-
 include/linux/pgtable.h        | 4 ++--
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..7392fcc88777 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1288,6 +1288,15 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config ARCH_HAS_NONLEAF_PMD_YOUNG
+	bool
+	depends on PGTABLE_LEVELS > 2
+	help
+	  Architectures that select this are able to set the accessed bit on
+	  non-leaf PMD entries in addition to leaf PTE entries where pages are
+	  mapped. For them, page table walkers that clear the accessed bit may
+	  stop at non-leaf PMD entries if they do not see the accessed bit.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d9830e7e1060..245742b79be9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -84,6 +84,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NONLEAF_PMD_YOUNG	if X86_64
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c60b16f8b741..36205ec0acac 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -817,7 +817,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 
 static inline int pmd_bad(pmd_t pmd)
 {
-	return (pmd_flags(pmd) & ~_PAGE_USER) != _KERNPG_TABLE;
+	return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=
+	       (_KERNPG_TABLE & ~_PAGE_ACCESSED);
 }
 
 static inline unsigned long pages_to_mb(unsigned long npg)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..a224193d84bf 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -550,7 +550,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return ret;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pmd_t *pmdp)
 {
@@ -562,6 +562,9 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pudp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pud_t *pudp)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a64c6124c137..afb9004b778a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -211,7 +211,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
@@ -232,7 +232,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 	BUILD_BUG();
 	return 0;
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-- 
2.34.0.rc0.344.g81b53c2807-goog

