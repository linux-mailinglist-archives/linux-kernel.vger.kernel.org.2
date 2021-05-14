Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D1380FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhENSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhENSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:46:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EEFF61177;
        Fri, 14 May 2021 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621017895;
        bh=7T8DxFAwbrGNtQP7f/I8R6XgsGQ6c7P/JvusIls4O18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L9B0QIsHfTigsT4fX+yDT3k3WJhrBax21PUKiYMguHymf+3MyXgGfxbSo0+Fbf7/1
         MB9aBi52IUriw3a0O3ijUfW2yDcwMuZ693svFlzt49fBiL90TO7VtyVwFv5xtZveeh
         zOPKHoWHrU6OWWzs+5I3zfRXZne3MjDH6KsNcQrHqacrd0/i2oYDakWzFfcdQ6j1Ir
         8E6nbfMRveNq4b/YQ7z4RKynbZ23haZPpgRht4HHZuYg+bYuXPr9rbZumpH8hrsUEu
         B/QuJdqE1mzP0+WwppEmoFzrFWaVagHfYKf3QdGk0YRZnFEdT3l6/RSpiPu0q8KvtD
         niOH9LFWLemnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DB735C02A5; Fri, 14 May 2021 11:44:55 -0700 (PDT)
Date:   Fri, 14 May 2021 11:44:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
Message-ID: <20210514184455.GJ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
 <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <9c9739ec-1273-5137-7b6d-00a27a22ffca@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c9739ec-1273-5137-7b6d-00a27a22ffca@colorfullife.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:41:02AM +0200, Manfred Spraul wrote:
> On 5/13/21 9:02 PM, Paul E. McKenney wrote:
> > On Thu, May 13, 2021 at 08:10:51AM +0200, Manfred Spraul wrote:
> > > Hi Paul,
> > > 
> > > On 5/12/21 10:17 PM, Paul E. McKenney wrote:
> > > [...]
> > > > 	int foo;
> > > > 	DEFINE_RWLOCK(foo_rwlock);
> > > > 
> > > > 	void update_foo(int newval)
> > > > 	{
> > > > 		write_lock(&foo_rwlock);
> > > > 		foo = newval;
> > > > 		do_something(newval);
> > > > 		write_unlock(&foo_rwlock);
> > > > 	}
> > > > 
> > > > 	int read_foo(void)
> > > > 	{
> > > > 		int ret;
> > > > 
> > > > 		read_lock(&foo_rwlock);
> > > > 		do_something_else();
> > > > 		ret = foo;
> > > > 		read_unlock(&foo_rwlock);
> > > > 		return ret;
> > > > 	}
> > > > 
> > > > 	int read_foo_diagnostic(void)
> > > > 	{
> > > > 		return data_race(foo);
> > > > 	}
> > > The text didn't help, the example has helped:
> > > 
> > > It was not clear to me if I have to use data_race() both on the read and the
> > > write side, or only on one side.
> > > 
> > > Based on this example: plain C may be paired with data_race(), there is no
> > > need to mark both sides.
> > Actually, you just demonstrated that this example is quite misleading.
> > That data_race() works only because the read is for diagnostic
> > purposes.  I am queuing a commit with your Reported-by that makes
> > read_foo_diagnostic() just do a pr_info(), like this:
> > 
> > 	void read_foo_diagnostic(void)
> > 	{
> > 		pr_info("Current value of foo: %d\n", data_race(foo));
> > 	}
> > 
> > So thank you for that!
> 
> I would not like this change at all.
> Assume you chase a rare bug, and notice an odd pr_info() output.
> It will take you really long until you figure out that a data_race() mislead
> you.
> Thus for a pr_info(), I would consider READ_ONCE() as the correct thing.

It depends, but I agree with a general preference for READ_ONCE() over
data_race().

However, for some types of concurrency designs, using a READ_ONCE()
can make it more difficult to enlist KCSAN's help.  For example, if this
variable is read or written only while holding a particular lock, so that
read_foo_diagnostic() is the only lockless read, then using READ_ONCE()
adds a concurrent read.  In RCU, the updates would now need WRITE_ONCE(),
which would cause KCSAN to fail to detect a buggy lockless WRITE_ONCE().
If data_race() is used, then adding a buggy lockless WRITE_ONCE() will
cause KCSAN to complain.

Of course, you would be quite correct to say that this must be balanced
against the possibility of a messed-up pr_info() due to compiler mischief.
Tradeoffs, tradeoffs!  ;-)

I should document this tradeoff, shouldn't I?

> What about something like the attached change?
> 
> --
> 
>     Manfred
> 
> 

> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> index 1ab189f51f55..588326b60834 100644
> --- a/tools/memory-model/Documentation/access-marking.txt
> +++ b/tools/memory-model/Documentation/access-marking.txt
> @@ -68,6 +68,11 @@ READ_ONCE() and WRITE_ONCE():
>  
>  4.	Writes setting values that feed into error-tolerant heuristics.
>  
> +In theory, plain C-language loads can also be used for these use cases.
> +However, in practice this will have the disadvantage of causing KCSAN
> +to generate false positives because KCSAN will have no way of knowing
> +that the resulting data race was intentional.
> +
>  
>  Data-Racy Reads for Approximate Diagnostics
>  
> @@ -86,11 +91,6 @@ that fail to exclude the updates.  In this case, it is important to use
>  data_race() for the diagnostic reads because otherwise KCSAN would give
>  false-positive warnings about these diagnostic reads.
>  
> -In theory, plain C-language loads can also be used for this use case.
> -However, in practice this will have the disadvantage of causing KCSAN
> -to generate false positives because KCSAN will have no way of knowing
> -that the resulting data race was intentional.
> -
>  
>  Data-Racy Reads That Are Checked Against Marked Reload
>  
> @@ -110,11 +110,6 @@ that provides the compiler much less scope for mischievous optimizations.
>  Capturing the return value from cmpxchg() also saves a memory reference
>  in many cases.
>  
> -In theory, plain C-language loads can also be used for this use case.
> -However, in practice this will have the disadvantage of causing KCSAN
> -to generate false positives because KCSAN will have no way of knowing
> -that the resulting data race was intentional.

Normally, I would be completely in favor of your suggestion to give
this advice only once.  But in this case, there are likely to be people
reading just the part of the document that they think applies to their
situation.  So it is necessary to replicate the reminder into all the
sections.

That said, I do applaud your approach of reading the whole thing.  That
of course gets you a much more complete understanding of the situation,
and gets me more feedback.  ;-)

>  Reads Feeding Into Error-Tolerant Heuristics
>  
> @@ -125,11 +120,9 @@ that data_race() loads are subject to load fusing, which can result in
>  consistent errors, which in turn are quite capable of breaking heuristics.
>  Therefore use of data_race() should be limited to cases where some other
>  code (such as a barrier() call) will force the occasional reload.
> -
> -In theory, plain C-language loads can also be used for this use case.
> -However, in practice this will have the disadvantage of causing KCSAN
> -to generate false positives because KCSAN will have no way of knowing
> -that the resulting data race was intentional.
> +The heuristics must be able to handle any error. If the heuristics are
> +only able to handle old and new values, then WRITE_ONCE()/READ_ONCE()
> +must be used.

Excellent addition!  I have applied the commit shown below with your
Signed-off-by.  Please let me know if you would like me to take some other
course of action.  And also please let me know if I messed something up.

>  Writes Setting Values Feeding Into Error-Tolerant Heuristics
> @@ -142,11 +135,8 @@ due to compiler-mangled reads, it can also tolerate the occasional
>  compiler-mangled write, at least assuming that the proper value is in
>  place once the write completes.
>  
> -Plain C-language stores can also be used for this use case.  However,
> -in kernels built with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n, this
> -will have the disadvantage of causing KCSAN to generate false positives
> -because KCSAN will have no way of knowing that the resulting data race
> -was intentional.
> +Note that KCSAN will only detect mangled writes in kernels built with
> +CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n.

And the same point on needing to say this more than once.

							Thanx, Paul

------------------------------------------------------------------------

commit 48db6caa1d32c39e7405df3940f9f7ba07ed0527
Author: Manfred Spraul <manfred@colorfullife.com>
Date:   Fri May 14 11:40:06 2021 -0700

    tools/memory-model: Heuristics using data_race() must handle all values
    
    Data loaded for use by some sorts of heuristics can tolerate the
    occasional erroneous value.  In this case the loads may use data_race()
    to give the compiler full freedom to optimize while also informing KCSAN
    of the intent.  However, for this to work, the heuristic needs to be
    able to tolerate any erroneous value that could possibly arise.  This
    commit therefore adds a paragraph spelling this out.
    
    Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index e4a20ebf565d..22ecadec4894 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -126,6 +126,11 @@ consistent errors, which in turn are quite capable of breaking heuristics.
 Therefore use of data_race() should be limited to cases where some other
 code (such as a barrier() call) will force the occasional reload.
 
+Note that this use case requires that the heuristic be able to handle
+any possible error.  In contrast, if the heuristics might be fatally
+confused by one or more of the possible erroneous values, use READ_ONCE()
+instead of data_race().
+
 In theory, plain C-language loads can also be used for this use case.
 However, in practice this will have the disadvantage of causing KCSAN
 to generate false positives because KCSAN will have no way of knowing
