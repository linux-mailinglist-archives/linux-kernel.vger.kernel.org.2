Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0943C324042
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhBXOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:44:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:39326 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210224133105epoutp03598fcf7c69ce74a60c4a4d7301de64bc~msjbgutZq0056700567epoutp03X
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:31:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210224133105epoutp03598fcf7c69ce74a60c4a4d7301de64bc~msjbgutZq0056700567epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614173465;
        bh=uPAhP8Wnfwm8b3SBQk3lWo6UuUQe2oZPT/GdukZ8jIc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eZIWmkGPqLjoMmrsiASYBjtvs/QsLinNTu5ZMib3+w4dethqlj3qCZ0LcDPFrg6zv
         LZBuivmSetAUJRFhJ1iouBYMfukvgsCzqiNNwDZULhmCVLIiTjBrx0ekevggtvjZn4
         dUz0d44fNeUX2xf6ChuUS9/3lOjM2LpeCkw/LEZQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210224133103epcas5p12f9d82cfe4c687f145c809e112623aaa~msjaBJ53q1306913069epcas5p15;
        Wed, 24 Feb 2021 13:31:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.E6.50652.71556306; Wed, 24 Feb 2021 22:31:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210224123759epcas5p1c1143b69537467c5135283d590c89bf7~mr1E18v6U2103921039epcas5p1D;
        Wed, 24 Feb 2021 12:37:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210224123759epsmtrp1646440d8bb344449f142996c70cabdff~mr1E1HsjG1759417594epsmtrp12;
        Wed, 24 Feb 2021 12:37:59 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-54-60365517cb3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.D8.08745.7A846306; Wed, 24 Feb 2021 21:37:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210224123757epsmtip15dbe7adf8054e6ea66b914835d6714f2~mr1CoKN4W1278012780epsmtip1N;
        Wed, 24 Feb 2021 12:37:57 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] arm: print alloc free paths for address in registers
