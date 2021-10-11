Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AD4291F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhJKOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:36:31 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:53727 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234869AbhJKOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962869; bh=2A5O+OFybi8Ge+jcHDiYfmxo6jKeWW8QxnwL+wFgFrk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Qc6/aHmXxWF/J/FNGEHzx+0oCZAtZi1Sh0ynORocJFg2Sc5NUDL3LT5d1Uv+3vp+n
         QpPpzEYwYADrpr/qVEW5aBzXuzdJPaPhiyOiu/UaYeWJPt6d0tXhVF3tE7ElDNEHTb
         sPQph+AL+5TAc++8Qwv/pkp+dMpwiO3Ms8T7osClqF8ZdlIkD8sEQXtUOKKEkydyjp
         CXs26AJiVDWwpaeHENnZzN06X6HX/YL3Wy1dmr5tYsbcmwwL46yKOE+JTt9dgQeLUZ
         QrdvcCJp1ieCyevOyQWR9AiPRUNQuoGwTJp4KqPvBUcZWrY6fqYYZVvbNgQ7P0MNDz
         Mfu1BzRq0Isng==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 48373A40239;
        Mon, 11 Oct 2021 14:34:20 +0000 (UTC)
From:   sxwjean@me.com
To:     linux-mm@kvack.org, x86@kernel.org
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Huang Rui <ray.huang@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        "David S. Miller" <davem@davemloft.net>, sxwjean@me.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] x86/mm: Randomize VA with generic arch_pick_mmap_layout()
Date:   Mon, 11 Oct 2021 22:31:48 +0800
Message-Id: <20211011143150.318239-5-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=470 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The code logic of arch_pick_mmap_layout() of x86 is basiclly same as
arch_pick_mmap_layout() where is in mm/util.c. Let's enable
ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT for x86 to use generic
arch_pick_mmap_layout(). Meanwhile, delete the arch_pick_mmap_layout()
and the related assistant functions in x86.

