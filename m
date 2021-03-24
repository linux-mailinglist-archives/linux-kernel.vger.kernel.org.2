Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35AA347244
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhCXHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:16:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23356 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhCXHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:16:24 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210324071622epoutp01bc9204b2da94a1e5a1c68e3e1bee7c2a~vNgQV1s3W1167811678epoutp01m
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210324071622epoutp01bc9204b2da94a1e5a1c68e3e1bee7c2a~vNgQV1s3W1167811678epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616570182;
        bh=JfwyFLtEnH92E6JOT0cexb/0uIe8wkrNN8VfuEQfHBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKZsdFXROOgKh9h15k58wBy+EWUiGvH+nR1gY5VozXs7n0U/nqD5AwqmOBM3KpIn/
         S5RGsvrAffJG3sa0I2MmSug6ZlmM29c6MqWqFosL83fViy6BVhkc2RI9WC1ibPq2s6
         zDXJmtnlElxsrrcwNYH4/CEH8Zh2mEl7xGlG34Xk=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210324071621epcas5p1a087dc1205d7f1ae37b118edc00fcabf~vNgPiZJA60169501695epcas5p1V;
        Wed, 24 Mar 2021 07:16:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.E2.41008.547EA506; Wed, 24 Mar 2021 16:16:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210324065516epcas5p450958011b69f5941e8f2bc993b82b904~vNN08j2Lf2429124291epcas5p4t;
        Wed, 24 Mar 2021 06:55:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210324065516epsmtrp272d6e26f8b1a44e5ad74529edec01e77~vNN07kngR2488824888epsmtrp2b;
        Wed, 24 Mar 2021 06:55:16 +0000 (GMT)
X-AuditID: b6c32a4b-bf2c4a800001a030-11-605ae7454345
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.B3.33967.352EA506; Wed, 24 Mar 2021 15:55:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210324065513epsmtip25aeeae6ea9e3dca99da31ee6a6ceca80~vNNyIl9g30289902899epsmtip2P;
        Wed, 24 Mar 2021 06:55:12 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        0x7f454c46@gmail.com, amit.kachhap@arm.com, james.morse@arm.com,
        vincenzo.frascino@arm.com, nsaenzjulienne@suse.de,
        keescook@chromium.org, samitolvanen@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 2/2] arm64: print alloc free paths for address in registers
