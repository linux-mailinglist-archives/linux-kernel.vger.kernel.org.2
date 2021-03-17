Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB833F9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhCQUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:14:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA255C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:14:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616012090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8a9tIgg8DQfwAiJAIJSvHbvJRzm9suhkCKdCJHq90U=;
        b=bw+QdD4c2I2mFuhb2xIlZrsB3nkdKm4ZOIqZ3SpsJPwzZAjnTxtX3J8GgVCRfaEQ4AXfDk
        F87UpC/f88Xn6fAKo+jbtVQFUV1KNz3F8/8bpwcGwqzvSAlshRa4z4PHbDkhhQMD0IjBcB
        k6L4CmLNO/0rYAeVjSaHmXFZZ+L8VZJxYzbfofHdpHgwBI60Y0IQpHecKZLhdIf0us5u+u
        cW/50fNUtPthWnqs2/wTKpD9tlfJZZoBV1sP0yYap65xE5d+7haixZJ22oEnfxH8jk1v/Y
        aSq5+R+hwsIhuy23RKwO/NsBPkTyiId05yxE7ps7192WtD880T+KmgnRTKQ7wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616012090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8a9tIgg8DQfwAiJAIJSvHbvJRzm9suhkCKdCJHq90U=;
        b=XfJlh3+sIDjlcDqx36lbJm9kTA8mhHbJreCQCPOzORqwXNsNeET3Zgru4HkmfuxL6+TryS
        fsphfxuiDMOyqvBA==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <20210219113101.967508-2-vkuznets@redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-2-vkuznets@redhat.com>
Date:   Wed, 17 Mar 2021 21:14:49 +0100
Message-ID: <87im5py1ty.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:
> Trying to offline/online CPU0 seems to work only once:
>
>  # echo 0 > /sys/devices/system/cpu/cpu0/online
>  # echo 1 > /sys/devices/system/cpu/cpu0/online
>  # echo 0 > /sys/devices/system/cpu/cpu0/online
>  -bash: echo: write error: No space left on device
>
> with the following in dmesg:
>
>  [ ... ] CPU 0 has 4294967295 vectors, 589 available. Cannot disable CPU
>
> Clearly, we went negative with cm->allocated in irq_matrix and think that
> there are too many vectors require re-assigning.
>
> The problem turns to be: lapic_assign_system_vectors() called from
> native_init_IRQ() makes an exception for PIC_CASCADE_IR and doesn't
> mark it in irq_matrix. Later, when x86_vector_alloc_irqs() called
> from setup_IO_APIC() does clear_irq_vector() for all legacy entries,
> it doesn't make an exception so we go negative.
>
> CPU0 offlining still works for the first time because some other vectors
> get assigned and the overall balance remains positive (it's off-by-one, but
> the check passes). When we online CPU0 back, no vectors get assigned and
> the overall balance remains '-1'.
>
> The simplest solution seems to be to not make an exception for
> PIC_CASCADE_IR. Nothing seems to blow up immediately.

Well no. This does not make sense. Just a few lines above the code which
you are fiddling with is:

	if (nr_legacy_irqs() > 1)
		lapic_assign_legacy_vector(PIC_CASCADE_IR, false);

Which is there for a reason because this _MUST_ stay at exactly this
place and not move randomly around.

Even without looking at the machine I can tell you what's going on. MP
config or ACPI has a pin assigned to IRQ 2 which I've not seen before.
The code there is ignoring IRQ 2 because that's how the original code
worked as well as it is reserved for the PIC_CASCADE_IRQ which should
never fire and we actually want to catch an spurious interrupt on it.

So depending on the overall configuration of that system and the
resulting delivery modes this might be ok, but I'm really nervous about
doing this wholesale as it might break old machines.

Out of paranoia I'd rather ignore that IO/APIC pin completely if it
claims to be IRQ2. I assume there is no device connected to it at all,
right?

Can you please provide a dmesg with apic=verbose on the command line?

Thanks,

        tglx
