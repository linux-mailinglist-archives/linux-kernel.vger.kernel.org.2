Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079553710A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhECDPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 23:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECDPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 23:15:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29003611CE;
        Mon,  3 May 2021 03:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620011685;
        bh=Gg6gx9+BbIJpPshU7mq6a8VhsNaJNErD+n5vwYlU4vA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yf3zn/i6kOoYyAerEloPaMSDXbDo61Nm3X5KgZxqodY23g7tskhuxQbZ3wqrtMTFK
         eldPWT70xvskkJVlLSGilTD8vG4ubg3rtztjNY9pDnh5aMQwnH+zS/dvv4VCUtzZbd
         kR+gi3FLCg65yjtEZ/nh6lWPDb8+9FNb0m1gC8g+3Y3shJQrLGxiS+JOXzFZ58Lt5b
         t/1Z8GUSNu3DKxHfyJD6CeWTvxhHFykDuk6vj1W3OmKky8SJjUna7f7Nu7g/zZCozH
         lRadp7HjKQnj9DFRaZaDdYbG36EQx4XaINeYd45zmM7B6Ai2cL0pzUkk7DqQEXD+qg
         HVbE8fHhKisVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E174C5C01C9; Sun,  2 May 2021 20:14:44 -0700 (PDT)
Date:   Sun, 2 May 2021 20:14:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210503031444.GP975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
 <20210429184908.GH1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429184908.GH1847222@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 07:49:08PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 29, 2021 at 11:34:12AM -0700, Paul E. McKenney wrote:
> > +++ b/include/linux/rcupdate.h
> > @@ -532,7 +532,10 @@ do {									      \
> >   * @p: The pointer to read, prior to dereferencing
> >   * @c: The conditions under which the dereference will take place
> >   *
> > - * This is the RCU-bh counterpart to rcu_dereference_check().
> > + * This is the RCU-bh counterpart to rcu_dereference_check().  However,
> > + * please note that in recent kernels, synchronize_rcu() waits for
> > + * local_bh_disable() regions of code in addition to regions of code
> > + * demarked by rcu_read_lock() and rcu_read_unlock().
> >   */
> 
> I've been trying to get rid of "please note that" in my own documentation
> recently.  It doesn't add any value.  Also, "recent kernels" is going to
> go stale quickly, "Since v5.8" (or whatever) is good because it lets us
> know in ten years that we can just delete the reference.
> 
> So I'd make this:
> 
>  * This is the RCU-bh equivalent of rcu_dereference_check().  Since v5.8,
>  * synchronize_rcu() waits for code with bottom halves disabled as well
>  * as code between rcu_read_lock() and rcu_read_unlock().

Normally, I would be right there with you on the "less is more"
approach to writing.  But in this particular case:

1.	I added comments to rcu_read_lock_bh(), rcu_read_lock_sched(),
	call_rcu(), and synchronize_rcu().

2.	I included a section entitled "RCU flavor consolidation" in the
	2019 edition of the RCU API: https://lwn.net/Articles/777036/

3.	I presented on this topic at LCA:
	https://www.youtube.com/watch?v=hZX1aokdNiY

4.	I published a paper on this topic:
	https://dl.acm.org/doi/10.1145/3319647.3325836
	http://www.rdrop.com/~paulmck/RCU/rcu-exploit.2019.05.01a.pdf

All of these, even taken together, have proven to be insufficient.
This therefore does not appear to be the place to economize on words.  :-/

Your point on the version (v5.0, as it turns out) is right on, and I
will make that change.

							Thanx, Paul
