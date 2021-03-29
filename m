Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7A34D945
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhC2UoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:44:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39104 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhC2UoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:44:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617050652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzdIA7Tqyx3FWfeIMgfDnt3zetELTcxSkWCFIqnOxeg=;
        b=t5krLasIZPDSx1tgbcTmmecuFI3Kp6NaS65Ru+gwKkDId0fuKJCXv7v66/oMyGQtbC4lZ2
        XOuSaYrjINSIqyzkSNdwAh9dflIcIA5Eo7mVSvFy9EPZ4KwjwLHSe4SHUQAT+LJYnjeEN9
        PxRNHit1trheXc4AOY25z6PkrJnR6Ha0PNWYjcHyhWjJ1AeCY5PdeWCh2o3AJJZxZi0Rs3
        XbCWVj+/jXpIfrMvRVQnuPax8oFsFVa8+SBpSC4MgDGWlhAJa6K1569WovHUch1J+kKwqQ
        EHUmqj2H3bU7ic5pxkURLxlrVsQvuUoLvhc6p8Up0uQfB8liXZCH6ecvW8HYQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617050652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzdIA7Tqyx3FWfeIMgfDnt3zetELTcxSkWCFIqnOxeg=;
        b=bBXxAsOADktXWj2MGiVk11NqrYTy0Sj8N0yhPfRE3blwPn7ekCnuPZvaEikcTiInFXCGeh
        zgy397NDr8w/IEAA==
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] x86/apic/vector: Move pr_warn() out of vector_lock
In-Reply-To: <ce7250cb-2b11-7d83-56b0-00f4f6274dae@redhat.com>
References: <20210329005236.1218-1-longman@redhat.com> <87tuoub07f.ffs@nanos.tec.linutronix.de> <ce7250cb-2b11-7d83-56b0-00f4f6274dae@redhat.com>
Date:   Mon, 29 Mar 2021 22:44:11 +0200
Message-ID: <87czvh7kro.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman,

On Mon, Mar 29 2021 at 15:57, Waiman Long wrote:
> On 3/29/21 8:42 AM, Thomas Gleixner wrote:
>> On Sun, Mar 28 2021 at 20:52, Waiman Long wrote:
>>> It was found that the following circular locking dependency warning
>>> could happen in some systems:
>>>
>>> [  218.097878] ======================================================
>>> [  218.097879] WARNING: possible circular locking dependency detected
>>> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
>> Reports have to be against latest mainline and not against the random
>> distro frankenkernel of the day. That's nothing new.
>>
>> Plus I was asking you to provide a full splat to look at so this can be
>> discussed _upfront_. Oh well...
>
> That was the full splat that I can see except the following trailing
> data:

I meant: Just the splat without yet another eyebleeding patch.

>>> [  218.097985] 6 locks held by systemd/1:
>>> [  218.097986]  #0: ffff88822b5cc1e8 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x79/0x440
>>> [  218.097989]  #1: ffff88832ee00770 (&port->mutex){+.+.}, at: tty_port_open+0x85/0x190
>>> [  218.097993]  #2: ffff88813be85a88 (&desc->request_mutex){+.+.}, at: __setup_irq+0x249/0x1e60
>>> [  218.097996]  #3: ffff88813be858c0 (&irq_desc_lock_class){-.-.}, at: __setup_irq+0x2d9/0x1e60
>>> [  218.098000]  #4: ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
>>> [  218.098003]  #5: ffffffff84c27e20 (console_lock){+.+.}, at: vprintk_emit+0x13a/0x450
>> This is a more fundamental problem than just vector lock and the same
>> problem exists with any other printk over serial which is nested in the
>> interrupt activation chain not only on X86.
>
> That is true. This problem is more generic than just that. I am hoping 
> that the new printk rewrite may address this problem. I have been 
> waiting for a while and that work is still not upstream yet. So what is 
> your current timeline for that? If that will happen soon, I probably 
> don't need this patch. I send this patch out as I am uncertain about
> it.

Timeline? You know how kernel development works, right?

>> But, because I'm curious and printk is a constant source of trouble, I
>> just added unconditional pr_warns into those functions under vector_lock
>> on 5.12-rc5.
>>
>> Still waiting for the lockdep splat to show up while enjoying the
>> trickle of printks over serial.
>>
>> If you really think this is an upstream problem then please provide a
>> corresponding lockdep splat on plain 5.12-rc5 along with a .config and
>> the scenario which triggers this. Not less, not more.
>
> I will try to reproduce this problem with an upstream kernel.

Yes please.

Thanks,

        tglx
