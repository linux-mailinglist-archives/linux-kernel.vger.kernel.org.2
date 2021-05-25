Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779639044E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhEYOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhEYOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:52:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:51:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621954275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjNOQsEO/65TuQVk1yhlMEaznOxjKZEYZBAvSQqrnFE=;
        b=KVW5DVG1GMWQxv0MC5hWSpTXwkr1BA3UnekJC16U3wWoGVYCZP7XHhfuH8fUbHKjvZzOq9
        4LhSb/+hor4PwZfDVeJQ1CrpVLwzuYbLPv9CzrdgTqzvlu5F6nMBLG4NrrlaBSZs5V9w2O
        xaAjqJlBAzGRjS6VNKXCEV1o9zJ75wrKr0rSLhL/PqfZ5wIbbDC0i0r5Iss5Dary3w8tT7
        SPICk/1qC++YDQu0heYsB0YAKOnENbAok/OIkp/T9rvaQvzHhj/wjf4XNSp45ylBVIW9WP
        Je+YbbxjBGcAn7QgGLWLW6J2xfmkGZbHod9mA5EhcI8jCd6Lb1sY77rrfsLNnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621954275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjNOQsEO/65TuQVk1yhlMEaznOxjKZEYZBAvSQqrnFE=;
        b=xDwyt7i7YV8HzWitOdb/40vYYf40SVzO4lmVxSsd4X6M9z5JpLnxpnKGOmgmHDmWHCgOZb
        LPAr4VddjVTQ/jAA==
To:     imran.f.khan@oracle.com
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de
Subject: Re: [RFC PATCH] x86/apic: Fix BUG due to multiple allocation of legacy vectors.
In-Reply-To: <8e1b9002-aa2c-5314-54f6-d5156703e25d@oracle.com>
References: <20210519233928.2157496-1-imran.f.khan@oracle.com> <8735uhddjw.ffs@nanos.tec.linutronix.de> <8e1b9002-aa2c-5314-54f6-d5156703e25d@oracle.com>
Date:   Tue, 25 May 2021 16:51:14 +0200
Message-ID: <871r9uamu5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imran,

On Mon, May 24 2021 at 13:29, imran f. khan wrote:
> On 20/5/21 6:17 pm, Thomas Gleixner wrote:
> But I tested ML v5.13-rc2 on qemu based x86_64 setup (4 CPUs) and
> observed some difference in system vector assignments depending
> on whether kernel is booted with or without noapic option.

Of course there is a difference.

> Even my current setup that was crashing with in-house 5.4 and 5.8 
> kernels, boots fine if I boot it with noapic option removed from kernel 
> boot parameters.

May I ask the obvious question why the changelog of your patch did not
mention that this happens only with 'noapic' on the kernel command line?

> If kernel is booted with option noapic, the io_apic_irqs
> bitmap is not set by setup_IO_APIC and this happens because 
> skip_ioapic_setup is found as set in this case. But in absence
> of noapic kernel parameters, io_apic_irqs bitmap gets set by
> setup_IO_APIC.

Yes

> Now in case of booting with noapic option, the check "test_bit(isairq, 
> &io_apic_irqs))" in __setup_vector_irq will fail for system vectors
> and __setup_vector_irq will end up returning corresponding irq descriptor.
> This irq descriptor gets assigned in per cpu vector_irq corresponding
> to secondary CPUs.
>
> But the corresponding bitmap in irq_matrix still remains unset,
> because invocation of lapic_assign_system_vectors via native_init_IRQ 
> happens only for boot CPU.

Which is sufficient because system vectors are assigned system wide.

> As a result of this if any of these vectors get allocated for secondary 
> CPUs kernel will hit the BUG condition given in apic_update_vector.

Correct. So you almost decoded the underlying problem.

In absence of IOAPIC all legacy interrupts are routed through the
PIC. The PIC does not support interrupt affinities and the interrupt can
end up on any online CPU. That's why we need to treat the PIC interrupts
special.

