Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3F344F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhCVTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:02:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47893 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232372AbhCVTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:01:30 -0400
Received: (qmail 678067 invoked by uid 1000); 22 Mar 2021 15:01:25 -0400
Date:   Mon, 22 Mar 2021 15:01:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] USB: ehci: drop workaround for forced irq threading
Message-ID: <20210322190125.GD675969@rowland.harvard.edu>
References: <20210322111249.32141-1-johan@kernel.org>
 <20210322164200.GB667925@rowland.harvard.edu>
 <20210322165917.it5d5f5kuvs7jah5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322165917.it5d5f5kuvs7jah5@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:59:17PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-03-22 12:42:00 [-0400], Alan Stern wrote:
> > What happens on RT systems?  Are they smart enough to avoid the whole 
> > problem by enabling interrupts during _all_ callbacks?
> 
> tl;dr: Yes. 
> 
> The referenced commit (id 81e2073c175b) disables interrupts only on !RT
> configs so for RT everything remains unchanged (the backports are
> already adjusted for the old stable trees to use the proper CONFIG_* for
> enabled RT).
> 
> All hrtimer callbacks run as HRTIMER_MODE_SOFT by default. The
> HRTIMER_MODE_HARD ones (which expire in HARDIRQ context) were audited /
> explicitly enabled.
> The same goes irq_work.
> The printk code is different compared to mainline. A printk() on RT in
> HARDIRQ context is printed once the HARDIRQ context is left. So the
> serial/console/… driver never gets a chance to acquire its lock in
> hardirq context.
> 
> An interrupt handler which is not forced-threaded must be marked as such
> and must not use any spinlock_t based locking. lockdep/might_sleep
> complain here already.

Okay, in that case:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
