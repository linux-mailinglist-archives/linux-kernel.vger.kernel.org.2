Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BED324C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhBYI16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:27:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44980 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhBYI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:27:50 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210225082707epoutp011b33987d27c44e22eb67ede925e9fc6a~m8DUNHJe21394613946epoutp01I
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210225082707epoutp011b33987d27c44e22eb67ede925e9fc6a~m8DUNHJe21394613946epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614241627;
        bh=tONvObl6UZzbtI4pxM9cNsEgx+Tf0y6Oz+KHi1rU8FI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XzzGkw67XRKxg21YK/m7TMAJI8AvoO3f+/wx7gN95u+QidKjFUl/yN4om379/ig4E
         Pz19tkgVEzAgB+C34H2B/m/EI1V3Ih4mJrjVSSGiZqzndDPDIWWWXWZypTyHMqhW9O
         nbdAG49s1szQchf/WtVxT30ExuaGKrdZe18l/yeA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210225082706epcas5p3bd244e5b8a2cd5e828b86f41db38f2f5~m8DTgYiwx0347203472epcas5p3o;
        Thu, 25 Feb 2021 08:27:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.4D.15682.A5F57306; Thu, 25 Feb 2021 17:27:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d~m7o66Ouyx1503015030epcas5p3R;
        Thu, 25 Feb 2021 07:56:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210225075653epsmtrp15b9286856d3602204caf67a7faafb5d9~m7o65TpMR0753907539epsmtrp1Y;
        Thu, 25 Feb 2021 07:56:53 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-39-60375f5abb13
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.6C.13470.54857306; Thu, 25 Feb 2021 16:56:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210225075650epsmtip25bb80c62f5d89987bf5b151544a66f26~m7o4pXcWP1351713517epsmtip2l;
        Thu, 25 Feb 2021 07:56:50 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2] arm: print alloc free paths for address in registers