To verify if the entropy of mmap is kept after the patch, I did basically
test with the following c code:
	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/mman.h>

	int main(int argc, char *argv[])
	{
		unsigned long *addr;

		addr = mmap(NULL, 4096, PROT_READ, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
		if (addr == MAP_FAILED) {
			printf("NULL\n");
		} else {
			printf("%lx\n", (unsigned long)addr);
			munmap(addr, 4096);
		}

		return 0;
	}

Run the program above 10 thousands times to get the mmap address, please
see the results below.

Before this patch:
	    Virtual Address Range       | hit times
	----------------------------------------
	0x7f0000000000 - 0x7f0ffffff000 |   655
	0x7f1000000000 - 0x7f1ffffff000 |   617
	0x7f2000000000 - 0x7f2ffffff000 |   636
	0x7f3000000000 - 0x7f3ffffff000 |   625
	0x7f4000000000 - 0x7f4ffffff000 |   651
	0x7f5000000000 - 0x7f5ffffff000 |   591
	0x7f6000000000 - 0x7f6ffffff000 |   623
	0x7f7000000000 - 0x7f7ffffff000 |   627
	0x7f8000000000 - 0x7f8ffffff000 |   638
	0x7f9000000000 - 0x7f9ffffff000 |   586
	0x7fa000000000 - 0x7faffffff000 |   637
	0x7fb000000000 - 0x7fbffffff000 |   607
	0x7fc000000000 - 0x7fcffffff000 |   618
	0x7fd000000000 - 0x7fdffffff000 |   656
	0x7fe000000000 - 0x7feffffff000 |   614
	0x7ff000000000 - 0x7ffffffff000 |   619

After this patch:
	    Virtual Address Range       | hit times
	----------------------------------------
	0x7f0000000000 - 0x7f0ffffff000 |   661
	0x7f1000000000 - 0x7f1ffffff000 |   645
	0x7f2000000000 - 0x7f2ffffff000 |   609
	0x7f3000000000 - 0x7f3ffffff000 |   594
	0x7f4000000000 - 0x7f4ffffff000 |   616
	0x7f5000000000 - 0x7f5ffffff000 |   622
	0x7f6000000000 - 0x7f6ffffff000 |   617
	0x7f7000000000 - 0x7f7ffffff000 |   582
	0x7f8000000000 - 0x7f8ffffff000 |   618
	0x7f9000000000 - 0x7f9ffffff000 |   629
	0x7fa000000000 - 0x7faffffff000 |   635
	0x7fb000000000 - 0x7fbffffff000 |   625
	0x7fc000000000 - 0x7fcffffff000 |   614
	0x7fd000000000 - 0x7fdffffff000 |   610
	0x7fe000000000 - 0x7feffffff000 |   648
	0x7ff000000000 - 0x7ffffffff000 |   675

It looks like the result after the patch is reasonable.

Furthermore, define a is_compat_task() for x86 to fix function undefined
issue.

Add __weak attribute to generic arch_randomize_brk() to ensure the kernel
always uses the arch_randomize_brk() of x86 in x86 arch.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/Kconfig              |   1 +
 arch/x86/include/asm/compat.h |   5 ++
 arch/x86/mm/mmap.c            | 112 ----------------------------------
 mm/util.c                     |   2 +-
 4 files changed, 7 insertions(+), 113 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a52e81cb256e..01a40b710103 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -114,6 +114,7 @@ config X86
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7516e4199b3c..22714a202794 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -156,6 +156,11 @@ struct compat_shmid64_ds {
 	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
 #endif
 
+static inline int is_compat_task(void)
+{
+	return IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_ADDR32);
+}
+
 static inline bool in_x32_syscall(void)
 {
 #ifdef CONFIG_X86_X32_ABI
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..daf65cc5e5b1 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -38,118 +38,6 @@ unsigned long task_size_64bit(int full_addr_space)
 	return full_addr_space ? TASK_SIZE_MAX : DEFAULT_MAP_WINDOW;
 }
 
-static unsigned long stack_maxrandom_size(unsigned long task_size)
-{
-	unsigned long max = 0;
-	if (current->flags & PF_RANDOMIZE) {
-		max = (-1UL) & __STACK_RND_MASK(task_size == task_size_32bit());
-		max <<= PAGE_SHIFT;
-	}
-
-	return max;
-}
-
-#ifdef CONFIG_COMPAT
-# define mmap32_rnd_bits  mmap_rnd_compat_bits
-# define mmap64_rnd_bits  mmap_rnd_bits
-#else
-# define mmap32_rnd_bits  mmap_rnd_bits
-# define mmap64_rnd_bits  mmap_rnd_bits
-#endif
-
-#define SIZE_128M    (128 * 1024 * 1024UL)
-
-static int mmap_is_legacy(void)
-{
-	if (current->personality & ADDR_COMPAT_LAYOUT)
-		return 1;
-
-	return sysctl_legacy_va_layout;
-}
-
-static unsigned long arch_rnd(unsigned int rndbits)
-{
-	if (!(current->flags & PF_RANDOMIZE))
-		return 0;
-	return (get_random_long() & ((1UL << rndbits) - 1)) << PAGE_SHIFT;
-}
-
-unsigned long arch_mmap_rnd(void)
-{
-	return arch_rnd(mmap_is_ia32() ? mmap32_rnd_bits : mmap64_rnd_bits);
-}
-
-static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
-			       struct rlimit *rlim_stack)
-{
-	unsigned long gap = rlim_stack->rlim_cur;
-	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
-	unsigned long gap_min, gap_max;
-
-	/* Values close to RLIM_INFINITY can overflow. */
-	if (gap + pad > gap)
-		gap += pad;
-
-	/*
-	 * Top of mmap area (just below the process stack).
-	 * Leave an at least ~128 MB hole with possible stack randomization.
-	 */
-	gap_min = SIZE_128M;
-	gap_max = (task_size / 6) * 5;
-
-	if (gap < gap_min)
-		gap = gap_min;
-	else if (gap > gap_max)
-		gap = gap_max;
-
-	return PAGE_ALIGN(task_size - gap - rnd);
-}
-
-static unsigned long mmap_legacy_base(unsigned long rnd,
-				      unsigned long task_size)
-{
-	return __TASK_UNMAPPED_BASE(task_size) + rnd;
-}
-
-/*
- * This function, called very early during the creation of a new
- * process VM image, sets up which VM layout function to use:
- */
-static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
-		unsigned long random_factor, unsigned long task_size,
-		struct rlimit *rlim_stack)
-{
-	*legacy_base = mmap_legacy_base(random_factor, task_size);
-	if (mmap_is_legacy())
-		*base = *legacy_base;
-	else
-		*base = mmap_base(random_factor, task_size, rlim_stack);
-}
-
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
-{
-	if (mmap_is_legacy())
-		mm->get_unmapped_area = arch_get_unmapped_area;
-	else
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
-
-	arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
-			arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
-			rlim_stack);
-
-#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
-	/*
-	 * The mmap syscall mapping base decision depends solely on the
-	 * syscall type (64-bit or compat). This applies for 64bit
-	 * applications and 32bit applications. The 64bit syscall uses
-	 * mmap_base, the compat syscall uses mmap_compat_base.
-	 */
-	arch_pick_mmap_base(&mm->mmap_compat_base, &mm->mmap_compat_legacy_base,
-			arch_rnd(mmap32_rnd_bits), task_size_32bit(),
-			rlim_stack);
-#endif
-}
-
 unsigned long get_mmap_base(int is_legacy)
 {
 	struct mm_struct *mm = current->mm;
diff --git a/mm/util.c b/mm/util.c
index ab3711c445e6..91a26da501d3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -344,7 +344,7 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 }
 
 #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-unsigned long arch_randomize_brk(struct mm_struct *mm)
+unsigned long __weak arch_randomize_brk(struct mm_struct *mm)
 {
 	/* Is the current task 32bit ? */
 	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
-- 
2.30.2

