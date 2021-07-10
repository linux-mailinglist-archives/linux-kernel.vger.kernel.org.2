Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DAD3C33CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhGJJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 05:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhGJJIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 05:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D45A611CD;
        Sat, 10 Jul 2021 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625907937;
        bh=S4kecq9F6JmOhA5tFROcx7hRmDIKucWFNWd98Yyw86s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9tCROnnRYt7iRl6l8x9N0HbxyJ4kbAQrVXbc5lz4zgGPz6ok1PkKz148IBTh9AY0
         g3ob11Rw0qmOVU/Ttpl+o3Lw/6GouTKqTu+SUlXTL0WT0QoImgVVfykPKZzVlbxjPe
         qOjbjnC1BGNJ+HcIYZ/diazdBUCnzhfON6JI1/JaUq8NDQPlLReOAbyddeLiWw+jMN
         uMFsPskd7Kl/rpDGt/vIY5fcwOweKuwbfx0tpZ42xxA8r5eJCNemP9bdOAI4xERnfU
         FL8gYyjIPuxj37Jk/KbkI5fuJF5kW273ReZOKkpT/wc7reEbSBP0GzdBLZGL8V3Fkm
         gayM1VJvM3CRA==
Date:   Sat, 10 Jul 2021 11:05:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     He Zhe <zhe.he@windriver.com>, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
Message-ID: <20210710090535.GA28305@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
 <20210708153620.GA6716@lothringen>
 <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
 <20210709084303.GA17239@lothringen>
 <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
 <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
 <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 04:13:25PM +0200, Nicolas Saenz Julienne wrote:
> 31cd0e119d50 ("timers: Recalculate next timer interrupt only when
> necessary") subtly altered get_next_timer_interrupt()'s behaviour. The
> function no longer consistently returns KTIME_MAX with no timers
> pending.
> 
> In order to decide if there are any timers pending we check whether the
> next expiry will happen NEXT_TIMER_MAX_DELTA jiffies from now.
> Unfortunately, the next expiry time and the timer base clock are no
> longer updated in unison. The former changes upon certain timer
> operations (enqueue, expire, detach), whereas the latter keeps track of
> jiffies as they move forward. Ultimately breaking the logic above.
> 
> A simplified example:
> 
> - Upon entering get_next_timer_interrupt() with:
> 
> 	jiffies = 1
> 	base->clk = 0;
> 	base->next_expiry = NEXT_TIMER_MAX_DELTA;
> 
>   'base->next_expiry == base->clk + NEXT_TIMER_MAX_DELTA', the function
>   returns KTIME_MAX.
> 
> - 'base->clk' is updated to the jiffies value.
> 
> - The next time we enter get_next_timer_interrupt(), taking into account
>   no timer operations happened:
> 
> 	base->clk = 1;
> 	base->next_expiry = NEXT_TIMER_MAX_DELTA;
> 
>   'base->next_expiry != base->clk + NEXT_TIMER_MAX_DELTA', the function
>   returns a valid expire time, which is incorrect.
> 
> This ultimately might unnecessarily rearm sched's timer on nohz_full
> setups, and add latency to the system[1].
> 
> So, introduce 'base->timers_pending'[2], update it every time
> 'base->next_expiry' changes, and use it in get_next_timer_interrupt().
> 
> [1] See tick_nohz_stop_tick().
> [2] A quick pahole check on x86_64 and arm64 shows it doesn't make
>     'struct timer_base' any bigger.
> 
> Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

He Zhe, does it fix your issue?

Thanks.
