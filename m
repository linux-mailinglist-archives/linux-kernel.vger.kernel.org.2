Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B475366E87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbhDUOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:53:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56929 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbhDUOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:53:38 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1lZEDs-0004gm-P0
        for linux-kernel@vger.kernel.org; Wed, 21 Apr 2021 14:53:01 +0000
Received: by mail-io1-f69.google.com with SMTP id 5-20020a6b14050000b02903f01f27777eso5958170iou.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSbzbAFvpXRSjJLn1izf1iuk5pDKNstI3MAGzwMWdg4=;
        b=d2nyJOZcM73qfmFOTu3Ft0QL3xEVEx+6MghQ2stUW+thHXsa45vW7LlSaCHurDD/x7
         0vafDgR1EqPTssmJgAj5ox+gaNAb6lesuNuqckYXG3G6T/LOlTOUBVLVvd9JAPfj1Ojf
         OoMP4FnD/JKVlTrzOEBErW0Vx8s8K8yQ6ZGDlF500ah2qzGRlBZyADsEoWe2uDZLKw2Y
         wUfNYcust09YVig8izxjkXSbI5cBWS4z2V1S1o0PCRL6vj0dmCNUG/9MdJugJnN2n30o
         lqzLf1Ca3khMg+5V0QXWItT/p2YxUQKn6tu2j35oxNGcCQ37RW508gP2T5zcvLfh20kz
         bT2A==
X-Gm-Message-State: AOAM530PLTlgGwjq47SXAFb5/JRslmO2OEA2Uqb3m9SHsZ9Lpia8v7QG
        yl5xOOwCjTSXeHQVdjN4DAKWLdWz50v9LLu/JWjn3ynRbGSvTYAb5zANW2fMdP1qSQGIYjrtl7g
        aIJQMnJxzUIL6B5H7Z/utGJbxiYZr3mjJSFQrxd8u/A==
X-Received: by 2002:a05:6e02:20c1:: with SMTP id 1mr25067304ilq.71.1619016776407;
        Wed, 21 Apr 2021 07:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzalCiBLEjvoo3qKU7HB4tR36NR/+huF0KM7kcBnz4Zi90lb9XW3HQRKB86M6lOtBkQhjhf1Q==
X-Received: by 2002:a05:6e02:20c1:: with SMTP id 1mr25067250ilq.71.1619016775514;
        Wed, 21 Apr 2021 07:52:55 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id f1sm1061456ilu.46.2021.04.21.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:52:54 -0700 (PDT)
Date:   Wed, 21 Apr 2021 08:52:52 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH 08/11] irqchip/gic: Configure SGIs as standard interrupts
Message-ID: <YIA8RCjoI+9nChN6@xps13.dannf>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-9-maz@kernel.org>
 <YH87dtTfwYgavusz@xps13.dannf>
 <YH9G3+aDUWpcLCpD@xps13.dannf>
 <8735vjrjj3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735vjrjj3.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + Fu Wei ]
