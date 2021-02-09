Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70893314B24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhBIJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhBIJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:01:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5406C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:01:15 -0800 (PST)
Date:   Tue, 9 Feb 2021 10:01:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612861273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPeCBxGcgrptzbjPAZhFaC3gfl7tYPppNQEZi5JmYqI=;
        b=MSG1KGdEcqbIqPTaNVtGP0DAlma/UZpcZSqYist10/f1Ky8fc4hvPZR+TZvjoFjQI4qW86
        IGSJG7vOP23mx8In3ItMoPmrBkLUtckuG9m+xHOWcZjb4Rodu5Gzqu7QsdSSln0YbyVFwW
        r+cOlePBvb1a4vDG71oaR1V1Rc4BWfRzRSCAK9Nll53mELsiyeC6D45hVqSlwLwrfIxGhc
        lVgtoDnjDzJYebXWzwDfdkpEzML1QFgPEMhee6fdLnjnfD9TCuI+66cV1P06KrEXKC/GRR
        +90GkpWNqUD8VZlOH1TJBW7hbHzVvK+PvJCc/KLguyPp4HL/RmajsjKT/qBnqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612861273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPeCBxGcgrptzbjPAZhFaC3gfl7tYPppNQEZi5JmYqI=;
        b=p/MDTnD7eoOp9LghL1r5q0zhEcBbpnUaCwa3bN3y1Ii17BCukqY7/OSzfGoL4J76UbB6c+
        Clz7dz5naGkbAwBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08 23:26:57 [+0100], Miguel Ojeda wrote:
> Thanks -- can you please add a Link: tag to a lore URL or the docs or
> similar where more information can be found regarding the
> proposal/discussion for removing `in_interrurt()` etc.? It is useful
> to track why these things are happening around the kernel.

If I post series with more than just one patch I have a cover letter
including:

|in the discussion about preempt count consistency across kernel
|configurations:
|
| https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
|
|it was concluded that the usage of in_interrupt() and related context
|checks should be removed from non-core code.
|
|In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
|driver code completely.

since this patch was small, simple and removing not required code I kept
it out. Is this enough information for you?

> Also, `hacking.rst` (and related documentation) should be updated
> before this is done, so that we can link to it.

The information is not wrong, it doesn't say you have to use it it your
driver. It also does not mention that you should not. I will look into
this.

> > What I meant was GFP_KERNEL for context which can sleep vs GFP_ATOMIC for
> > context which must not sleep. The commit above also eliminates the
> > in_interrupt() usage within the driver (in multiple steps).
> 
> I was thinking something along those lines, but `in_interrupt()` nor
> `cond_resched()` take an explicit context either, so I am confused.
> Does `cond_reched()` always do the right thing regardless of context?
> The docs are not really clear:
> 
>   "cond_resched() and cond_resched_lock(): latency reduction via
> explicit rescheduling in places that are safe."
> 
> It could be read as "it will only resched whenever safe" or "only to
> be called if it is safe".

You should keep track of the context you are in and not attempt to sleep
if it is not allowed. If you are doing something that may monopolize the
CPU then you should use cond_resched(). The difference compared to
schedule() is that you don't blindly invoke the scheduler and that it is
optimized away on a preemptible kernel. But as you noticed, you must not
not use it if the context does not allow it (like in interrupt handler,
disabled preemption and so on).

> Cheers,
> Miguel

Sebastian
