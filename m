Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9A399ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:34:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFCGew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:34:52 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B82921FD4D;
        Thu,  3 Jun 2021 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622701987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d7iutrIVQKysvdt5z7MYC93Y1HKMzZlp9EFA0JQ3iwg=;
        b=DJtTKATFP2x2ettob3iQALh8nf3OxNsq/Fnod8NLII/48jvlR4Q7j8TCfEzc1Z/6QIZ/2R
        QLCWCJASmxEXfXPNYox8JeC6DY2QYcFKa8ca0zX9CB0A9hYENzQetBoaPmEA4yLJuFmab2
        3tcX+v/uXLV+Iyo6DI9Por7IwMqnufw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE921A3B85;
        Thu,  3 Jun 2021 06:33:06 +0000 (UTC)
Date:   Thu, 3 Jun 2021 08:33:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YLh3oqUiHGTtWJIC@alley>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
 <20210531162051.2325-2-john.ogness@linutronix.de>
 <YLY9NR7C1IFuNI4A@alley>
 <874keh3bsv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874keh3bsv.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-01 16:21:52, John Ogness wrote:
> On 2021-06-01, Petr Mladek <pmladek@suse.com> wrote:
> >> +void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
> >
> > I think about calling this printk_cpu_lock_irqsave() to make it clear
> > that it disables interrupts.
> 
> Agreed.
> 
> > Strictly speaking, it should be enough to disable preemption. If it is
> > safe when interrupted by NMI, it must be safe also when interrupted
> > by a normal interrupt.
> >
> > I guess that the interrupts are disabled because it reduces the risk
> > of nested (messed) backtraces.
> 
> If it was just about synchronizing output triggered by sysreq, then it
> probably would be acceptable to leave interrupts active. But when atomic
> consoles are involved, we are talking about a crashing machine that is
> trying to get log messages out. Any interrupt is a risk that the machine
> may not survive long enough to return from that interruption.

Fair enough. It might be good to mention this motivation in the commit
message or in a code commentary. IMHO, it is always good to know
whether these things a must to have or if there is another reason.
Anyway, it was not obvious to me ;-)

Best Regards,
Petr
