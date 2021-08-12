Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15563EA679
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhHLOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:43704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233282AbhHLOXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:23:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4031042;
        Thu, 12 Aug 2021 07:22:56 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7663F70D;
        Thu, 12 Aug 2021 07:22:55 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: Fix priority comparison when non-secure
 priorities are used
To:     Marc Zyngier <maz@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210811171505.1502090-1-wenst@chromium.org>
 <87fsvfal4n.wl-maz@kernel.org> <79eabae1-e4a3-7a12-7aa0-3680569584e5@arm.com>
 <871r6yajy7.wl-maz@kernel.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <061bafb6-b0fe-bd7c-1567-a642d3ddd4a5@arm.com>
Date:   Thu, 12 Aug 2021 15:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <871r6yajy7.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 8/12/21 2:09 PM, Marc Zyngier wrote:
> On Thu, 12 Aug 2021 12:51:34 +0100,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>> Hi,
>>
>> After re-familiarizing myself with the spec, it starting to look to
>> me like indeed there's something not quite right (read as: totally
>> broken) with my patch.
>>
>> Arm IHI 0069F, the pseudocode for reading ICC_RPR_EL1 (page 11-797),
>> says that the priority returned is unchanged if SCTLR_EL3.FIQ ==
>> 0.
> Sure, but look at what ICC_RPR_EL1 does for FIQ==1:
>
> <quote>
> if HaveEL(EL3) && !IsSecure() && SCR_EL3.FIQ == '1' then
>     // A Non-secure GIC access and Group 0 inaccessible to Non-secure.
>         if pPriority<7> == '0' then
> 	    // Priority is in Secure half and not visible to Non-secure
> 	    Priority = Zeros();
>         elsif !IsOnes(pPriority) then
> 	    // Non-secure access and not idle, so physical priority must be shifted
>             pPriority<7:0> = (pPriority AND PRIMask())<6:0>:'0';
>
> return ZeroExtend(pPriority);
> </quote>
>
> See how the the priority is shifted *left* (bits [6:0] end up in
> [7:1])?

Yes, when SCR_EL3.FIQ=1, but gic_nonsecure_priorities is enabled when
SCR_EL3.FIQ=0 (gic_has_group0()). In that case ICC_RPR_EL1 returns (what I assume
to be) the highest priority interrupt from ICC_AP0R_EL1, ICC_AP1R_EL1NS and
ICC_AP1R_EL1S. Isn't that the secure view (or Distributor value) of the priority?

>
>> This means that the ICC_RPR_EL1 read will return the secure view
>> (the value as it is stored by the GIC) of the priority, so for
>> pseudo-nmis it will return (GICD_INT_NMI_PRI >> 1) | 0x80, which
>> definitely != GICD_INT_NMI_PRI.
> That's not my reading of the pseudocode.
>
>> This is further confirmed by this statement on page 4-67:
>>
>> "When GICD_CTLR.DS == 0, [..] For Non-secure access to ICC_PMR_EL1
>> and ICC_RPR_EL1 when SCR_EL3.FIQ == 0: The Secure, unshifted view
>> applies."
>>
>> I don't know how I missed that during testing.
>>
>> Did a quick test on the model with PMU NMIs (GICD_CTRL.DS = 0,
>> SCTLR_EL2.FIQ = 0), gic_handle_nmi() was not being called at all,
> 0? Really????

Yes, I was also very surprised myself, I was certain that I tested my patch on the
model with PMU NMIs. Here's what I did to get this result, I would very much
appreciate anyone pointing out what I did wrong here.

$ git diff
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..749748df2466 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -623,6 +623,8 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
        bool irqs_enabled = interrupts_enabled(regs);
        int err;
 
+       panic("Pseudo-NMI");
+
        if (irqs_enabled)
                nmi_enter();
 
@@ -1654,8 +1656,10 @@ static void gic_enable_nmi_support(void)
         * be in the non-secure range, we use a different PMR value to mask IRQs
         * and the rest of the values that we use remain unchanged.
         */
