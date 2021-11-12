Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5874E44E03F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhKLC02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhKLC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:26:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01BA460EE7;
        Fri, 12 Nov 2021 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636683817;
        bh=9CuwnlX45L/XmiymTl8nfQxEOW9aHHJeZ9weRSnfPh0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iZzJpj1ShAOft+sWJOm/Pv8dWEXLrxZNhlDoZf2+B+d6/xAu89B5iV6usmWj8kpY7
         GJJ6C7YTecD0lo030iIHBNcWjZU63aWafBcVFZArUMkRWiCUOoQLpkflCuXa2PlEO7
         zOPuNqoCCzwpRn1XfSVL1gn/xf6aw5a/gOqwiOgMNG/CYPTFDb3IOf/TIWCzNcxCZT
         z0s/DkfabGVTLCcdj4uP0ua6NDsMyWPdwkgbO3fTzj1hWwIptDO3QpRkPBWrsI8SH6
         n/luXYdEgzSoAiHVDB48hIJ4i2HjisW12V3CBWNkNPmAaUVSz4UhbWA/6ZHoTvzox+
         Tgp4qcIrNZtpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B95865C06AF; Thu, 11 Nov 2021 18:23:36 -0800 (PST)
Date:   Thu, 11 Nov 2021 18:23:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <20211112022336.GT641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY3GY8ZSH5ACaZZS@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:41:55AM +0900, Sergey Senozhatsky wrote:
> On (21/11/11 16:59), Wander Lairson Costa wrote:
> > 
> > If we have a reasonable large dataset to flush in the printk ring
> > buffer in the presence of a slow console device (like a serial port
> > with a low baud rate configured), the RCU stall detector may report
> > warnings.
> > 
> > This patch suppresses RCU stall warnings while flushing the ring buffer
> > to the console.
> > 
> [..]
> > +extern int rcu_cpu_stall_suppress;
> > +
> > +static void rcu_console_stall_suppress(void)
> > +{
> > +	if (!rcu_cpu_stall_suppress)
> > +		rcu_cpu_stall_suppress = 4;
> > +}
> > +
> > +static void rcu_console_stall_unsuppress(void)
> > +{
> > +	if (rcu_cpu_stall_suppress == 4)
> > +		rcu_cpu_stall_suppress = 0;
> > +}
> > +
> >  /**
> >   * console_unlock - unlock the console system
> >   *
> > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> >  	 * and cleared after the "again" goto label.
> >  	 */
> >  	do_cond_resched = console_may_schedule;
> > +
> > +	rcu_console_stall_suppress();
> > +
> >  again:
> >  	console_may_schedule = 0;
> >  
> > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> >  	if (!can_use_console()) {
> >  		console_locked = 0;
> >  		up_console_sem();
> > +		rcu_console_stall_unsuppress();
> >  		return;
> >  	}
> >  
> > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> >  
> >  		handover = console_lock_spinning_disable_and_check();
> >  		printk_safe_exit_irqrestore(flags);
> > -		if (handover)
> > +		if (handover) {
> > +			rcu_console_stall_unsuppress();
> >  			return;
> > +		}
> >  
> >  		if (do_cond_resched)
> >  			cond_resched();
> > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> >  	retry = prb_read_valid(prb, next_seq, NULL);
> >  	if (retry && console_trylock())
> >  		goto again;
> > +
> > +	rcu_console_stall_unsuppress();
> >  }
> 
> May be we can just start touching watchdogs from printing routine?

You could invoke cond_resched() periodically and keep RCU happy.

But if you also get stall warnings in PREEMPT=y kernels, something
more is required.

							Thanx, Paul
