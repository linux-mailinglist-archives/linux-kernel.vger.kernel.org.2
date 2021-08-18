Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E783EFCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhHRGb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbhHRGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:31:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so1874328yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r28OOl9H0j68087MxXenLvNFF4q/L5LmucJPA1P1rF0=;
        b=rVacPqv+ksAvDz+9AzHa3UA8YFJnchxgAhITykWT0kxNmHdqCt/DAMGYBXtFWBzdAw
         UzvzekE5eXZhtYXiInhdds4rbazWL2e8SFPVHUTGBWlGoWlFjQjsFG7H8fdm3sVFRrQW
         CFVuV2fjqGRF2ixE+rJiDYBWDDGU/m+XKJeE5lrzOOrs34yZw1Ln+xkk4ovZWFoIZoZa
         qCrHFEneIQhdNP2RXcj/F4CpHXU0rbR7/8YAGVM5R73tsv7EDGpvPGvc4a+NpC+R39BQ
         Ur9JQcBxVNokNwE8GV6vwh3SSZ/rfbxBm3LxCp2vVHVrgTnlp/1EuNSgPFpyUabNGaju
         +HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r28OOl9H0j68087MxXenLvNFF4q/L5LmucJPA1P1rF0=;
        b=c5gLHS54oFVwS8A4nw6R5+3FUpr7eopfkVC5KPqqX1KA/CZaghoce6XiEhgS6QWwKb
         33wa8T6zkj9nYvXmEavFSrkiHkGTkZ1YWF4kC8u1DG4eqjF6UOWIdzAcZ6DLluNdh+Sq
         yi7CB1OchFoeEH9PZPfmx/xWsYz3TlwQLrFHA168mIpuJtA3iL15ISnaD22IuuK7WFqn
         WTWBcH0qhPjC+adXzm25ZQ1bzj+F7gsKkucDPhA804LwdAmHQRICUXprRub/HcpACLOw
         RE6bjXTMLraDVCMoXpFpHNO9bg2j4p/4mEgg8Nc4iqVePnvtNDESv6KQZOF/7NTAN/9O
         bg/A==
X-Gm-Message-State: AOAM530kzhv8KQe5gDBQs8yE/+ZrerIxPTtwtunLO8Xtw1YSbkXqBVK8
        7pnx53EK1e7rIhq508MiRe/jAa8PV+E=
X-Google-Smtp-Source: ABdhPJxKa+6gSOMXKC9+9yKBARFPL7honqMsWyRtIkHW0A5Nhi7abOtfmKUl4eee1vwoKxR4P+tGRKOMAyI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:41f0:f89:87cd:8bd0])
 (user=yuzhao job=sendgmr) by 2002:a25:2688:: with SMTP id m130mr9020507ybm.146.1629268273873;
 Tue, 17 Aug 2021 23:31:13 -0700 (PDT)
Date:   Wed, 18 Aug 2021 00:30:58 -0600
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
Message-Id: <20210818063107.2696454-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20210818063107.2696454-1-yuzhao@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v4 02/11] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support the accessed bit on non-leaf PMD entries,
e.g., x86_64 sets the accessed bit on a non-leaf PMD entry when using
it as part of linear address translation [1]. As an optimization, page
table walkers who are interested in the accessed bit can skip the PTEs
under a non-leaf PMD entry if the accessed bit is cleared on this
non-leaf PMD entry.

Although an inline function may be preferable, this capability is
added as a configuration option to look consistent when used with the
existing macros.

[1]: Intel 64 and IA-32 Architectures Software Developer's Manual
     Volume 3 (October 2019), section 4.8

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
index 129df498a8e1..5b6b4f95372f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1282,6 +1282,15 @@ config ARCH_SPLIT_ARG64
 config ARCH_HAS_ELFCORE_COMPAT
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
index 88fb922c23a0..36a81d31f711 100644
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
index 3908780fc408..01a1763123ff 100644
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
index 3a8221fa2c76..483d5ff7a33e 100644
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
2.33.0.rc1.237.g0d66db33f3-goog