The problem is that lapic_assign_legacy_vector() is _NOT_ invoked for
any interrupt except PIC_CASCADE_IRQ if the IOAPIC is disabled.

So with your patch you work around that, but that falls flat on it's
nose when the IO/APIC is enabled and one of the legacy interrupts is in
PIC mode, e.g. IRQ0. If that happens then bit 0 is not set in
io_apic_irqs _AND_ the interrupt is correctly marked as system vector
already. So marking it again via irq_matrix_assign() will explode
in the matrix allocator.

So the right thing to do is to ensure that the legacy interrupts are
marked as system vectors in case that the IO/APIC is disabled via
config, kernel command line or lack of enumeration. See below.

Thanks,

        tglx
---
Subject: x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 25 May 2021 13:08:41 +0200

PIC interrupts do not support affinity setting and they can end up on any
online CPU. Therefore it's required to mark the associated vectors as
system wide reserved. Otherwise the corresponding irq descriptors are
copied to the secondary CPUs but the vectors are not marked as assigned or
reserved. This works correctly for the IO/APIC case.

When the IO/APIC is disabled via config, kernel command line or lack of
enumeration then all legacy interrupts are routed through the PIC, but
nothing marks them as system wide reserved vectors.

As a consequence a subsequent allocation on a secondary CPU can result in
allocating one on these vectors, which triggers the BUG() in
apic_update_vector() because the interrupt descriptor slot is not empty.

Imran tried to work around that by marking those interrupts as allocated
when a CPU comes online. But that's wrong in case that the IO/APIC is
available and one of the legacy interrupts, e.g. IRQ0, has been switched to
PIC mode because then marking them as allocated will fail as they are
already marked as system vectors.

Stay consistent and update the legacy vectors after attempting IO/APIC
initialization and mark them as system vectors in case that no IO/APIC is
available.

Reported-by: Imran Khan <imran.f.khan@oracle.com>
Fixes: 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/apic.h   |    1 +
 arch/x86/kernel/apic/apic.c   |    1 +
 arch/x86/kernel/apic/vector.c |   20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -174,6 +174,7 @@ static inline int apic_is_clustered_box(
 extern int setup_APIC_eilvt(u8 lvt_off, u8 vector, u8 msg_type, u8 mask);
 extern void lapic_assign_system_vectors(void);
 extern void lapic_assign_legacy_vector(unsigned int isairq, bool replace);
+extern void lapic_update_legacy_vectors(void);
 extern void lapic_online(void);
 extern void lapic_offline(void);
 extern bool apic_needs_pit(void);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2604,6 +2604,7 @@ static void __init apic_bsp_setup(bool u
 	end_local_APIC_setup();
 	irq_remap_enable_fault_handling();
 	setup_IO_APIC();
+	lapic_update_legacy_vectors();
 }
 
 #ifdef CONFIG_UP_LATE_INIT
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -738,6 +738,26 @@ void lapic_assign_legacy_vector(unsigned
 	irq_matrix_assign_system(vector_matrix, ISA_IRQ_VECTOR(irq), replace);
 }
 
+void __init lapic_update_legacy_vectors(void)
+{
+	unsigned int i;
+
+	if (IS_ENABLED(CONFIG_X86_IO_APIC) && nr_ioapics > 0)
+		return;
+
+	/*
+	 * If the IO/APIC is disabled via config, kernel command line or
+	 * lack of enumeration then all legacy interrupts are routed
+	 * through the PIC. Make sure that they are marked as legacy
+	 * vectors. PIC_CASCADE_IRQ has already been marked in
+	 * lapic_assign_system_vectors().
+	 */
+	for (i = 0; i < nr_legacy_irqs(); i++) {
+		if (i != PIC_CASCADE_IR)
+			lapic_assign_legacy_vector(i, true);
+	}
+}
+
 void __init lapic_assign_system_vectors(void)
 {
 	unsigned int i, vector = 0;
