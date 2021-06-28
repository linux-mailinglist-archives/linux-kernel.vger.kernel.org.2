Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4163B5E42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhF1Mps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:45:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhF1Mpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:45:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FB2F20285;
        Mon, 28 Jun 2021 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624884190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+L17SCE00Re7ujwqiAE4IZDYqdtI5zSoAMLWFQnB96k=;
        b=iyyhccFZIF9bX6+2vzNZAqk8fl0MhFCxdLkUtTmUtLHhOSo3FcABpGd3vY91AnKPFwURj2
        ohm55sxPreKxvGhYCEvFP9ugDuQlUHfvhTqy+VC34+dr+jLVnDvZHianetnMYOc1tTVqU5
        C70MSmcJblOG+vpi/JW/EUB3dZ68NPo=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AFA1FA3B9A;
        Mon, 28 Jun 2021 12:43:09 +0000 (UTC)
Date:   Mon, 28 Jun 2021 14:43:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Add CONFIG_CONSOLE_LOGLEVEL_PANIC
Message-ID: <YNnD3b1wKfDODKnw@alley>
References: <20210622143350.1105701-1-dima@arista.com>
 <YNWeIks8NC1i2w96@alley>
 <8e7dae6f-e67c-b961-4986-883e1db0c566@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7dae6f-e67c-b961-4986-883e1db0c566@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-06-25 13:17:43, Dmitry Safonov wrote:
> Hi Petr, thanks for looking into this,
> 
> On 6/25/21 10:13 AM, Petr Mladek wrote:
> > On Tue 2021-06-22 15:33:50, Dmitry Safonov wrote:
> [..]
> >> @@ -76,8 +76,8 @@ static inline void console_silent(void)
> >>  
> >>  static inline void console_verbose(void)
> >>  {
> >> -	if (console_loglevel)
> >> -		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
> >> +	if (console_loglevel && (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0))
> >> +		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
> > 
> > console_verbose() is called also in some other situations.
> > For example, check_hung_task(), oops_begin(), debug_locks_ff().
> > These do not always lead to panic.>
> > At minimum, the name is misleading. It should be something
> > like CONFIG_CONSOLE_LOGLEVEL_VERBOSE.
> 
> Hmm, check_hung_task() calls it only if it's going to panic().

Yup.

> debug_locks_off() AFAICS is called only when there is something bad with
> either lockdep itself or locks: they may get freed
> [print_freed_lock_bug()] or lock is held on return to userspace
> [lockdep_sys_exit()] and so on - when lockdep has to turn off. Arguably,
> the situations are somewhat close to panic.

"Somewhat close to panic" is not enough. The important thing is to
see the messages in these critical situations. One way is the verbose
console. The other way is the crash dump. And the crashdump is
generated only when panic() is really called.

BTW: It might actually be better to handle this using a command line
option instead of build option. The build option prevents debugging
the problem when crash dump fails from some reason. It is always
much easier to remove a command line option than rebuild and install
anoter kernel.

> MCE calls it also just before panic.

yup.

> So, the only left is oops_begin().
> I'm not sure what to do about it.
> What do you think, should console_verbose() be called only under
> panic_on_oops?

No. IMHO, it is even more important to make the console_verbose()
when panic_on_oops is disabled. Oops means that there is a high
risk that the system might crash. And the worst thing is a silent
crash (no message, no crashdump).


> Or should there be console_unverbose() to return the
> loglevel in oops_end()? [that seems quite a bit ugly, considering that
> there're already places that temporary save loglevel and adding another
> one is ugh]

Yeah, the temporary console_loglevel changes are ugly. They might be
racy if two processes manipulate the loglevel in parallel.
We should keep them at minimum or better remove them at all.


> Renaming console_verbose() to console_verbose_on_panic() or something
> sounds good to me - I didn't do it only to keep the patch short.

Yup, it looks like to most reasonable approach to me.


> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 678c13967580..0c12cafd9d8b 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -61,6 +61,19 @@ config CONSOLE_LOGLEVEL_QUIET
> >>  	  will be used as the loglevel. IOW passing "quiet" will be the
> >>  	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
> >>  
> >> +config CONSOLE_LOGLEVEL_PANIC
> >> +	int "panic console loglevel (1-15)"
> > 
> > The range is 1-15 here.
> > 
> >> +	range 0 15
> > 
> > But it is 0-15 here. If you use "range 1 15" you should not need the
> > check (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0) in the code.
> > 
> >> +	default "15"
> >> +	help
> >> +	  loglevel to use in kernel panic or oopses.
> >> +
> >> +	  Usually in order to provide more debug information on console upon
> >> +	  panic, one wants to see everything being printed (loglevel = 15).
> >> +	  With an exception to setups with low baudrate on serial console,
> >> +	  keeping this value high is a good choice.
> >> +	  0 value is to keep the loglevel during panic/oops unchanged.
> > 
> > The trick with 0 value just makes things more complicated. The default
> > "15" does the same job and should be good enough. The hard-coded
> > default is good enough for the other CONSOLE_LOGLEVEL_* settings.
> 
> Well, "0" is kinda reverse to "15" - it doesn't change loglevel at all.
> Actually, the origin purpose of the patch is to have "0" :-)

Is it enough to keep the current level during panic()? It might be
easier to introduce a commandline option, for example, no_console_verbose_panic.
It would do:

static inline void console_verbose_panic(void)
{
	if (!no_console_verbose_panic)
		console_verbose();
}

It is clear what it does. On the other hand, the logic with particular
loglevels is not clear. 3 different proposals has already been mentioned
in this thread:

	if (console_loglevel &&
	    (CONFIG_CONSOLE_LOGLEVEL_PANIC > console_loglevel)) {
		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
	}

vs.

	if (console_loglevel)
		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;

vs.

	if (console_loglevel && CONFIG_CONSOLE_LOGLEVEL_PANIC)
		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;


Just imagine that you are a distributor, developer or admin:

   What value you would choose for CONFIG_CONSOLE_LOGLEVEL_PANIC?
   What console loglevel will be used at the end?

The answer depends on the implemented alhorith, console_loglevel,
and CONFIG_CONSOLE_LOGLEVEL_PANIC.

The answer would be much easier if "no_verbose_console_panic" is
used instead.

Best Regards,
Petr
