Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3F3CCEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhGSHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:48:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12227 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhGSHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:48:42 -0400
Received: from dggeme765-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GStzH2LLnz1CL8N;
        Mon, 19 Jul 2021 15:39:55 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 19 Jul 2021 15:45:39 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <ardb@kernel.org>
CC:     <andreyknvl@gmail.com>, <chenzefeng2@huawei.com>,
        <dvyukov@google.com>, <f.fainelli@gmail.com>, <glider@google.com>,
        <huangshaobo6@huawei.com>, <kasan-dev@googlegroups.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <liucheng32@huawei.com>, <liuwenliang@huawei.com>,
        <nico@marvell.com>, <nixiaoming@huawei.com>, <qbarnes@gmail.com>,
        <ryabinin.a.a@gmail.com>, <sagar.abhishek@gmail.com>,
        <wuquanming@huawei.com>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: [PATCH] ARM: fix panic when kasan and kprobe are enabled
Date:   Mon, 19 Jul 2021 15:45:38 +0800
Message-ID: <20210719074538.9112-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAMj1kXFELSiLXzgJVChstUiDShON+LGZpMUpg1WJoZ0EmZ5pfw@mail.gmail.com>
References: <CAMj1kXFELSiLXzgJVChstUiDShON+LGZpMUpg1WJoZ0EmZ5pfw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.103.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme765-chm.china.huawei.com (10.3.19.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 07:06, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 19 Jul 2021 at 05:09, Shaobo Huang <huangshaobo6@huawei.com> wrote:
> >
> > On Sat, 17 Jul 2021 at 01:01, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Wed, 14 Jul 2021 at 10:27, Shaobo Huang <huangshaobo6@huawei.com> wrote:
> > >>
> > >> From: huangshaobo <huangshaobo6@huawei.com>
> > >>
> > >> arm32 uses software to simulate the instruction replaced
> > >> by kprobe. some instructions may be simulated by constructing
> > >> assembly functions. therefore, before executing instruction
> > >> simulation, it is necessary to construct assembly function
> > >> execution environment in C language through binding registers.
> > >> after kasan is enabled, the register binding relationship will
> > >> be destroyed, resulting in instruction simulation errors and
> > >> causing kernel panic.
> > >>
> > >> the kprobe emulate instruction function is distributed in three
> > >> files: actions-common.c actions-arm.c actions-thumb.c, so disable
> > >> KASAN when compiling these files.
> > >>
> > >> for example, use kprobe insert on cap_capable+20 after kasan
> > >> enabled, the cap_capable assembly code is as follows:
> > >> <cap_capable>:
> > >> e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
> > >> e1a05000        mov     r5, r0
> > >> e280006c        add     r0, r0, #108    ; 0x6c
> > >> e1a04001        mov     r4, r1
> > >> e1a06002        mov     r6, r2
> > >> e59fa090        ldr     sl, [pc, #144]  ;
> > >> ebfc7bf8        bl      c03aa4b4 <__asan_load4>
> > >> e595706c        ldr     r7, [r5, #108]  ; 0x6c
> > >> e2859014        add     r9, r5, #20
> > >> ......
> > >> The emulate_ldr assembly code after enabling kasan is as follows:
> > >> c06f1384 <emulate_ldr>:
> > >> e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
> > >> e282803c        add     r8, r2, #60     ; 0x3c
> > >> e1a05000        mov     r5, r0
> > >> e7e37855        ubfx    r7, r5, #16, #4
> > >> e1a00008        mov     r0, r8
> > >> e1a09001        mov     r9, r1
> > >> e1a04002        mov     r4, r2
> > >> ebf35462        bl      c03c6530 <__asan_load4>
> > >> e357000f        cmp     r7, #15
> > >> e7e36655        ubfx    r6, r5, #12, #4
> > >> e205a00f        and     sl, r5, #15
> > >> 0a000001        beq     c06f13bc <emulate_ldr+0x38>
> > >> e0840107        add     r0, r4, r7, lsl #2
> > >> ebf3545c        bl      c03c6530 <__asan_load4>
> > >> e084010a        add     r0, r4, sl, lsl #2
> > >> ebf3545a        bl      c03c6530 <__asan_load4>
> > >> e2890010        add     r0, r9, #16
> > >> ebf35458        bl      c03c6530 <__asan_load4>
> > >> e5990010        ldr     r0, [r9, #16]
> > >> e12fff30        blx     r0
> > >> e356000f        cm      r6, #15
> > >> 1a000014        bne     c06f1430 <emulate_ldr+0xac>
> > >> e1a06000        mov     r6, r0
> > >> e2840040        add     r0, r4, #64     ; 0x40
> > >> ......
> > >>
> > >> when running in emulate_ldr to simulate the ldr instruction, panic
> > >> occurred, and the log is as follows:
> > >> Unable to handle kernel NULL pointer dereference at virtual address
> > >> 00000090
> > >> pgd = ecb46400
> > >> [00000090] *pgd=2e0fa003, *pmd=00000000
> > >> Internal error: Oops: 206 [#1] SMP ARM
> > >> PC is at cap_capable+0x14/0xb0
> > >> LR is at emulate_ldr+0x50/0xc0
> > >> psr: 600d0293 sp : ecd63af8  ip : 00000004  fp : c0a7c30c
> > >> r10: 00000000  r9 : c30897f4  r8 : ecd63cd4
> > >> r7 : 0000000f  r6 : 0000000a  r5 : e59fa090  r4 : ecd63c98
> > >> r3 : c06ae294  r2 : 00000000  r1 : b7611300  r0 : bf4ec008
> > >> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > >> Control: 32c5387d  Table: 2d546400  DAC: 55555555
> > >> Process bash (pid: 1643, stack limit = 0xecd60190)
> > >> (cap_capable) from (kprobe_handler+0x218/0x340)
> > >> (kprobe_handler) from (kprobe_trap_handler+0x24/0x48)
> > >> (kprobe_trap_handler) from (do_undefinstr+0x13c/0x364)
> > >> (do_undefinstr) from (__und_svc_finish+0x0/0x30)
> > >> (__und_svc_finish) from (cap_capable+0x18/0xb0)
> > >> (cap_capable) from (cap_vm_enough_memory+0x38/0x48)
> > >> (cap_vm_enough_memory) from
> > >> (security_vm_enough_memory_mm+0x48/0x6c)
> > >> (security_vm_enough_memory_mm) from
> > >> (copy_process.constprop.5+0x16b4/0x25c8)
> > >> (copy_process.constprop.5) from (_do_fork+0xe8/0x55c)
> > >> (_do_fork) from (SyS_clone+0x1c/0x24)
> > >> (SyS_clone) from (__sys_trace_return+0x0/0x10)
> > >> Code: 0050a0e1 6c0080e2 0140a0e1 0260a0e1 (f801f0e7)
> > >>
> > >> Fixes: 35aa1df43283 ("ARM kprobes: instruction single-stepping support")
> > >> Fixes: 421015713b30 ("ARM: 9017/2: Enable KASan for ARM")
> > >> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> > >> Asked-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Please don't do this - the maintainer will pick it up when applying,
> > > or when you send a new version of the patch, it is OK to add these
> > > tags if you have not made any substantial changes.
> > >
> > > But please do *not* add tags like this on someone else's behalf by
> > > replying to the email - and I should also point out that 'asked-by' is
> > > bogus.
> > >
> >
> > Hi ardb,
> > 1.The original patch you have been asked-by by email before, link: https://lore.kernel.org/linux-arm-kernel/CAMj1kXGqfF68MT4WwrxS0cYiUBb0gODDh-wGZSQcW9vxdfK90A@mail.gmail.com/
> 
> No it was not.
> 
> It was ACKed by, not ASKed by.
> 
> > 2.In addition to adding the asked-by tag, there is no other content modification in this patch
> > 3.The patch was reissued because the previous recipient did not include kasan maintainer and reviewers
> >
> 
> I don't care. Do NOT reply to emails with tags in other people's names.
> 
Hi ardb,
Sincerely apologize for my mistake,
I mistakenly wrote the Acked-by label as Asked-by. 
Do I need to change to Acked-by or remove the label and reissue a patch?

thanks,
Shaobo Huang
> 
> > thanks,
> > ShaoBo Huang
> >
> > >
> > >> ---
> > >>  arch/arm/probes/kprobes/Makefile | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
> > >> index 14db56f49f0a..6159010dac4a 100644
> > >> --- a/arch/arm/probes/kprobes/Makefile
> > >> +++ b/arch/arm/probes/kprobes/Makefile
> > >> @@ -1,4 +1,7 @@
> > >>  # SPDX-License-Identifier: GPL-2.0
> > >> +KASAN_SANITIZE_actions-common.o := n
> > >> +KASAN_SANITIZE_actions-arm.o := n
> > >> +KASAN_SANITIZE_actions-thumb.o := n
> > >>  obj-$(CONFIG_KPROBES)          += core.o actions-common.o checkers-common.o
> > >>  obj-$(CONFIG_ARM_KPROBES_TEST) += test-kprobes.o
> > >>  test-kprobes-objs              := test-core.o
> > >> --
> > >> 2.12.3
> > >>
