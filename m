Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169FC34575C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCWFcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhCWFcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:32:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B7F8619AF;
        Tue, 23 Mar 2021 05:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616477551;
        bh=SS2DXZz2i+lWJzqGiLw1xx0ovgUUtAO61e+StnYHjDU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k1szK608XWm2MyH3SQhoeOOtXqaLcjPv9H7UtIKUPQCxJa5lI3I8VWPg8872v217T
         QpvT/3hUO/Y1ktZlSc0BX7utA+i0jJeQnCxdVkaoXyiYQOh+ss3IOQIsgMXTHh4Kfz
         xRdTT5DBiox0Y6FJOD3Di5MxxUqqPgU57haSzESj1L3HCxy30+fYEkvzHktMVB6ue8
         MWHLqx7gxUO+4rhJoeXZ77R6khZQBM+6XDBvWZWOTNdxubELTxdmo3CrumlNwespaG
         Y6iXznXH+6utMRqeT2ja21gv3A7R7ne3y4zvSDnt0c82+yyU4ZmF2iD+0l/qprKYpY
         tjHNMijwuAEeA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 27ABF35239E6; Mon, 22 Mar 2021 22:32:31 -0700 (PDT)
Date:   Mon, 22 Mar 2021 22:32:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix various typos in comments
Message-ID: <20210323053231.GT2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210322230258.GA1983587@gmail.com>
 <70fcf956-5242-db43-b039-eb82f722eb36@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fcf956-5242-db43-b039-eb82f722eb36@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:55:05PM -0700, Randy Dunlap wrote:
> On 3/22/21 4:02 PM, Ingo Molnar wrote:
> > 
> > Hi Paul,
> > 
> > Was working on automation to make it a bit more straightforward to fix 
> > typos within comments (which we tend to reintroduce during 
> > development), and here are the ones it found in the RCU code.
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> > =========>
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Mon, 22 Mar 2021 23:57:26 +0100
> > Subject: [PATCH] rcu: Fix various typos in comments
> > 
> > Fix ~12 single-word typos in RCU code comments.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c                                           | 4 ++--
> >  kernel/rcu/sync.c                                               | 2 +-
> >  kernel/rcu/tasks.h                                              | 8 ++++----
> >  kernel/rcu/tree.c                                               | 4 ++--
> >  kernel/rcu/tree.h                                               | 2 +-
> >  kernel/rcu/tree_plugin.h                                        | 2 +-
> >  tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h | 2 +-
> >  7 files changed, 12 insertions(+), 12 deletions(-)
> 
> > diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> > index d4558ab7a07d..3eeb871cf0de 100644
> > --- a/kernel/rcu/sync.c
> > +++ b/kernel/rcu/sync.c
> > @@ -94,7 +94,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
> >  		rcu_sync_call(rsp);
> >  	} else {
> >  		/*
> > -		 * We're at least a GP after the last rcu_sync_exit(); eveybody
> > +		 * We're at least a GP after the last rcu_sync_exit(); everybody
> >  		 * will now have observed the write side critical section.
> >  		 * Let 'em rip!.
> 
> 		Drop the '.'.
> 
> >  		 */
> Otherwise LGTM. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied, dropping the "." and adding the Reviewed-by.

Thank you both!

							Thanx, Paul
