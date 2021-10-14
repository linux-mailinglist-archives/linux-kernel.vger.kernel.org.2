Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464D42E490
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhJNXI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234051AbhJNXIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A8061053;
        Thu, 14 Oct 2021 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634252778;
        bh=pTt9hE/zP7h6eknt1Q7xk/zT7K9OERkXxzhqLIb9hoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T8yj7cSo7Bzs2cc+LX7PbO1F+tngLHx8qp8iZaqsnsrgqfoKjb6EVhOSW80gk0fXO
         EcLyKiZyuaN+jSf78pbQPWVjoTaIWpAqXsj1DTomrNFyUqWMEueli/uqp3+ODyAUjp
         gvuZujWSrX68ztwqyn+r6esvl7eMrqGPyQ4g0hfM42OpPy32tlqDUdF+tRE66Dq2nL
         AE7fl3x9uTZAHdLzX0Q/cSGgKngnrV/eWR4OVPjjvyE7w7GRvAG51PQdGiLIUrPK6/
         5UXGDwz7qIQTKdb0Pqv2+3vC6iIN8PH/ph4f75y+azpnYrycSiVUkh4csi6zdkL4yj
         WnSM3OsopHchw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A33E25C0A06; Thu, 14 Oct 2021 16:06:18 -0700 (PDT)
Date:   Thu, 14 Oct 2021 16:06:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: data dependency naming inconsistency
Message-ID: <20211014230618.GL880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211011064233-mutt-send-email-mst@kernel.org>
 <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
 <20211014013156-mutt-send-email-mst@kernel.org>
 <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
 <8a9ea500-8f8c-129a-2974-4bdda65dbf64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9ea500-8f8c-129a-2974-4bdda65dbf64@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 07:48:09AM +0900, Akira Yokosawa wrote:
> On Thu, 14 Oct 2021 23:29:43 +0900, Akira Yokosawa wrote:
> > [-CC akys: my 2nd address]
> > On Thu, 14 Oct 2021 01:37:17 -0400, Michael S. Tsirkin wrote:
> >> On Thu, Oct 14, 2021 at 01:43:24PM +0900, Akira Yokosawa wrote:
> >>> On Mon, 11 Oct 2021 07:07:08 -0400, Michael S. Tsirkin wrote:
> >>>> Hello Paul, all!
> >>>
> >>> Hello Michael,
> >>>
> >>> I thought Paul would respond soon, but looks like he has not
> >>> done so.
> 
> This is because Michael used Paul's old email address.

Indeed, my ibm.com email addresses died about two years ago.

> Forwarding to his current address.
> 
> Paul, you can see the thread at the lore archive:
> https://lore.kernel.org/lkml/20211011064233-mutt-send-email-mst@kernel.org/T/

And thank you for forwarding this.

>         Thanks, Akira
> 
> >>> So, I'm trying to give some hint to your findings.
> >>>
> >>>> I've been reading with interest Paul's posts about Rust interactions with LKMM
> >>>> https://paulmck.livejournal.com/63316.html
> >>>> and in particular it states:
> >>>> 		A data dependency involves a load whose return value directly or
> >>>> 	indirectly determine the value stored by a later store, which results in
> >>>> 	the load being ordered before the store.
> >>>>
> >>>> This matches the perf book:
> >>>> 	A data dependency occurs when the value returned by
> >>>> 	a load instruction is used to compute the data stored by
> >>>> 	a later store instruction.
> >>>
> >>> You might likely be aware, but these concern "data dependency",
> >>> not a _barrier_.
> >>>
> >>>>
> >>>> however, memory-barriers.txt states:
> >>>>
> >>>>      A data dependency barrier is a partial ordering on interdependent loads
> >>>>      only; it is not required to have any effect on stores, independent loads
> >>>>      or overlapping loads.

As noted by others, the difference is that the first two are about a
data dependency, that is a prior load affecting the value stored by
a later store.  In contrast, the last one is about a data-dependency
barrier, which need only affect trailing loads.  Trailing stores are
already covered by control dependencies.  But clearer wording might
be good.  Suggestions?

> >>>> It also says:
> >>>> 	A data-dependency barrier is not required to order dependent writes
> >>>> 	because the CPUs that the Linux kernel supports don't do writes
> >>>> 	until they are certain (1) that the write will actually happen, (2)
> >>>> 	of the location of the write, and (3) of the value to be written.
> >>>
> >>> These concern the historic "data-dependency barrier", or
> >>> [smp_]read_barrier_depends(), which existed until Linux kernel v4.14.
> > 
> > Ah... I should have said ", which existed prior to Linux kernel v4.15".
> > This invited off-by-one error below...
> > 
> >>>
> >>>>
> >>>> so the result it the same: writes are ordered without a barrier,
> >>>> reads are ordered by a barrier.
> >>>>
> >>>> However, it would seem that a bit more consistency in naming won't
> >>>> hurt.
> >>>
> >>> So, I don't think the historic term of "data-dependency barrier"
> >>> can be changed.
> >>>
> >>> I guess the right approach would be to further de-emphasize
> >>> "data-dependency barrier"/"data dependency barrier" in
> >>> memory-barriers.txt.
> >>>
> >>> Rewrite by commit 8ca924aeb4f2 ("Documentation/barriers: Remove
> >>> references to [smp_]read_barrier_depends()") did some of such
> >>> changes, but it failed to update the introductory section of
> >>> "VARIETIES OF MEMORY BARRIER".
> >>> The part Michael quoted above belongs to it.
> >>> I don't think it has any merit keeping it around.
> >>>
> >>> Also, there remain a couple of ascii-art diagrams concerning
> >>> <data dependency barrier> in the first part of "EXAMPLES OF MEMORY
> >>> BARRIER SEQUENCES" section, which, I think, can be removed as well.
> >>>
> >>> Hope this helps clarify the circumstances.
> >>
> >> It does, thanks! It might be worth adding a sentence along the lines of
> >>
> >> "NB: a data dependency barrier is distinct from a data dependency: it's
> >> a barrier that used to be required in the presence of a data dependency.
> >> Since v4.14 Linux no longer offers an API for a data dependency barrier.
> > 
> >   Since v4.15
> > 
> >> Instead, using READ_ONCE is sufficient for ordering in the presence of a
> >> data dependency".
> > 
> > 
> > Maybe.
> > 
> > But I'm more inclined to get rid of remaining contents related to the
> > "data dependency barrier".

Given that we don't seem to have any more data-dependency barriers,
so getting rid of remaining mentions makes a lot of sense to me.

							Thanx, Paul

> >         Thanks, Akira
> > 
> >>
> >>
> >>> Paul, what is your take on the naming of "data dependency"/
> >>> "data dependency barrier"?
> >>>
> >>>         Thanks, Akira
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>> -- 
> >>>> MST
> >>