Date:   Thu, 25 Feb 2021 13:26:40 +0530
Message-Id: <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTQRjN7G63a7G6KY2MnBGDCsglHqsSMPFaz/gDE8UDqmwQhVJbDs+I
        1lSpWlDBo0IhUEEaBCwGkcu4EBEFBCGAF4JiRCmRtmpUYlW6EP+997335n0zGQIVZfKciVhp
        IiOXSuI8cQFW2eA9zy8icklUYPttB6qjhqGyy0pwque7CVDF55Q4ZXzfzaM6q7Nxqq/kD49i
        s+oA1ZCrwiiV1cajVPo7CMU25wDqxkkNWCGkO7s7UDrPmEQbDWk4bbRc4tPqkS6EfnxtDKMH
        u64idIX+BK25awB0S14jn7Ya3bc4RAhCopm42GRGHhAaJdg3XNcKZPnBh3ItLJoK9D5qMIWA
        5EKoKTKgaiAgRGQNgD1ZZyaIBcCC8pcYR74D+DpdhU9Gml+dt2MRWQeg9cEszvQVwId1Bci4
        gJP+0FBda0+LyasAqoue4OMEJR8B+LP1ATbuciRpWNFj4o1jjPSCH9+O/ksThJBcC/VfXLk2
        d/iiLc2+EyTTCHi/0cTnhFXwR9soxmFH+Lnp7sTcGX5KV/G5gBJAS/1twJFMAG92mHmcKwwO
        K1PtbSjpDcuqA7ixG8x6Umq/AkpOgxfGBhFuLoRVuknsBU+/KJ84xgVazeaJJWhoOl0JuHfZ
        BTVfjGgGcNP+b8gDwABmMjJFfAyjWCQLkjIp/gpJvCJJGuO/NyHeCOwfx2ddFXjTP+rPAoQA
        LIAE6ikWVtgWRYmE0ZLDRxh5QqQ8KY5RsMCFwDydhFWB/ZEiMkaSyBxgGBkjn1QRYopzKhLg
        WhU6pgXhlUC/nCxjH031KCk1o8fjfot6xUGFfQe3H52vWV/4rDikgh2ynbV6RCu7BhgRmeO6
        wHv39rZ3XvWfft+4+Cvhaf3KnlNBu36mXEn0ybvuljJ3k9j87UPmXlmgS5hwcZg82K3cxZb0
        fOpSfujK2XO0vrwP0ftbTgyMDEjX3qFr3S83zXDVvV29U5vdmyidblSKMsIqm0r8VNRIftPG
        9OT2hrLGYb8F4TrbrSGTKXVPgbV3HqIWizWDgg3LHMZm6XLfmHSBLdsC+vanDB1rrsm3+Gqd
        5l+STV+88IzvjjUj57aG7Gl3Yu9pgjc79tfifzKeerzKkc5OXv7ttSem2CcJ8kHlCslfmZu9
        1KcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvK5rhHmCwePZrBYXd6dazFm/hs3i
        +rc3jBYru5vZLDY9vsZqcXnXHDaLe2v+s1ocmrqX0eLw/DYWi7bP/1gt2pZsZLI4dHIuo8Xs
        xj5GB16Py9cuMnss2FTqsWlVJ5vHpk+T2D263l5h8jgx4zeLx5Mr05k8Ni+p9+jbsorR48yC
        I+wenzfJBXBHcdmkpOZklqUW6dslcGW83nuWsWCRccX8T4eYGxiXaHUxcnJICJhInLzdw9bF
        yMUhJLCbUWLH9NNsEAlpiZ//3rNA2MISK/89Z4co+sQoMeXdLXaQBJuAnsSqXXtYQBIiAvMZ
        JZ5+nc0E4jALnGGUeHd1LhNIlbCAh8Tm629YQWwWAVWJ5/c/AMU5OHgF3CWWvJeB2CAncfNc
        J/MERp4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCQ1dLcwfj9lUf9A4xMnEw
        HmKU4GBWEuHd/M80QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQam/QZTD+Q2vjyreHLSkqiGmddcPEIaVRVawhlWv19xrcrk/sZC4ZUfuxwCw160rJEX
        O9XbEVytbzTTZ1Ncj8L1fRcWh3Xtu8N3y/1/haXFrTvzF2/9qKZat+Xavqq3hzTWsD5S9FS/
        L+v/fZPPwVm/Du/Ok5i30VM6e9HbYLlp75bH2Yh8bg6uStLbtlhnwvsbXV2TzdekTri+/duZ
        qqPecdsCHnQ+F/i84fM8aVb1/Bqx6f+6Fm5w/rvtSdgMzoYLW/+vm7iqfoVz1p7ombu6ddff
        4WiUjppwMPXfXhfu4NtzWNckrFmV4BjYeqXC7MWpX9kyWTOLZgRKdeVzfbswsafz0koJvQfG
        4Z5dbFZBe5VYijMSDbWYi4oTATi4kkLMAgAA
X-CMS-MailID: 20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d
References: <CGME20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of "Use After Free" kernel OOPs, free path of object
is required to debug futher.
And in most of cases object address is present in one of registers.

Thus check for register address and if it belongs to slab,
print its alloc and free path.

e.g. in below issue  register r6 belongs to slab, and use after free issue
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
v1 -> v2: do address sanity with virt_addr_valid

 arch/arm/include/asm/bug.h |  1 +
 arch/arm/kernel/process.c  | 18 ++++++++++++++++++
 arch/arm/kernel/traps.c    |  1 +
 include/linux/slab.h       | 14 ++++++++++++++
 mm/slab.h                  |  7 -------
 mm/slub.c                  | 18 ++++++++++++++++++
 6 files changed, 52 insertions(+), 7 deletions(-)

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
index 0d5fac3..31436db 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -648,6 +648,24 @@ void print_tracking(struct kmem_cache *s, void *object)
 	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
 }
 
+bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
+{
+	void *addr = (void *)address;
+	struct page *page;
+
+	if (virt_addr_valid(addr)) {
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