On Wed, Apr 21, 2021 at 11:58:40AM +0100, Marc Zyngier wrote:
> Hi Dan,n
> 
> On Tue, 20 Apr 2021 22:25:51 +0100,
> dann frazier <dann.frazier@canonical.com> wrote:
> > 
> > On Tue, Apr 20, 2021 at 02:37:10PM -0600, dann frazier wrote:
> > > On Tue, May 19, 2020 at 05:17:52PM +0100, Marc Zyngier wrote:
> > > > Change the way we deal with GIC SGIs by turning them into proper
> > > > IRQs, and calling into the arch code to register the interrupt range
> > > > instead of a callback.
> > > > 
> > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > 
> > > hey Marc,
> > > 
> > >   I bisected a boot failure on our Gigabyte R120-T33 systems (ThunderX
> > > CN88XX) down to this commit, but only when running in ACPI mode. See below:
> > > 
> > > 
> > > EFI stub: Booting Linux Kernel...
> > > EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
> > > EFI stub: Using DTB from configuration table
> > > EFI stub: Exiting boot services and installing virtual address map...
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a11]
> > > [    0.000000] Linux version 5.11.0-13-generic (buildd@bos02-arm64-067) (gcc (Ubuntu 10.2.1-23ubuntu1) 10.2.1 20210312, GNU ld (GNU Binutils for Ubuntu) 2.36.1) #14-Ubuntu SMP Fri Mar 19 16:57:35 UTC 2021 (Ubuntu 5.11.0-13.14-generic 5.11.7)
> > 
> > Sorry, realized I posted a log from an Ubuntu kernel. Here's an
> > upstream one:
> 
> [...]
> 
> > 
> > [    7.842174] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> > [    7.849699] io scheduler mq-deadline registered
> > [    7.857591] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > [    7.865127] efifb: probing for efifb
> > [    7.868738] efifb: No BGRT, not showing boot graphics
> > [    7.873783] efifb: framebuffer at 0x881010000000, using 3072k, total 3072k
> > [    7.880649] efifb: mode is 1024x768x32, linelength=4096, pages=1
> > [    7.886647] efifb: scrolling: redraw
> > [    7.890212] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> > [    7.895905] fbcon: Deferring console take-over
> > [    7.900350] fb0: EFI VGA frame buffer device
> > [    7.905289] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> > [    7.913714] ACPI: button: Power Button [PWRB]
> > [    7.919549] ACPI GTDT: [Firmware Bug]: failed to get the Watchdog base address.
> > [    7.927289] Unable to handle kernel read from unreadable memory at virtual address 0000000000000028
> > [    7.936326] Mem abort info:
> > [    7.939108]   ESR = 0x96000004
> > [    7.942151]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    7.947451]   SET = 0, FnV = 0
> > [    7.950494]   EA = 0, S1PTW = 0
> > [    7.953624] Data abort info:
> > [    7.956492]   ISV = 0, ISS = 0x00000004
> > [    7.960316]   CM = 0, WnR = 0
> > [    7.963273] [0000000000000028] user address but active_mm is swapper
> > [    7.969616] Internal error: Oops: 96000004 [#1] SMP
> > [    7.974483] Modules linked in:
> > [    7.977531] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc8 #19
> > [    7.983874] Hardware name: GIGABYTE R120-T33/MT30-GS1, BIOS F02 08/06/2019
> > [    7.990737] pstate: 40400085 (nZcv daIf +PAN -UAO -TCO BTYPE=--)
> > [    7.996732] pc : __ipi_send_mask+0x60/0x114
> > [    8.000910] lr : smp_cross_call+0x40/0xcc
> > [    8.004913] sp : ffff800012753c10
> > [    8.008216] x29: ffff800012753c10 x28: ffff000100de5d00 
> > [    8.013521] x27: 000000000000000a x26: ffff80001225da20 
> > [    8.018825] x25: 0000000000000000 x24: ffff000ff62719b0 
> > [    8.024129] x23: ffff80001225d000 x22: ffff800012368108 
> > [    8.029433] x21: ffff800010f69a20 x20: 0000000000000000 
> > [    8.034737] x19: ffff000100143c60 x18: 0000000000000020 
> > [    8.040041] x17: 000000008e74252f x16: 00000000bf0ab2ad 
> > [    8.045345] x15: ffffffffffffffff x14: 0000000000000000 
> > [    8.050649] x13: 003d090000000000 x12: 00003d0900000000 
> > [    8.055953] x11: 0000000000000000 x10: 00003d0900000000 
> > [    8.061257] x9 : ffff800010027f14 x8 : 0000000000000000 
> > [    8.066561] x7 : 00000000ffffffff x6 : ffff000ff6148698 
> > [    8.071865] x5 : ffff80001159d040 x4 : ffff80001159d110 
> > [    8.077169] x3 : ffff800010f69a00 x2 : 0000000000000000 
> > [    8.082473] x1 : ffff800010f69a20 x0 : 0000000000000000 
> > [    8.087777] Call trace:
> > [    8.090213]  __ipi_send_mask+0x60/0x114
> > [    8.094038]  smp_cross_call+0x40/0xcc
> > [    8.097691]  smp_send_reschedule+0x3c/0x50
> > [    8.101778]  resched_curr+0x5c/0xb0
> > [    8.105258]  check_preempt_curr+0x58/0x90
> > [    8.109258]  ttwu_do_wakeup+0x2c/0x190
> > [    8.112996]  ttwu_do_activate+0x7c/0x114
> > [    8.116909]  try_to_wake_up+0x388/0x670
> > [    8.120735]  wake_up_process+0x24/0x30
> > [    8.124474]  swake_up_one+0x48/0x9c
> > [    8.127953]  rcu_gp_kthread_wake+0x68/0x8c
> > [    8.132041]  rcu_accelerate_cbs_unlocked+0xb4/0xf0
> > [    8.136822]  rcu_core+0x520/0x694
> > [    8.140128]  rcu_core_si+0x1c/0x2c
> > [    8.143520]  __do_softirq+0x128/0x388
> > [    8.147172]  irq_exit+0xc4/0xec
> > [    8.150304]  __handle_domain_irq+0x8c/0xec
> > [    8.154394]  gic_handle_irq+0xd8/0x2f0
> > [    8.158132]  el1_irq+0xc0/0x180
> > [    8.161262]  __pi_strcmp+0x20/0x158
> > [    8.164742]  driver_register+0x68/0x140
> > [    8.168571]  __platform_driver_register+0x34/0x40
> > [    8.173265]  imx8mp_clk_driver_init+0x28/0x34
> > [    8.177614]  do_one_initcall+0x50/0x260
> > [    8.181440]  kernel_init_freeable+0x24c/0x2d4
> > [    8.185790]  kernel_init+0x20/0x134
> > [    8.189271]  ret_from_fork+0x10/0x18
> > [    8.192840] Code: a90363f7 aa0103f5 d0010957 f9401260 (b9402800) 
> > [    8.198955] ---[ end trace c24172add816c1f0 ]---
> > [    8.203562] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> > [    8.210442] SMP: stopping secondary CPUs
> > [    9.258360] SMP: failed to stop secondary CPUs 0,9
> > [    9.263141] Kernel Offset: disabled
> > [    9.266617] CPU features: 0x00040002,69101108
> > [    9.270963] Memory Limit: none
> > [    9.274024] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> Please feed this stacktrace to scripts/decode_stacktrace.sh so that I
> can get an idea about what is going wrong. I bet something is playing
> ungodly games with the one of the IPIs, and things go horribly wrong.

hey Marc,
  Sure:

[    7.927289] Unable to handle kernel read from unreadable memory at virtual address 0000000000000028
[    7.936326] Mem abort info:
[    7.939108]   ESR = 0x96000004
[    7.942151]   EC = 0x25: DABT (current EL), IL = 32 bits
[    7.947451]   SET = 0, FnV = 0
[    7.950494]   EA = 0, S1PTW = 0
[    7.953624] Data abort info:
[    7.956492]   ISV = 0, ISS = 0x00000004
[    7.960316]   CM = 0, WnR = 0
[    7.963273] [0000000000000028] user address but active_mm is swapper
[    7.969616] Internal error: Oops: 96000004 [#1] SMP
[    7.974483] Modules linked in:
[    7.977531] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc8 #19
[    7.983874] Hardware name: GIGABYTE R120-T33/MT30-GS1, BIOS F02 08/06/2019
[    7.990737] pstate: 40400085 (nZcv daIf +PAN -UAO -TCO BTYPE=--)
[    7.996732] pc : __ipi_send_mask (/home/ubuntu/linux/./include/linux/irqdomain.h:537 /home/ubuntu/linux/kernel/irq/ipi.c:283) 
[    8.000910] lr : smp_cross_call (/home/ubuntu/linux/arch/arm64/kernel/smp.c:958) 
[    8.004913] sp : ffff800012753c10
[    8.008216] x29: ffff800012753c10 x28: ffff000100de5d00
[    8.013521] x27: 000000000000000a x26: ffff80001225da20
[    8.018825] x25: 0000000000000000 x24: ffff000ff62719b0
[    8.024129] x23: ffff80001225d000 x22: ffff800012368108
[    8.029433] x21: ffff800010f69a20 x20: 0000000000000000
[    8.034737] x19: ffff000100143c60 x18: 0000000000000020
[    8.040041] x17: 000000008e74252f x16: 00000000bf0ab2ad
[    8.045345] x15: ffffffffffffffff x14: 0000000000000000
[    8.050649] x13: 003d090000000000 x12: 00003d0900000000
[    8.055953] x11: 0000000000000000 x10: 00003d0900000000
[    8.061257] x9 : ffff800010027f14 x8 : 0000000000000000
[    8.066561] x7 : 00000000ffffffff x6 : ffff000ff6148698
[    8.071865] x5 : ffff80001159d040 x4 : ffff80001159d110
[    8.077169] x3 : ffff800010f69a00 x2 : 0000000000000000
[    8.082473] x1 : ffff800010f69a20 x0 : 0000000000000000
[    8.087777] Call trace:
[    8.090213] __ipi_send_mask (/home/ubuntu/linux/./include/linux/irqdomain.h:537 /home/ubuntu/linux/kernel/irq/ipi.c:283) 
[    8.094038] smp_cross_call (/home/ubuntu/linux/arch/arm64/kernel/smp.c:958) 
[    8.097691] smp_send_reschedule (/home/ubuntu/linux/arch/arm64/kernel/smp.c:1011) 
[    8.101778] resched_curr (/home/ubuntu/linux/kernel/sched/core.c:621) 
[    8.105258] check_preempt_curr (/home/ubuntu/linux/kernel/sched/core.c:1715) 
[    8.109258] ttwu_do_wakeup (/home/ubuntu/linux/kernel/sched/core.c:2940) 
[    8.112996] ttwu_do_activate (/home/ubuntu/linux/kernel/sched/core.c:2991) 
[    8.116909] try_to_wake_up (/home/ubuntu/linux/kernel/sched/sched.h:1258 /home/ubuntu/linux/kernel/sched/sched.h:1353 /home/ubuntu/linux/kernel/sched/core.c:3187 /home/ubuntu/linux/kernel/sched/core.c:3464) 
[    8.120735] wake_up_process (/home/ubuntu/linux/kernel/sched/core.c:3534) 
[    8.124474] swake_up_one (/home/ubuntu/linux/./include/linux/list.h:135 /home/ubuntu/linux/./include/linux/list.h:204 /home/ubuntu/linux/kernel/sched/swait.c:31 /home/ubuntu/linux/kernel/sched/swait.c:22 /home/ubuntu/linux/kernel/sched/swait.c:53) 
[    8.127953] rcu_gp_kthread_wake (/home/ubuntu/linux/kernel/rcu/tree.c:1528) 
[    8.132041] rcu_accelerate_cbs_unlocked (/home/ubuntu/linux/kernel/rcu/tree.c:1606) 
[    8.136822] rcu_core (/home/ubuntu/linux/kernel/rcu/tree_plugin.h:2801 /home/ubuntu/linux/kernel/rcu/tree.c:2786) 
[    8.140128] rcu_core_si (/home/ubuntu/linux/kernel/rcu/tree.c:2808) 
[    8.143520] __do_softirq (/home/ubuntu/linux/./arch/arm64/include/asm/jump_label.h:21 /home/ubuntu/linux/./include/linux/jump_label.h:200 /home/ubuntu/linux/./include/trace/events/irq.h:142 /home/ubuntu/linux/kernel/softirq.c:346) 
[    8.147172] irq_exit (/home/ubuntu/linux/./arch/arm64/include/asm/percpu.h:43 /home/ubuntu/linux/kernel/softirq.c:402 /home/ubuntu/linux/kernel/softirq.c:424 /home/ubuntu/linux/kernel/softirq.c:446) 
[    8.150304] __handle_domain_irq (/home/ubuntu/linux/./include/asm-generic/irq_regs.h:29 /home/ubuntu/linux/kernel/irq/irqdesc.c:693) 
[    8.154394] gic_handle_irq (/home/ubuntu/linux/./arch/arm64/include/asm/arch_gicv3.h:45 /home/ubuntu/linux/drivers/irqchip/irq-gic-v3.c:222 /home/ubuntu/linux/drivers/irqchip/irq-gic-v3.c:649) 
[    8.158132] el1_irq (/home/ubuntu/linux/arch/arm64/kernel/entry.S:671) 
[    8.161262] __pi_strcmp (/home/ubuntu/linux/arch/arm64/lib/strcmp.S:66) 
[    8.164742] driver_register (/home/ubuntu/linux/drivers/base/driver.c:216 /home/ubuntu/linux/drivers/base/driver.c:164) 
[    8.168571] __platform_driver_register (/home/ubuntu/linux/drivers/base/platform.c:896) 
[    8.173265] imx8mp_clk_driver_init (/home/ubuntu/linux/drivers/clk/imx/clk-imx8mp.c:769) 
[    8.177614] do_one_initcall (/home/ubuntu/linux/init/main.c:1226) 
[    8.181440] kernel_init_freeable (/home/ubuntu/linux/init/main.c:1298 /home/ubuntu/linux/init/main.c:1315 /home/ubuntu/linux/init/main.c:1335 /home/ubuntu/linux/init/main.c:1537) 
[    8.185790] kernel_init (/home/ubuntu/linux/init/main.c:1426) 
[    8.189271] ret_from_fork (/home/ubuntu/linux/arch/arm64/kernel/entry.S:961) 
[ 8.192840] Code: a90363f7 aa0103f5 d0010957 f9401260 (b9402800)
All code
========
   0:	a90363f7 	stp	x23, x24, [sp, #48]
   4:	aa0103f5 	mov	x21, x1
   8:	d0010957 	adrp	x23, 0x212a000
   c:	f9401260 	ldr	x0, [x19, #32]
  10:*	b9402800 	ldr	w0, [x0, #40]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	b9402800 	ldr	w0, [x0, #40]
[    8.198955] ---[ end trace c24172add816c1f0 ]---
[    8.203562] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[    8.210442] SMP: stopping secondary CPUs
[    9.258360] SMP: failed to stop secondary CPUs 0,9
[    9.263141] Kernel Offset: disabled
[    9.266617] CPU features: 0x00040002,69101108
[    9.270963] Memory Limit: none
[    9.274024] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---


> Now, here's a hunch: in the fine TX1 tradition, the firmware is broken
> and the GTDT table looks unusable. Amusingly, the crash happens right
> after the SBSA watchdog fails to probe.

Yeah, I noticed that, but didn't highlight it as I didn't see it in
the backtrace...

> And looking at the code that implements that driver, it looks dodgy as
> hell, as it unmaps an interrupt it doesn't even know is valid. And it
> does that right when the driver fails the way you experienced it. If,
> by any chance, the interrupt field is 0 in the firmware table, this
> results in SGI0 being unmapped. Given that this is the rescheduling
> interrupt, fireworks happen.

... and that explains why. I wouldn't have gotten there, but wish I'd
thought to test w/ the watchdog compiled out :(

> Can you have a go with the patchlet below, and let me know if that
> helps?

It does!

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a11]
[    0.000000] Linux version 5.12.0-rc8+ (ubuntu@seidel) (gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.36.1) #20 SMP Wed Apr 21 14:22:16 UTC 2021
[    0.000000] Machine model: Cavium ThunderX CN88XX board
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi: ESRT=0xffce0ff18 SMBIOS 3.0=0xfffb0000 ACPI 2.0=0xffec60000 MEMRESERVE=0xffc889d98 
[    0.000000] esrt: Reserving ESRT space from 0x0000000ffce0ff18 to 0x0000000ffce0ff50.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000FFEC60000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000FFEC60028 00008C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000000FFEC600B8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000FFEC601D0 00220B (v02 CAVIUM THUNDERX 00000001 INTL 20130517)
[    0.000000] ACPI: SPMI 0x0000000FFEC623E0 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: FIDT 0x0000000FFEC62428 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: APIC 0x0000000FFEC624C8 000F68 (v03 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: DBG2 0x0000000FFEC63430 000067 (v01 CAVIUM CN88XDBG 00000000 INTL 20150619)
[    0.000000] ACPI: GTDT 0x0000000FFEC63498 0000E0 (v02 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: IORT 0x0000000FFEC63578 0013D4 (v01 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: MCFG 0x0000000FFEC64950 00006C (v01 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: SSDT 0x0000000FFEC649C0 00089C (v02 CAVIUM NETWORK  00000001 INTL 20150619)
[    0.000000] ACPI: OEM1 0x0000000FFEC65260 0001E8 (v02 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: SLIT 0x0000000FFEC65448 000030 (v01 CAVIUM TEMPLATE 00000001 INTL 20150619)
[    0.000000] ACPI: SPCR 0x0000000FFEC65478 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000B)
[    0.000000] ACPI: BGRT 0x0000000FFEC654C8 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SPCR: console: pl011,mmio32,0x87e024000000,115200
[    0.000000] efi_bgrt: Ignoring BGRT: Incorrect BMP magic number 0x3707 (expected 0x4d42)
[    0.000000] NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000500000-0x0000000fff0fffff]
[    0.000000] NUMA: NODE_DATA [mem 0xff677c480-0xff6780fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000500000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fff0fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000500000-0x0000000000dfffff]
[    0.000000]   node   0: [mem 0x0000000000e00000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000010000000-0x00000000102fffff]
[    0.000000]   node   0: [mem 0x0000000010300000-0x00000000fff9ffff]
[    0.000000]   node   0: [mem 0x00000000fffa0000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000fee6affff]
[    0.000000]   node   0: [mem 0x0000000fee6b0000-0x0000000fee6cffff]
[    0.000000]   node   0: [mem 0x0000000fee6d0000-0x0000000ffac2ffff]
[    0.000000]   node   0: [mem 0x0000000ffac30000-0x0000000ffb0affff]
[    0.000000]   node   0: [mem 0x0000000ffb0b0000-0x0000000ffc8bffff]
[    0.000000]   node   0: [mem 0x0000000ffc8c0000-0x0000000ffc91ffff]
[    0.000000]   node   0: [mem 0x0000000ffc920000-0x0000000ffca3ffff]
[    0.000000]   node   0: [mem 0x0000000ffca40000-0x0000000ffca4ffff]
[    0.000000]   node   0: [mem 0x0000000ffca50000-0x0000000ffcdbffff]
[    0.000000]   node   0: [mem 0x0000000ffcdc0000-0x0000000ffd12ffff]
[    0.000000]   node   0: [mem 0x0000000ffd130000-0x0000000ffec2ffff]
[    0.000000]   node   0: [mem 0x0000000ffec30000-0x0000000ffec5ffff]
[    0.000000]   node   0: [mem 0x0000000ffec60000-0x0000000ffec6ffff]
[    0.000000]   node   0: [mem 0x0000000ffec70000-0x0000000ffed1ffff]
[    0.000000]   node   0: [mem 0x0000000ffed20000-0x0000000fff0fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000500000-0x0000000fff0fffff]
[    0.000000] On node 0 totalpages: 16772096
[    0.000000]   DMA zone: 16364 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1047296 pages, LIFO batch:63
[    0.000000]   Normal zone: 245700 pages used for memmap
[    0.000000]   Normal zone: 15724800 pages, LIFO batch:63
[    0.000000]   Normal zone: 256 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fdc00000
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] ACPI: SRAT not present
[    0.000000] percpu: Embedded 33 pages/cpu s98072 r8192 d28904 u135168
[    0.000000] pcpu-alloc: s98072 r8192 d28904 u135168 alloc=33*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23 
[    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31 
[    0.000000] pcpu-alloc: [0] 32 [0] 33 [0] 34 [0] 35 [0] 36 [0] 37 [0] 38 [0] 39 
[    0.000000] pcpu-alloc: [0] 40 [0] 41 [0] 42 [0] 43 [0] 44 [0] 45 [0] 46 [0] 47 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Software prefetching using PRFM
[    0.000000] CPU features: detected: Cavium erratum 27456
[    0.000000] CPU features: detected: Cavium erratum 30115
[    0.000000] CPU features: kernel page table isolation forced OFF by ARM64_WORKAROUND_CAVIUM_27456
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16510032
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-dannf root=UUID=76e81d96-78e4-4432-a490-bb852f6111e8 ro sysrq_always_enabled acpi=force
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] printk: log_buf_len total cpu_extra contributions: 192512 bytes
[    0.000000] printk: log_buf_len min size: 262144 bytes
[    0.000000] printk: log_buf_len: 524288 bytes
[    0.000000] printk: early log buf free: 255872(97%)
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f9c00000-0x00000000fdc00000] (64MB)
[    0.000000] Memory: 65572072K/67088384K available (15616K kernel code, 3626K rwdata, 11808K rodata, 7616K init, 1157K bss, 1483544K reserved, 32768K cma-reserved)
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x38/0x5b4 with crng_init=0
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=48, Nodes=1
[    0.000000] ftrace: allocating 49728 entries in 195 pages
[    0.000000] ftrace: allocated 195 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=48.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=48
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GIC: enabling workaround for GICv3: Cavium erratum 38539
[    0.000000] GICv3: 128 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000801080000000
[    0.000000] ACPI: SRAT not present
[    0.000000] ITS [mem 0x801000020000-0x80100003ffff]
[    0.000000] ITS@0x0000801000020000: Devices Table too large, reduce ids 21->19
[    0.000000] ITS@0x0000801000020000: allocated 524288 Devices @100800000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000100270000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000100280000
[    0.000000] arch_timer: Failed to initialize memory-mapped timer.
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
[    0.000150] Console: colour dummy device 80x25
[    0.000232] ACPI: Core revision 20210105
[    0.000452] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000462] pid_max: default: 49152 minimum: 384
[    0.000575] LSM: Security Framework initializing
[    0.000590] Yama: becoming mindful.
[    0.000650] AppArmor: AppArmor initialized
[    0.000804] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000869] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.001661] ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
[    0.002248] rcu: Hierarchical SRCU implementation.
[    0.002999] Platform MSI: ITS@0x801000020000 domain created
[    0.003014] PCI/MSI: ITS@0x801000020000 domain created
[    0.003024] fsl-mc MSI: ITS@0x801000020000 domain created
[    0.003041] Remapping and enabling EFI services.
[    0.005152] smp: Bringing up secondary CPUs ...
[    0.005634] Detected VIPT I-cache on CPU1
[    0.005649] GICv3: CPU1: found redistributor 1 region 0:0x0000801080020000
[    0.005674] GICv3: CPU1: using allocated LPI pending table @0x0000000100290000
[    0.005694] CPU1: Booted secondary processor 0x0000000001 [0x431f0a11]
[    0.006251] Detected VIPT I-cache on CPU2
[    0.006262] GICv3: CPU2: found redistributor 2 region 0:0x0000801080040000
[    0.006286] GICv3: CPU2: using allocated LPI pending table @0x00000001002a0000
[    0.006305] CPU2: Booted secondary processor 0x0000000002 [0x431f0a11]
[    0.006848] Detected VIPT I-cache on CPU3
[    0.006858] GICv3: CPU3: found redistributor 3 region 0:0x0000801080060000
[    0.006884] GICv3: CPU3: using allocated LPI pending table @0x00000001002b0000
[    0.006903] CPU3: Booted secondary processor 0x0000000003 [0x431f0a11]
[    0.007444] Detected VIPT I-cache on CPU4
[    0.007455] GICv3: CPU4: found redistributor 4 region 0:0x0000801080080000
[    0.007480] GICv3: CPU4: using allocated LPI pending table @0x00000001002c0000
[    0.007500] CPU4: Booted secondary processor 0x0000000004 [0x431f0a11]
[    0.008046] Detected VIPT I-cache on CPU5
[    0.008057] GICv3: CPU5: found redistributor 5 region 0:0x00008010800a0000
[    0.008082] GICv3: CPU5: using allocated LPI pending table @0x00000001002d0000
[    0.008102] CPU5: Booted secondary processor 0x0000000005 [0x431f0a11]
[    0.008639] Detected VIPT I-cache on CPU6
[    0.008650] GICv3: CPU6: found redistributor 6 region 0:0x00008010800c0000
[    0.008677] GICv3: CPU6: using allocated LPI pending table @0x00000001002e0000
[    0.008697] CPU6: Booted secondary processor 0x0000000006 [0x431f0a11]
[    0.009242] Detected VIPT I-cache on CPU7
[    0.009253] GICv3: CPU7: found redistributor 7 region 0:0x00008010800e0000
[    0.009279] GICv3: CPU7: using allocated LPI pending table @0x00000001002f0000
[    0.009299] CPU7: Booted secondary processor 0x0000000007 [0x431f0a11]
[    0.009839] Detected VIPT I-cache on CPU8
[    0.009851] GICv3: CPU8: found redistributor 8 region 0:0x0000801080100000
[    0.009876] GICv3: CPU8: using allocated LPI pending table @0x0000000100300000
[    0.009897] CPU8: Booted secondary processor 0x0000000008 [0x431f0a11]
[    0.010450] Detected VIPT I-cache on CPU9
[    0.010462] GICv3: CPU9: found redistributor 9 region 0:0x0000801080120000
[    0.010487] GICv3: CPU9: using allocated LPI pending table @0x0000000100310000
[    0.010508] CPU9: Booted secondary processor 0x0000000009 [0x431f0a11]
[    0.011054] Detected VIPT I-cache on CPU10
[    0.011066] GICv3: CPU10: found redistributor a region 0:0x0000801080140000
[    0.011091] GICv3: CPU10: using allocated LPI pending table @0x0000000100320000
[    0.011113] CPU10: Booted secondary processor 0x000000000a [0x431f0a11]
[    0.011661] Detected VIPT I-cache on CPU11
[    0.011673] GICv3: CPU11: found redistributor b region 0:0x0000801080160000
[    0.011699] GICv3: CPU11: using allocated LPI pending table @0x0000000100330000
[    0.011721] CPU11: Booted secondary processor 0x000000000b [0x431f0a11]
[    0.012279] Detected VIPT I-cache on CPU12
[    0.012291] GICv3: CPU12: found redistributor c region 0:0x0000801080180000
[    0.012316] GICv3: CPU12: using allocated LPI pending table @0x0000000100340000
[    0.012338] CPU12: Booted secondary processor 0x000000000c [0x431f0a11]
[    0.012901] Detected VIPT I-cache on CPU13
[    0.012914] GICv3: CPU13: found redistributor d region 0:0x00008010801a0000
[    0.012941] GICv3: CPU13: using allocated LPI pending table @0x0000000100350000
[    0.012963] CPU13: Booted secondary processor 0x000000000d [0x431f0a11]
[    0.013511] Detected VIPT I-cache on CPU14
[    0.013524] GICv3: CPU14: found redistributor e region 0:0x00008010801c0000
[    0.013551] GICv3: CPU14: using allocated LPI pending table @0x0000000100360000
[    0.013573] CPU14: Booted secondary processor 0x000000000e [0x431f0a11]
[    0.014123] Detected VIPT I-cache on CPU15
[    0.014136] GICv3: CPU15: found redistributor f region 0:0x00008010801e0000
[    0.014165] GICv3: CPU15: using allocated LPI pending table @0x0000000100370000
[    0.014188] CPU15: Booted secondary processor 0x000000000f [0x431f0a11]
[    0.014732] Detected VIPT I-cache on CPU16
[    0.014745] GICv3: CPU16: found redistributor 100 region 0:0x0000801080200000
[    0.014772] GICv3: CPU16: using allocated LPI pending table @0x0000000100380000
[    0.014795] CPU16: Booted secondary processor 0x0000000100 [0x431f0a11]
[    0.015335] Detected VIPT I-cache on CPU17
[    0.015348] GICv3: CPU17: found redistributor 101 region 0:0x0000801080220000
[    0.015375] GICv3: CPU17: using allocated LPI pending table @0x0000000100390000
[    0.015398] CPU17: Booted secondary processor 0x0000000101 [0x431f0a11]
[    0.015967] Detected VIPT I-cache on CPU18
[    0.015980] GICv3: CPU18: found redistributor 102 region 0:0x0000801080240000
[    0.016007] GICv3: CPU18: using allocated LPI pending table @0x00000001003a0000
[    0.016030] CPU18: Booted secondary processor 0x0000000102 [0x431f0a11]
[    0.016592] Detected VIPT I-cache on CPU19
[    0.016606] GICv3: CPU19: found redistributor 103 region 0:0x0000801080260000
[    0.016634] GICv3: CPU19: using allocated LPI pending table @0x00000001003b0000
[    0.016658] CPU19: Booted secondary processor 0x0000000103 [0x431f0a11]
[    0.017210] Detected VIPT I-cache on CPU20
[    0.017224] GICv3: CPU20: found redistributor 104 region 0:0x0000801080280000
[    0.017252] GICv3: CPU20: using allocated LPI pending table @0x00000001003c0000
[    0.017276] CPU20: Booted secondary processor 0x0000000104 [0x431f0a11]
[    0.017823] Detected VIPT I-cache on CPU21
[    0.017837] GICv3: CPU21: found redistributor 105 region 0:0x00008010802a0000
[    0.017864] GICv3: CPU21: using allocated LPI pending table @0x00000001003d0000
[    0.017889] CPU21: Booted secondary processor 0x0000000105 [0x431f0a11]
[    0.018451] Detected VIPT I-cache on CPU22
[    0.018465] GICv3: CPU22: found redistributor 106 region 0:0x00008010802c0000
[    0.018493] GICv3: CPU22: using allocated LPI pending table @0x00000001003e0000
[    0.018517] CPU22: Booted secondary processor 0x0000000106 [0x431f0a11]
[    0.019081] Detected VIPT I-cache on CPU23
[    0.019095] GICv3: CPU23: found redistributor 107 region 0:0x00008010802e0000
[    0.019124] GICv3: CPU23: using allocated LPI pending table @0x00000001003f0000
[    0.019148] CPU23: Booted secondary processor 0x0000000107 [0x431f0a11]
[    0.019699] Detected VIPT I-cache on CPU24
[    0.019714] GICv3: CPU24: found redistributor 108 region 0:0x0000801080300000
[    0.019741] GICv3: CPU24: using allocated LPI pending table @0x0000000100c00000
[    0.019766] CPU24: Booted secondary processor 0x0000000108 [0x431f0a11]
[    0.020343] Detected VIPT I-cache on CPU25
[    0.020358] GICv3: CPU25: found redistributor 109 region 0:0x0000801080320000
[    0.020386] GICv3: CPU25: using allocated LPI pending table @0x0000000100c10000
[    0.020411] CPU25: Booted secondary processor 0x0000000109 [0x431f0a11]
[    0.020962] Detected VIPT I-cache on CPU26
[    0.020977] GICv3: CPU26: found redistributor 10a region 0:0x0000801080340000
[    0.021005] GICv3: CPU26: using allocated LPI pending table @0x0000000100c20000
[    0.021030] CPU26: Booted secondary processor 0x000000010a [0x431f0a11]
[    0.021598] Detected VIPT I-cache on CPU27
[    0.021613] GICv3: CPU27: found redistributor 10b region 0:0x0000801080360000
[    0.021641] GICv3: CPU27: using allocated LPI pending table @0x0000000100c30000
[    0.021667] CPU27: Booted secondary processor 0x000000010b [0x431f0a11]
[    0.022219] Detected VIPT I-cache on CPU28
[    0.022234] GICv3: CPU28: found redistributor 10c region 0:0x0000801080380000
[    0.022263] GICv3: CPU28: using allocated LPI pending table @0x0000000100c40000
[    0.022288] CPU28: Booted secondary processor 0x000000010c [0x431f0a11]
[    0.022850] Detected VIPT I-cache on CPU29
[    0.022865] GICv3: CPU29: found redistributor 10d region 0:0x00008010803a0000
[    0.022895] GICv3: CPU29: using allocated LPI pending table @0x0000000100c50000
[    0.022921] CPU29: Booted secondary processor 0x000000010d [0x431f0a11]
[    0.023482] Detected VIPT I-cache on CPU30
[    0.023498] GICv3: CPU30: found redistributor 10e region 0:0x00008010803c0000
[    0.023527] GICv3: CPU30: using allocated LPI pending table @0x0000000100c60000
[    0.023553] CPU30: Booted secondary processor 0x000000010e [0x431f0a11]
[    0.024116] Detected VIPT I-cache on CPU31
[    0.024132] GICv3: CPU31: found redistributor 10f region 0:0x00008010803e0000
[    0.024161] GICv3: CPU31: using allocated LPI pending table @0x0000000100c70000
[    0.024188] CPU31: Booted secondary processor 0x000000010f [0x431f0a11]
[    0.024762] Detected VIPT I-cache on CPU32
[    0.024778] GICv3: CPU32: found redistributor 200 region 0:0x0000801080400000
[    0.024806] GICv3: CPU32: using allocated LPI pending table @0x0000000100c80000
[    0.024833] CPU32: Booted secondary processor 0x0000000200 [0x431f0a11]
[    0.025402] Detected VIPT I-cache on CPU33
[    0.025418] GICv3: CPU33: found redistributor 201 region 0:0x0000801080420000
[    0.025447] GICv3: CPU33: using allocated LPI pending table @0x0000000100c90000
[    0.025475] CPU33: Booted secondary processor 0x0000000201 [0x431f0a11]
[    0.026040] Detected VIPT I-cache on CPU34
[    0.026056] GICv3: CPU34: found redistributor 202 region 0:0x0000801080440000
[    0.026086] GICv3: CPU34: using allocated LPI pending table @0x0000000100ca0000
[    0.026113] CPU34: Booted secondary processor 0x0000000202 [0x431f0a11]
[    0.026681] Detected VIPT I-cache on CPU35
[    0.026698] GICv3: CPU35: found redistributor 203 region 0:0x0000801080460000
[    0.026727] GICv3: CPU35: using allocated LPI pending table @0x0000000100cb0000
[    0.026755] CPU35: Booted secondary processor 0x0000000203 [0x431f0a11]
[    0.027317] Detected VIPT I-cache on CPU36
[    0.027334] GICv3: CPU36: found redistributor 204 region 0:0x0000801080480000
[    0.027364] GICv3: CPU36: using allocated LPI pending table @0x0000000100cc0000
[    0.027392] CPU36: Booted secondary processor 0x0000000204 [0x431f0a11]
[    0.027955] Detected VIPT I-cache on CPU37
[    0.027972] GICv3: CPU37: found redistributor 205 region 0:0x00008010804a0000
[    0.028002] GICv3: CPU37: using allocated LPI pending table @0x0000000100cd0000
[    0.028030] CPU37: Booted secondary processor 0x0000000205 [0x431f0a11]
[    0.028609] Detected VIPT I-cache on CPU38
[    0.028626] GICv3: CPU38: found redistributor 206 region 0:0x00008010804c0000
[    0.028656] GICv3: CPU38: using allocated LPI pending table @0x0000000100ce0000
[    0.028684] CPU38: Booted secondary processor 0x0000000206 [0x431f0a11]
[    0.029243] Detected VIPT I-cache on CPU39
[    0.029261] GICv3: CPU39: found redistributor 207 region 0:0x00008010804e0000
[    0.029291] GICv3: CPU39: using allocated LPI pending table @0x0000000100cf0000
[    0.029320] CPU39: Booted secondary processor 0x0000000207 [0x431f0a11]
[    0.029895] Detected VIPT I-cache on CPU40
[    0.029912] GICv3: CPU40: found redistributor 208 region 0:0x0000801080500000
[    0.029942] GICv3: CPU40: using allocated LPI pending table @0x0000000100d00000
[    0.029971] CPU40: Booted secondary processor 0x0000000208 [0x431f0a11]
[    0.030554] Detected VIPT I-cache on CPU41
[    0.030572] GICv3: CPU41: found redistributor 209 region 0:0x0000801080520000
[    0.030603] GICv3: CPU41: using allocated LPI pending table @0x0000000100d10000
[    0.030632] CPU41: Booted secondary processor 0x0000000209 [0x431f0a11]
[    0.031197] Detected VIPT I-cache on CPU42
[    0.031214] GICv3: CPU42: found redistributor 20a region 0:0x0000801080540000
[    0.031245] GICv3: CPU42: using allocated LPI pending table @0x0000000100d20000
[    0.031275] CPU42: Booted secondary processor 0x000000020a [0x431f0a11]
[    0.031853] Detected VIPT I-cache on CPU43
[    0.031871] GICv3: CPU43: found redistributor 20b region 0:0x0000801080560000
[    0.031904] GICv3: CPU43: using allocated LPI pending table @0x0000000100d30000
[    0.031933] CPU43: Booted secondary processor 0x000000020b [0x431f0a11]
[    0.032528] Detected VIPT I-cache on CPU44
[    0.032546] GICv3: CPU44: found redistributor 20c region 0:0x0000801080580000
[    0.032578] GICv3: CPU44: using allocated LPI pending table @0x0000000100d40000
[    0.032607] CPU44: Booted secondary processor 0x000000020c [0x431f0a11]
[    0.033191] Detected VIPT I-cache on CPU45
[    0.033210] GICv3: CPU45: found redistributor 20d region 0:0x00008010805a0000
[    0.033241] GICv3: CPU45: using allocated LPI pending table @0x0000000100d50000
[    0.033271] CPU45: Booted secondary processor 0x000000020d [0x431f0a11]
[    0.033843] Detected VIPT I-cache on CPU46
[    0.033861] GICv3: CPU46: found redistributor 20e region 0:0x00008010805c0000
[    0.033893] GICv3: CPU46: using allocated LPI pending table @0x0000000100d60000
[    0.033924] CPU46: Booted secondary processor 0x000000020e [0x431f0a11]
[    0.034503] Detected VIPT I-cache on CPU47
[    0.034522] GICv3: CPU47: found redistributor 20f region 0:0x00008010805e0000
[    0.034554] GICv3: CPU47: using allocated LPI pending table @0x0000000100d70000
[    0.034584] CPU47: Booted secondary processor 0x000000020f [0x431f0a11]
[    0.034694] smp: Brought up 1 node, 48 CPUs
[    0.034960] SMP: Total of 48 processors activated.
[    0.034966] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.034971] CPU features: detected: CRC32 instructions
[    0.035202] CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
[    0.044471] CPU: All CPU(s) started at EL2
[    0.044630] alternatives: patching kernel code
[    0.058585] devtmpfs: initialized
[    0.078235] Registered cp15_barrier emulation handler
[    0.078260] Registered setend emulation handler
[    0.078268] KASLR disabled due to lack of seed
[    0.078435] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.078504] futex hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.079924] pinctrl core: initialized pinctrl subsystem
[    0.080485] SMBIOS 3.0.0 present.
[    0.080500] DMI: GIGABYTE R120-T33/MT30-GS1, BIOS F02 08/06/2019
[    0.080988] NET: Registered protocol family 16
[    0.082760] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.083231] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.083710] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.083743] audit: initializing netlink subsys (disabled)
[    0.083898] audit: type=2000 audit(0.080:1): state=initialized audit_enabled=0 res=1
[    0.084439] thermal_sys: Registered thermal governor 'fair_share'
[    0.084445] thermal_sys: Registered thermal governor 'bang_bang'
[    0.084450] thermal_sys: Registered thermal governor 'step_wise'
[    0.084454] thermal_sys: Registered thermal governor 'user_space'
[    0.084459] thermal_sys: Registered thermal governor 'power_allocator'
[    0.084640] cpuidle: using governor ladder
[    0.084902] cpuidle: using governor menu
[    0.085048] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.085632] ASID allocator initialised with 65536 entries
[    0.085922] ACPI: bus type PCI registered
[    0.085930] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.086167] Serial: AMBA PL011 UART driver
[    0.096900] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.096908] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.096914] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.096919] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.101966] ACPI: Added _OSI(Module Device)
[    0.101973] ACPI: Added _OSI(Processor Device)
[    0.101978] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.101983] ACPI: Added _OSI(Processor Aggregator Device)
[    0.101988] ACPI: Added _OSI(Linux-Dell-Video)
[    0.101993] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.101998] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.105918] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.107812] ACPI: Interpreter enabled
[    0.107820] ACPI: Using GIC for interrupt routing
[    0.107848] ACPI: MCFG table detected, 4 entries
[    0.131510] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    0.131526] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.131675] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    0.131804] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
[    0.132264] acpi PNP0A08:00: ECAM area [mem 0x848000000000-0x848001ffffff] reserved by CAVA02C:00
[    0.132282] acpi PNP0A08:00: ECAM at [mem 0x848000000000-0x848001ffffff] for [bus 00-1f]
[    0.132438] PCI host bridge to bus 0000:00
[    0.132446] pci_bus 0000:00: root bus resource [mem 0x801000000000-0x807fffffffff window]
[    0.132453] pci_bus 0000:00: root bus resource [mem 0x838000000000-0x841fffffffff window]
[    0.132460] pci_bus 0000:00: root bus resource [mem 0x846000000000-0x847fffffffff window]
[    0.132466] pci_bus 0000:00: root bus resource [mem 0x868000000000-0x87e023ffffff window]
[    0.132472] pci_bus 0000:00: root bus resource [mem 0x87e026000000-0x87e0bfffffff window]
[    0.132479] pci_bus 0000:00: root bus resource [mem 0x87e0c6000000-0x87ffffffffff window]
[    0.132486] pci_bus 0000:00: root bus resource [bus 00-1f]
[    0.132516] pci 0000:00:01.0: [177d:a002] type 01 class 0x060400
[    0.132688] pci 0000:00:09.0: [177d:a018] type 00 class 0x120000
[    0.132723] pci 0000:00:09.0: BAR 0: [mem 0x87e040000000-0x87e0400fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    0.132733] pci 0000:00:09.0: VF BAR 0: [mem 0x840000800000-0x8400008fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.153628] pci 0000:00:09.0: VF(n) BAR0 space: [mem 0x840000800000-0x8400008fffff 64bit] (contains BAR0 for 1 VFs)
[    1.153780] pci 0000:00:10.0: [177d:a01b] type 00 class 0x0c0330
[    1.153817] pci 0000:00:10.0: BAR 0: [mem 0x868000000000-0x8680001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153826] pci 0000:00:10.0: BAR 4: [mem 0x868000200000-0x8680002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153953] pci 0000:00:11.0: [177d:a01b] type 00 class 0x0c0330
[    1.153989] pci 0000:00:11.0: BAR 0: [mem 0x869000000000-0x8690001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153998] pci 0000:00:11.0: BAR 4: [mem 0x869000200000-0x8690002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154123] pci 0000:00:14.0: [177d:a002] type 01 class 0x060400
[    1.154325] pci 0000:01:00.0: [177d:a001] type 00 class 0x088000
[    1.154361] pci 0000:01:00.0: BAR 0: [mem 0x87e0fc000000-0x87e0fc0fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154370] pci 0000:01:00.0: BAR 4: [mem 0x87e0fcf00000-0x87e0fcffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154497] pci 0000:01:00.1: [177d:a00e] type 00 class 0x088000
[    1.154532] pci 0000:01:00.1: BAR 0: [mem 0x87e006000000-0x87e0067fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154541] pci 0000:01:00.1: BAR 4: [mem 0x87e006f00000-0x87e006ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154661] pci 0000:01:01.3: [177d:a02b] type 00 class 0x0c8000
[    1.154696] pci 0000:01:01.3: BAR 0: [mem 0x87e005000000-0x87e0057fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154814] pci 0000:01:01.4: [177d:a010] type 00 class 0x058000
[    1.154853] pci 0000:01:01.4: BAR 0: [mem 0x87e009000000-0x87e0097fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154862] pci 0000:01:01.4: BAR 4: [mem 0x87e009f00000-0x87e009ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154983] pci 0000:01:06.0: [177d:a02e] type 00 class 0x058000
[    1.155020] pci 0000:01:06.0: BAR 0: [mem 0x87e050000000-0x87e0507fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155029] pci 0000:01:06.0: BAR 4: [mem 0x87e050f00000-0x87e050ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155155] pci 0000:01:06.1: [177d:a02e] type 00 class 0x058000
[    1.155191] pci 0000:01:06.1: BAR 0: [mem 0x87e051000000-0x87e0517fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155200] pci 0000:01:06.1: BAR 4: [mem 0x87e051f00000-0x87e051ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155322] pci 0000:01:06.2: [177d:a02e] type 00 class 0x058000
[    1.155357] pci 0000:01:06.2: BAR 0: [mem 0x87e052000000-0x87e0527fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155366] pci 0000:01:06.2: BAR 4: [mem 0x87e052f00000-0x87e052ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155485] pci 0000:01:06.3: [177d:a02e] type 00 class 0x058000
[    1.155521] pci 0000:01:06.3: BAR 0: [mem 0x87e053000000-0x87e0537fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155530] pci 0000:01:06.3: BAR 4: [mem 0x87e053f00000-0x87e053ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155649] pci 0000:01:06.4: [177d:a02e] type 00 class 0x058000
[    1.155685] pci 0000:01:06.4: BAR 0: [mem 0x87e054000000-0x87e0547fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155694] pci 0000:01:06.4: BAR 4: [mem 0x87e054f00000-0x87e054ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155816] pci 0000:01:06.5: [177d:a02e] type 00 class 0x058000
[    1.155852] pci 0000:01:06.5: BAR 0: [mem 0x87e055000000-0x87e0557fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155861] pci 0000:01:06.5: BAR 4: [mem 0x87e055f00000-0x87e055ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155981] pci 0000:01:06.6: [177d:a02e] type 00 class 0x058000
[    1.156016] pci 0000:01:06.6: BAR 0: [mem 0x87e056000000-0x87e0567fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156025] pci 0000:01:06.6: BAR 4: [mem 0x87e056f00000-0x87e056ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156145] pci 0000:01:06.7: [177d:a02e] type 00 class 0x058000
[    1.156184] pci 0000:01:06.7: BAR 0: [mem 0x87e057000000-0x87e0577fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156193] pci 0000:01:06.7: BAR 4: [mem 0x87e057f00000-0x87e057ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156316] pci 0000:01:07.0: [177d:a02f] type 00 class 0x058000
[    1.156352] pci 0000:01:07.0: BAR 0: [mem 0x87e058000000-0x87e0587fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156361] pci 0000:01:07.0: BAR 4: [mem 0x87e058f00000-0x87e058ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156488] pci 0000:01:07.1: [177d:a02f] type 00 class 0x058000
[    1.156524] pci 0000:01:07.1: BAR 0: [mem 0x87e059000000-0x87e0597fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156533] pci 0000:01:07.1: BAR 4: [mem 0x87e059f00000-0x87e059ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156654] pci 0000:01:07.2: [177d:a02f] type 00 class 0x058000
[    1.156689] pci 0000:01:07.2: BAR 0: [mem 0x87e05a000000-0x87e05a7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156698] pci 0000:01:07.2: BAR 4: [mem 0x87e05af00000-0x87e05affffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156821] pci 0000:01:07.3: [177d:a02f] type 00 class 0x058000
[    1.156856] pci 0000:01:07.3: BAR 0: [mem 0x87e05b000000-0x87e05b7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156865] pci 0000:01:07.3: BAR 4: [mem 0x87e05bf00000-0x87e05bffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156985] pci 0000:01:07.4: [177d:a030] type 00 class 0x058000
[    1.157020] pci 0000:01:07.4: BAR 0: [mem 0x87e05c000000-0x87e05c7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157029] pci 0000:01:07.4: BAR 4: [mem 0x87e05cf00000-0x87e05cffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157149] pci 0000:01:07.5: [177d:a030] type 00 class 0x058000
[    1.157185] pci 0000:01:07.5: BAR 0: [mem 0x87e05d000000-0x87e05d7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157194] pci 0000:01:07.5: BAR 4: [mem 0x87e05df00000-0x87e05dffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157316] pci 0000:01:07.6: [177d:a030] type 00 class 0x058000
[    1.157352] pci 0000:01:07.6: BAR 0: [mem 0x87e05e000000-0x87e05e7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157361] pci 0000:01:07.6: BAR 4: [mem 0x87e05ef00000-0x87e05effffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157484] pci 0000:01:07.7: [177d:a030] type 00 class 0x058000
[    1.157532] pci 0000:01:07.7: BAR 0: [mem 0x87e05f000000-0x87e05f7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157542] pci 0000:01:07.7: BAR 4: [mem 0x87e05ff00000-0x87e05fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157677] pci 0000:01:09.2: [177d:a012] type 00 class 0x0c8000
[    1.157714] pci 0000:01:09.2: BAR 0: [mem 0x87e0d2000000-0x87e0d27fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157723] pci 0000:01:09.2: BAR 4: [mem 0x87e0d2f00000-0x87e0d2ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157851] pci 0000:01:09.4: [177d:a012] type 00 class 0x0c8000
[    1.157887] pci 0000:01:09.4: BAR 0: [mem 0x87e0d4000000-0x87e0d47fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157896] pci 0000:01:09.4: BAR 4: [mem 0x87e0d4f00000-0x87e0d4ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158018] pci 0000:01:0a.0: [177d:a022] type 00 class 0x058000
[    1.158055] pci 0000:01:0a.0: BAR 0: [mem 0x87e088000000-0x87e0887fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158064] pci 0000:01:0a.0: BAR 4: [mem 0x87e088f00000-0x87e088ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158186] pci 0000:01:0a.1: [177d:a022] type 00 class 0x058000
[    1.158222] pci 0000:01:0a.1: BAR 0: [mem 0x87e089000000-0x87e0897fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158231] pci 0000:01:0a.1: BAR 4: [mem 0x87e089f00000-0x87e089ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158354] pci 0000:01:10.0: [177d:a026] type 00 class 0x028000
[    1.158389] pci 0000:01:10.0: BAR 0: [mem 0x87e0e0000000-0x87e0e03fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158398] pci 0000:01:10.0: BAR 4: [mem 0x87e0e0400000-0x87e0e07fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158520] pci 0000:01:10.1: [177d:a026] type 00 class 0x028000
[    1.158555] pci 0000:01:10.1: BAR 0: [mem 0x87e0e1000000-0x87e0e13fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158564] pci 0000:01:10.1: BAR 4: [mem 0x87e0e1400000-0x87e0e17fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158675] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    1.158842] pci 0000:02:00.0: [177d:a01d] type 00 class 0x010400
[    1.158880] pci 0000:02:00.0: BAR 0: [mem 0x870000000000-0x8700007fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158890] pci 0000:02:00.0: BAR 4: [mem 0x870000f00000-0x870000ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.159004] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    1.159080] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.159093] pci 0000:00:14.0: PCI bridge to [bus 02]
[    1.159101] pci_bus 0000:00: resource 4 [mem 0x801000000000-0x807fffffffff window]
[    1.159107] pci_bus 0000:00: resource 5 [mem 0x838000000000-0x841fffffffff window]
[    1.159114] pci_bus 0000:00: resource 6 [mem 0x846000000000-0x847fffffffff window]
[    1.159120] pci_bus 0000:00: resource 7 [mem 0x868000000000-0x87e023ffffff window]
[    1.159127] pci_bus 0000:00: resource 8 [mem 0x87e026000000-0x87e0bfffffff window]
[    1.159133] pci_bus 0000:00: resource 9 [mem 0x87e0c6000000-0x87ffffffffff window]
[    1.159289] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 00-1f])
[    1.159302] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.159444] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    1.159573] acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
[    1.160046] acpi PNP0A08:01: ECAM area [mem 0x849000000000-0x849001ffffff] reserved by CAVA02C:01
[    1.160063] acpi PNP0A08:01: ECAM at [mem 0x849000000000-0x849001ffffff] for [bus 00-1f]
[    1.160192] PCI host bridge to bus 0001:00
[    1.160199] pci_bus 0001:00: root bus resource [mem 0x810000000000-0x817fffffffff window]
[    1.160207] pci_bus 0001:00: root bus resource [bus 00-1f]
[    1.160235] pci 0001:00:08.0: [177d:a01c] type 00 class 0x010601
[    1.160268] pci 0001:00:08.0: BAR 0: [mem 0x814000000000-0x8140001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160276] pci 0001:00:08.0: BAR 4: [mem 0x814000200000-0x8140002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160404] pci 0001:00:09.0: [177d:a01c] type 00 class 0x010601
[    1.160443] pci 0001:00:09.0: BAR 0: [mem 0x815000000000-0x8150001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160453] pci 0001:00:09.0: BAR 4: [mem 0x815000200000-0x8150002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160583] pci 0001:00:0a.0: [177d:a01c] type 00 class 0x010601
[    1.160618] pci 0001:00:0a.0: BAR 0: [mem 0x816000000000-0x8160001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160627] pci 0001:00:0a.0: BAR 4: [mem 0x816000200000-0x8160002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160752] pci 0001:00:0b.0: [177d:a01c] type 00 class 0x010601
[    1.160787] pci 0001:00:0b.0: BAR 0: [mem 0x817000000000-0x8170001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160796] pci 0001:00:0b.0: BAR 4: [mem 0x817000200000-0x8170002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160928] pci_bus 0001:00: resource 4 [mem 0x810000000000-0x817fffffffff window]
[    1.161037] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
[    1.161049] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.161189] acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    1.161317] acpi PNP0A08:02: _OSC: OS now controls [PCIeCapability]
[    1.161821] acpi PNP0A08:02: ECAM area [mem 0x84a000000000-0x84a001ffffff] reserved by CAVA02C:02
[    1.161837] acpi PNP0A08:02: ECAM at [mem 0x84a000000000-0x84a001ffffff] for [bus 00-1f]
[    1.161970] PCI host bridge to bus 0002:00
[    1.161977] pci_bus 0002:00: root bus resource [mem 0x842000000000-0x843fffffffff window]
[    1.161985] pci_bus 0002:00: root bus resource [bus 00-1f]
[    1.162008] pci 0002:00:02.0: [177d:a002] type 01 class 0x060400
[    1.162156] pci 0002:00:03.0: [177d:a01f] type 00 class 0x028000
[    1.162191] pci 0002:00:03.0: BAR 0: [mem 0x842000000000-0x84200000ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162200] pci 0002:00:03.0: BAR 2: [mem 0x842040000000-0x84207fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162208] pci 0002:00:03.0: BAR 4: [mem 0x842000f00000-0x842000ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162399] pci 0002:01:00.0: [177d:a01e] type 00 class 0x020000
[    1.162436] pci 0002:01:00.0: BAR 0: [mem 0x843000000000-0x84303fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162445] pci 0002:01:00.0: BAR 4: [mem 0x843060000000-0x8430600fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162453] pci 0002:01:00.0: VF BAR 0: [mem 0x8430a0000000-0x8430a01fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.162462] pci 0002:01:00.0: VF BAR 4: [mem 0x8430e0000000-0x8430e01fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    2.178959] pci 0002:01:00.0: VF(n) BAR0 space: [mem 0x8430a0000000-0x8430afffffff 64bit] (contains BAR0 for 128 VFs)
[    2.178973] pci 0002:01:00.0: VF(n) BAR4 space: [mem 0x8430e0000000-0x8430efffffff 64bit] (contains BAR4 for 128 VFs)
[    2.179182] pci 0002:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.179208] pci 0002:00:02.0: PCI bridge to [bus 01]
[    2.179217] pci_bus 0002:00: resource 4 [mem 0x842000000000-0x843fffffffff window]
[    2.179326] ACPI: PCI Root Bridge [PCI3] (domain 0003 [bus 00-1f])
[    2.179339] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.179483] acpi PNP0A08:03: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    2.179614] acpi PNP0A08:03: _OSC: OS now controls [PCIeCapability]
[    2.180134] acpi PNP0A08:03: ECAM area [mem 0x84b000000000-0x84b001ffffff] reserved by CAVA02C:03
[    2.180150] acpi PNP0A08:03: ECAM at [mem 0x84b000000000-0x84b001ffffff] for [bus 00-1f]
[    2.180280] PCI host bridge to bus 0003:00
[    2.180287] pci_bus 0003:00: root bus resource [mem 0x818000000000-0x81ffffffffff window]
[    2.180295] pci_bus 0003:00: root bus resource [bus 00-1f]
[    2.180329] pci_bus 0003:00: resource 4 [mem 0x818000000000-0x81ffffffffff window]
[    2.180436] ACPI: PCI Root Bridge [PEM0] (domain 0004 [bus 1f-57])
[    2.180448] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.180588] acpi PNP0A08:04: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    2.180717] acpi PNP0A08:04: _OSC: OS now controls [PCIeCapability]
[    2.180726] acpi PNP0A08:04: MCFG quirk: ECAM at [mem 0x88001f000000-0x880057ffffff] for [bus 1f-57] with thunder_pem_ecam_ops
[    2.181277] acpi PNP0A08:04: ECAM area [mem 0x88001f000000-0x880057ffffff] reserved by CAVA02B:00
[    2.181874] acpi PNP0A08:04: ECAM at [mem 0x88001f000000-0x880057ffffff] for [bus 1f-57]
[    2.181909] Remapped I/O 0x0000883000000000 to [io  0x0000-0xffff window]
[    2.182046] PCI host bridge to bus 0004:1f
[    2.182053] pci_bus 0004:1f: root bus resource [io  0x0000-0xffff window]
[    2.182061] pci_bus 0004:1f: root bus resource [mem 0x881010000000-0x881fffffffff window] (bus address [0x10000000-0xfffffffff])
[    2.182069] pci_bus 0004:1f: root bus resource [mem 0x882000000000-0x882fffffffff pref window] (bus address [0x1000000000-0x1fffffffff])
[    2.182076] pci_bus 0004:1f: root bus resource [mem 0x87e0c0000000-0x87e0c0ffffff window]
[    2.182083] pci_bus 0004:1f: root bus resource [bus 1f-57]
[    2.182108] pci 0004:1f:00.0: [177d:a100] type 01 class 0x060400
[    2.182123] pci 0004:1f:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit pref]
[    2.182133] pci 0004:1f:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.182148] pci 0004:1f:00.0: enabling Extended Tags
[    2.182172] pci 0004:1f:00.0: BAR 0: [mem 0x87e0c0f00000-0x87e0c0ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.182344] pci 0004:1f:00.0: Primary bus is hard wired to 0
[    2.182439] pci 0004:20:00.0: [1a03:1150] type 01 class 0x060400
[    2.182488] pci 0004:20:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    2.182498] pci 0004:20:00.0: Max Payload Size set to 128 (was 128, max 128)
[    2.182507] pci 0004:20:00.0: enabling Extended Tags
[    2.182592] pci 0004:20:00.0: supports D1 D2
[    2.182597] pci 0004:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.182768] pci 0004:20:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.182834] pci_bus 0004:21: extended config space not accessible
[    2.182894] pci 0004:21:00.0: [1a03:2000] type 00 class 0x030000
[    2.182915] pci 0004:21:00.0: reg 0x10: [mem 0x881010000000-0x881010ffffff]
[    2.182928] pci 0004:21:00.0: reg 0x14: [mem 0x881011000000-0x88101101ffff]
[    2.182940] pci 0004:21:00.0: reg 0x18: [io  0x0000-0x007f]
[    2.182999] pci 0004:21:00.0: BAR 0: assigned to efifb
[    2.183049] pci 0004:21:00.0: supports D1 D2
[    2.183054] pci 0004:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.183249] pci 0004:1f:00.0: Primary bus is hard wired to 0
[    2.183267] pci 0004:1f:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
[    2.183275] pci 0004:1f:00.0: BAR 6: assigned [mem 0x881011800000-0x88101180ffff pref]
[    2.183283] pci 0004:1f:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    2.183292] pci 0004:20:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
[    2.183298] pci 0004:20:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    2.183306] pci 0004:21:00.0: BAR 0: assigned [mem 0x881010000000-0x881010ffffff]
[    2.183315] pci 0004:21:00.0: BAR 1: assigned [mem 0x881011000000-0x88101101ffff]
[    2.183324] pci 0004:21:00.0: BAR 2: assigned [io  0x1000-0x107f]
[    2.183333] pci 0004:20:00.0: PCI bridge to [bus 21]
[    2.183340] pci 0004:20:00.0:   bridge window [io  0x1000-0x1fff]
[    2.183346] pci 0004:20:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
[    2.183353] pci 0004:1f:00.0: PCI bridge to [bus 20-21]
[    2.183360] pci 0004:1f:00.0:   bridge window [io  0x1000-0x1fff]
[    2.183366] pci 0004:1f:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
[    2.183374] pci_bus 0004:1f: resource 4 [io  0x0000-0xffff window]
[    2.183380] pci_bus 0004:1f: resource 5 [mem 0x881010000000-0x881fffffffff window]
[    2.183386] pci_bus 0004:1f: resource 6 [mem 0x882000000000-0x882fffffffff pref window]
[    2.183392] pci_bus 0004:1f: resource 7 [mem 0x87e0c0000000-0x87e0c0ffffff window]
[    2.183399] pci_bus 0004:20: resource 0 [io  0x1000-0x1fff]
[    2.183405] pci_bus 0004:20: resource 1 [mem 0x881010000000-0x8810117fffff]
[    2.183411] pci_bus 0004:21: resource 0 [io  0x1000-0x1fff]
[    2.183417] pci_bus 0004:21: resource 1 [mem 0x881010000000-0x8810117fffff]
[    2.183529] ACPI: PCI Interrupt Link [LN0A] (IRQs *48)
[    2.183581] ACPI: PCI Interrupt Link [LN0B] (IRQs *49)
[    2.183627] ACPI: PCI Interrupt Link [LN0C] (IRQs *50)
[    2.183674] ACPI: PCI Interrupt Link [LN0D] (IRQs *51)
[    2.183964] ARMH0011:00: ttyAMA0 at MMIO 0x87e024000000 (irq = 21, base_baud = 0) is a SBSA
[    6.381459] printk: console [ttyAMA0] enabled
[    6.389031] ARMH0011:01: ttyAMA1 at MMIO 0x87e025000000 (irq = 22, base_baud = 0) is a SBSA
[    6.403390] iommu: Default domain type: Translated 
[    6.408406] pci 0004:21:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    6.416759] pci 0004:21:00.0: vgaarb: bridge control possible
[    6.422498] pci 0004:21:00.0: vgaarb: setting as boot device (VGA legacy resources not available)
[    6.431360] vgaarb: loaded
[    6.434782] SCSI subsystem initialized
[    6.438664] libata version 3.00 loaded.
[    6.438725] ACPI: bus type USB registered
[    6.442785] usbcore: registered new interface driver usbfs
[    6.448294] usbcore: registered new interface driver hub
[    6.453646] usbcore: registered new device driver usb
[    6.458787] pps_core: LinuxPPS API ver. 1 registered
[    6.463750] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.472880] PTP clock support registered
[    6.477015] EDAC MC: Ver: 3.0.0
[    6.480631] Registered efivars operations
[    6.486471] NetLabel: Initializing
[    6.489874] NetLabel:  domain hash size = 128
[    6.494221] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    6.499910] NetLabel:  unlabeled traffic allowed by default
[    6.506019] clocksource: Switched to clocksource arch_sys_counter
[    6.552176] VFS: Disk quotas dquot_6.6.0
[    6.556156] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    6.563484] AppArmor: AppArmor Filesystem Enabled
[    6.568273] pnp: PnP ACPI init
[    6.571957] system 00:00: [mem 0x848000000000-0x848001ffffff] could not be reserved
[    6.579633] system 00:00: Plug and Play ACPI device, IDs CAVa02c PNP0c02 (active)
[    6.579813] system 00:01: [mem 0x849000000000-0x849001ffffff] could not be reserved
[    6.587483] system 00:01: Plug and Play ACPI device, IDs CAVa02c PNP0c02 (active)
[    6.587663] system 00:02: [mem 0x84a000000000-0x84a001ffffff] could not be reserved
[    6.595333] system 00:02: Plug and Play ACPI device, IDs CAVa02c PNP0c02 (active)
[    6.595513] system 00:03: [mem 0x84b000000000-0x84b001ffffff] could not be reserved
[    6.603185] system 00:03: Plug and Play ACPI device, IDs CAVa02c PNP0c02 (active)
[    6.603373] system 00:04: [mem 0x87e0c0000000-0x87e0c0ffffff] could not be reserved
[    6.611034] system 00:04: [mem 0x88001f000000-0x880057ffffff] could not be reserved
[    6.618694] system 00:04: Plug and Play ACPI device, IDs CAVa02b PNP0c02 (active)
[    6.620919] pnp: PnP ACPI: found 5 devices
[    6.630876] NET: Registered protocol family 2
[    6.636036] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    6.645263] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    6.655124] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    6.662890] TCP: Hash tables configured (established 524288 bind 65536)
[    6.669909] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    6.678126] UDP hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    6.685679] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    6.693858] NET: Registered protocol family 1
[    6.698228] NET: Registered protocol family 44
[    6.702864] PCI: CLS 0 bytes, default 64
[    6.706894] Trying to unpack rootfs image as initramfs...
[    7.711420] Freeing initrd memory: 68180K
[    7.718497] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 7 counters available
[    7.726530] kvm [1]: IPA Size Limit: 48 bits
[    7.732420] kvm [1]: GICv3: no GICV resource entry
[    7.737213] kvm [1]: disabling GICv2 emulation
[    7.741649] kvm [1]: GICv3 sysreg trapping enabled ([G0G1], reduced performance)
[    7.749050] kvm [1]: GIC system register CPU interface enabled
[    7.756017] kvm [1]: vgic interrupt IRQ9
[    7.761141] kvm [1]: Hyp mode initialized successfully
[    7.769051] Initialise system trusted keyrings
[    7.773521] Key type blacklist registered
[    7.777691] workingset: timestamp_bits=40 max_order=24 bucket_order=0
[    7.788417] zbud: loaded
[    7.792124] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.798498] fuse: init (API version 7.33)
[    7.802906] integrity: Platform Keyring initialized
[    7.830790] Key type asymmetric registered
[    7.834887] Asymmetric key parser 'x509' registered
[    7.839775] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    7.847300] io scheduler mq-deadline registered
[    7.855218] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.862764] efifb: probing for efifb
[    7.866372] efifb: No BGRT, not showing boot graphics
[    7.871416] efifb: framebuffer at 0x881010000000, using 3072k, total 3072k
[    7.878282] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    7.884280] efifb: scrolling: redraw
[    7.887845] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    7.893537] fbcon: Deferring console take-over
[    7.897981] fb0: EFI VGA frame buffer device
[    7.902922] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    7.911343] ACPI: button: Power Button [PWRB]
[    7.917165] ACPI GTDT: [Firmware Bug]: failed to get the Watchdog base address.
[    7.928506] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    7.941108] msm_serial: driver initialized
[    7.946004] arm-smmu arm-smmu.0.auto: probing hardware configuration...
[    7.952620] arm-smmu arm-smmu.0.auto: SMMUv2 with:
[    7.957404] arm-smmu arm-smmu.0.auto: 	stage 1 translation
[    7.962880] arm-smmu arm-smmu.0.auto: 	stage 2 translation
[    7.968357] arm-smmu arm-smmu.0.auto: 	nested translation
[    7.973747] arm-smmu arm-smmu.0.auto: 	non-coherent table walk
[    7.979571] arm-smmu arm-smmu.0.auto: 	(IDR0.CTTW overridden by FW configuration)
[    7.987044] arm-smmu arm-smmu.0.auto: 	stream matching with 128 register groups
[    7.994346] arm-smmu arm-smmu.0.auto: 	128 context banks (0 stage-2 only)
[    8.001129] arm-smmu arm-smmu.0.auto: 	enabling workaround for Cavium erratum 27704
[    8.008777] arm-smmu arm-smmu.0.auto: 	Supported page sizes: 0x62215000
[    8.015384] arm-smmu arm-smmu.0.auto: 	Stage-1: 48-bit VA -> 48-bit IPA
[    8.021991] arm-smmu arm-smmu.0.auto: 	Stage-2: 48-bit IPA -> 48-bit PA
[    8.028829] arm-smmu arm-smmu.1.auto: probing hardware configuration...
[    8.035443] arm-smmu arm-smmu.1.auto: SMMUv2 with:
[    8.040228] arm-smmu arm-smmu.1.auto: 	stage 1 translation
[    8.045704] arm-smmu arm-smmu.1.auto: 	stage 2 translation
[    8.051180] arm-smmu arm-smmu.1.auto: 	nested translation
[    8.056571] arm-smmu arm-smmu.1.auto: 	non-coherent table walk
[    8.062396] arm-smmu arm-smmu.1.auto: 	(IDR0.CTTW overridden by FW configuration)
[    8.069871] arm-smmu arm-smmu.1.auto: 	stream matching with 128 register groups
[    8.077181] arm-smmu arm-smmu.1.auto: 	128 context banks (0 stage-2 only)
[    8.083968] arm-smmu arm-smmu.1.auto: 	enabling workaround for Cavium erratum 27704
[    8.091616] arm-smmu arm-smmu.1.auto: 	Supported page sizes: 0x62215000
[    8.098222] arm-smmu arm-smmu.1.auto: 	Stage-1: 48-bit VA -> 48-bit IPA
[    8.104830] arm-smmu arm-smmu.1.auto: 	Stage-2: 48-bit IPA -> 48-bit PA
[    8.111616] arm-smmu arm-smmu.2.auto: probing hardware configuration...
[    8.118232] arm-smmu arm-smmu.2.auto: SMMUv2 with:
[    8.123015] arm-smmu arm-smmu.2.auto: 	stage 1 translation
[    8.128492] arm-smmu arm-smmu.2.auto: 	stage 2 translation
[    8.133969] arm-smmu arm-smmu.2.auto: 	nested translation
[    8.139361] arm-smmu arm-smmu.2.auto: 	non-coherent table walk
[    8.145186] arm-smmu arm-smmu.2.auto: 	(IDR0.CTTW overridden by FW configuration)
[    8.152660] arm-smmu arm-smmu.2.auto: 	stream matching with 128 register groups
[    8.159962] arm-smmu arm-smmu.2.auto: 	128 context banks (0 stage-2 only)
[    8.166748] arm-smmu arm-smmu.2.auto: 	enabling workaround for Cavium erratum 27704
[    8.174398] arm-smmu arm-smmu.2.auto: 	Supported page sizes: 0x62215000
[    8.181004] arm-smmu arm-smmu.2.auto: 	Stage-1: 48-bit VA -> 48-bit IPA
[    8.187610] arm-smmu arm-smmu.2.auto: 	Stage-2: 48-bit IPA -> 48-bit PA
[    8.194389] arm-smmu arm-smmu.3.auto: probing hardware configuration...
[    8.201006] arm-smmu arm-smmu.3.auto: SMMUv2 with:
[    8.205789] arm-smmu arm-smmu.3.auto: 	stage 1 translation
[    8.211268] arm-smmu arm-smmu.3.auto: 	stage 2 translation
[    8.216745] arm-smmu arm-smmu.3.auto: 	nested translation
[    8.222136] arm-smmu arm-smmu.3.auto: 	non-coherent table walk
[    8.227960] arm-smmu arm-smmu.3.auto: 	(IDR0.CTTW overridden by FW configuration)
[    8.235435] arm-smmu arm-smmu.3.auto: 	stream matching with 128 register groups
[    8.242737] arm-smmu arm-smmu.3.auto: 	128 context banks (0 stage-2 only)
[    8.249518] arm-smmu arm-smmu.3.auto: 	enabling workaround for Cavium erratum 27704
[    8.257166] arm-smmu arm-smmu.3.auto: 	Supported page sizes: 0x62215000
[    8.263772] arm-smmu arm-smmu.3.auto: 	Stage-1: 48-bit VA -> 48-bit IPA
[    8.270378] arm-smmu arm-smmu.3.auto: 	Stage-2: 48-bit IPA -> 48-bit PA
[    8.278228] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    8.300471] loop: module loaded
[    8.304862] libphy: Fixed MDIO Bus: probed
[    8.309004] tun: Universal TUN/TAP device driver, 1.6
[    8.314446] PPP generic driver version 2.4.2
[    8.318858] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.325395] ehci-pci: EHCI PCI platform driver
[    8.329877] ehci-orion: EHCI orion driver
[    8.333922] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.340103] ohci-pci: OHCI PCI platform driver
[    8.344581] uhci_hcd: USB Universal Host Controller Interface driver
[    8.351159] mousedev: PS/2 mouse device common for all mice
[    8.557146] rtc-efi rtc-efi.0: registered as rtc0
[    8.661912] rtc-efi rtc-efi.0: setting system clock to 2021-04-21T14:37:38 UTC (1619015858)
[    8.670456] i2c /dev entries driver
[    8.674560] device-mapper: uevent: version 1.0.3
[    8.679352] device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com
[    8.689096] ledtrig-cpu: registered to indicate activity on CPUs
[    8.696877] pstore: Registered efi as persistent store backend
[    8.703575] drop_monitor: Initializing network drop monitor service
[    8.710343] NET: Registered protocol family 10
[    8.737123] Segment Routing with IPv6
[    8.740837] NET: Registered protocol family 17
[    8.745394] Key type dns_resolver registered
[    8.749897] registered taskstats version 1
[    8.754046] Loading compiled-in X.509 certificates
[    8.760576] Loaded X.509 cert 'Build time autogenerated kernel key: b2705ab2481bcbdfae85dcbf8e7e0248227cf5e0'
[    8.772791] zswap: loaded using pool lzo/zbud
[    8.777549] Key type ._fscrypt registered
[    8.781562] Key type .fscrypt registered
[    8.785479] Key type fscrypt-provisioning registered
[    8.790614] pstore: Using crash dump compression: deflate
[    8.806123] Key type encrypted registered
[    8.810138] AppArmor: AppArmor sha1 policy hashing enabled
[    8.816085] ima: No TPM chip found, activating TPM-bypass!
[    8.821581] ima: Allocated hash algorithm: sha1
[    8.826128] ima: No architecture policies found
[    8.830690] evm: Initialising EVM extended attributes:
[    8.835822] evm: security.selinux
[    8.839129] evm: security.SMACK64
[    8.842434] evm: security.SMACK64EXEC
[    8.846087] evm: security.SMACK64TRANSMUTE
[    8.850173] evm: security.SMACK64MMAP
[    8.853823] evm: security.apparmor
[    8.857215] evm: security.ima
[    8.860173] evm: security.capability
[    8.863739] evm: HMAC attrs: 0x1
[    8.867907] pcieport 0000:00:01.0: Adding to iommu group 0
[    8.873929] pcieport 0000:00:14.0: Adding to iommu group 1
[    8.879884] pcieport 0002:00:02.0: Adding to iommu group 2
[    8.885864] pcieport 0004:1f:00.0: Adding to iommu group 3
[    8.891806] PCI Interrupt Link [LN0A] enabled at IRQ 48
[    8.897695] pcieport 0004:20:00.0: Adding to iommu group 4
[    8.909838] Freeing unused kernel memory: 7616K

  -dann