Date:   Wed, 24 Mar 2021 12:24:59 +0530
Message-Id: <1616568899-986-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmhq7r86gEgwcLZS0mTHvBYnFxd6rF
        nPVr2CymfNjBavF+WQ+jxf19y5ksznTnWmx6fI3V4vKuOWwWh+e3sVgsvX6RyWLbrOVsFv13
        rrNZLF3xltXi0Mm5jBZ7//1ksWi5Y+og6LFm3hpGj9kNF1k8ds66y+6xYFOpx6ZVnWweJ2b8
        ZvHYvKTeo2/LKkaPzaerPT5vkgvgiuKySUnNySxLLdK3S+DKuHlxP0vBHpWKVU+fMTUwvpXt
        YuTkkBAwkehYtJS9i5GLQ0hgN6PEnt1fGEESQgKfGCWavvND2N8YJdb854Np+HBrDhNEw15G
        iecL5jFDOF8YJRbf/c0KUsUmoCexatceFpCEiMB0JonW1uesIA6zwCZGic29r8GqhAW8JX5e
        /QW2j0VAVeLgzZtgNq+Aq0T71h5WiH1yEjfPdTKD2JwCbhJNSzYxggySEFjLIXF34XeoIheJ
        72sWsUPYwhKvjm+BsqUkPr/bywbR0M0oMXPOZWYIZzWjxKYX16G67SVeNzcAvcQBdJ+mxPpd
        +hBhWYmpp9YxgdjMAnwSvb+fMEHEeSV2zIOxVSVabm6AGiMt8fnjRxYI20Pi7Na30GCdySix
        4shstgmMcrMQVixgZFzFKJlaUJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGcorS8dzA+evBB
        7xAjEwfjIUYJDmYlEd6W8IgEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw7DB7ECwmkJ5akZqem
        FqQWwWSZODilGph8/73+aBFQvOWC5bHP6kf0uzK/lR0Rjts44UFJ7Il9c50fVO6U1EgKnGvS
        OU1L+p5Aw73GI7P3Tzpkkn9ns9MNgwuzHXv/zwmPPB3ioWoqcYhdfMsH/S3Jyjyqlq9fvH21
        2NBiRvbEJ1dPH9JjqPk635vxwxW96q6MKbpn9yziUPv0e+3PwPKsLJuzS409Hki0/zDvuZKS
        1PV6n//d5pXuTZfCN3vXel85bjT/U0/4Rd/eiE2f5wjtZWhZHVzzdJX0joTfK+KZZgVtvhBj
        ut7t/EFH0fkhRjfO7tk7ce5UQZYF93+eWpp8KsNcd+FEvaXbt1YZR0g2uU78el4g9NzJS6x5
        TAuU9oUs7o3as5bfX4mlOCPRUIu5qDgRAEQUDXPAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvG7wo6gEg8lnrCwmTHvBYnFxd6rF
        nPVr2CymfNjBavF+WQ+jxf19y5ksznTnWmx6fI3V4vKuOWwWh+e3sVgsvX6RyWLbrOVsFv13
        rrNZLF3xltXi0Mm5jBZ7//1ksWi5Y+og6LFm3hpGj9kNF1k8ds66y+6xYFOpx6ZVnWweJ2b8
        ZvHYvKTeo2/LKkaPzaerPT5vkgvgiuKySUnNySxLLdK3S+DKuHlxP0vBHpWKVU+fMTUwvpXt
        YuTkkBAwkfhwaw5TFyMXh5DAbkaJG2f3sUIkpCV+/nvPAmELS6z895wdougTo8T07utsIAk2
        AT2JVbv2sIAkRASWM0l0zDsF1sEssI1RYt0+RRBbWMBb4ufVX4wgNouAqsTBmzfBbF4BV4n2
        rT1Q2+Qkbp7rZAaxOQXcJJqWbAKrEQKqebCpnXUCI98CRoZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjBMaCluYNx+6oPeocYmTgYDzFKcDArifC2hEckCPGmJFZWpRblxxeV5qQW
        H2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDUY2kSGP9qteldQeNtk11cojYwZ34N
        tzLj8bk0sf6jR47cqyPnD3XLvvi0zUj2XlzhGrVbc4tOlDe9ZPFcHNzimv5g1cXp/y+f6b2/
        ZoPp5A0sl9llvku++M3KOaekeu2Bc5Vle7qUItKCt+8//WZv69v1P+Y99r3WEphSv2vmkUkx
        y1ZbL1uy0Tvr6OuMJ+/PsNW8FC86eq7jadbGZ8/c57fPmnP0XKRn5EKBg+J3X5ztWPZuthFv
        QVr5Bfk9Nww2he/yku22e6elW6ejm9r/s0qaseuGntjLksCpyXeyNV7xTE5yFXpb8T+6pVPL
        73aXX6LMBafEjQHKSSnzuJM0OTe83DzzRNAryfToW3eclFiKMxINtZiLihMBiO1RS/ACAAA=
X-CMS-MailID: 20210324065516epcas5p450958011b69f5941e8f2bc993b82b904
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210324065516epcas5p450958011b69f5941e8f2bc993b82b904
References: <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210324065516epcas5p450958011b69f5941e8f2bc993b82b904@epcas5p4.samsung.com>
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
index 6e60aa3b5ea9..d0d0ada332c3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -306,6 +306,17 @@ void __show_regs(struct pt_regs *regs)
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

