Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED83524E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 03:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDBBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 21:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhDBBBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 21:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D84F6112E;
        Fri,  2 Apr 2021 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617325282;
        bh=2XUfjK/K6Lzq9EJhc8+q6SuI87XxdnM/juFSu3J01JE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A5MxzdStSf4z+WVIdXJeCcmtHQH2ZXH5Ix3Izb4Ky/ams/k/uGTEwVHUEuy0xq2fb
         mRGC8RyvjQ+tTcgvxvpYQ8I3+G6caVtdRj266EbAPsyKhGq5PoYA4o7YyOOzsGELE7
         6WH6E/NIbtvXIQZMRjUdPAZKBVINn6hhH5bU0LSPPQrJnQ347TOVLlMNc29OFwGhhP
         xJulR9yhSc2kU1hE/XBSaiQT9yBCUT/rJVwbtx2qI7SYiu8gcouVEgdWC7ycyonpjT
         7FqWM90Y3XegrhkiLfR0vb+5Rn7jFJR06s3zz40t+8zSncJCghtsno3plVVNrC43Xb
         U6rkeiUWXbYIQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E29883523A03; Thu,  1 Apr 2021 18:01:21 -0700 (PDT)
Date:   Thu, 1 Apr 2021 18:01:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] srcu: Remove superfluous ssp initialization on
 deferred work queue
Message-ID: <20210402010121.GA7355@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-2-frederic@kernel.org>
 <20210402004856.GM2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402004856.GM2696@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:48:56PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 02, 2021 at 01:47:02AM +0200, Frederic Weisbecker wrote:
> > When an ssp has already started a grace period and queued an early work
> > to flush after SRCU workqueues are created, we expect the ssp to be
> > properly initialized already. So we can skip this step at this stage.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > ---
> >  kernel/rcu/srcutree.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 036ff5499ad5..7197156418e4 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1396,7 +1396,6 @@ void __init srcu_init(void)
> >  	while (!list_empty(&srcu_boot_list)) {
> >  		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> >  				      work.work.entry);
> > -		check_init_srcu_struct(ssp);
> 
> You lost me on this one.  What happens if the only pre-initialization
> invocation on the statically allocated srcu_struct pointed to by ssp
> was call_srcu()?  I am not seeing how the initialization has already
> happened in that case.
> 
> What am I missing here?

Idiot here was looking at Tiny SRCU's call_srcu(), not that of Tree SRCU.
Never mind, I will queue this one as well.

							Thanx, Paul

> >  		list_del_init(&ssp->work.work.entry);
> >  		queue_work(rcu_gp_wq, &ssp->work.work);
> >  	}
> > -- 
> > 2.25.1
> > 
