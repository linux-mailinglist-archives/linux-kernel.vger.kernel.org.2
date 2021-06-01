Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E5397CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhFAXYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234989AbhFAXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33F4761396;
        Tue,  1 Jun 2021 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622589755;
        bh=/uKKR8u1AHOQjBwcyVTzk/1UAcLGgZWy4Bb+xUC5YIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRja1mt022qtedKaIMuXmoumyP0IS62eYwap3qR7HCsavXo184zPIhUqrd1xmqL1w
         HTNbI81IKyD9EOYkp7yHB0Qkz+hWTv7ggbj5S4DffxQNyaotjnfp8pHbShQfT8ioI9
         aOIxeWDTJxe6Fhfx++1YwMbYcxQfn+TZ7+ef3myjfbCaASGms3xhgPVHwkRMjCHG1z
         LwrTttvUcQyVcDH1lzOULoTzwqhiV1jA0D8xnZl5NxHhI3llVwvhfhq1rJqJ8EDKtU
         oNf3K44C4/8rcmQ20apxe9ees82QntAyd6HiREBdDh7rYCMTkDrKQ8LlwnB9KS+wXL
         9dENEjHpXwyeA==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ming Lin <mlin@kernel.org>
Subject: [PATCH 1/2] mm: make "vm_flags" be an u64
Date:   Tue,  1 Jun 2021 16:22:32 -0700
Message-Id: <1622589753-9206-2-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622589753-9206-1-git-send-email-mlin@kernel.org>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can have enough bits on 32-bit architectures.

Signed-off-by: Ming Lin <mlin@kernel.org>
---
 arch/arm64/Kconfig       |   1 -
 arch/powerpc/Kconfig     |   1 -
 arch/x86/Kconfig         |   1 -
 include/linux/mm.h       | 100 ++++++++++++++++++++++-------------------------
 include/linux/mm_types.h |   4 +-
 include/linux/mman.h     |   4 +-
 mm/Kconfig               |   2 -
 mm/memory.c              |   2 +-
 mm/mmap.c                |   2 +-
 9 files changed, 53 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d856..c6960ea 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1658,7 +1658,6 @@ config ARM64_MTE
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
 	depends on ARM64_PAN
-	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2a..5c1b49e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -940,7 +940,6 @@ config PPC_MEM_KEYS
 	prompt "PowerPC Memory Protection Keys"
 	def_bool y
 	depends on PPC_BOOK3S_64
-	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b..a885336 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1874,7 +1874,6 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	def_bool y
 	# Note: only available in 64-bit mode
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
-	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75..e9d67bc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -264,73 +264,68 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+#define VM_FLAGS_BIT(N)	(1ULL << (N))
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
 #define VM_NONE		0x00000000
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_READ		VM_FLAGS_BIT(0)	 /* currently active flags */
+#define VM_WRITE	VM_FLAGS_BIT(1)
+#define VM_EXEC		VM_FLAGS_BIT(2)
+#define VM_SHARED	VM_FLAGS_BIT(3)
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
-
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
-
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#define VM_MAYREAD	VM_FLAGS_BIT(4)	 /* limits for mprotect() etc */
+#define VM_MAYWRITE	VM_FLAGS_BIT(5)
+#define VM_MAYEXEC	VM_FLAGS_BIT(6)
+#define VM_MAYSHARE	VM_FLAGS_BIT(7)
+
+#define VM_GROWSDOWN	VM_FLAGS_BIT(8)	 /* general info on the segment */
+#define VM_UFFD_MISSING	VM_FLAGS_BIT(9)	 /* missing pages tracking */
+#define VM_PFNMAP	VM_FLAGS_BIT(10) /* Page-ranges managed without "struct page", just pure PFN */
+#define VM_DENYWRITE	VM_FLAGS_BIT(11) /* ETXTBSY on write attempts.. */
+#define VM_UFFD_WP	VM_FLAGS_BIT(12) /* wrprotect pages tracking */
+
+#define VM_LOCKED	VM_FLAGS_BIT(13)
+#define VM_IO           VM_FLAGS_BIT(14) /* Memory mapped I/O or similar */
+
+					 /* Used by sys_madvise() */
+#define VM_SEQ_READ	VM_FLAGS_BIT(15) /* App will access data sequentially */
+#define VM_RAND_READ	VM_FLAGS_BIT(16) /* App will not benefit from clustered reads */
+
+#define VM_DONTCOPY	VM_FLAGS_BIT(17) /* Do not copy this vma on fork */
+#define VM_DONTEXPAND	VM_FLAGS_BIT(18) /* Cannot expand with mremap() */
+#define VM_LOCKONFAULT	VM_FLAGS_BIT(19) /* Lock the pages covered when they are faulted in */
+#define VM_ACCOUNT	VM_FLAGS_BIT(20) /* Is a VM accounted object */
+#define VM_NORESERVE	VM_FLAGS_BIT(21) /* should the VM suppress accounting */
+#define VM_HUGETLB	VM_FLAGS_BIT(22) /* Huge TLB Page VM */
+#define VM_SYNC		VM_FLAGS_BIT(23) /* Synchronous page faults */
+#define VM_ARCH_1	VM_FLAGS_BIT(24) /* Architecture-specific flag */
+#define VM_WIPEONFORK	VM_FLAGS_BIT(25) /* Wipe VMA contents in child. */
+#define VM_DONTDUMP	VM_FLAGS_BIT(26) /* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+# define VM_SOFTDIRTY	VM_FLAGS_BIT(27) /* Not soft dirty clean area */
 #else
 # define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
