Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957AA389CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhETEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhETEzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7D24611AE;
        Thu, 20 May 2021 04:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621486443;
        bh=L6DSXhHdKQSxlvvlLMaDbmTO96rEstMo7pXyyKUcSAs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aGoU80/7a2RBQ+aR0pfWgmb3OyOI2BEWp/+Eh1IMqM5zoZM7dj/23aI8fBuugggxB
         lzdRqwA5Pe8GFPsQlgw7WjzMOVk372qKOMyvFLJrXDgdlziVWjSBITD0wTmgJo04NH
         /Ud0QL/V8KLe+Wn2kRdX2d4LUCJw+KpgCPlWvMkX35cHYB3vFMZPIt7w/+42GTyiTZ
         5ImkUY7ZtQs2bBqhe5ChJSq9UqGjiYkvL+sNgNw8IfWIX2fJD/3ZhLLryO6S93wQzP
         65TIVDyjgWdyNkPQAlzvcJsypEHadUfcBPMOETsHJxj+oRj3gY7gdVRflS0obNJue5
         KD7zj9yo7NU+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 99BB75C0138; Wed, 19 May 2021 21:54:03 -0700 (PDT)
Date:   Wed, 19 May 2021 21:54:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu: Assume rcu_report_dead() always deals with
 local CPU
Message-ID: <20210520045403.GF4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-4-frederic@kernel.org>
 <20210519185107.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210520005426.GB22836@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520005426.GB22836@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 02:54:26AM +0200, Frederic Weisbecker wrote:
> On Wed, May 19, 2021 at 11:51:07AM -0700, Paul E. McKenney wrote:
> > On Wed, May 19, 2021 at 02:09:30AM +0200, Frederic Weisbecker wrote:
> > > rcu_report_dead() is always called locally from the idle path. Passing
> > > a CPU number to it suggests otherwise and is rather error-prone as the
> > > code inside relies on locality.
> > > 
> > > Robustify the function prototype and refine the name along the way.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Makes a lot of sense, thank you!
> > 
> > On the function name, here is the list:
> > 
> > int rcutree_prepare_cpu(unsigned int cpu) -- notifier from any CPU.
> > void rcu_cpu_starting(unsigned int cpu) -- direct call on incoming CPU.
> > int rcutree_online_cpu(unsigned int cpu) -- notifier from any CPU.
> > 
> > int rcutree_offline_cpu(unsigned int cpu) -- notifier from any CPU.
> > void rcu_report_dead(unsigned int cpu) -- direct call on outgoing CPU.
> > void rcutree_migrate_callbacks(int cpu) -- direct call from surviving CPU.
> > int rcutree_dead_cpu(unsigned int cpu) -- notifier from any CPU.
> > 
> > Note that rcu_report_dead() can also be invoked from cpu_die_early() on
> > other CPU when onlining a CPU fails.  This happens on arm64.  Which might
> > be an arm64 bug, but unless I am missing something it is a case where
> > rcu_report_dead() is called non-locally.
> 
> Hmm, I see it only called with smp_processor_id() from cpu_die_early().

I clearly should have looked at the initialization of that "cpu"
local variable.  Once again, right you are!

> > And the naming is currently a bit random, isn't it?  :-/
> > 
> > Maybe rcutree_*_cpu() if there is a CPU parameter and rcutree_*_self()
> > if all calls run on the CPU in question?
> 
> Makes sense. Or rcutree_*_curr_cpu() but it's going to produce long names.

Either way, it should be a separate patch.

> > I cannot immediately think of a reason to make names reflect whether
> > the corresponding functions are directly called or are called via notifier.
> > Thoughts?
> 
> No indeed, let's wait for some convention to ever emerge :)

Sounds like a long wait, but that works for me!

							Thanx, Paul
