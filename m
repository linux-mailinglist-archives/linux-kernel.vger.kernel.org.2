Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFF33FA64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhCQVTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:19:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCQVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:18:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616015919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2M0zUddyPUo8fdS6bYp53hZm09wZ4b3CmVbM3sCnzHw=;
        b=brZz+qJVP0kXFuECazJyZfH+dADcoeotBYlEDodUW9UYTDM1zFvTaBXGI2XI6exJ5yIzVH
        9q8Css+fMH8nXK36Lw/lwNJpND72eA5gXRYD61sxgZncdAjedgf4LyZ8pHfyt3jCjpYmgN
        TymGBc7v2qSAacfrS2+qzzLZcUfuIHqPH/WpKfmrqoPWvsuAEjycKXANRZRO5I82/GbGXG
        YXFGGVfUXB1UAMIvLkffZcP/OA0+6RdM+lm3Xzc/uT0mEDILORpL1WnEFQVrWBrOCVwLPF
        B6V4dPoHpnXegcvbYHczZ70CH95fi1bBZJG7sqeTB6BxO7UVSo+BLnT1yQOZmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616015919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2M0zUddyPUo8fdS6bYp53hZm09wZ4b3CmVbM3sCnzHw=;
        b=Qvzf8BbwaQhmd+/hUOwcLzUHCy/9j4x2RW/xRRrbTLh+nRuklHfU8vg7E6WpdS7Q179W3h
        O48SSINfRtmwBeAw==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <87im5py1ty.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-2-vkuznets@redhat.com> <87im5py1ty.fsf@nanos.tec.linutronix.de>
Date:   Wed, 17 Mar 2021 22:18:39 +0100
Message-ID: <87blbhxyvk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 21:14, Thomas Gleixner wrote:
> On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:
> Even without looking at the machine I can tell you what's going on. MP
> config or ACPI has a pin assigned to IRQ 2 which I've not seen before.
> The code there is ignoring IRQ 2 because that's how the original code
> worked as well as it is reserved for the PIC_CASCADE_IRQ which should
> never fire and we actually want to catch an spurious interrupt on it.
>
> So depending on the overall configuration of that system and the
> resulting delivery modes this might be ok, but I'm really nervous about
> doing this wholesale as it might break old machines.
>
> Out of paranoia I'd rather ignore that IO/APIC pin completely if it
> claims to be IRQ2. I assume there is no device connected to it at all,
> right?

Seems at some point we lost the 'ignore cascade IRQ' logic in
IO/APIC. There is still a comment to that effect.

Let me do some archaeology.

Thanks,

        tglx
