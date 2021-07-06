Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113DB3BC7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhGFIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhGFIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:40:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B4C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DXY1qUMBnJFSsc8HYd8YE2jdbbBHR73IfHDefgzAuo0=; b=SQQwBpgRlmlK4hcKwseUJQ4k+R
        /N99bql5Ieioj+0l1XKTgdMLXOwAoLAQ56KRh5G89gIwBVDtLftxegYGXioxvxXtJtni1iw/V1wm1
        P6CQaMN+73UuB+HmRt2FjcT5N/NW8kqKfFfBnH2Z3VjAfjfJXXLsWOazopvngo93skp1L+0Ps2OOC
        yIO+3GgZ+5lJ58gKotH/BdGKLQR89YlCE2g+b3+nUhmlSS5eqLR//lq9zKC4cE+1j3Cn9QgMZidwL
        pZdtSoipFttatOH0MMN7SEQ8bzwg8ffSyrAjaytYVmpCVfXdaoXayQWz7NsgV7M+dSrYRwsXjOXna
        0n5RZxAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0gaT-00EzRf-QM; Tue, 06 Jul 2021 08:37:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DDBF300056;
        Tue,  6 Jul 2021 10:37:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16A49200F8B7A; Tue,  6 Jul 2021 10:37:49 +0200 (CEST)
Date:   Tue, 6 Jul 2021 10:37:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YOQWXVzj5T+AGKWg@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 06:37:57AM -0700, Paul E. McKenney wrote:
> Because the static inline functions end up in RCU's tranlation units,
> and they do write to other state.  See for example the line marked with
> the asterisk at the end of this email, which is apparently between
> __run_timers() and rcu_torture_reader().  But gdb says that this is
> really between this statement in __run_timers():
> 
> 	base->running_timer = NULL;

(I'm finding that in expire_timers(), not in __run_timers(), and both
are in kernel/time/timer.c)

> And this statement in try_to_del_timer_sync():
> 
> 	if (base->running_timer != timer)
> 
> Because of inline functions, running KCSAN on RCU can detect races in
> other subsystems.  In this case, I could argue for a READ_ONCE() on the
> "if" condition, but last I knew, the rules for timers are that C-language
> writes do not participate in data races.  So maybe I should add that
> READ_ONCE(), but running KCSAN on rcutorture would still complain.

That code is correct as is, AFAICT, so READ_ONCE() is not the right
annotation.  Also, READ_ONCE() would not actively help the situation in
any case, and arguably make the code worse and more confusing.


What happens here is that we read base->running_timer while holding
base->lock. We set base->running_timer to !0 holding that same
base->lock from the timer IRQ context. We clear base->running_timer
*without* base->lock, from the timer IRQ context.

So yes, there's a race between the locked load of base->running_timer
and the timer IRQ on another CPU clearing it.

But since the comparison is an equality test and the only purpose of the
clear is to destroy that equality, any partial clear serves that
purpose.

Now, a partial clear could create a false positive match for another
timer, which in turn could make try_to_del_timer_sync() fail spuriously
I suppose, but any caller needs to be able to deal with failure of that
function, so no harm done there.


*HOWEVER* timer_curr_running() violates all that.. but that looks like
it's only ever used as a diagnostic, so that should be fine too.


Anyway, AFAIU the problem is on the WRITE side, so any READ_ONCE() will
not ever fix anything here. If we want to get rid of the possible
spurious fail in try_to_del_timer_sync() we need to consistently
WRITE/READ_ONCE() all of base->running_timer, if we don't care, we need
a data_race() annotation somewhere, although I'm not currently seeing
that inlining you mention that's needed for this problem to manifest in
the first place.

