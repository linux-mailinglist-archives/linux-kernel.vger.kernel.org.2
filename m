Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A964633D1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhCPKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:42:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50368 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhCPKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:42:06 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210316104204epoutp02117a01b3b2848121f2d8374ba71ff8ac~szJkqFGUU1638016380epoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:42:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210316104204epoutp02117a01b3b2848121f2d8374ba71ff8ac~szJkqFGUU1638016380epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615891324;
        bh=44oltOHh00cZrfJITia/CNyT4nk6c4K1PXacEE+BPn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1BFXYkVnDhzb9dFYd+K8QbKd5kZbXQg5NAHla97qF3hviKfBvPeCwjNqf1p5PCGv
         LSsRAwJltgNUZP0JVLgjgJc7TqT6Z6PsEZ4SbaqBmc/xre84ovWPmpwtqKMH8Lsa4n
         rGmIVu2AXilh4ANR76Xi/rCUwkuMq+rIA1DWdJ84=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210316104203epcas5p12c0758a80da525df614f7df5bd027c38~szJjpPNAe1114111141epcas5p14;
        Tue, 16 Mar 2021 10:42:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.14.15682.B7B80506; Tue, 16 Mar 2021 19:42:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210316103745epcas5p3994f29958b7f14aec8cbd90fa518761f~szFzprZ_A1658216582epcas5p3y;
        Tue, 16 Mar 2021 10:37:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316103745epsmtrp20c3234e34dc33cec89cd1ea364af2cfd~szFzox2N42065620656epsmtrp2D;
        Tue, 16 Mar 2021 10:37:45 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-d0-60508b7b974a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.17.08745.97A80506; Tue, 16 Mar 2021 19:37:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210316103742epsmtip117cf63bb98ac9af542f935f3ea7eabaf~szFwoay4E3001630016epsmtip1Y;
        Tue, 16 Mar 2021 10:37:42 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     paulmck@kernel.org, linux@armlinux.org.uk, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 3/3] arm: print alloc free paths for address in registers
Date:   Tue, 16 Mar 2021 16:07:12 +0530
Message-Id: <1615891032-29160-3-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUxTZxTG996vXmq63CDoC9gqNRpBBZxDXw0I6KLX7R9ijDI1SDNvqFlv
        7VrAD1zAgJ2VafAboQJZysQCFm6ZlirCirFChlIRGJllDTBnRPygk0SJc5Rbsv9+z3POc87J
        m5fGQx1kJL1fm8PptSqNkpISNzpiYlbml6RnJYwPh6HSi88I5LnFIbOtnkIDky8AulZSRCFh
        pJ9EvU4zhYbqP5LIdaEVoI4qI4EmLJMEMvr/JZHR0oQhV+cVgCqOnQbo4Qc3mcqwvf0enG0p
        90rYaiGXFawmihUmzkrYk+OPMfZ+2RTBjj6+hLF2SwF7utkK2N+q70pYv6BghdFxLF22S5q0
        j9Psz+P08RuypOq/Jj/TtcsP2c0WshC8n38ShNCQ+RyeNd0GAQ5lbgHYPzztS6d5AkB7kxEX
        hR/AwssfqdnEiQfeYMEJ4HBbFymKfwB81G6bmUUxcdDqvE0EOIx5Mt11LCfQhDP3AHzX3TZT
        mMtshcXHvdNpmiaYJdB9c17AljFbYIW5IbhNAQcfmPAAhzAsLHPaiMAcyNyn4cC7JonY9AU8
        3+EhRZ4Ln7ubg34k9L9spcRACYCXzb24KOoAFJ4NBBMpcKyoEAtcgTMx0OaMF205vNB1HQsw
        znwKT02NYqIvg47KWV4Ciwcbg2OioP/NG0JkFvrODUnEZ6kA8JdqMygFivL/V1QDYAURnM7A
        Z3OGRN0qLXcwzqDiDbna7LhvDvACmPlcsVsdwOt7HecCGA1cANK4MkyWqE3PCpXtUx0+wukP
        7NXnajiDC0TRhHK+zJHg2xvKZKtyuG85TsfpZ6sYHRJZiJUuyNi0FBrtX/WkRGuid5eZuj2N
        R7evb+leY9pWuTEi/PdFPTV3kuKd8xTtd4yLk89l7PiuluyT8r57yYN/LpSrNy8fG7HzBRul
        avp83kJe5a663vOjj+mTJkWlXcmsu/v3l2nhq9ek1ikyx2p3tpR/bS2obfv+UGmmo8/GTL3q
        fDpS0ix5dcLSxzeGD614rdmUd6TDWKnsKkpeRmXUcCsF3r95js2S2pN/tV4zfGb5D786qwrk
        CZ6KlD3j17rfCsWJ255W1fxc81Ovrv+t4nDD7udplfz7ter0aG9k/WrjzaU71hV1ln2iaEV/
        XAzbFRsvd+ZHqPMMN4YyGyZPuazuJ0rCoFatisX1BtV/2RnlFcsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG5lV0CCwZVOJYsJ016wWFzcnWox
        Z/0aNovr394wWqzsbmaz2PT4GqvF5V1z2CzurfnPanFo6l5Gi8Pz21gsPi35xmLR9vkfq0Xb
        ko1MFodOzmW0mN3Yx2hx/u9xVgcBj8vXLjJ77Jx1l91jwaZSj02rOtk8Nn2axO7R9fYKk8eJ
        Gb9ZPJ5cmc7ksXlJvUffllWMHmcWHGH3+LxJzmPTk7dMAbxRXDYpqTmZZalF+nYJXBlPvxkV
        HJCt2DxnCWsD4y/xLkZODgkBE4mOc3eZuxi5OIQEdjBKbHp/ggUiIS3x8997KFtYYuW/5+wQ
        RZ8YJXY1LWUHSbAJ6Ems2rWHBSQhIvCCUWLNnpVMIA6zwBlGiXdX5zKBVAkLeEq0tN5l7WLk
        4GARUJU4vl0MJMwr4C4xe85aNogNchI3z3Uyg9icAh4SM3atB9ssBFQz7/VvtgmMfAsYGVYx
        SqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHhpbWDsY9qz7oHWJk4mA8xCjBwawkwmua
        F5AgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9M6qQNs
        aT4LLEokFvDvYOgv45gRsPGzzp6Yz35tYeZS7pu3lJQlz47dzPn9y4MFHDMqNA3KP+uI1zu+
        lA39foQv7Mo/4Xk93762Lp6ey/DsaLqpW7PIVOHenWU8K57aXSpIy+BU3zF3Vu6h+61fKyuv
        TBHMvbCi5Gwo848vvxqfWF3avuWQ2KRStu7HH/5+NmxILas4Ma3aqiWr8snFXIs7drXGvp03
        vqW7sE7fde2dm/lBMbVI5aD1MtPy69M2zzNUr/92vs11o/zL2yt3zsmojPjQvnnJesfOhfqe
        fecy/2uyORaFcc/btH9jcUFO1d/AN6YSQj9vvLQMelU69dmG6xUsOsKnXOetUdn+3EyJpTgj
        0VCLuag4EQCcWn7H/AIAAA==
