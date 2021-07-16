Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875573CBAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGPREb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhGPRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4DD0613F6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626454893;
        bh=aOGO+frcbfLMAxQDcOgbZUrCBSN56Da9gPuOPbPqklY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZPOkDRl5Xdjfp2lh+hwoLa5j5oEgG4gfQ8RDKSpckTIZtA9Z3c5RMHzTpTvESe06
         NZCgTyl12swGVdA6WnsjRI2PawQeQEpgp26XRvZxfHkpzMj4VH+mKgnvHnXKX0iElG
         AphrGMZaKhB6J3z2avU70OmWNyVu2nL2w19yISzk7TtzC1+LaDvOA4A2B+u0aqF2dW
         5QlYTKb2G2GhqpyCkDMiwnnIS8lcDo6fDbXSUm3jorwFzWP52elvSToTdt+scJhVQs
         n+UxFj+ox5Zzjr1yAkyxRxTvRTBh9uVYqy/k9rQBGbHqGW9ysOB4QcZ8C6fQLis8wo
         bjMFz8JWK9a5g==
Received: by mail-oi1-f172.google.com with SMTP id y66so2207388oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:01:33 -0700 (PDT)
X-Gm-Message-State: AOAM533ypeoOfMhCyL4IHWCo+z78QKccaz0e3DSaMUd2o50vUHAWftg5
        blSx3/qe9FScnD1t1vWAiiFdOzpn1rLTr4W7NwM=
X-Google-Smtp-Source: ABdhPJyn410ZTRY0qVT9wErTkEb09IWuh2eznezgTO5Oo/6Pf1cUjzlr/d1GvXToiIKx2AM//6HtyMrzxszKzyK+RCA=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr8579751oib.33.1626454893040;
 Fri, 16 Jul 2021 10:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210708041409.34168-1-huangshaobo6@huawei.com> <20210714082738.2668-1-huangshaobo6@huawei.com>
In-Reply-To: <20210714082738.2668-1-huangshaobo6@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Jul 2021 19:01:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNKhkwAuEYe1d6L6w7D0OxjgGsiR0i+ZoyZjMVmnjxDA@mail.gmail.com>
Message-ID: <CAMj1kXGNKhkwAuEYe1d6L6w7D0OxjgGsiR0i+ZoyZjMVmnjxDA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix panic when kasan and kprobe are enabled
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, nico@marvell.com,
        qbarnes@gmail.com, sagar.abhishek@gmail.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>, andreyknvl@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wuquanming@huawei.com, young.liuyang@huawei.com,
        zengweilin@huawei.com, chenzefeng2@huawei.com,
        kepler.chenxin@huawei.com, liucheng32@huawei.com,
        Abbott Liu <liuwenliang@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>, xiaoqian9@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 10:27, Shaobo Huang <huangshaobo6@huawei.com> wrote:
>
> From: huangshaobo <huangshaobo6@huawei.com>
>
> arm32 uses software to simulate the instruction replaced
> by kprobe. some instructions may be simulated by constructing
> assembly functions. therefore, before executing instruction
> simulation, it is necessary to construct assembly function
> execution environment in C language through binding registers.
> after kasan is enabled, the register binding relationship will
> be destroyed, resulting in instruction simulation errors and
> causing kernel panic.
>
> the kprobe emulate instruction function is distributed in three
> files: actions-common.c actions-arm.c actions-thumb.c, so disable
> KASAN when compiling these files.
>
> for example, use kprobe insert on cap_capable+20 after kasan
> enabled, the cap_capable assembly code is as follows:
> <cap_capable>:
> e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
> e1a05000        mov     r5, r0
> e280006c        add     r0, r0, #108    ; 0x6c
> e1a04001        mov     r4, r1
> e1a06002        mov     r6, r2
> e59fa090        ldr     sl, [pc, #144]  ;
> ebfc7bf8        bl      c03aa4b4 <__asan_load4>
> e595706c        ldr     r7, [r5, #108]  ; 0x6c
> e2859014        add     r9, r5, #20
> ......
> The emulate_ldr assembly code after enabling kasan is as follows:
> c06f1384 <emulate_ldr>:
> e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
> e282803c        add     r8, r2, #60     ; 0x3c
> e1a05000        mov     r5, r0
> e7e37855        ubfx    r7, r5, #16, #4
> e1a00008        mov     r0, r8
> e1a09001        mov     r9, r1
> e1a04002        mov     r4, r2
> ebf35462        bl      c03c6530 <__asan_load4>
> e357000f        cmp     r7, #15
> e7e36655        ubfx    r6, r5, #12, #4
> e205a00f        and     sl, r5, #15
> 0a000001        beq     c06f13bc <emulate_ldr+0x38>
> e0840107        add     r0, r4, r7, lsl #2
> ebf3545c        bl      c03c6530 <__asan_load4>
> e084010a        add     r0, r4, sl, lsl #2
> ebf3545a        bl      c03c6530 <__asan_load4>
> e2890010        add     r0, r9, #16
> ebf35458        bl      c03c6530 <__asan_load4>
> e5990010        ldr     r0, [r9, #16]
> e12fff30        blx     r0
> e356000f        cm      r6, #15
> 1a000014        bne     c06f1430 <emulate_ldr+0xac>
> e1a06000        mov     r6, r0
> e2840040        add     r0, r4, #64     ; 0x40
> ......
>
> when running in emulate_ldr to simulate the ldr instruction, panic
> occurred, and the log is as follows:
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000090
> pgd = ecb46400
> [00000090] *pgd=2e0fa003, *pmd=00000000
> Internal error: Oops: 206 [#1] SMP ARM
> PC is at cap_capable+0x14/0xb0
> LR is at emulate_ldr+0x50/0xc0
> psr: 600d0293 sp : ecd63af8  ip : 00000004  fp : c0a7c30c
> r10: 00000000  r9 : c30897f4  r8 : ecd63cd4
> r7 : 0000000f  r6 : 0000000a  r5 : e59fa090  r4 : ecd63c98
> r3 : c06ae294  r2 : 00000000  r1 : b7611300  r0 : bf4ec008
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 32c5387d  Table: 2d546400  DAC: 55555555
> Process bash (pid: 1643, stack limit = 0xecd60190)
> (cap_capable) from (kprobe_handler+0x218/0x340)
> (kprobe_handler) from (kprobe_trap_handler+0x24/0x48)
> (kprobe_trap_handler) from (do_undefinstr+0x13c/0x364)
> (do_undefinstr) from (__und_svc_finish+0x0/0x30)
> (__und_svc_finish) from (cap_capable+0x18/0xb0)
> (cap_capable) from (cap_vm_enough_memory+0x38/0x48)
> (cap_vm_enough_memory) from
> (security_vm_enough_memory_mm+0x48/0x6c)
> (security_vm_enough_memory_mm) from
> (copy_process.constprop.5+0x16b4/0x25c8)
> (copy_process.constprop.5) from (_do_fork+0xe8/0x55c)
> (_do_fork) from (SyS_clone+0x1c/0x24)
> (SyS_clone) from (__sys_trace_return+0x0/0x10)
> Code: 0050a0e1 6c0080e2 0140a0e1 0260a0e1 (f801f0e7)
>
> Fixes: 35aa1df43283 ("ARM kprobes: instruction single-stepping support")
> Fixes: 421015713b30 ("ARM: 9017/2: Enable KASan for ARM")
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> Asked-by: Ard Biesheuvel <ardb@kernel.org>

Please don't do this - the maintainer will pick it up when applying,
or when you send a new version of the patch, it is OK to add these
tags if you have not made any substantial changes.

But please do *not* add tags like this on someone else's behalf by
replying to the email - and I should also point out that 'asked-by' is
bogus.


> ---
>  arch/arm/probes/kprobes/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
> index 14db56f49f0a..6159010dac4a 100644
> --- a/arch/arm/probes/kprobes/Makefile
> +++ b/arch/arm/probes/kprobes/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +KASAN_SANITIZE_actions-common.o := n
> +KASAN_SANITIZE_actions-arm.o := n
> +KASAN_SANITIZE_actions-thumb.o := n
>  obj-$(CONFIG_KPROBES)          += core.o actions-common.o checkers-common.o
>  obj-$(CONFIG_ARM_KPROBES_TEST) += test-kprobes.o
>  test-kprobes-objs              := test-core.o
> --
> 2.12.3
>
