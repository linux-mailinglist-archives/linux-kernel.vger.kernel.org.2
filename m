Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12853EC5CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHNW0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:26:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0308D31B;
        Sat, 14 Aug 2021 15:26:14 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517FB3F70D;
        Sat, 14 Aug 2021 15:26:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <20210814194737.GA3951530@roeck-us.net>
References: <20210814194737.GA3951530@roeck-us.net>
Date:   Sat, 14 Aug 2021 23:26:07 +0100
Message-ID: <87sfzb7jeo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/08/21 12:47, Guenter Roeck wrote:
> On Tue, Jun 29, 2021 at 01:50:09PM +0100, Valentin Schneider wrote:
>> Now that the proper infrastructure is in place, convert the irq-gic chip to
>> use handle_strict_flow_irq() along with IRQCHIP_AUTOMASKS_FLOW.
>> 
>> For EOImode=1, the Priority Drop is moved from gic_handle_irq() into
>> chip->irq_ack(). This effectively pushes the EOI write down into
>> ->handle_irq(), but doesn't change its ordering wrt the irqaction
>> handling.
>> 
>> The EOImode=1 irqchip also gains IRQCHIP_EOI_THREADED, which allows the
>> ->irq_eoi() call to be deferred to the tail of ONESHOT IRQ threads. This
>> means a threaded ONESHOT IRQ can now be handled entirely without a single
>> chip->irq_mask() call.
>> 
>> EOImode=0 handling remains unchanged.
>> 
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: https://lore.kernel.org/r/20210629125010.458872-13-valentin.schneider@arm.com
>> ---
>
> This patch results in a variety of crashes in -next.
>

Thanks for testing & reporting.

