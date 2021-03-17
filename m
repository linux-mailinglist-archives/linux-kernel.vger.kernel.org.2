Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7069433FB85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQWxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:53:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCQWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:53:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616021578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wU0Jael/CNV4tXTlJR46qmg+N9P8Tz/iRksWFaPvY94=;
        b=NZXz60Uv1bvXXo75ETg88M1YcTmg5A4hwFCt/AFRxFZRldPLoGsu0cMPwEI5q3mFiz2fph
        p1xFfPYuF/uZWer2vY4aGyDh8AP5iUD6Lu0NNBrwUjpauZ5/khwhZVr9Kv2tt/z1AqVZNE
        himXErOsqbFBn/U+FnYcxMm9JVGlsp0FozvXspJEWOIoOmt4n+IRJTuQXNw5qoicUEbh/T
        G8oM6yYzC7fxm878gCEnJGwuycYk9iBKKIzx3IAzCLJS7itTnlukqZ4c0MdLztoLYKXC5L
        tShc5SVOWNmkMf7p3USD9sXaGaasvcmXudGNthKiYr5nhZpzjx67D1T4MF5HBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616021578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wU0Jael/CNV4tXTlJR46qmg+N9P8Tz/iRksWFaPvY94=;
        b=rsiW0PzVEi4TsivN9I0kn+CuusXzRL3IRF5W9xk5MV7zGSKZkEso6CtiI6OUEyui+FR2XG
        DUch1ksCsY9STIDQ==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <878s6lxxuq.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-2-vkuznets@redhat.com> <87im5py1ty.fsf@nanos.tec.linutronix.de> <87blbhxyvk.fsf@nanos.tec.linutronix.de> <878s6lxxuq.fsf@nanos.tec.linutronix.de>
Date:   Wed, 17 Mar 2021 23:52:58 +0100
Message-ID: <874kh9xuid.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 22:40, Thomas Gleixner wrote:
> af174783b925 ("x86: I/O APIC: Never configure IRQ2")
>
> has a very nice explanation why.
>
> Back then the logic was quite different. All legacy PIC interrupts
> (0-15) were bound to the legacy vectors at boot and never moved away.
>
> There was a check in the back then setup routing which prevented the
> IOAPIC routing of IRQ2 which got lost at some point. Haven't figured out
> yet where this might be. Still digging in those ancient horrors.

So the commit in question is:

  d32932d02e18 ("x86/irq: Convert IOAPIC to use hierarchical irqdomain interfaces")

For almost 6 years nobody complained about this wreckage, which might
indicate that we could lift this requirement, but OTOH for any system
which actually has a PIC IRQ2 is unusable by design.

And my history based paranoia vs. these kind of changes just makes me
tend to the safe side, so restoring the original behaviour makes more
sense than just papering over it.

Just to be clear: The reservation of PIC pin2 (aka. IRQ2) as a permanent
system vector cannot go away for any system which has a PIC. If that
ever fires then the PIC is hosed and you really want the warning about
the unhandled vector which is easy to identify because it is fixed.

You might think that's not relevant for modern CPUs where the PIC is
emulated, but I've dealt with reports where that emulation goes south so
I rather keep those sanity checks around as long as that legacy mess is
relevant. No idea why it still exists, but that's a different story.

Thanks,

        tglx
---
Subject: x86/ioapic: Ignore IRQ2 again
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 17 Mar 2021 23:10:02 +0100

Why did I have to do the archaeology?

< INSERT PROPER CHANGELOG >

Fixes: d32932d02e18 ("x86/irq: Convert IOAPIC to use hierarchical irqdomain interfaces")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1032,6 +1032,16 @@ static int mp_map_pin_to_irq(u32 gsi, in
 	if (idx >= 0 && test_bit(mp_irqs[idx].srcbus, mp_bus_not_pci)) {
 		irq = mp_irqs[idx].srcbusirq;
 		legacy = mp_is_legacy_irq(irq);
+		/*
+		 * IRQ2 is unusable for historical reasons on systems which
+		 * have a legacy PIC. See the comment vs. IRQ2 further down.
+		 *
+		 * If this gets removed at some point then the related code
+		 * in lapic_assign_system_vectors() needs to be adjusted as
+		 * well.
+		 */
+		if (legacy && irq == PIC_CASCADE_IR)
+			return -EINVAL;
 	}
 
 	mutex_lock(&ioapic_mutex);
