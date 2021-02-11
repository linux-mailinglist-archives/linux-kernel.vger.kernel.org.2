Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5C318685
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKIv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBKIub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:50:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82FE064E9C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613032830;
        bh=H6KqmZyTahwGU0Jxi6xna20RJcO64LZ6jd+0Gj9PiqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q7VsXEHIkqbKZT0RyXr2oN9euUvp7iI3kBVTLRPS0KsRFlKRrMrumdYtyf1O7X9xr
         Hn8VFWl5AWxICWQUHRF3fo8gWk0ThBatEbOO4QruKBtFxXqs37oRLeYQ9uvTmTzwpv
         78OluBkzNSl8MbYtnOiyuiP2J6608wDEUA2wEQdAdEQ1VwyUGyYlO2YDKr0KupBUja
         l9MhOfAiwN/18qeYdg8Vzc3wjTwsbSa0Vnu7MI6JDAv5yWrJ3hqZyZv36BGNAJQIiz
         NnSfDtTNZyK5T3a09P6OazQncWUKkFCRnM7yUWh9J8lYLDBXKcXzW5gH8SiHGivLyr
         ljJAc4R28pGzg==
Received: by mail-oi1-f179.google.com with SMTP id h6so5260548oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:40:30 -0800 (PST)
X-Gm-Message-State: AOAM5325xeyqvhTCzesaFtr0aCQiUWg44kVmLpHy4ZckSRM4i/N3NIwo
        1YypqfKQWaZIrK/K8Mf1a4/rCzpObywfbVsW9V0=
X-Google-Smtp-Source: ABdhPJyIs43NAgRsttEx6L2QgNVf7z3a6DWqU/EAeOw0LlgfFp0OB9+eKb8dRdxXcY7npZq4FkV0yTJulQjHUJABRvA=
X-Received: by 2002:aca:4bd1:: with SMTP id y200mr2050777oia.33.1613032829865;
 Thu, 11 Feb 2021 00:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20210209085511.21056-1-huangshaobo6@huawei.com>
In-Reply-To: <20210209085511.21056-1-huangshaobo6@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Feb 2021 09:40:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqfF68MT4WwrxS0cYiUBb0gODDh-wGZSQcW9vxdfK90A@mail.gmail.com>
Message-ID: <CAMj1kXGqfF68MT4WwrxS0cYiUBb0gODDh-wGZSQcW9vxdfK90A@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix panic when kasan and kprobe are enabled
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>, sagar.abhishek@gmail.com,
        nico@marvell.com, qbarnes@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zengweilin@huawei.com, young.liuyang@huawei.com,
        chenzefeng2@huawei.com, wuquanming@huawei.com,
        liucheng32@huawei.com, Xiaoming Ni <nixiaoming@huawei.com>,
        kepler.chenxin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 09:55, Shaobo Huang <huangshaobo6@huawei.com> wrote:
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

Acked-by: Ard Biesheuvel <ardb@kernel.org>

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