> Example:
>
> [    0.025729] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    0.025811] pgd = (ptrval)
> [    0.026029] [00000000] *pgd=00000000
> [    0.027301] Internal error: Oops: 80000005 [#1] SMP ARM
> [    0.027650] Modules linked in:
> [    0.027986] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-rc5-next-20210813 #1
> [    0.028162] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [    0.028311] PC is at 0x0
> [    0.028485] LR is at handle_strict_flow_irq+0xc8/0x2b8
> [    0.028538] pc : [<00000000>]    lr : [<c01a59c4>]    psr: 400001d3
> [    0.028566] sp : c1701e60  ip : c17097cc  fp : 00000050
> [    0.028594] r10: c1700000  r9 : 00000057  r8 : c2012400
> [    0.028641] r7 : 00000000  r6 : c1711268  r5 : c2083c6c  r4 : c2083c00
> [    0.028674] r3 : 00000000  r2 : 00000000  r1 : 0a728000  r0 : c2083c18
> [    0.028766] Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [    0.028821] Control: 10c5387d  Table: 8000406a  DAC: 00000051
> [    0.028881] Register r0 information: slab kmalloc-512 start c2083c00 pointer offset 24 size 512
> [    0.029482] Register r1 information: non-paged memory
> [    0.029649] Register r2 information: NULL pointer
> [    0.029672] Register r3 information: NULL pointer
> [    0.029692] Register r4 information: slab kmalloc-512 start c2083c00 pointer offset 0 size 512
> [    0.029752] Register r5 information: slab kmalloc-512 start c2083c00 pointer offset 108 size 512
> [    0.029809] Register r6 information: non-slab/vmalloc memory
> [    0.029876] Register r7 information: NULL pointer
> [    0.029897] Register r8 information: slab kmalloc-1k start c2012400 pointer offset 0 size 1024
> [    0.029958] Register r9 information: non-paged memory
> [    0.029980] Register r10 information: non-slab/vmalloc memory
> [    0.030002] Register r11 information: non-paged memory
> [    0.030023] Register r12 information: non-slab/vmalloc memory
> [    0.030064] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
> [    0.030167] Stack: (0xc1701e60 to 0xc1702000)
> [    0.030562] 1e60: c168fcd8 c1700000 c17097cc c019fa2c c1709a44 d080c00c c168fcfc c1700000
> [    0.030754] 1e80: c17097cc c1701eb8 c1700000 c076fe04 c1700000 600000d3 c0824188 80000053
> [    0.030924] 1ea0: ffffffff c1701eec 00000000 c1700000 c1700000 c0100b70 c2013400 c20a0000
> [    0.031096] 1ec0: 00000050 00000000 c20a00a0 c07c0ad4 00000910 c2013400 00000000 c20a0000
> [    0.031267] 1ee0: c1700000 00000050 00000000 c1701f08 c0824188 c0824188 80000053 ffffffff
> [    0.031439] 1f00: 00000051 00000000 00000000 c168f31c c17097cc c2013400 c2013708 3123ccba
> [    0.031614] 1f20: 00000001 c2013400 00000960 c20a0000 c1422958 c1709380 c16804d8 c1646020
> [    0.031790] 1f40: c14d1eec c082626c c1f6f4e0 c2013400 00000000 c1422958 c1709380 c16461d4
> [    0.031961] 1f60: 00000000 00000000 00000000 c0f7d3a4 c186fdcc c1700000 c17093cc c16804d8
> [    0.032155] 1f80: c18f8e20 c160fe80 c1903000 c1663a80 00000012 c1700000 c1709380 00000000
> [    0.032327] 1fa0: c170caf0 c1600e50 ffffffff ffffffff 00000000 c1600588 00000000 c1700000
> [    0.032500] 1fc0: 00000000 c1663a80 3126c2ba 00000000 00000000 c1600330 00000051 10c0387d
> [    0.032671] 1fe0: ffffffff 8833b000 410fc075 10c5387d 00000000 00000000 00000000 00000000
> [    0.032889] [<c01a59c4>] (handle_strict_flow_irq) from [<c019fa2c>] (handle_domain_irq+0x64/0xa4)
> [    0.033027] [<c019fa2c>] (handle_domain_irq) from [<c076fe04>] (gic_handle_irq+0x84/0xbc)
> [    0.033076] [<c076fe04>] (gic_handle_irq) from [<c0100b70>] (__irq_svc+0x70/0x98)
> [    0.033140] Exception stack(0xc1701eb8 to 0xc1701f00)
> [    0.033204] 1ea0:                                                       c2013400 c20a0000
> [    0.033377] 1ec0: 00000050 00000000 c20a00a0 c07c0ad4 00000910 c2013400 00000000 c20a0000
> [    0.033551] 1ee0: c1700000 00000050 00000000 c1701f08 c0824188 c0824188 80000053 ffffffff
> [    0.033596] [<c0100b70>] (__irq_svc) from [<c0824188>] (do_update_region+0x108/0x19c)
> [    0.033652] [<c0824188>] (do_update_region) from [<c082626c>] (csi_J+0xf0/0x290)
> [    0.033685] [<c082626c>] (csi_J) from [<c16461d4>] (con_init+0x1b4/0x248)
> [    0.033726] [<c16461d4>] (con_init) from [<c160fe80>] (console_init+0x21c/0x330)
> [    0.033760] [<c160fe80>] (console_init) from [<c1600e50>] (start_kernel+0x508/0x6d4)
> [    0.033797] [<c1600e50>] (start_kernel) from [<00000000>] (0x0)
> [    0.034079] Code: bad PC value
> [    0.034726] ---[ end trace c1324fc4facef313 ]---
> [    0.035004] Kernel panic - not syncing: Fatal exception in interrupt
>
> https://kerneltests.org/builders/qemu-arm-v7-next/builds/66 provides
> a more detailed log.
>
> Reverting this patch fixes the problem.
>

Passing the stacktrace through scripts/decode_stracktrace.sh would help by
giving line numbers - that said I'm pretty sure this is caused by the
flow-handler now issuing a chip->irq_ack(), and this has an irqchip that
doesn't have one.

The hardware name points me at arch/arm/mach-imx/mach-imx6ul.c, but I can't
figure out an actual devicetree/irqchip layout from this.

Ah, with some more grepping I did find arch/arm/mach-imx/gpc.c, and bingo,
no .irq_ack().

Now, the above makes me feel like this is the start of a wild goose chase
for irqchips in a similar situation. I'm tempted to apply a dumb

  .irq_ack = irq_chip_ack_parent

to all irqchips without one specified. Let's see how bad this gets, does
the below help?

---
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index ebc4339b8be4..a4e10daa3ae7 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -158,6 +158,7 @@ static void imx_gpc_irq_mask(struct irq_data *d)
 
 static struct irq_chip imx_gpc_chip = {
 	.name			= "GPC",
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= imx_gpc_irq_mask,
 	.irq_unmask		= imx_gpc_irq_unmask,
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 5b5a365dbd5e..e304c80cd403 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -126,6 +126,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
 
 static struct irq_chip gpcv2_irqchip_data_chip = {
 	.name			= "GPCv2",
+	.irq_ack                = irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= imx_gpcv2_irq_mask,
 	.irq_unmask		= imx_gpcv2_irq_unmask,
