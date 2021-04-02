Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA83530FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhDBWMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBWMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:12:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A840261167;
        Fri,  2 Apr 2021 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617401552;
        bh=jXGSF/80piCp6rM9kOtvYlAFUn+s/QeQepWekdu1jv8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tqPXiSFKg6iQWANHHDirNeu+0nqH7QN00yzteHyj7bflZWcNDBr/753asO2hM2DNt
         I4hwlOwZKCAQPmApG1KJDzZNUmro+dR+JSVw/09IiI/yBm1vDIT/5QFw7E8qWl/9Qo
         n37Sb73cJuCUYM6kBhNAUVcDmUuonV0+PIbTmuV/0KQ1jcE+Mkv5QXckHAeZH3fxoL
         5saY+VK5FXLLREw9/pEKsFO8RX43p6JPo+febOn9E4+C7izIHTt11kEMvqf4e2z/hx
         1oEJv7GNzVelmVadiQs7E/wmEr8+HXlC5qy1DT5h3psnln60SDpzE95BYlhWFqvX9z
         BDqJo4wKIkhDQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4F26B35212A5; Fri,  2 Apr 2021 15:12:32 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:12:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210402221232.GU2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-4-frederic@kernel.org>
 <20210402011241.GO2696@paulmck-ThinkPad-P72>
 <20210402100221.GA134532@lothringen>
 <20210402150357.GQ2696@paulmck-ThinkPad-P72>
 <20210402205038.GB134532@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402205038.GB134532@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 10:50:38PM +0200, Frederic Weisbecker wrote:
> On Fri, Apr 02, 2021 at 08:03:57AM -0700, Paul E. McKenney wrote:
> > On Fri, Apr 02, 2021 at 12:02:21PM +0200, Frederic Weisbecker wrote:
> > > Arguably that's a quite a corner case and I don't expect anyone to call
> > > start_poll_synchronize_srcu() so early but who knows. An alternative is to
> > > forbid it and warn if used before srcu is initialized.
> > 
> > Another approach would be to have start_poll_synchronize_rcu() check to
> > see if initialization has happened, and if not, simply queue a callback.
> > 
> > Any other ways to make this work?
> 
> Ok I think that should work. We want to make sure that the cookies returned
> by each call to start_poll_synchronize_rcu() before rcu_init_geometry() will
> match the gpnums targeted by the corresponding callbacks we requeue.
> 
> Since we are very early and the workqueues can't schedule, the grace periods
> shouldn't be able to complete. Assuming ssp->srcu_gp_seq is initialized as N.
> The first call to call_srcu/start_poll_synchronize_rcu should target gpnum N +
> 1. Then all those that follow should target gpnum N + 2 and not further.
> 
> While we call srcu_init() and requeue the callbacks in order after resetting
> gpnum to N, this should just behave the same and attribute the right gpnum
> to each callbacks.
> 
> It would have been a problem if the workqueues could schedule and complete
> grace periods concurrently because we might target gpnum N + 3, N + 4, ...
> as we requeue the callbacks. But it's not the case so we should be fine as
> long as callbacks are requeued in order.
> 
> Does that sound right to you as well? If so I can try it.

Makes sense to me!

There also needs to be an additional start_poll_synchronize_rcu() check
to avoid double call_rcu() of a single rcu_head structure.  But everything
is single-threaded at that point, and this check is after the check
for already being initialized, so this should be no problem.

And yes, srcu_init() happens well before context switch is possible,
let alone workqueues scheduling.  Famous last words...

							Thanx, Paul
