Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCC352949
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhDBKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235087AbhDBKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27F6960FEE;
        Fri,  2 Apr 2021 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617357743;
        bh=kUiz7HnSsLZJGnb9d11ae/vOTxBB4CDr9BAzgmqKnt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWd9uUCc3fzczeJpSgAgSMmcYWQtpUFH0fM+zM+LxU4lGewRE5PU5YmvovOVe4Zmg
         lT3QQenXuiUTVi9jMzo9hWJxbQbUClScd9ZYRTWIQ5VOmE3TEkC7qHWAfUaq3m7oh3
         72mMYFh3N3wHu9OcbMGxnf/gl7tXWzcDG04UOAiOXQ09Wymus34QOBrxj1CcMli2a9
         TCP3TUuhakr3F3J17UOepXte3UvuqHVqwxtEN7nywNgUj9BK7iaSGaf9vpNm1aol7D
         c+BywdvFqY0JxfzYweRSmG8nVi2Wh2OJWAx22qq10xnn8wWgrnFDSnTJDKV7KvlI0W
         O+vsZzUAQcRnA==
Date:   Fri, 2 Apr 2021 12:02:21 +0200
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
Message-ID: <20210402100221.GA134532@lothringen>
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-4-frederic@kernel.org>
 <20210402011241.GO2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402011241.GO2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:12:41PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 02, 2021 at 01:47:04AM +0200, Frederic Weisbecker wrote:
gg> >  void __init srcu_init(void)
> >  {
> > -	struct srcu_struct *ssp;
> > +	static struct srcu_data __initdata old_sdp;
> > +	static struct srcu_node __initdata old_mynode;
> > +	struct srcu_struct *ssp, *tmp;
> >  
> >  	srcu_init_done = true;
> > -	while (!list_empty(&srcu_boot_list)) {
> > -		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> > -				      work.work.entry);
> > +	/*
> > +	 * ssp's that got initialized before rcu_init_geometry() have a stale
> > +	 * node hierarchy. Rebuild their node trees and propagate states from
> > +	 * pruned leaf nodes.
> > +	 */
> > +	list_for_each_entry_safe(ssp, tmp, &srcu_early_init_list, early_init) {
> > +		struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
> > +
> > +		list_del(&ssp->early_init);
> > +		old_sdp = *sdp;
> > +		old_mynode = *sdp->mynode;
> > +		init_srcu_struct_nodes(ssp);
> > +		restore_srcu_sdp(sdp, &old_sdp, &old_mynode);
> 
> Why not just pull all of the pre-initialization callbacks onto a local
> list (re-initialization the rcu_segcblist structures if necessary),
> then iterate through that list re-invoking call_srcu() on each?
> There shouldn't be that many pre-initialization call_srcu() invocations,
> and if someday there are, it would not be hard to make __call_srcu()
> take lists of callbacks and a count instead of a single callback, correct?
> 
> Or am I once again missing something basic?

So that would work for callbacks based started grace periods but not for the
others. So if anybody calls start_poll_synchronize_rcu() early, simply requeuing
the callbacks won't help. Even worse, a blind reinitialization of the ssp would
lose the started grace period and a future poll_state_synchronize_rcu() might
never succeed.

Arguably that's a quite a corner case and I don't expect anyone to call
start_poll_synchronize_srcu() so early but who knows. An alternative is to
forbid it and warn if used before srcu is initialized.

Thanks.
