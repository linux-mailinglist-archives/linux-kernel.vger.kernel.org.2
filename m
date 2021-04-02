Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9A353067
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhDBUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3CD3610CC;
        Fri,  2 Apr 2021 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617396641;
        bh=0Ax51oRuPovlp3aM1JtM+jBcjX5iSBj0pzbz5C8UCeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkTNhUcZPMhxIi5tdWbvNZlct/lXnSrtiWKDHDDoi9XMjEmDXOd/8hG8QqJrpcOuG
         11BVdUHref6TA76BzeFtkG6S0ygDSnaSAiVCdX69UtUMZ3SEk1htlGBvBGOppDUE8j
         vv9A8el+IqQldtK8Qp48SHqBCGSGlE/g8FXZUFZp7iIBZ7RotRD2H9deIWgx0ouJxc
         sr4EnvYnk9FwDctWCNNWf1SFvBtYLQM50auL8wnhTTUCIycXyusFRQDlWAY5refvad
         F2yIxhAV6l88+CZ1KlfahrKseID/ZNHKFBxgJZo45T5lp8QMdVscnmIKViDXwmoA+E
         0odCDMaVz527w==
Date:   Fri, 2 Apr 2021 22:50:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210402205038.GB134532@lothringen>
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-4-frederic@kernel.org>
 <20210402011241.GO2696@paulmck-ThinkPad-P72>
 <20210402100221.GA134532@lothringen>
 <20210402150357.GQ2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402150357.GQ2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:03:57AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 02, 2021 at 12:02:21PM +0200, Frederic Weisbecker wrote:
> > Arguably that's a quite a corner case and I don't expect anyone to call
> > start_poll_synchronize_srcu() so early but who knows. An alternative is to
> > forbid it and warn if used before srcu is initialized.
> 
> Another approach would be to have start_poll_synchronize_rcu() check to
> see if initialization has happened, and if not, simply queue a callback.
> 
> Any other ways to make this work?

Ok I think that should work. We want to make sure that the cookies returned
by each call to start_poll_synchronize_rcu() before rcu_init_geometry() will
match the gpnums targeted by the corresponding callbacks we requeue.

Since we are very early and the workqueues can't schedule, the grace periods
shouldn't be able to complete. Assuming ssp->srcu_gp_seq is initialized as N.
The first call to call_srcu/start_poll_synchronize_rcu should target gpnum N +
1. Then all those that follow should target gpnum N + 2 and not further.

While we call srcu_init() and requeue the callbacks in order after resetting
gpnum to N, this should just behave the same and attribute the right gpnum
to each callbacks.

It would have been a problem if the workqueues could schedule and complete
grace periods concurrently because we might target gpnum N + 3, N + 4, ...
as we requeue the callbacks. But it's not the case so we should be fine as
long as callbacks are requeued in order.

Does that sound right to you as well? If so I can try it.

Thanks.
