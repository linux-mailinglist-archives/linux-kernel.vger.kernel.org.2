Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219744E91B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhKLOpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhKLOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636728173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AINtjk/YrkMUwH1GuZOgeWlXFR64XMnlKMEzq+GpKfw=;
        b=h2d5+dUelei6ZweLNZ6NsiAl/EH36NN0bRnxo+b26IR6Jrsx/3V3JdS9Bb78KiDDSpa90z
        Mq7oRFERiZFG0Ss3b71/5E7GFF6ou2JsdFNXuGpn9CyY+mMSKu+8AH6KEk/7pGwIO95fx7
        EzL1Cv74FF673SenoGflg6W9cKOE8NE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-2XBQ-Q59OJyNOYbE3Kt9Jg-1; Fri, 12 Nov 2021 09:42:51 -0500
X-MC-Unique: 2XBQ-Q59OJyNOYbE3Kt9Jg-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so8425011edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AINtjk/YrkMUwH1GuZOgeWlXFR64XMnlKMEzq+GpKfw=;
        b=AQPOBjTuGoZwenYu+wr7X27elZtX3ntUtlh8+8WxeMNXEQ5y6ftHQqVrG1pPSdOD2n
         BiKI2bqXfw4EZBtinMEbDXaLXvK8TulqyDgw2/TMWD2f4R/fsRUJ6r+GqurGZE0HmhTl
         Wdot0wQqgxkgLqy8wIx12swSiswqvBR/Z4NfUrjovK1cRjn7lEVF/Uz+QMKHeQ+cUvqL
         ANYBqq2j0fl/Vw4CpeseVWw0m5K/Gfbrge5d2fnk0YyMqYWjBYpyCF2694oodm+M/rhF
         Vxjdz2L9AE0mFE1LiQSkF0BAj2tJ61drdIWPPcX5+M91NhZmwSjwfgH+nW+O3RIsfjCz
         pFew==
X-Gm-Message-State: AOAM533WpQgrPfJzD+820IdIfWl8MU3m30mIO+NwMGt3yhfd3ddn1Gwr
        HkpRq6QVCZ0krz3uw6/3v654eq+xn41SMLmFa/esTIVUwv6dtbrga7b7HmVpBUfNW0IfsRwCn0M
        TQDxnRn+AX23/qGDc4TU/erjLVqaewNhsJViztYT/
X-Received: by 2002:a05:6402:12c9:: with SMTP id k9mr21614977edx.364.1636728170396;
        Fri, 12 Nov 2021 06:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIijrSS7MYplqhKKg+YwK9QoNb1SZqR+88OKstncvoYq76MZaGP/VaDqPXvcfbtXEGE16CsXCDWrY4CTW+2JY=
X-Received: by 2002:a05:6402:12c9:: with SMTP id k9mr21614944edx.364.1636728170224;
 Fri, 12 Nov 2021 06:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20211111195904.618253-1-wander@redhat.com> <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com>
In-Reply-To: <YY3GY8ZSH5ACaZZS@google.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 12 Nov 2021 11:42:39 -0300
Message-ID: <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by slow
 console devices
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
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
> > +     if (!rcu_cpu_stall_suppress)
> > +             rcu_cpu_stall_suppress = 4;
> > +}
> > +
> > +static void rcu_console_stall_unsuppress(void)
> > +{
> > +     if (rcu_cpu_stall_suppress == 4)
> > +             rcu_cpu_stall_suppress = 0;
> > +}
> > +
> >  /**
> >   * console_unlock - unlock the console system
> >   *
> > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> >        * and cleared after the "again" goto label.
> >        */
> >       do_cond_resched = console_may_schedule;
> > +
> > +     rcu_console_stall_suppress();
> > +
> >  again:
> >       console_may_schedule = 0;
> >
> > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> >       if (!can_use_console()) {
> >               console_locked = 0;
> >               up_console_sem();
> > +             rcu_console_stall_unsuppress();
> >               return;
> >       }
> >
> > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> >
> >               handover = console_lock_spinning_disable_and_check();
> >               printk_safe_exit_irqrestore(flags);
> > -             if (handover)
> > +             if (handover) {
> > +                     rcu_console_stall_unsuppress();
> >                       return;
> > +             }
> >
> >               if (do_cond_resched)
> >                       cond_resched();
> > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> >       retry = prb_read_valid(prb, next_seq, NULL);
> >       if (retry && console_trylock())
> >               goto again;
> > +
> > +     rcu_console_stall_unsuppress();
> >  }
>
> May be we can just start touching watchdogs from printing routine?
>
Hrm, console_unlock is called from vprintk_emit [0] with preemption
disabled. and it already has the logic implemented to call
cond_resched when possible [1].

[0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
[1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719

