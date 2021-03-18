Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F695340127
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhCRIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhCRIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616057234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1ZUXseVPifFMGG6XiKUXKZPm0NoNYRG7To9b3mwF/E=;
        b=Zju6pZHqw8Xt5wqOf8H9BND54ExxGzqHOmxwsImsYgUgOKFKsnmNNTWl2sWbUzq1iqz665
        NVV33nLH/o8B5wris5lYucxy0O45wgWReMRuZDQPMOGx8q5fknYZZ0ZTPn8xRQzYMhKI+V
        HMojLqybCKx/VjT562B1GI3n2pnug5E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-KvFyQkLtMIekND_VY4sdag-1; Thu, 18 Mar 2021 04:47:12 -0400
X-MC-Unique: KvFyQkLtMIekND_VY4sdag-1
Received: by mail-ed1-f72.google.com with SMTP id n20so20922133edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=M1ZUXseVPifFMGG6XiKUXKZPm0NoNYRG7To9b3mwF/E=;
        b=JSGlYqSQECmxCLEIWFlqhQLgcp+YwAhTk5LDW4rUAzeOFc9B6/5pebJanEpLqqQkZV
         cUp6qgl+hTVZKqLvkLhZzg+XgHbg3+R07OazZ9lGhAh2VyoflAJjc1E2lgGzlltpVLeh
         RjqNOHs24XomV0BZaydWtI3cizTDEjMnr4DPggiu21vTqSCAq9g4J/y0zu63W230eU1L
         4BYIkJ31FY4HmAmIqLsDIYe35B3oaVUn5wcvI+nbl4X6nsUPOA3Bn5q64MydJIg6pfHX
         LJATPII8gcxeXnXnew7QRl4jIGLDG+7BNBVG56VBAo1/r1uwWP2IGsutWVBawdhUW39R
         F5rA==
X-Gm-Message-State: AOAM530ZYcpc7vkVd01buTyuHznzDSSl/EFjmDjuiuqZHnRNmaBKZWEs
        teIrVPCjjBM17MHVixOP8CvPLqeOMKeozPNRMbYnqdRcNBuJcjAf4XyWxpDGypPTRtr2IWLgZiW
        qLqxasnj/8v+/YZxJGSVPWDMGcEJYx64/smcWONs3JzEv1DZ7gGTm3I8EZ9qm3zimCMpE96ubou
        Lx
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr39002656eji.511.1616057231707;
        Thu, 18 Mar 2021 01:47:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywf90WkxYplk4TD/8XiOizfRSWdSYIYuGNhHypDRvzch6CWGB9By65jwhECuzagFhPh/Ywaw==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr39002642eji.511.1616057231509;
        Thu, 18 Mar 2021 01:47:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a9sm1383806eds.33.2021.03.18.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:47:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for
 PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <874kh9xuid.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com>
 <20210219113101.967508-2-vkuznets@redhat.com>
 <87im5py1ty.fsf@nanos.tec.linutronix.de>
 <87blbhxyvk.fsf@nanos.tec.linutronix.de>
 <878s6lxxuq.fsf@nanos.tec.linutronix.de>
 <874kh9xuid.fsf@nanos.tec.linutronix.de>
Date:   Thu, 18 Mar 2021 09:47:10 +0100
Message-ID: <878s6k7ss1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Mar 17 2021 at 22:40, Thomas Gleixner wrote:
>> af174783b925 ("x86: I/O APIC: Never configure IRQ2")
>>
>> has a very nice explanation why.
>>
>> Back then the logic was quite different. All legacy PIC interrupts
>> (0-15) were bound to the legacy vectors at boot and never moved away.
>>
>> There was a check in the back then setup routing which prevented the
>> IOAPIC routing of IRQ2 which got lost at some point. Haven't figured out
>> yet where this might be. Still digging in those ancient horrors.
>
> So the commit in question is:
>
>   d32932d02e18 ("x86/irq: Convert IOAPIC to use hierarchical irqdomain interfaces")
>
> For almost 6 years nobody complained about this wreckage, which might
> indicate that we could lift this requirement, but OTOH for any system
> which actually has a PIC IRQ2 is unusable by design.
>
> And my history based paranoia vs. these kind of changes just makes me
> tend to the safe side, so restoring the original behaviour makes more
> sense than just papering over it.
>
> Just to be clear: The reservation of PIC pin2 (aka. IRQ2) as a permanent
> system vector cannot go away for any system which has a PIC. If that
> ever fires then the PIC is hosed and you really want the warning about
> the unhandled vector which is easy to identify because it is fixed.
>
> You might think that's not relevant for modern CPUs where the PIC is
> emulated, but I've dealt with reports where that emulation goes south so
> I rather keep those sanity checks around as long as that legacy mess is
> relevant. No idea why it still exists, but that's a different story.
>
> Thanks,
>
>         tglx
> ---
> Subject: x86/ioapic: Ignore IRQ2 again
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 17 Mar 2021 23:10:02 +0100
>
> Why did I have to do the archaeology?
>
> < INSERT PROPER CHANGELOG >
>
> Fixes: d32932d02e18 ("x86/irq: Convert IOAPIC to use hierarchical irqdomain interfaces")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/apic/io_apic.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1032,6 +1032,16 @@ static int mp_map_pin_to_irq(u32 gsi, in
>  	if (idx >= 0 && test_bit(mp_irqs[idx].srcbus, mp_bus_not_pci)) {
>  		irq = mp_irqs[idx].srcbusirq;
>  		legacy = mp_is_legacy_irq(irq);
> +		/*
> +		 * IRQ2 is unusable for historical reasons on systems which
> +		 * have a legacy PIC. See the comment vs. IRQ2 further down.
> +		 *
> +		 * If this gets removed at some point then the related code
> +		 * in lapic_assign_system_vectors() needs to be adjusted as
> +		 * well.
> +		 */
> +		if (legacy && irq == PIC_CASCADE_IR)
> +			return -EINVAL;
>  	}
>  
>  	mutex_lock(&ioapic_mutex);
>

This seems to work well for me, thanks! Please feel free to add

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Alternatively, just let me know and I'll pick this up, write a changelog and
send out with your Suggested-by:.

-- 
Vitaly

