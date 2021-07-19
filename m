Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22D73CD62C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhGSNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239352AbhGSNOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CED6E601FF;
        Mon, 19 Jul 2021 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626702883;
        bh=3tPYHJRCtyoikc4wbq0m278Es/pj7dJKMWmF4o9SYdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBqipVouv/afMeOExIbgc8TRLYvc+TzbDan0pk48/NMDDBYu9+VnfgMKHmuc+Zbfq
         oWannhkXisQ/J/4F2Ckwh9SGyqS0FnscUjQX2O0IU5RwlWxdXLgGF83mCYFWSnVvsV
         8vLSBnh1vBhyM6GTLrA2McF8IexugqXkb5iEfBPVk8+3H0RZWQBXOqRXJzIccNaQpu
         nY1NkZ9fDJLnUBG78SFGQwpUMX3RpwUDdOczwXWqtTG+8k7HH8A5VrKUo5anc6tDeN
         XvGtRyFXyWmD1YcG12u80zCsWOifgfNV/VNTGGEhyAuzYVW9y4PnE0raywRGksDTW9
         44zyrQ+BNGjRg==
Date:   Mon, 19 Jul 2021 15:54:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     He Zhe <zhe.he@windriver.com>, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
Message-ID: <20210719135440.GC116346@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
 <20210708153620.GA6716@lothringen>
 <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
 <20210709084303.GA17239@lothringen>
 <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
 <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
 <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
 <20210710005243.GA23956@lothringen>
 <95fb6503b1513cff1df54a043d9e3df530ddd63a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95fb6503b1513cff1df54a043d9e3df530ddd63a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 06:38:37PM +0200, Nicolas Saenz Julienne wrote:
> On Sat, 2021-07-10 at 02:52 +0200, Frederic Weisbecker wrote:
> > I guess later we can turn this .timers_pending into
> > .timers_count and that would spare us the costly call to
> > __next_timer_interrupt() up to the last level after the last
> > timer is dequeued.
> 
> I've been looking into this. AFAIU there is no limit to the number of timers
> one might enqueue, so there is no fool proof way of selecting .timers_count's
> size. That said, 'struct timer_list' size is 40 bytes (as per pahole), so in
> order to overflow an u32 .timers_count you'd need to allocate ~160GB in 'struct
> timer_list' which I think is safe to assume will never happen.
> 
> Also, I measured the costy call to __next_timer_interrupt() it's slightly less
> than 1us on my test machine. Not a that big in the grand scheme of things, but
> it's in the irq exit code path, so I think it's worth the extra complexity in
> the timer code.

And also each time we iterate the idle loop. In fact __next_timer_interrupt()
won't always have the same cost: the worst case is when the wheel is entirely
empty after the last removal and we need to walk through all 9 levels. It's
a pretty common case because it happens when the last timer expires.

And that's the only one case to measure because it's the only one covered
by the counter.

> 
> Any thoughs?
> 
> -- 
> Nicolás Sáenz
> 