-       if (gic_has_group0() && !gic_dist_security_disabled())
+       if (gic_has_group0() && !gic_dist_security_disabled()) {
+               pr_info("enabling gic_nonsecure_priorities");
                static_branch_enable(&gic_nonsecure_priorities);
+       }
 
        static_branch_enable(&supports_pseudo_nmis);
 
And a truncated log for FVP:

Boot-wrapper v0.2

[..]
[    0.000000] Kernel command line: earlycon=pl011,0x1c090000 console=ttyAMA0
kpti=off root=/dev/vda irqchip.gicv3_pseudo_nmi=1
[..]
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
[    0.000000] GICv3: enabling gic_nonsecure_priorities
[..]
[    0.037784] armv8-pmu pmu: hw perfevents: no interrupt-affinity property, guessing.
[    0.037901] hw perfevents: enabled with armv8_pmuv3 PMU driver, 9 counters
available, using NMIs
[..]
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3      
  9:          0          0          0          0     GICv3  25 Level     vgic
 11:          0          0          0          0     GICv3  30 Level     kvm guest
ptimer
 12:          0          0          0          0     GICv3  27 Level     kvm guest
vtimer
 13:         83         77         69         88     GICv3  26 Level     arch_timer
 16:          0          0          0          0     GICv3  92 Level     arm-pmu
 17:          0          0          0          0     GICv3  93 Level     arm-pmu
 18:          0          0          0          0     GICv3  94 Level     arm-pmu
 19:          0          0          0          0     GICv3  95 Level     arm-pmu
 22:          0          0          0          0     GICv3  47 Level     eth0
 24:         33          0          0          0     GICv3  37 Level     uart-pl011
 29:          0          0          0          0     GICv3  36 Level     rtc-pl031
 31:        138          0          0          0     GICv3  74 Level     virtio0
IPI0:       251        334        252        172       Rescheduling interrupts
IPI1:        26         23         10         20       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump)
interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
# perf record -a -- sleep 5

^C[ perf record: Woken up 1 times to write data ]
[    6.908820] random: perf: uninitialized urandom read (6 bytes read)

[    7.596139] random: perf: uninitialized urandom read (6 bytes read)
[ perf record: Captured and wrote 0.013 MB perf.data (24 samples) ]

#
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3      
  9:          0          0          0          0     GICv3  25 Level     vgic
 11:          0          0          0          0     GICv3  30 Level     kvm guest
ptimer
 12:          0          0          0          0     GICv3  27 Level     kvm guest
vtimer
 13:        546        115         82        132     GICv3  26 Level     arch_timer
 16:          6          0          0          0     GICv3  92 Level     arm-pmu
 17:          0         10          0          0     GICv3  93 Level     arm-pmu
 18:          0          0          4          0     GICv3  94 Level     arm-pmu
 19:          0          0          0          4     GICv3  95 Level     arm-pmu
 22:          0          0          0          0     GICv3  47 Level     eth0
 24:         80          0          0          0     GICv3  37 Level     uart-pl011
 29:          0          0          0          0     GICv3  36 Level     rtc-pl031
 31:        195          0          0          0     GICv3  74 Level     virtio0
IPI0:       259        367        263        224       Rescheduling interrupts
IPI1:        27         51         16         24       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump)
interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
#

With this change to the driver:

$ git diff
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..e58e62ab64fe 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -623,6 +623,8 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
        bool irqs_enabled = interrupts_enabled(regs);
        int err;
 
+       panic("Pseudo-NMI");
+
        if (irqs_enabled)
                nmi_enter();
 