X-CMS-MailID: 20210316103745epcas5p3994f29958b7f14aec8cbd90fa518761f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316103745epcas5p3994f29958b7f14aec8cbd90fa518761f
References: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210316103745epcas5p3994f29958b7f14aec8cbd90fa518761f@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of user after free kernel OOPs, free path of object
is required to debug futher.
And in most of cases object address is present in one of registers.

Thus check for register address and if it belongs to slab,
print its alloc and free path.

e.g. in below issue  register r6 belongs to slab, and user afree issue
occurred on one of its derefer values:

[   20.182197] Unable to handle kernel paging request at virtual address 6b6b6b6f
....
[   20.185035] pc : [<c0538afc>]    lr : [<c0465674>]    psr: 60000013
[   20.185271] sp : c8927d40  ip : ffffefff  fp : c8aa8020
[   20.185462] r10: c8927e10  r9 : 00000001  r8 : 00400cc0
[   20.185674] r7 : 00000000  r6 : c8ab0180  r5 : c1804a80  r4 : c8aa8008
[   20.185924] r3 : c1a5661c  r2 : 00000000  r1 : 6b6b6b6b  r0 : c139bf48
.....
[   20.191499] Register r6 information: slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
[   20.192078]     meminfo_proc_show+0x40/0x4fc
[   20.192263]     seq_read_iter+0x18c/0x4c4
[   20.192430]     proc_reg_read_iter+0x84/0xac
[   20.192617]     generic_file_splice_read+0xe8/0x17c
[   20.192816]     splice_direct_to_actor+0xb8/0x290
[   20.193008]     do_splice_direct+0xa0/0xe0
[   20.193185]     do_sendfile+0x2d0/0x438
[   20.193345]     sys_sendfile64+0x12c/0x140
[   20.193523]     ret_fast_syscall+0x0/0x58
[   20.193695]     0xbeeacde4
[   20.193822]  Free path:
[   20.193935]     meminfo_proc_show+0x5c/0x4fc
[   20.194115]     seq_read_iter+0x18c/0x4c4
[   20.194285]     proc_reg_read_iter+0x84/0xac
[   20.194475]     generic_file_splice_read+0xe8/0x17c
[   20.194685]     splice_direct_to_actor+0xb8/0x290
[   20.194870]     do_splice_direct+0xa0/0xe0
[   20.195014]     do_sendfile+0x2d0/0x438
[   20.195174]     sys_sendfile64+0x12c/0x140
[   20.195336]     ret_fast_syscall+0x0/0x58
[   20.195491]     0xbeeacde4

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/include/asm/bug.h |  1 +
 arch/arm/kernel/process.c  | 11 +++++++++++
 arch/arm/kernel/traps.c    |  1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 673c7dd75ab9..ba8d9d7d242b 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -88,5 +88,6 @@ extern asmlinkage void c_backtrace(unsigned long fp, int pmode,
 struct mm_struct;
 void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
+extern void __show_regs_alloc_free(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5199a2bb4111..249dd285c4d8 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -92,6 +92,17 @@ void arch_cpu_idle_exit(void)
 	ledtrig_cpu(CPU_LED_IDLE_END);
 }
 
+void __show_regs_alloc_free(struct pt_regs *regs)
+{
+	int i;
+
+	/* check for r0 - r12 only */
+	for (i = 0; i < 13; i++) {
+		pr_alert("Register r%d information:", i);
+		mem_dump_obj((void *)regs->uregs[i]);
+	}
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a785df28..64308e3a5d0c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -287,6 +287,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	print_modules();
 	__show_regs(regs);
+	__show_regs_alloc_free(regs);
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
-- 
2.17.1

