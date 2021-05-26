Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51539132D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhEZI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhEZI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622019421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhkPVaZKIm9DZQqqxgLb/Cl0n6VLgqEfhyr5+MGRQiM=;
        b=CzKC88p6vMROOwspfcEw1cL6s53X7tKkK9jA7OVrL3WCYzjh3f6p2myiTIRJcyRBmlLOWq
        /UsF7tQvL7bE6w/r7UCJ1pIULq3n+YEkTdPKBT2TjPzrPpUph+bFmj4vPwQlA/1OwRIhdc
        kANy4gO5wC3efYXIs48L0l7s0w9BNIE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6B82B01E;
        Wed, 26 May 2021 08:57:01 +0000 (UTC)
Date:   Wed, 26 May 2021 10:57:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 4/4] printk: index: Add indexing support to dev_printk
Message-ID: <YK4NXO0Tv9O0Ss9u@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <fff5e1c790f14e9af4559e902ba9689ec93d38e2.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff5e1c790f14e9af4559e902ba9689ec93d38e2.1621338324.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-18 13:00:48, Chris Down wrote:
> While for most kinds of issues we have counters, tracepoints, or metrics
> with a stable interface which can reliably be used to indicate issues,
> in order to react to production issues quickly we sometimes need to work
> with the interface which most kernel developers naturally use when
> developing: printk, and printk-esques like dev_printk.
> 
> dev_printk is by far the most likely custom subsystem printk to benefit
> from the printk indexing infrastructure, since niche device issues
> brought about by production changes, firmware upgrades, and the like are
> one of the most common things that we need printk infrastructure's
> assistance to monitor.
> 
> Often these errors were never expected to practically manifest in
> reality, and exhibit in code without extensive (or any) metrics present.
> As such, there are typically very few options for issue detection
> available to those with large fleets at the time the incident happens,
> and we thus benefit strongly from monitoring netconsole in these
> instances.
> 
> As such, add the infrastructure for dev_printk to be indexed in the
> printk index. Even on a minimal kernel config, the coverage of the base
> kernel's printk index is significantly improved:
> 
> Before:
> 
>     [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
>     4497 /sys/kernel/debug/printk/index/vmlinux
> 
> After:
> 
>     [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
>     5573 /sys/kernel/debug/printk/index/vmlinux

Cool.

> In terms of implementation, in order to trivially disambiguate them,
> dev_printk is now a macro which wraps _dev_printk. If preferred, it's
> also possible to have the macro and function have the same name.

I prefer to use _dev_printk to disambiguate the macro and function
names. By other words, I prefer the approach used in this patch.

Please, remove the "If preferred..." sentence in the next version.

> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> index 6f009559ee54..202c6a9ea7eb 100644
> --- a/include/linux/dev_printk.h
> +++ b/include/linux/dev_printk.h
> @@ -97,25 +97,54 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
>  
>  #endif
>  
> +/*
> + * Some callsites directly call dev_printk rather than going through the
> + * dev_<level> infrastructure, so we need to emit here as well as inside those
> + * level-specific macros. Only one index entry will be produced, either way,
> + * since dev_printk's `fmt` isn't known at compile time if going through the
> + * dev_<level> macros.
> + */
> +#define dev_printk(level, dev, fmt, ...) ({			\
> +	dev_printk_index_emit(level, fmt);			\

Please, define dev_printk_index_emit() macro before it is used
for the first time.

> +	_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
> +})
> +
>  /*
>   * #defines for all the dev_<level> macros to prefix with whatever
>   * possible use of #define dev_fmt(fmt) ...
>   */
>  
> -#define dev_emerg(dev, fmt, ...)					\
> -	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_crit(dev, fmt, ...)						\
> -	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_alert(dev, fmt, ...)					\
> -	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_err(dev, fmt, ...)						\
> -	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_warn(dev, fmt, ...)						\
> -	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_notice(dev, fmt, ...)					\
> -	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
> -#define dev_info(dev, fmt, ...)						\
> -	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_printk_index_emit(level, fmt)				\
> +	printk_index_subsys_emit("%s %s: ", "", level, fmt)
> +
> +#define dev_emerg(dev, fmt, ...) ({					\
> +	dev_printk_index_emit(KERN_EMERG, dev_fmt(fmt));		\
> +	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
> +})
> +#define dev_crit(dev, fmt, ...) ({					\
> +	dev_printk_index_emit(KERN_CRIT, dev_fmt(fmt));			\
> +	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
> +})
> +#define dev_alert(dev, fmt, ...) ({					\
> +	dev_printk_index_emit(KERN_ALERT, dev_fmt(fmt));		\
> +	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
> +})

I would slightly reduce the duplcation the follwing way:

#define dev_printk_index_wrap(_p_func, level, dev, fmt, ...)			\
	({								       \
		printk_index_subsys_emit("%s %s: ", "", level, dev_fmt(fmt));  \
		_p_func(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
	})

#define dev_printk(level, dev, fmt, ...)				\
	dev_printk_index_wrap(_dev_printk, level, dev, ##__VA_ARGS__)

#define dev_crit(dev, fmt, ...)							\
	dev_printk_index_wrap(_dev_crit, KERN_CRIT, dev, ##__VA_ARGS__)
#define dev_alert(dev, fmt, ...)						\
	dev_printk_index_wrap(_dev_alert, KERN_ALERT, dev, ##__VA_ARGS__)


Note that I did not try to complile it, so there might be a mistake.


BTW: I was curious why we actually need _dev_crit() defined as a function.
But it seems to reduce size of the kernel binaries, see
the commit 38a1ec40efa196efbac0253 ("device.h drivers/base/core.c
Convert dev_<level> logging macros to functions"). Sigh.

Best Regards,
Petr