@@ -687,7 +689,7 @@ static asmlinkage void __exception_irq_entry
gic_handle_irq(struct pt_regs *regs
                return;
 
        if (gic_supports_nmi() &&
-           unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+           unlikely(gic_read_rpr() == ((GICD_INT_NMI_PRI >> 1) | 0x80))) {
                gic_handle_nmi(irqnr, regs);
                return;
        }
@@ -1654,8 +1656,10 @@ static void gic_enable_nmi_support(void)
         * be in the non-secure range, we use a different PMR value to mask IRQs
         * and the rest of the values that we use remain unchanged.
         */
-       if (gic_has_group0() && !gic_dist_security_disabled())
+       if (gic_has_group0() && !gic_dist_security_disabled()) {
+               pr_info("enabling gic_nonsecure_priorities");
                static_branch_enable(&gic_nonsecure_priorities);
+       }
 
        static_branch_enable(&supports_pseudo_nmis);
 

This is what I get from FVP (also truncated):

Boot-wrapper v0.2

[..]
[    0.000000] Kernel command line: earlycon=pl011,0x1c090000 console=ttyAMA0
kpti=off root=/dev/vda irqchip.gicv3_pseudo_nmi=1
[..]
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
[    0.000000] GICv3: enabling gic_nonsecure_priorities
[..]
[    0.037749] armv8-pmu pmu: hw perfevents: no interrupt-affinity property, guessing.
[    0.037860] hw perfevents: enabled with armv8_pmuv3 PMU driver, 9 counters
available, using NMIs
[..]
# perf record -a -- sleep 10
[    3.556669] Kernel panic - not syncing: Pseudo-NMI
[    3.556676] CPU: 0 PID: 145 Comm: perf Not tainted 5.14.0-rc5-dirty #23
[    3.556690] Hardware name: FVP Base (DT)
[    3.556692] Call trace:
[    3.556700]  dump_backtrace+0x0/0x19c
[    3.556710]  show_stack+0x1c/0x70
[    3.556725]  dump_stack_lvl+0x68/0x84
[    3.556729]  dump_stack+0x1c/0x38
[    3.556741]  panic+0x16c/0x340
[    3.556750]  gic_handle_irq+0x178/0x1a4
[    3.556760]  call_on_irq_stack+0x2c/0x58
[    3.556776]  do_interrupt_handler+0x54/0x60
[    3.556791]  el1_interrupt+0x30/0xa0
[    3.556800]  el1h_64_irq_handler+0x1c/0x2c
[    3.556809]  el1h_64_irq+0x78/0x7c
[    3.556819]  do_vfs_ioctl+0x90/0xd30
[    3.556830]  __arm64_sys_ioctl+0x88/0xf0
[    3.556842]  invoke_syscall+0x48/0x114
[    3.556849]  el0_svc_common+0x48/0x17c
[    3.556859]  do_el0_svc+0x2c/0x94
[    3.556873]  el0_svc+0x2c/0x5c
[    3.556879]  el0t_64_sync_handler+0xa8/0x130
[    3.556889]  el0t_64_sync+0x198/0x19c
[    3.556907] SMP: stopping secondary CPUs
[    3.556919] Kernel Offset: 0x57c5cb480000 from 0xffff800010000000
[    3.556922] PHYS_OFFSET: 0xffffebb580000000
[    3.556930] CPU features: 0x000000c1,ff3d4eef
[    3.556940] Memory Limit: none
[    3.556949] ---[ end Kernel panic - not syncing: Pseudo-NMI ]---

>
>> but when I changed the comparison to gic_read_rpr() ==
>> ((GICD_INT_NMI_PRI >> 1) | 0x80), NMIs were being correctly handled
>> again.
> You have completely lost me. This contradicts what you have written
> above.

I don't see how that is the case - ICC_RPR_EL1 contains the priority value as seen
by the Distributor, and non-secure priorities get right-shifted when
SCR_EL3.FIQ=0, meaning that GICD_INT_NMI_PRI becomes (GICD_INT_NMI_PRI >> 1) |
0x80 in the Distributor. Can you elaborate where I'm contradicting myself?

Thanks,

Alex

