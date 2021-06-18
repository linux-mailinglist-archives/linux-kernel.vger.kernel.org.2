Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8C3ACE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhFRO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhFRO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:57:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:55:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624028137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KR3HX4/+i4plryORjpOnMONKZ2mk+i6c6onI71WK80U=;
        b=PRGmnkHnPP1/zA40j0r6L+AGKbLadfTH8rV3Zz6Ud848H/nCC85yY/+OU33U/srJpqC+P+
        WgW/Nyx6B7CQlorMgoj4lERY9LrwkhpLuDOpp5RD+z54yKDcSTcA/C+0erJeMe/ACIaGiL
        D+hwBezFmHuxlN+X75vFY9cnXozaUnzZ5pW/ywwGh6rAnv9nbMWnMAJLlLFxvzZYN/vnjU
        o7JRj4fsYgBTynZtBjt2JQC8I6SjLyIqbR8G/w1+wASvVoj4obDmJjx+YhLJ05GGeShXmC
        9XSiDcvc3FeSk1j5EkkzDTeJhYKuvLPINJ1Qf4uR4KFeLOFbNh7zA1VqrD17rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624028137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KR3HX4/+i4plryORjpOnMONKZ2mk+i6c6onI71WK80U=;
        b=7pkzzXuwBcVWMjgsrjUhAn0Eor6xQFrQ4z0P5KZnLbGZhv/seOWQdLtR8U1tbFueCKmjuZ
        a2S5XjcMMfqlOtAA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
In-Reply-To: <20210617093243.795b4853@gandalf.local.home>
References: <20210617095051.4808-1-john.ogness@linutronix.de> <20210617095051.4808-2-john.ogness@linutronix.de> <20210617093243.795b4853@gandalf.local.home>
Date:   Fri, 18 Jun 2021 17:01:37 +0206
Message-ID: <877dirb4t2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-17, Steven Rostedt <rostedt@goodmis.org> wrote:
> Can we add this lock to early_printk() ?
>
> This would make early_printk() so much more readable.
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 421c35571797..2b749c745c1f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2259,6 +2259,7 @@ struct console *early_console;
>  
>  asmlinkage __visible void early_printk(const char *fmt, ...)
>  {
> +	unsigned long flags;
>  	va_list ap;
>  	char buf[512];
>  	int n;
> @@ -2270,7 +2271,9 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
>  	n = vscnprintf(buf, sizeof(buf), fmt, ap);
>  	va_end(ap);
>  
> +	printk_cpu_lock_irqsave(flags);
>  	early_console->write(early_console, buf, n);
> +	printk_cpu_unlock_irqrestore(flags);
>  }
>  #endif

Since the cpu lock is also taken in NMI context (for example, via
nmi_cpu_backtrace()/dump_stack()), the main concerns are:

1. locks that are taken by a CPU that is holding the cpu lock

2. NMI contexts that take any type of lock

(Actually, #2 is just a special case of #1 where an NMI interrupted a
task that was holding the cpu lock.)

For early_printk() the early USB devices look to be a
problem. early_xdbc_write() will take a spinlock. Assuming the
early_console was also registered as a normal console (via "keep") we
could end up in the following deadlock between the normal console and
early_printk() writes:

    CPU0                          CPU1
    ----                          ----
    early_printk()                console->write()
      cpu_lock()                    spinlock()
      early_console->write()      *NMI*
        spinlock()                cpu_lock()

The upcoming atomic console work addresses this by implementing a new
write_atomic() callback that is lockless (and SMP-safe) or aware of the
cpu lock to avoid dead locks such as above.

AFAICT, the USB devices (CONFIG_EARLY_PRINTK_USB) are the only
early_printk() candidates that use locking. So for all other
early_printk() implementations I think your suggestion would work fine.

Although, in general, early_printk() is not SMP-safe. So I'm not sure
how much safety we need to include at this point.

John Ogness
