Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BF31161F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhBEWv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:51:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:27370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhBEOmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:42:55 -0500
IronPort-SDR: aIzaq62Il7pLdAufD3vyFhSDK/dBVP7KBpuJGbAA4ZgQUrdtG3ZZ3InBKkFJAD5BtPBd5n7s2W
 eqVwhBREmGnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266273610"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="266273610"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:49 -0800
IronPort-SDR: zgKDaClIwIvBd6Pnmc+DLs9UeYhat+eFSlon/Anj46ldVGWyPnhUNAGAj12ZX7mu6BCs7KF2T7
 G8Tq5C34EqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="508569469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 07:16:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 15AB03F9; Fri,  5 Feb 2021 17:16:41 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 8/9] x86/mm: Make LAM_U48 and mappings above 47-bits mutually exclusive
Date:   Fri,  5 Feb 2021 18:16:29 +0300
Message-Id: <20210205151631.43511-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAM_U48 steals bits above 47-bit for tags and makes it impossible for
userspace to use full address space on 5-level paging machine.

Make these features mutually exclusive: whichever gets enabled first
blocks the othe one.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/elf.h         |  3 ++-
 arch/x86/include/asm/mmu_context.h | 13 +++++++++++++
 arch/x86/kernel/sys_x86_64.c       |  5 +++--
 arch/x86/mm/hugetlbpage.c          |  6 ++++--
 arch/x86/mm/mmap.c                 |  9 ++++++++-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..8ba405dfb861 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -326,7 +326,8 @@ static inline int mmap_is_ia32(void)
 extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
-extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern bool mmap_address_hint_valid(struct mm_struct *mm,
+				    unsigned long addr, unsigned long len);
 
 #ifdef CONFIG_X86_32
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b83755..e338beb031b2 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -214,4 +214,17 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#ifdef CONFIG_X86_5LEVEL
+static inline bool full_va_allowed(struct mm_struct *mm)
+{
+	/* LAM_U48 steals VA bits abouve 47-bit for tags */
+	return mm->context.lam != LAM_U48;
+}
+#else
+static inline bool full_va_allowed(struct mm_struct *mm)
+{
+	return false;
+}
+#endif
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 504fa5425bce..b5d0afee9b0f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,6 +21,7 @@
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
+#include <asm/mmu_context.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
@@ -189,7 +190,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	/* requesting a specific address */
 	if (addr) {
 		addr &= PAGE_MASK;
-		if (!mmap_address_hint_valid(addr, len))
+		if (!mmap_address_hint_valid(mm, addr, len))
 			goto get_unmapped_area;
 
 		vma = find_vma(mm, addr);
@@ -210,7 +211,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	 * !in_32bit_syscall() check to avoid high addresses for x32
 	 * (and make it no op on native i386).
 	 */
-	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
+	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall() && full_va_allowed(mm))
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
 	info.align_mask = 0;
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index a0d023cb4292..9fdc8db42365 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -18,6 +18,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/elf.h>
+#include <asm/mmu_context.h>
 
 #if 0	/* This is just for testing */
 struct page *
@@ -103,6 +104,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
+	struct mm_struct *mm = current->mm;
 	struct vm_unmapped_area_info info;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
@@ -114,7 +116,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
 	 * in the full address space.
 	 */
-	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
+	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall() && full_va_allowed(mm))
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
@@ -161,7 +163,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (addr) {
 		addr &= huge_page_mask(h);
-		if (!mmap_address_hint_valid(addr, len))
+		if (!mmap_address_hint_valid(mm, addr, len))
 			goto get_unmapped_area;
 
 		vma = find_vma(mm, addr);
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..f9ca824729de 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -21,6 +21,7 @@
 #include <linux/elf-randomize.h>
 #include <asm/elf.h>
 #include <asm/io.h>
+#include <asm/mmu_context.h>
 
 #include "physaddr.h"
 
@@ -35,6 +36,8 @@ unsigned long task_size_32bit(void)
 
 unsigned long task_size_64bit(int full_addr_space)
 {
+	if (!full_va_allowed(current->mm))
+		return DEFAULT_MAP_WINDOW;
 	return full_addr_space ? TASK_SIZE_MAX : DEFAULT_MAP_WINDOW;
 }
 
@@ -206,11 +209,15 @@ const char *arch_vma_name(struct vm_area_struct *vma)
  * the failure of such a fixed mapping request, so the restriction is not
  * applied.
  */
-bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
+bool mmap_address_hint_valid(struct mm_struct *mm,
+			     unsigned long addr, unsigned long len)
 {
 	if (TASK_SIZE - len < addr)
 		return false;
 
+	if (addr + len > DEFAULT_MAP_WINDOW && !full_va_allowed(mm))
+		return false;
+
 	return (addr > DEFAULT_MAP_WINDOW) == (addr + len > DEFAULT_MAP_WINDOW);
 }
 
-- 
2.26.2

