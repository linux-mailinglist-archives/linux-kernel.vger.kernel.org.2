Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7603BD878
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhGFOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhGFOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EDBB619B4;
        Tue,  6 Jul 2021 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625580217;
        bh=SlVNiPbVwivuijrsvG9rmj7KMdvuRpGvNZME7KtyPLE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dWfAm7VKcJ8uQmZAof7gx5Uelo11PLuriPZYcIK4GYL5p1y5TioA4vtoBMx5nsz+m
         oN0cZelDqlNppqjqvLvsbfgavFhe/YQUlMBypxvww9q1ZQa+Mknon43OETnZ3wlZil
         mmDihmTprS+HqDQpz2n0KPrud4LIFF11CmGeOsXKAgwgk+evnNlbFblPezDSR47cG3
         8v6xBdikj8t2p7BljGrdDMKZarxDV8RdQ665zqiUd/CHF0+lHwD07u3/Q8HgnJyn4s
         3rdV7B7c37CYkKfjQyGrsPZvtOV0yiZF/O+pzXKS6TBMOy45EtJxovKtTCSTPrlkJz
         8TotspibDvbRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E6EC5C034D; Tue,  6 Jul 2021 07:03:37 -0700 (PDT)
Date:   Tue, 6 Jul 2021 07:03:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <20210706140337.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
 <YOQNgsS9Tjt4aDmG@hirez.programming.kicks-ass.net>
 <CANpmjNNRAJ34KUF-1hWrP3F0Ooy4oi6kbH82WWpDxmVqVSj4SA@mail.gmail.com>
 <YOQxYJaypdsmqhlX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOQxYJaypdsmqhlX@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 12:33:04PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 06, 2021 at 10:44:46AM +0200, Marco Elver wrote:
> > On Tue, 6 Jul 2021 at 10:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > [...]
> > > In that case, would not an explicit: data_debug(addr) call (implemented
> > > by KASAN/KCSAN/whoever), which would report whatever knowledge they have
> > > about that address, be even more useful?
> > 
> > KCSAN/KASAN report data-races/memory errors as soon as they encounter
> > them, but before they do, cannot give you any more than that (metadata
> > if it exists, but not sure it can be interpreted in any useful way
> > before an error occurs).
> > 
> > But maybe I misunderstood. Is data_debug() meant to not return
> > anything and instead just be a "fake access"?
> 
> Mostly just print any meta data that you might have. Like who allocated
> it, or which code touched it. I'm thinking KASAN/KCSAN need to keep
> track of such stuff for when a violation is detected.
> 
> If I understand Paul right; and there's a fair chance I didn't; I tihnk
> the issue is that when RCU finds a double call_rcu() (or some other
> fail), it has very little clue how we got there, and any addition
> information might be useful.

If it is a current reference, we know that reference is relevant.
After all, if the structure is being passed to call_rcu(), then there
better not not be something else referencing it right now.  But the
historical data you are (I think?) asking for might be completely
irrelevant due to its having happened too long ago.

							Thanx, Paul
