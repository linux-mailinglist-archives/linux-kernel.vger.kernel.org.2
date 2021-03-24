Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A974A34723B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhCXHQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:16:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21547 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhCXHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:16:19 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210324071617epoutp02bfa6c8c920c9aa6fdf07f1ba1df8754d~vNgL2ZwED2974329743epoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:16:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210324071617epoutp02bfa6c8c920c9aa6fdf07f1ba1df8754d~vNgL2ZwED2974329743epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616570177;
        bh=EZJ6jZebfYOz2VBi03W6MBX3hbw6FXJXb37vByeCE8s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nQOaCw/Nw3nTxeFW6Izv++CIgECFZZJmOUUq1qWL/LKeyJ+B+dmoA9kOrxuOoGZvp
         m+i6Le6BA3RbBmP/aXDlhnlMJEhaXqBHmV2jzkw1cWPVEYUTpnQ1bilPbA+9aDuTpo
         qd8aRzgy8knh/M2scrbvuz+0Ft0V6Cqv6p763NOM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210324071614epcas5p2beb8860299b9d00cbf2f13e28879280a~vNgI3pGQu3065430654epcas5p2H;
        Wed, 24 Mar 2021 07:16:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.D2.41008.E37EA506; Wed, 24 Mar 2021 16:16:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210324065511epcas5p1cb74119660e2d98a381ae69d01b29275~vNNw7pqQc2060220602epcas5p1I;
        Wed, 24 Mar 2021 06:55:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210324065511epsmtrp1af6f8952da5435723b7c8c8d9d27765d~vNNw6jQD_0887508875epsmtrp15;
        Wed, 24 Mar 2021 06:55:11 +0000 (GMT)
X-AuditID: b6c32a4b-64bff7000001a030-dd-605ae73eab9a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.A3.33967.F42EA506; Wed, 24 Mar 2021 15:55:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210324065508epsmtip2403aa1020ff9d8650e3dc6bb2c6101e0~vNNuQ0gCc0285702857epsmtip2M;
        Wed, 24 Mar 2021 06:55:08 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        0x7f454c46@gmail.com, amit.kachhap@arm.com, james.morse@arm.com,
        vincenzo.frascino@arm.com, nsaenzjulienne@suse.de,
        keescook@chromium.org, samitolvanen@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/2] arm64/process.c: fix Wmissing-prototypes build warnings
