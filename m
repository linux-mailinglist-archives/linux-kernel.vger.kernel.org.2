Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC82C38104C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhENTJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:09:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:08:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621019287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R95oUmG5Yb9qPpk2kZ5TR+4QpACFVPOmGrKV9AQGNQw=;
        b=duUVETTP0HD/BUsmQoOqZR4pQUCmZH6utTfkuH6C+6UeC+7H1V0iQnqz43AxY6SOYTUmql
        ZMFvv6aKRmeuOEfv0gCD6TbL3LSYOjGYIxHLAQsj7pUv2tnrTGH4vr1cSypg5e800b4WmM
        RWZS+4iqGVnsO6YXRyj5mUUI4gl0lI+N6WvdwqL4lHbqfW+v3K0qdsPCCbn46sy3YbpCir
        nlgL21vP95PP7q9ewWmib6X8b5LQPvZOgncwtmqrBIIb7R87zNxC2RqItX/8U6gsbqS+R5
        /PR+WFXdw5KKwiCoOx/CMugOswgnzHDTOFF/F+DneWtnGlYHzzmAT1k5ZknIWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621019287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R95oUmG5Yb9qPpk2kZ5TR+4QpACFVPOmGrKV9AQGNQw=;
        b=6UTjEBXCqWyYWHhJ6XOuR6AFptWpygqkxpTiLdaDVMzklUeJf67vpepzhC7A77LRsqqGGx
        efR/fGe5KESverCQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch V2 8/8] hrtimer: Avoid more SMP function calls in clock_was_set()
In-Reply-To: <YJzZqyaEWstfWtYW@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de> <20210427083724.840364566@linutronix.de> <20210427151125.GA171315@fuller.cnet> <877dkno5w0.ffs@nanos.tec.linutronix.de> <87a6pgfdps.ffs@nanos.tec.linutronix.de> <YJzZqyaEWstfWtYW@hirez.programming.kicks-ass.net>
Date:   Fri, 14 May 2021 21:08:06 +0200
Message-ID: <878s4h3zhl.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13 2021 at 09:47, Peter Zijlstra wrote:
> On Fri, Apr 30, 2021 at 09:12:15AM +0200, Thomas Gleixner wrote:
>> +	/*
>> +	 * If the remote CPU is currently handling an hrtimer interrupt, it
>> +	 * will reevaluate the first expiring timer of all clock bases
>> +	 * before reprogramming. Nothing to do here.
>> +	 */
>> +	if (cpu_base->in_hrtirq)
>> +		return false;
>
> This one gives me a head-ache though; if we get here, that means
> hrtimer_interrupt()'s hrtimer_update_base() happened before the change.
> It also means that CPU is in __run_hrtimer() running a fn(), since we
> own cpu_base->lock.
>
> That in turn means it is in __hrtimer_run_queues(), possible on the last
> base.
>
> Now, if I understand it right, the thing that saves us, is that
> hrtimer_update_next_event() -- right after returning from
> __hrtimer_run_queues() -- will re-evaluate all bases (with the
> hrtimer_update_base() we just did visible to it) and we'll eventually
> goto retry if time moved such that we now have timers that should've ran
> but were missed due to this concurrent shift in time.

Correct.

> However, since that retries thing is limited to 3; could we not trigger
> that by generating a stream of these updates, causing the timer to keep
> having to be reset? I suppose updating time is a root only thing, and
> root can shoot its own foot off any time it damn well likes, so who
> cares.

It's root only. Sou you could argue that a borked NTPd can cause this to
happen, but then you surely have other problems aside of hitting the
retries limit.

Thanks,

        tglx