Date:   Wed, 24 Feb 2021 18:07:34 +0530
Message-Id: <1614170254-3207-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUwTaRjG/ebq0E3NpBD4BCSGwAbYUPEejSJhFYdNMF6LWRO1jZ1UAhTS
        ioox2WqxpkWFSAmouFvSorErlK2sEuSoxXhUxdQq2IiCCIqURtriCaK2o9n/fs/7vOeXj0SF
        ejyazJPvYRVySUE8wccudycnpUb9vlScVmaLpZ1XWbrOcpGg+96NA/pCuZqgrS96cdrVVkfQ
        zy5+wWl7dQegu//WYLQmMIPTGtO/CG2/fRbQZw6dABkCxtXrRBmDtYSxmrUEY/Wf5DE670OE
        uVU7hTHDD2sQ5pLpT+ZEixkwdw3XeUzAGrfhp238lVK2IG8vq5ifLubvNhxuRoorF+3/9M8V
        ngpUpehAGAmpxXDUYwdBFlJXAXQ1lOoA/xv7AazVdqKcCAA41qBBdIAMVXzonc3F2wBU17Yj
        nJgEsNvlRoKtCEoEzW3tWNCIoGoA1J13EEGBUjcA/HivCwtmhVPZ0PLoFR5kjEqE1skRIsgC
        Kgs+sehRbsE46O7RhvaAlJaERpuW4Iw10OuZBhyHw7GbLTyOo+HrCg2PK1AD6O9sBJzQA9jg
        9OFc1mroUatCF6FUMrS0zefCc2G1oyl0A0rNhsenhhEuLoCtf/3gRFjmbv7eJgYGfD6MYwZW
        e7pw7im3w7Mj14hKMPf0/xMMAJjBHLZYWShjlUuKF8rZfSKlpFBZIpeJdhUVWkHo46T81gqe
        D06I7AAhgR1AEo2PEFyaWSIWCqSS0gOsominoqSAVdpBDInFRwla0wZ3CimZZA+bz7LFrOKH
        i5Bh0Sqk0bsl3Kkx7RjOjF32YpVjMuf9SVkL71iuibKuYfqPRsT4empz+81j9feHjojSG+4M
        bPkvpv1oRZMjvMNhezCwfMbSkdBp5Ed6S8PGmVtL3+oGijo2XMakxoKAZ/BcYlWa6lBFwrT+
        1JDSn6pHHjij7m3auMvSt6LdPxHpWL3+1Tx3V9+0tHmz84j74O0kuwR7/EucaFZd0/0zWfVZ
        o4tHmISfM56NT310rMiseTuUI6iXxOKk0Oetyn+teoerTyeVS6/IVoqTM1vzX+7ILk/cGv3r
        OoNnovJ4zwKXI1084PyjzG7rdJce1Dy1NfbrTfLRvI05GXS2s9v4eW3u1jfxmHK3ZEEKqlBK
        vgIAEU3+pwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO5yD7MEgy/vNS0u7k61mLN+DZvF
        9W9vGC1WdjezWWx6fI3V4vKuOWwW99b8Z7U4NHUvo8Xh+W0sFm2f/7FatC3ZyGRx6ORcRovZ
        jX2MDrwel69dZPZYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5bF5S79G3ZRWjx5kF
        R9g9Pm+SC+CO4rJJSc3JLEst0rdL4MpY0LSBqWCCccWv1dvZGxgna3UxcnBICJhI/LjG18XI
        xSEksINRouvZA+YuRk6guLTEz3/vWSBsYYmV/56zQxR9YpTo7DgHVsQmoCexatceFpCEiMB8
        RomnX2czgTjMAmcYJd5dncsEUiUs4Cmx/upzVhCbRUBVYtOXp2wgNq+Am8Tt9VOg1slJ3DzX
        yTyBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg0NXS2sG4Z9UHvUOMTByM
        hxglOJiVRHg3/zNNEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyW
        iYNTqoHpWKT4UgG5y7J8/N/fHhGYXBm3yEtW+fd7TofzBtmCvGemFKnXv+P5tWalbqxe74Yj
        zanfJ1deuVv1+q90R+HR05Lf3jL9+LJjSeYF64dFL17bCNeutjJi+bdQ+KFW4e1f0zSPSlaV
        KR/KzDC39PmQ/HK7/Qs+59jyy6UX3/7ye8+sGLl6yeWIsrOhTdpcJ8Runzhskihm0jNV4EGF
        eLSt3cdNey8uYMj+Ejnvw9LwKzYNixx2fH1zZPWHTTs3anB56FxsPWY9r6rbRk9Z8WHlS4vq
        7qgbekvE73/lTpl81FT8aFKe3/KP8QZ7/AWW+nUnP9vmKdZxueVMyst3UWsNZ6T9OLs+Rt1l
        55Pvz1btV2Ipzkg01GIuKk4EAJkvo2LMAgAA
X-CMS-MailID: 20210224123759epcas5p1c1143b69537467c5135283d590c89bf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210224123759epcas5p1c1143b69537467c5135283d590c89bf7
References: <CGME20210224123759epcas5p1c1143b69537467c5135283d590c89bf7@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of "Use After Free" kernel OOPs, free path of object
is required to debug futher.
And in most of cases object address is present in one of registers.

Thus check for register address and if it belongs to slab,
print its alloc and free path.

e.g. in below issue  register r6 belongs to slab, and user afree issue
occurred on one of its derefer values:

