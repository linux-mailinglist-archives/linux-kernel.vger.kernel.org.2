Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A214018E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhIFJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbhIFJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:34:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212AEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:33:38 -0700 (PDT)
Date:   Mon, 6 Sep 2021 11:33:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630920815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UN1huiQ1hCCmYuOPeMLCSrlLHdNvwG3s1qb3USL0hnU=;
        b=NmdztmKghE1Bc7KRxENnbWZ5+bQN1wfyO1qXUlkqF2aRcXNFw3FlyiBpVPxImEKo6hNR9I
        XcRhUzWHoy3IGmzzc90/2vITqg9k07LHokAJl+sIuMnOaIVQDV+poqIzAcGJJiRneuDOWb
        A+vHInpZ7CpR8UjkZf/VZ3p8uM9+XNAzeO2LRXaoVWOrCMxl6ugR6jSPjHq2281aP1rF59
        D6a3/7uYFvGC2hF20VTW0FAtvLZriCrDwzF07kF43GPaniwt1Cw/sq47pJ8VCrL4BpWJib
        Tf8IxM9rp4FHRkNrwMLDntjXXLj+JlzojTToeQ0pXpHUKReXnw7LPCVxI6/h6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630920815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UN1huiQ1hCCmYuOPeMLCSrlLHdNvwG3s1qb3USL0hnU=;
        b=Wtl0CVvFxyDBnW2zgKcdFd+qeMNsMwwW0Gv8NaE7McbXKMi04mfOJDPJV2+sANa3iTilJN
        MBL3uusm/38FEnBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marco Elver <elver@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, tj@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        andreyknvl@gmail.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] workqueue: Don't record workqueue stack holding
 raw_spin_lock
Message-ID: <20210906093334.i7angdb7bda74puf@linutronix.de>
References: <20210902200134.25603-1-skhan@linuxfoundation.org>
 <CANpmjNPWyp67SSfRiXVYTiqRaMre9XVQzNVM-73PQ6TTjQW3Gw@mail.gmail.com>
 <2bd3759d-cd13-24f5-2cbd-00505d98e0c9@linuxfoundation.org>
 <YTW/emWbsNX7OkOh@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTW/emWbsNX7OkOh@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-06 09:12:58 [+0200], Marco Elver wrote:
> On Thu, Sep 02, 2021 at 05:46PM -0600, Shuah Khan wrote:
> [...]
> > > 3. Try to not allocate memory in stackdepot. Not sure this is feasible
> > > without telling stackdepot to preallocate the max slabs on boot if RT.
> > > 
> > 
> > We could. I have to ask though how much of the real world cases do we
> > need to impact for the debug code to work?
> > 
> > > Anything else? Because I don't think any of the options are satisfying.
> > 
> > One option to consider is checking dry-run invalid nesting check and
> > bail out if it is true in kasan_record_aux_stack()
> 
> Sadly, if lockdep is off, this won't work. And we need a way to
> generically fix this, as otherwise we still have a bug (which may also
> cause issues on RT kernels).
> 
> I propose we properly fix this and prevent stackdepot from replenishing
> its "stack slab" pool if memory allocations cannot be done in the
> current context. Specifically, I noticed technically it's a bug to use
> either GFP_ATOMIC nor GFP_NOWAIT in certain non-preemptive contexts,
> including raw_spin_locks (see gfp.h and ab00db216c9c7).

I would say so, too. It is unlikely that we manage to remove
raw_spin_lock_t from the workqueue code or that memory allocation with
disabled preemption/ interrupts would be allowed on RT.
Also as Marco pointed out, avoiding this code once a debug switch has
been noticed is not good.

> This is what kasan_record_aux_stack() via stackdepot does, and it's a
> bug here regardless if lockdep is on or off.
> 
> I've prepared a series (see attached draft patches) that allows telling
> stackdepot to not replenish its pool if alloc_pages() cannot be called
> at all (where GFP_ATOMIC/NOWAIT doesn't even work).

This sounds good. debug_object has also a memory pool which is
replenished from time to time.

> The only downside is that saving a stack trace may fail if: stackdepot
> runs out of space AND the same stack trace has not been recorded before.
> I expect this to be unlikely, and a simple experiment (boot the kernel)
> didn't result in any failure to record stack trace from insert_work().
> 
> I think this is a reasonable trade-off. And considering that we're
> unsure if queuing work can or cannot be done from within an outer
> raw_spin_lock'ed critical section, I don't see a better way.
> 
> If you agree, I'll send this series out for further review.
> 
> Thanks,
> -- Marco

Sebastian
