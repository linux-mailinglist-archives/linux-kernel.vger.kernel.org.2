Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D79446737
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhKEQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:47:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:44:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636130688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pa0FDwhZuciKKSRg2JXZFbnZbfRkk7+ScucOPowuPJE=;
        b=qqb6qVyEGaSXuYP38i8PeduKwl1nuwuMxrEtLikWATG/X1nM+8q1Vy+o0Jll230vCCQGic
        5Q4U8nw6K4vdhIDYO8b6PmlBUd5u/8U35ur5foe/HDLUcuEPYcIqM9zHyBqkAPNap4v+Ag
        lDA86YU5arikgmO+iw+ROahiTuC+ynJ7puswwwVMSoP0cw1YcDki84xZRIeN1LOJ3EV+R5
        Q44vMSJ5XDAEsiwqfBjR/Z1OH8guak5Bie6eDawXJQWZBgVBVbEW0a/QkblbMPu4qSTz4q
        ItkIODKvQqjkZ/bt1vE4/OZthPTEwXemcrnKE7WdB+34OFXtj7JrI15GJFZA8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636130688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pa0FDwhZuciKKSRg2JXZFbnZbfRkk7+ScucOPowuPJE=;
        b=Ecvf98ENkfQwQPjRkzC/LumfnqacIRdBRY5bYBhT7QmndSmVUrVvhtytujJpiYJxiNqHZV
        JDlnfHpavzub+KBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removal of printk safe buffers delays NMI context printk
In-Reply-To: <YYVakNdzjrYuBmhf@alley>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
 <87r1bv2aga.fsf@jogness.linutronix.de>
 <1636111599.wwppq55w4t.astroid@bobo.none>
 <87h7cqg0xk.fsf@jogness.linutronix.de> <YYVakNdzjrYuBmhf@alley>
Date:   Fri, 05 Nov 2021 17:50:48 +0106
Message-ID: <87lf22eem7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-05, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2021-11-05 15:03:27, John Ogness wrote:
>> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>>> but we do need that printk flush capability back there and for
>>> nmi_backtrace.
>> 
>> Agreed. I had not considered this necessary side-effect when I
>> removed the NMI safe buffers.
>
> Honestly, I do not understand why it stopped working or how
> it worked before.

IIUC, Nick is presenting a problem where a lockup on the other CPUs is
detected. Those CPUs will dump their backtraces per NMI context. But in
their lockup state the irq_work for those CPUs is not functional. So
even though the messages are in the buffer, there is no one printing the
buffer.

printk_safe_flush() would dump the NMI safe buffers for all the CPUs
into the printk buffer, then trigger an irq_work on itself (the
non-locked-up CPU).

That irq_work trigger was critical, because the other CPUs (which also
triggered irq_works for themselves) aren't able to process irq_works. I
did not consider this case. Which is why we still need to trigger
irq_work here. (Or, as the removed comment hinted at, add some printk()
call to either directly print or trigger the irq_work.)

John Ogness
