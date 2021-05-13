Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1437F99C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhEMOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhEMOX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA8D613BC;
        Thu, 13 May 2021 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620915736;
        bh=G4vCXEGiMxTe526VUaPffNnPoAYhrWSx6k1fW7Br7iA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JeScwqKGVsgr8dhA6KWFOjRAaoDSlcmtHzUWvf6gUXHzloUyQoJxbsaB4huYd3P36
         lAFHgMB2WIX4en8vqNUCsk05TNuzhIyf8ed4r1qYS91kZ14pbCNfs8LvFaoXtazihE
         qVFpkOidoo2M0iOyZG3iersgwhHkFrUl8DNJkAtDEqxF/Qie9y8TjIW1k46BydMDKY
         OuhWmqohwaD6MA1RXvT2/c/BjCkRCKM3YETSZnE+rLWXLppMJPgaJEZUUxKow5XWKX
         lowu3OXrZ/6mMjI3OWpXc8bCAuD9mrDDMC+QqzkJJ2hV6jRfsTVx1id1buvsoigxZT
         unJPgCEppFlDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8100C5C014E; Thu, 13 May 2021 07:22:16 -0700 (PDT)
Date:   Thu, 13 May 2021 07:22:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched/isolation: reconcile rcu_nocbs= and nohz_full=
Message-ID: <20210513142216.GZ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
 <20210422212448.GJ975577@paulmck-ThinkPad-P17-Gen-1>
 <YJ0X6MciAc36TMJc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ0X6MciAc36TMJc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:13:28PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > On Mon, Apr 19, 2021 at 12:26:59AM -0400, Paul Gortmaker wrote:
> > > We have a mismatch between RCU and isolation -- in relation to what is
> > > considered the maximum valid CPU number.
> > > 
> > > This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
> > > fact the former will enforce the latter.  So we don't want a CPU mask to
> > > be valid for one and denied for the other.
> > > 
> > > The difference 1st appeared as of v4.15; further details are below.
> > 
> > I pulled this into -rcu for testing and further review.
> > 
> > If it should instead go through some other tree:
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks - added this fix to tip:sched/core.

Very good, I will drop it from -rcu later today, Pacific Time.

							Thanx, Paul