Date:   Wed, 24 Mar 2021 12:24:58 +0530
Message-Id: <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7bCmhq7d86gEg9PvRCwmTHvBYnFxd6rF
        nPVr2CymfNjBavF+WQ+jxf19y5ksznTnWmx6fI3V4vKuOWwWh+e3sVgsvX6RyWLbrOVsFv13
        rrNZLF3xltVi77+fLBYtd0wdBDzWzFvD6DG74SKLx85Zd9k9Fmwq9di0qpPN48SM3ywem5fU
        e/RtWcXosfl0tcfnTXIBXFFcNimpOZllqUX6dglcGff3vGAtWC5RcfPOP6YGxo0iXYycHBIC
        JhIbF31m6WLk4hAS2M0ocbO7hx3C+cQo8XrXFDYI5xujxPoL+1lhWiauaGOESOxllFhyYS9U
        1RdGibVbZjGCVLEJ6Ems2rUHbLCIwHQmidbW52DtzAJdjBKbfhqB2MICPhJ3dywHa2ARUJW4
        fuUvC4jNK+AqsWjCE2aIdXISN891MoMMkhDo5ZA4unwtI0TCRWLRqZMsELawxKvjW9ghbCmJ
        l/1t7BAN3YwSM+dchupeDbT5xXWoL+wlXjc3MHUxcgCdpCmxfpc+RFhWYuqpdUwQl/JJ9P5+
        wgQR55XYMQ/GVpVoubkBaoy0xOePH6GO8JBYd2AXWI2QQKzE8d0P2SYwys5C2LCAkXEVo2Rq
        QXFuemqxaYFxXmq5XnFibnFpXrpecn7uJkZwAtLy3sH46MEHvUOMTByMhxglOJiVRHhbwiMS
        hHhTEiurUovy44tKc1KLDzFKc7AoifPuMHgQLySQnliSmp2aWpBaBJNl4uCUamDqn3dG+baH
        zL8vN42kjifEHpwTWcKnfDHox6GTEiGeDZ86jn1wMXHp0Ld8Wz75bP7Zjd/W1X07lNiy6sOp
        VOk1D1uW1rSxi7kc/mv+mePTvaSNP7a2ZzFse5ru2prnvnKhrUScvUmopH92rP+LqYXfjKp2
        vN7QYfGz6n+Gko67/aS6BWdnbvuocqjMZecHvp6ekgdOr3XVVgo3fLpUWPVbSSrk4yGLtHdm
        fgYW2brfP5gv2fp5W0DadcEntsG/LvttMn0+4cTcW86eX9i/uS58ZJWdON91xeWmudXHDA39
        3z3ZO3vBdPbv/5ckCO+ZbL+KKdB42gsJ5v+mt6OZTYQl26ctzlimqMs2383p1cEcJZbijERD
        Leai4kQAceta5q8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvK7/o6gEg6d71SwmTHvBYnFxd6rF
        nPVr2CymfNjBavF+WQ+jxf19y5ksznTnWmx6fI3V4vKuOWwWh+e3sVgsvX6RyWLbrOVsFv13
        rrNZLF3xltVi77+fLBYtd0wdBDzWzFvD6DG74SKLx85Zd9k9Fmwq9di0qpPN48SM3ywem5fU
        e/RtWcXosfl0tcfnTXIBXFFcNimpOZllqUX6dglcGff3vGAtWC5RcfPOP6YGxo0iXYycHBIC
        JhITV7QxgthCArsZJXomOkHEpSV+/nvPAmELS6z895y9i5ELqOYTo0TXxq+sIAk2AT2JVbv2
        sIAkRASWM0l0zDsF5jAL9DFKdCy+A9YuLOAjcXfHcrAVLAKqEtev/AWL8wq4Siya8IQZYoWc
        xM1zncwTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDmQtzR2M21d90DvE
        yMTBeIhRgoNZSYS3JTwiQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWp
        RTBZJg5OqQamvdzhZWpvW2+ez53r4NsRkPB3R/fD2bt3tl9OucR5UmoxZ+38axYeVz76GzgX
        f9lStOlvT6j3yYt14YXKseu7bHjvLTgldMrKi03PdMreTM/g/3tlu7aG7cnOYdo54fMujm0H
        jkW9XW98uW1ZZ5Lmqv0p4rE9gVxSm+yuiqR9CmnOl5m61uL0x3m6Nqw517zOdL+W1uspFueb
        1d7FVLTpQvkb8YtZ8xSzpb7smm34Vkd6++MVS24tiZjPeNSz703db/ZVJx98UZj0MPn838NS
        G7LEtKeciufL1H32l1UrT1TlULqsXkO87XPB5tU8IvsOLw/hfbvW/lzHnVyjRzw7j2qt2DLz
        17wrnF4tZzmvKrEUZyQaajEXFScCADVfoS7TAgAA
X-CMS-MailID: 20210324065511epcas5p1cb74119660e2d98a381ae69d01b29275
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210324065511epcas5p1cb74119660e2d98a381ae69d01b29275
References: <CGME20210324065511epcas5p1cb74119660e2d98a381ae69d01b29275@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function protypes are missed before defination, which
leads to compilation warning with "-Wmissing-prototypes"
flag.

https://lkml.org/lkml/2021/3/19/840

arch/arm64/kernel/process.c:261:6: warning: no previous prototype for '__show_regs' [-Wmissing-prototypes]
    261 | void __show_regs(struct pt_regs *regs)
        |      ^~~~~~~~~~~
arch/arm64/kernel/process.c:307:6: warning: no previous prototype for '__show_regs_alloc_free' [-Wmissing-prototypes]
    307 | void __show_regs_alloc_free(struct pt_regs *regs)
        |      ^~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/process.c:365:5: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
   365 | int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
        |     ^~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/process.c:546:41: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
   546 | __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
        |                                         ^~~~~~~~~~~
arch/arm64/kernel/process.c:710:25: warning: no previous prototype for 'arm64_preempt_schedule_irq' [-Wmissing-prototypes]
   710 | asmlinkage void __sched arm64_preempt_schedule_irq(void)
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/include/asm/processor.h   | 2 ++
 arch/arm64/include/asm/thread_info.h | 2 ++
 arch/arm64/kernel/process.c          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ca2cd75d3286..efc10e9041a0 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -251,6 +251,8 @@ unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 					 struct task_struct *next);
 
+asmlinkage void arm64_preempt_schedule_irq(void);
+
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 9f4e3b266f21..6623c99f0984 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -55,6 +55,8 @@ void arch_setup_new_exec(void);
 #define arch_setup_new_exec     arch_setup_new_exec
 
 void arch_release_task_struct(struct task_struct *tsk);
+int arch_dup_task_struct(struct task_struct *dst,
+				struct task_struct *src);
 
 #endif
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 325c83b1a24d..6e60aa3b5ea9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -57,6 +57,8 @@
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
+#include <asm/switch_to.h>
+#include <asm/system_misc.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
-- 
2.17.1

