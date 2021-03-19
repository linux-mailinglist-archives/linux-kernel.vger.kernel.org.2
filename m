Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4A341B48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCSLUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:20:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10191 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:19:31 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210319111927epoutp0244b6556a211867dd815f2561620fa134~tumEtmPLn2891528915epoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210319111927epoutp0244b6556a211867dd815f2561620fa134~tumEtmPLn2891528915epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616152767;
        bh=6O29xWL6gzdVuDDb7PRQUaA8sQ7h3iLqnGUUKe3AbBc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SwN+HJHZOKOjAo2PE4EWpRZOoq9YsELiUcKdpmcJ7SF/+xtXx6uc4fY/y2Y6nu7kh
         n1oHn+uF2g4+YpWg7HIF3UKOKmiVpwNkZ0N6x3u7GA+N87okRyKc3ZBplEsy7viB+S
         EiNrgn5Cs8UAoUPRxlOJo+nHKRMomTAOnGQ0tfsE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210319111927epcas5p3eed0e95eb7327daf9f29e70b52f3621a~tumD-F-K00091100911epcas5p3p;
        Fri, 19 Mar 2021 11:19:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.9E.50652.EB884506; Fri, 19 Mar 2021 20:19:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210319111755epcas5p3d40683c22af11626a221ca494e8298f8~tukuq4sxf1369113691epcas5p3I;
        Fri, 19 Mar 2021 11:17:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210319111755epsmtrp245d86ecefea06d08c77242d0141b3f7d~tukuqD3si2311023110epsmtrp2o;
        Fri, 19 Mar 2021 11:17:55 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-68-605488bed539
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.39.08745.36884506; Fri, 19 Mar 2021 20:17:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210319111753epsmtip1c6e20e500d6e45c6e20475927e585daa~tukskdYN90250502505epsmtip11;
        Fri, 19 Mar 2021 11:17:53 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        mark.rutland@arm.com
Cc:     akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        amit.kachhap@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] arm64: print alloc free paths for address in registers
Date:   Fri, 19 Mar 2021 16:47:39 +0530
Message-Id: <1616152659-26488-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+845OzsuF4c18M1ywahAq9nCwemCXUg9ODKlRRGFG3owa07Z
        1G5EZitL0wbeclpKZdFaXpaXpWapSTrpsjTN0LCLJt3UrP7IitiO0X8/nofned/346NwyW/C
        n0o0pHJGg04vJ0VEQ0dg4MrWMxrtqp+laxlL0TjBuJs5pqzaTjIFk04BM3HtHGIcb/sFTG9T
        Gcl0lJ8mmMoBN8acHxogmfbui4gxD6k2+rL2S3bE3rEOC9kKRxrrsJ0l2a4LMwR7++pxNq/O
        hthphyya2i1aH8/pE9M5Y3CoVrSvoLqZSGlZcqjv+UsyA30OyEY+FNAh8OpKPspGIkpCNyPo
        q6kQeAwJ/RXB6ATOG9MIesaqyGxEeRMvu7bzehOCsZMOnA98Q1BrVnqYpBVga2ohPCylNWB+
        UeItwukZBM9P5HsnzKfV8LTNjDxM0EvB1Vnm1cV0BPSX2wX8ejIYfHzWGwb6jRB6bPdI3tgC
        fYOfCZ7nw4eHdUKe/WH6y12SD+QgKCnrnU3fROAYH5it3QAfT2ZgnntwOhCqm4J5OQAKXVWY
        h3F6HuTOvMN4XQzOS/94KZgHa2ZrFsL01NTsEizcuFyH+KfYC5kuF7KgAOv/CRUI2dACLsWU
        lMCZVCmrDdxBhUmXZEozJCjikpMcyPtDgiKd6PXIpKIdYRRqR0Dhcqm4K06jlYjjdYePcMbk
        WGOanjO1o4UUIfcTO1eNxEroBF0qd4DjUjjjPxejfPwzsIo169rCr9+cm5q/3/pJ2/o6Xv89
        5oFs87BUpBmxNob0Kg9PqaMfPXYMWhJkYN1pGfOZGMJ21ctynPoc/9KYBrjcUzATvsdv8t6O
        rE+16V+UWXVq6XH3qQWqo7FPfxh0CtbdobanN9r6q0/lLqssvxPXHZlcG14e6jYdK/75TKAc
        KxqNGwizzB2ec6whKkwVq/pVu7heuDXHLM2MeO/X/3tyUdfm1CXSAOHyQu1E/VDigYwVnVhM
        b16V/Myf9RKRb+XeHYbRW69+ZbUWLg4tXvktU9Y4ciOyxhVVvO2+sNOJB60IC9bk6/PEP97L
        Lb4F3TsjnvS0XZ0zvml7SHSLUi0nTPt0yiDcaNL9BXcqaYqQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnG5yR0iCwf2lwhYTpr1gsbi4O9Vi
        zvo1bBZTPuxgtXi/rIfRYtPja6wWl3fNYbM4PL+NxWLp9YtMFv13rrNZHDo5l9Gi5Y6pA4/H
        mnlrGD12zrrL7rFgU6nHplWdbB4nZvxm8di8pN6jb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4
        Mqas381SsEel4srVW2wNjG9luxg5OCQETCRunQjuYuTiEBLYwSixftEali5GTqC4tMTPf++h
        bGGJlf+es0MUfWKUeLJ4MzNIgk1AT2LVrj1gRSICERIdX46B2cwCzUwSC3bWgNjCAt4SFw62
        MILYLAKqEqeOzmEFsXkF3CWuzV/DCrFATuLmuU7mCYw8CxgZVjFKphYU56bnFhsWGOWllusV
        J+YWl+al6yXn525iBAejltYOxj2rPugdYmTiYDzEKMHBrCTCeyI5JEGINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpvZYNhGGoNppyokHVrYvbU5JmDXR
        yDz+b6i+652Lh2MNpop6RmqWnm89+mKqcK1MAIMng3+Sh2vImQnTa1fu25Cb/unxBzfD3MuF
        tdVsbJ1pm7Mi4wXC5WUttwobVfw2Wbsq8a3zpfkHD1Qu27nwSl7ItkRm7oXvFV/O/Kt/NN5s
        Z2KDFnd8fMLagA1/X4ne/nDz/429N7x1dI6lb9u5Y8psj2rbH10CrqwcLh+1yr4bL22/8P3B
        VNOpX7sKf7TqfuoM8E2d3b+5j/lHlHqr9NxnCl6//PzK7jjvfxmg4PhlQfyVauaF3jFPD16f
        OunfV79rVoeLrdga3WoSDh3y3XqOVfv5moqbr1nP/DJVVGIpzkg01GIuKk4EAGfpMj61AgAA
