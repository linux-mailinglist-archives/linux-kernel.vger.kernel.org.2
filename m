Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1B3A992A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFPL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhFPL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:28:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bYtfClwMmhpkY2mnoZSeVVW3hwWO6HCXgLD2xMPwtY4=; b=oGk6Z+FS98Mo1I2M2EfODEv8nJ
        +VMkAtQv18uqmq7nvnLOoFJLyy7/3uEqVXfkgZRAyQJFJNXoGnTsgLHpNDjRe+Wcu5wpa0iANV+LP
        Z8NpKm4zIsYOL0LQZVHWASIiFiHExOJBysm8B43kugoqG3UJZNHwJQxsfVhtHNCgePqSjlW8hypLI
        jE5gF5Xwcy/2HpVZyxgYpGvxgaQ1px7430z209y9bH0mQw1MYM7G++znZSqko3a117gJ5qJep+Lgx
        CWh2MzzBYTolMkjavw/nH+NEgL765/CCFavIk1RLrCcbfNo3WUyihRcZAPYujarcbIFF9+R3/VUrD
        q7NPJxng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltTgf-008J57-Ds; Wed, 16 Jun 2021 11:26:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCD3A300252;
        Wed, 16 Jun 2021 13:26:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B28FC20C169EA; Wed, 16 Jun 2021 13:26:30 +0200 (CEST)
Date:   Wed, 16 Jun 2021 13:26:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <YMnf5vW3MUyuKUa5@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
 <YMm7iafJ1mberGIg@hirez.programming.kicks-ass.net>
 <20210616105116.GA801071@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616105116.GA801071@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:51:16PM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 16, 2021 at 10:51:21AM +0200, Peter Zijlstra wrote:

> > The cpu_timer_enqueue() is in arm_timer() and the condition for calling
> > that is:
> > 
> >   'new_expires != 0 && val < new_expires'
> > 
> > Which is not the same as the one you add.
> 
> There are two different things here:
> 
> 1) the threadgroup cputime counter, activated by cpu_clock_sample_group(clkid,
> p, true)
> 
> 2) the expiration set (+ the callback enqueued) in arm_timer()
> 
> The issue here is that we go through 1) but not through 2)

Correct, but then I would think the cleanup would need the same
conditions as 2, and not something slightly different, which is what
confused me.

> > I'm thinking the fundamental problem here is the disconnect between
> > cpu_timer_enqueue() and pct->timers_active ?
> 
> You're right it's the core issue. But what prevents the whole to be
> fundamentally connected is a circular dependency: we need to know the
> threadgroup cputime before arming the timer, but we would need to know
> if we arm the timer before starting the threadgroup cputime counter
> 
> To sum up, the current sequence is:
> 
> * fetch the threadgroup cputime AND start the whole threadgroup counter
> 
> * arm the timer if it isn't zero and it hasn't yet expired
> 
> While the ideal sequence should be:
> 
> * fetch the threadgroup cputime (without starting the whole threadgroup counter
>   yet)
> 
> * arm the timer if it isn't zero and it hasn't yet expired
> 
> * iff we armed the timer, start the whole theadgroup counter
> 
> But that means re-iterating the whole threadgroup and update atomically
> the group counter with each task's time.

Right, so by the time patch #5 comes around, you seem to be at the point
where you can do:

 * fetch cputime and start threadgroup counter

 * possibly arm timer

 * if expired:
   - fire now
   - if armed, disarm (which leads to stop)

Which is the other 'obvious' solution to not starting it.