-
-#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
-#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+#define VM_MIXEDMAP	VM_FLAGS_BIT(28) /* Can contain "struct page" and pure PFN pages */
+#define VM_HUGEPAGE	VM_FLAGS_BIT(29) /* MADV_HUGEPAGE marked this vma */
+#define VM_NOHUGEPAGE	VM_FLAGS_BIT(30) /* MADV_NOHUGEPAGE marked this vma */
+#define VM_MERGEABLE	VM_FLAGS_BIT(31) /* KSM may merge identical pages */
+
+#define VM_HIGH_ARCH_0	VM_FLAGS_BIT(32)
+#define VM_HIGH_ARCH_1	VM_FLAGS_BIT(33)
+#define VM_HIGH_ARCH_2	VM_FLAGS_BIT(34)
+#define VM_HIGH_ARCH_3	VM_FLAGS_BIT(35)
+#define VM_HIGH_ARCH_4	VM_FLAGS_BIT(36)
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
+# define VM_PKEY_SHIFT	32
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
@@ -373,8 +368,7 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	37
-# define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
+# define VM_UFFD_MINOR		VM_FLAGS_BIT(37)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c..5347293 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -264,7 +264,7 @@ struct page_frag_cache {
 	bool pfmemalloc;
 };
 
-typedef unsigned long vm_flags_t;
+typedef u64 vm_flags_t;
 
 /*
  * A region containing a mapping of a non-memory backed file under NOMMU
@@ -330,7 +330,7 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+	vm_flags_t vm_flags;			/* Flags, see mm.h. */
 
 	/*
 	 * For areas with an address space and backing store,
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 629cefc..b2cbae9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -135,7 +135,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 /*
  * Combine the mmap "prot" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
 {
 	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
@@ -147,7 +147,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 /*
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_flag_bits(unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
diff --git a/mm/Kconfig b/mm/Kconfig
index 02d44e3..aa8efba 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -830,8 +830,6 @@ config DEVICE_PRIVATE
 config VMAP_PFN
 	bool
 
-config ARCH_USES_HIGH_VMA_FLAGS
-	bool
 config ARCH_HAS_PKEYS
 	bool
 
diff --git a/mm/memory.c b/mm/memory.c
index 730daa0..eff2a47 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -550,7 +550,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
 	if (page)
 		dump_page(page, "bad pte");
-	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
+	pr_alert("addr:%px vm_flags:%08llx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps readpage:%ps\n",
 		 vma->vm_file,
diff --git a/mm/mmap.c b/mm/mmap.c
index 0584e54..096bba4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1353,7 +1353,7 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 }
 
 static inline int mlock_future_check(struct mm_struct *mm,
-				     unsigned long flags,
+				     vm_flags_t flags,
 				     unsigned long len)
 {
 	unsigned long locked, lock_limit;
-- 
1.8.3.1

