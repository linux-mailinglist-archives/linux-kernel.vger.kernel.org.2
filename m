Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719F1417069
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhIXKjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhIXKjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5716B60F70;
        Fri, 24 Sep 2021 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632479894;
        bh=XcXsghWhgwPvc1dsE7ugfOw4GjwzgSXM9EtiBpQ3Dd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIw4MhV2oP1lOclE7ntvE4CYG4tV6tHQD9GjsClxsIUdc9gxms7CFfqr4lwZ5S9jf
         t092MF0pOyujab4Jti/BzCb7aXifZ5m3ugiODlGIIGc5WxtIIiDEwotzc9b56775H0
         rBX9rOQXRNbHviSIjES+lOtBoyqfx0IlmfEQfrCC+AHmZPmNGC47dLGEbCqhBYjB+B
         f+wf4n8etTe3V4lA1L1vH1MfvZqhjXG8+fMRLKEwdVPETQlWg9cX9TS9nvx6gCJshD
         +/54AfGRhlxlmIZ3FzowlWKeHJs5v+Om5e31Y7CZy9vj1QZB5jybMy/mT4o+LzchT7
         6XSVIBk/X85CA==
Date:   Fri, 24 Sep 2021 12:38:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Chung-Ki Woo <chungki0201.woo@samsung.com>
Subject: Re: [Issue] timer callback registered with mod_timer is getting
 called beforetime
Message-ID: <20210924103812.GA142770@lothringen>
References: <CGME20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
 <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maninder,

On Fri, Sep 24, 2021 at 12:23:10PM +0530, Maninder Singh wrote:
> Hi,
> 
> 
> we are facing issue of early invocation of timer callback(kernel versio 5.4), Is it known issue for timer callback?
> 
> As we checekd code if CPU responsible for updating jiffies value(lets say CPU0) has interrupts disabled for 60 ms
> and in mean time other CPU(CPU1) registers new timer for (jiffies + x) value. its callback will be called before time.
> 
> As it reads old jiffies value and register callback for x jiffies afterwards, but instead it is called
> at x - y jiffies. (y is lapsed period which CPU 1 does not know from jiffies)
> 
> 
> CPU 0                             CPU 1
> 
> // last jiffies updated
> local_irq_disable();              do_some_work()
> do_work()                         ....
> ...                               ....
> ...                               ....
> ... // 60 ms                      mod_timer(&timer, jiffies + x); // read old jiffies value
> local_irq_enable()                ...
> // new jiffies updated with       // timer interrupt reads updated jiffies and calls callback function where x was not actually passed on HW clock.
> // jiffies + 16
> 
> 
> we tried with TC (with 500 ms irq disable just to check behaviour, in actual issue it was 60 ms IRQ disable)
> 
> // IRQs disabled on same CPU0 responsible for jiffies updation for 500 mili seconds
> 
> [23.5598] ##### disable IRQs
> [24.0600] ##### registered timer 25025334960 5887  //registered timer at HW clock 25.025 seconds for 600 ms at 5887 jiffies on CPU1
> 
> [24.0604] ##### ticks change abruptly 5887 124   //IQRS enabled, CPU0 increments 124 jiffies colllectively because of irq disable long time
> 
> [24.1595] ##### timer called 25124783406 6037   // as per jiffies callback trigger at 6037 jiffies i.e. after 150 jiffies(600ms)
>                                                // but HW clock is passed only 100 milliseconds.
> 
> 
> 
> Is it known behaviour for timers?
> because only 1 CPU is assigned to update jiffies work to call do_timer utill unless it goes to idle state and pass ownership to other CPU.
> 
> we tried by making all CPU to handle code for jiffies updation (it will add performance hit)
> but then no issue of abrupt jiffies change occured on system.

First of all, are you meeting this issue specifically on NOHZ_FULL? Because
there is a pending fix for a related matter there:

      https://lore.kernel.org/lkml/20210915142303.24297-1-frederic@kernel.org/

As for what you're reporting here, I think the core problem is the fact that the
timekeeper (jiffies updater) is stuck with IRQs disabled for way too long. Even
one millisecond is too much to tolerate. Do you have any idea about the source of
that situation?

Thanks.

