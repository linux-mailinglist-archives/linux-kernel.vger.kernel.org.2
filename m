Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAA3B4019
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFYJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:15:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43056 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhFYJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:15:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 952E11FE67;
        Fri, 25 Jun 2021 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624612387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Isgc+M4F8lzQo39RcIUZi5oWcIOHR43lieHIr7259Nk=;
        b=FxX/8f/9CQ6Wy1UwB6wcc+aet4EIhrdQzzauHozpXql6As5aUDxTJMCM/jVH2E3HunuDwy
        HOosOTmqGpsF0o9tSXpMalKoVlXufCaDerKYC5BjXbNpaB7lHjHb54TZfQQA2jdzdhACKT
        P8agmOKSdTx1RCOCcpPdzpJcE6T6cxs=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B70DA3BE9;
        Fri, 25 Jun 2021 09:13:07 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:13:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Add CONFIG_CONSOLE_LOGLEVEL_PANIC
Message-ID: <YNWeIks8NC1i2w96@alley>
References: <20210622143350.1105701-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622143350.1105701-1-dima@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-22 15:33:50, Dmitry Safonov wrote:
> console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
> which provides more information to debug a panic/oops.
> 
> Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
> are configured to have 9600 baud rate. While verbose console messages
> have their value to post-analyze crashes, on such setup they:
> - may prevent panic/oops messages being printed
> - take too long to flush on console resulting in watchdog reboot
> 
> In all our setups we use kdump which saves dmesg buffer after panic,
> so in reality those extra messages on console provide no additional value,
> but rather add risk of not getting to __crash_kexec().

It makes sense.

> Provide CONFIG_CONSOLE_LOGLEVEL_PANIC, which allows to choose how
> verbose the kernel must be on oops/panic.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/printk.h |  4 ++--
>  lib/Kconfig.debug      | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fe7eb2351610..5a65a719f917 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -76,8 +76,8 @@ static inline void console_silent(void)
>  
>  static inline void console_verbose(void)
>  {
> -	if (console_loglevel)
> -		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
> +	if (console_loglevel && (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0))
> +		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;

console_verbose() is called also in some other situations.
For example, check_hung_task(), oops_begin(), debug_locks_ff().
These do not always lead to panic.

At minimum, the name is misleading. It should be something
like CONFIG_CONSOLE_LOGLEVEL_VERBOSE.

But the question is whether we really want to limit the loglevel
also in the non-panic scenarios. IMHO, it is a bad idea.

A better solution would be to introduce console_verbose_panic()
and use it only when it is really going to panic. The function
should also use the lower value only when crash dump is really
successfully enabled.


>  }
>  
>  /* strlen("ratelimit") + 1 */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..0c12cafd9d8b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -61,6 +61,19 @@ config CONSOLE_LOGLEVEL_QUIET
>  	  will be used as the loglevel. IOW passing "quiet" will be the
>  	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
>  
> +config CONSOLE_LOGLEVEL_PANIC
> +	int "panic console loglevel (1-15)"

The range is 1-15 here.

> +	range 0 15

But it is 0-15 here. If you use "range 1 15" you should not need the
check (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0) in the code.

> +	default "15"
> +	help
> +	  loglevel to use in kernel panic or oopses.
> +
> +	  Usually in order to provide more debug information on console upon
> +	  panic, one wants to see everything being printed (loglevel = 15).
> +	  With an exception to setups with low baudrate on serial console,
> +	  keeping this value high is a good choice.
> +	  0 value is to keep the loglevel during panic/oops unchanged.

The trick with 0 value just makes things more complicated. The default
"15" does the same job and should be good enough. The hard-coded
default is good enough for the other CONSOLE_LOGLEVEL_* settings.

Best Regards,
Petr