[  124.310386] (ptrval)
[  124.312647] 8<--- cut here ---
[  124.313761] Unable to handle kernel paging request at virtual address 6b6b6b6f
[  124.315972] pgd = (ptrval)
...
[  124.328290] pc : [<c052fc0c>]    lr : [<c052fc00>]    psr: 60000013
[  124.330349] sp : c8993d28  ip : 0000bff4  fp : c8ae2020
[  124.332071] r10: 00000000  r9 : 00000001  r8 : c1804cc8
[  124.333803] r7 : 00000000  r6 : c8ae9180  r5 : c1804a80  r4 : c8ae2008
[  124.335936] r3 : 6b6b6b6b  r2 : 315049d6  r1 : 2d867000  r0 : c1396584
..
[  124.365233] register r6: c8ae9180 belongs to slab object
[  124.366364] INFO: Allocated in meminfo_proc_show+0x3c/0x500 age=1 cpu=0 pid=69
[  124.367545]  meminfo_proc_show+0x3c/0x500
[  124.368271]  seq_read_iter+0x10c/0x4bc
[  124.368994]  proc_reg_read_iter+0x74/0xa8
[  124.369712]  generic_file_splice_read+0xe8/0x178
[  124.370496]  splice_direct_to_actor+0xe0/0x2b8
[  124.371261]  do_splice_direct+0xa4/0xdc
[  124.371917]  do_sendfile+0x1c4/0x3ec
[  124.372550]  sys_sendfile64+0x128/0x130
[  124.373109]  ret_fast_syscall+0x0/0x54
[  124.373664]  0xbe9a2de4
[  124.374081] INFO: Freed in meminfo_proc_show+0x5c/0x500 age=1 cpu=0 pid=69
[  124.374933]  meminfo_proc_show+0x5c/0x500
[  124.375485]  seq_read_iter+0x10c/0x4bc
[  124.376020]  proc_reg_read_iter+0x74/0xa8
[  124.376643]  generic_file_splice_read+0xe8/0x178
[  124.377331]  splice_direct_to_actor+0xe0/0x2b8
[  124.378022]  do_splice_direct+0xa4/0xdc
[  124.378633]  do_sendfile+0x1c4/0x3ec
[  124.379220]  sys_sendfile64+0x128/0x130
[  124.379822]  ret_fast_syscall+0x0/0x54
[  124.380421]  0xbe9a2de4

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/include/asm/bug.h |  1 +
 arch/arm/kernel/process.c  | 18 ++++++++++++++++++
 arch/arm/kernel/traps.c    |  1 +
 include/linux/slab.h       | 14 ++++++++++++++
 mm/slab.h                  |  7 -------
 mm/slub.c                  | 19 +++++++++++++++++++
 6 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 673c7dd..ba8d9d7 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -88,5 +88,6 @@ extern asmlinkage void c_backtrace(unsigned long fp, int pmode,
 struct mm_struct;
 void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
+extern void __show_regs_alloc_free(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5199a2b..97d2a7c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -27,6 +27,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
+#include <linux/slab.h>
 
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
@@ -92,6 +93,23 @@ void arch_cpu_idle_exit(void)
 	ledtrig_cpu(CPU_LED_IDLE_END);
 }
 
+void __show_regs_alloc_free(struct pt_regs *regs)
+{
+	int i;
+
+	/* check for r0 - r12 only */
+	for (i = 0; i < 13; i++) {
+		unsigned long addr = regs->uregs[i];
+		void *object;
+		struct kmem_cache *cache;
+
+		if (slab_page_object(addr, &object, &cache)) {
+			printk("\nregister r%d: %lx belongs to slab object\n", i, addr);
+			print_tracking(cache, object);
+		}
+	}
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a78..64308e3 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -287,6 +287,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	print_modules();
 	__show_regs(regs);
+	__show_regs_alloc_free(regs);
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7ae6040..a19ba55 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -706,4 +706,18 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
 #define slab_dead_cpu		NULL
 #endif
 
+#ifdef CONFIG_SLUB_DEBUG
+bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache);
+extern void print_tracking(struct kmem_cache *s, void *object);
+#else
+static inline void print_tracking(struct kmem_cache *s, void *object)
+{
+}
+
+static inline bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
+{
+	return false;
+}
+#endif
+
 #endif	/* _LINUX_SLAB_H */
diff --git a/mm/slab.h b/mm/slab.h
index 076582f..8a072bd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -208,18 +208,11 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
-#ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
 DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-extern void print_tracking(struct kmem_cache *s, void *object);
-#else
-static inline void print_tracking(struct kmem_cache *s, void *object)
-{
-}
-#endif
 
 /*
  * Returns true if any of the specified slub_debug flags is enabled for the
diff --git a/mm/slub.c b/mm/slub.c
index 0d5fac3..1863806 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -648,6 +648,25 @@ void print_tracking(struct kmem_cache *s, void *object)
 	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
 }
 
+bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
+{
+	void *addr = (void *)address;
+	struct page *page;
+
+	if ((addr >= (void *)PAGE_OFFSET) &&
+			(addr < high_memory)) {
+		page = virt_to_head_page(addr);
+
+		if (PageSlab(page)) {
+			*cache = page->slab_cache;
+			*object = nearest_obj(*cache, page, addr);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void print_page_info(struct page *page)
 {
 	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
-- 
1.9.1

