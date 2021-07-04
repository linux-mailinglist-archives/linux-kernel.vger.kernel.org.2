Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD73BAF24
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGDVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 17:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhGDVPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 17:15:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CAE761026;
        Sun,  4 Jul 2021 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625433183;
        bh=G1v2J0ZqR80/DsA4jhtqNia+K5QxRNxipjvsZPfJGZs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=suFa17+SzeZ3EZqoKZECwJoTFSjBn2uIc8jbFcsXpoAJuA1KqS8E9vnwBwp1fJ0MU
         atJ25OmRJsvZlkKpUoJ+CVxneQ1hdGIzNA6gcYSpdN8XKtCwXSjgXakAoXdVw5//zY
         o42I1xiVdY5KefqfZl2adPEtJRsFo/a4MCOgCIOTPJrJpgQhzkKz6QgfUXFiO+pMND
         aaaUA1N8r4poxsULXUR537+DzBZ8cf1BByb22yyOhF6g3vnIzPY3O10AQPlbxrIwtZ
         R9bP/xx+F4yPf961V8XszCKJysxjbMg3MSbfGqNgxIhLac2nBkdrW06ilOsPw6VuiF
         L9r/hargouzDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F34C45C0267; Sun,  4 Jul 2021 14:13:02 -0700 (PDT)
Date:   Sun, 4 Jul 2021 14:13:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] RCU changes for v5.14
Message-ID: <20210704211302.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com>
 <20210704203201.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=winZfYrRS-dbLT0RkRPJwwQuFDTwrbQiU=krRtsZ5qYGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=winZfYrRS-dbLT0RkRPJwwQuFDTwrbQiU=krRtsZ5qYGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 01:44:02PM -0700, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 1:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Once again, please accept my apologies, and thank you for the explanation.
> > I should have sent something like the following, correct?
> 
> Correct.  That
> 
> > I have done an example merge here:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge-example-rcu
> 
> makes it trivial for me to just do that "git fetch" and compare what
> you did with what I did.
> 
> Of course, now I've already pushed out my resolution, so it's too late
> (and I've forgotten which files were involved, so I'm too lazy to go
> back and check). But hopefully it matches anyway.

Nothing that my compiler cares about or that would make any difference
in the code output.

So I have it queued the patch shown below for later, unless someone
else's compiler complains before then.

							Thanx, Paul

------------------------------------------------------------------------

commit 30363f26e6cc347a7cf6e80206139c2e95d6f7d8
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Jul 4 13:59:35 2021 -0700

    rcu: Fix pr_info() formats and values in show_rcu_gp_kthreads()
    
    This commit changes from "%lx" to "%x" and from "0x1ffffL" to "0x1ffff"
    to match the change in type between the old field ->state (unsigned long)
    and the new field ->__state (unsigned int).
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 3f937b20814f..6c76988cc019 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -795,9 +795,9 @@ void show_rcu_gp_kthreads(void)
 	jr = j - data_race(rcu_state.gp_req_activity);
 	js = j - data_race(rcu_state.gp_start);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#x ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->__state : 0x1ffffL, t ? t->rt_priority : 0xffU,
+		rcu_state.gp_state, t ? t->__state : 0x1ffff, t ? t->rt_priority : 0xffU,
 		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