X-CMS-MailID: 20210319111755epcas5p3d40683c22af11626a221ca494e8298f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210319111755epcas5p3d40683c22af11626a221ca494e8298f8
References: <CGME20210319111755epcas5p3d40683c22af11626a221ca494e8298f8@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a use after free kernel OOPs, freed path of the object is
required to debug futher. In most of cases the object address is present
in one of the registers.

Thus check the register's address and if it belongs to slab, print its
alloc and free path.

commit a02a25709155 ("mm/slub: add support for free path information of an object")
provides free path along with alloc path of object in mem_dump_obj().

Thus call it with register values same as in ARM with
commit 14c0508adcdb ("arm: print alloc free paths for address in registers")

e.g.  in the below issue register x20 belongs to slab, and a use after free
issue occurred on one of its dereferenced values:

[   19.516507] Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b73
..
..
[   19.528784] Register x10 information: 0-page vmalloc region starting at 0xffff800011bb0000 allocated at paging_init+0x1d8/0x544
[   19.529143] Register x11 information: 0-page vmalloc region starting at 0xffff800011bb0000 allocated at paging_init+0x1d8/0x544
[   19.529513] Register x12 information: non-paged memory
..
[   19.544953] Register x20 information: slab kmalloc-128 start ffff0000c3a34280 data offset 128 pointer offset 0 size 128 allocated at meminfo_proc_show+0x44/0x588
[   19.545432]     ___slab_alloc+0x638/0x658
[   19.545576]     __slab_alloc.isra.0+0x2c/0x58
[   19.545728]     kmem_cache_alloc+0x584/0x598
[   19.545877]     meminfo_proc_show+0x44/0x588
[   19.546022]     seq_read_iter+0x258/0x460
[   19.546160]     proc_reg_read_iter+0x90/0xd0
[   19.546308]     generic_file_splice_read+0xd0/0x188
[   19.546474]     do_splice_to+0x90/0xe0
[   19.546609]     splice_direct_to_actor+0xbc/0x240
[   19.546768]     do_splice_direct+0x8c/0xe8
[   19.546911]     do_sendfile+0x2c4/0x500
[   19.547048]     __arm64_sys_sendfile64+0x160/0x168
[   19.547205]     el0_svc_common.constprop.0+0x60/0x120
[   19.547377]     do_el0_svc_compat+0x1c/0x40
[   19.547524]     el0_svc_compat+0x24/0x38
[   19.547660]     el0_sync_compat_handler+0x90/0x158
[   19.547821]  Free path:
[   19.547906]     __slab_free+0x3dc/0x538
[   19.548051]     kfree+0x2d8/0x310
[   19.548176]     meminfo_proc_show+0x60/0x588
[   19.548322]     seq_read_iter+0x258/0x460
[   19.548459]     proc_reg_read_iter+0x90/0xd0
[   19.548602]     generic_file_splice_read+0xd0/0x188
[   19.548761]     do_splice_to+0x90/0xe0
[   19.548889]     splice_direct_to_actor+0xbc/0x240
[   19.549040]     do_splice_direct+0x8c/0xe8
[   19.549183]     do_sendfile+0x2c4/0x500
[   19.549319]     __arm64_sys_sendfile64+0x160/0x168
[   19.549477]     el0_svc_common.constprop.0+0x60/0x120
[   19.549646]     do_el0_svc_compat+0x1c/0x40
[   19.549782]     el0_svc_compat+0x24/0x38
[   19.549913]     el0_sync_compat_handler+0x90/0x158
[   19.550067]     el0_sync_compat+0x174/0x180
..

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/process.c          | 11 +++++++++++
 arch/arm64/kernel/traps.c            |  1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 673be2d1263c..84d5204cdb80 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -31,6 +31,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
+extern void __show_regs_alloc_free(struct pt_regs *regs);
 
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 325c83b1a24d..a21761cee3dc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -304,6 +304,17 @@ void __show_regs(struct pt_regs *regs)
 	}
 }
 
+void __show_regs_alloc_free(struct pt_regs *regs)
+{
+	int i;
+
+	/* check for x0 - x29 only */
+	for (i = 0; i <= 29; i++) {
+		pr_alert("Register x%d information:", i);
+		mem_dump_obj((void *)regs->regs[i]);
+	}
+}
+
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs(regs);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a05d34f0e82a..cb4858c6e57b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -104,6 +104,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	print_modules();
 	show_regs(regs);
+	__show_regs_alloc_free(regs);
 
 	dump_kernel_instr(KERN_EMERG, regs);
 
-- 
2.17.1

