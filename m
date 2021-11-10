Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20144CB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhKJVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKJVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:41:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29BC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 13:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QNfGiqigvT4wNlYKF8FZeCrBkUxO3K6PPncrpJtlt0w=; b=c5yJuaiSEOl8AQuw7AIZMu+xlX
        hXOvUc76qoErOMN/vq20qQlmhuDutSUDJwiMlQZwqFP1Q5pt9nF4LDmPmmhkpWx41/607G41HyyzK
        SNzdLpa2ZvhGCDrx+0qKG/X1yHCcNRScuT0i3Iy/hi+SD8pBG00Ecauenpen6w0zOqTLhASCMx5lZ
        RTe7m8e4YzdoY66eMO4w4KXP1nYl/iIKoRuxW4JJ9tXtETMSJZxkUoRAF4GGnUXp3Z4rLaLCWc99l
        zY050VARx/TJbriT7/GyKXt0WNh1subErE6NLhRbSzf+uOsnLG0uuw/6NPBwHqxBcprCSXUKGM2F2
        n76wUHYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkvJ1-002DT9-GB; Wed, 10 Nov 2021 21:38:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E94FC9874D0; Wed, 10 Nov 2021 22:38:54 +0100 (CET)
Date:   Wed, 10 Nov 2021 22:38:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <20211110213854.GE174703@worktop.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 02:52:36PM -0500, Waiman Long wrote:
> > 
> > I did have a tentative patch to address this issue which is somewhat
> > similar to your approach. However, I would like to further investigate
> > the exact mechanics of the race condition to make sure that I won't miss
> > a latent bug somewhere else in the rwsem code.
> 
> I still couldn't figure how this race condition can happen. However, I do
> discover that it is possible to leave rwsem with no waiter but handoff bit
> set if we kill or interrupt all the waiters in the wait queue. I have just
> sent out a patch to address that concern, but it should be able to handle
> this race condition as well if it really happens.

The comment above RWSEM_WRITER_LOCKED seems wrong/out-dated in that
there's a 4th place that modifies the HANDOFF bit namely
rwsem_down_read_slowpath() in the out_nolock: case.

Now the thing I'm most worried about is that rwsem_down_write_slowpath()
modifies the HANDOFF bit depending on wstate, and wstate itself it not
determined under the same ->wait_lock section, so there could be a race
there.

Another thing is that once wstate==HANDOFF, we rely on spin_on_owner()
to return OWNER_NULL such that it goes to trylock_again, however if it
returns anything else then we're at signal_pending_state() and the
observed race can happen.

Now, spin_on_owner() *can* in fact return something else, consider
need_resched() being set for instance.

Combined I think the observed race is valid.

Now before we go make things more complicated, I think we should see if
we can make things simpler. Also I think perhaps the HANDOFF name here
is a misnomer.

I agree that using _andnot() will fix this issue; I also agree with
folding it with the existing _andnot() already there. But let me stare a
little more at this code, something isn't making sense...
