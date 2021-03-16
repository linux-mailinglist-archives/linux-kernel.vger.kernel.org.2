Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102433D590
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhCPOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhCPOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:12:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FCBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:12:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ox4so56758879ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vFNcj75F3NutZNhPqmGm8JOhCRe7NKkC2BE3t7uSe8=;
        b=ajRoA1Q2AuTnou/5VTfsUoB3v1iuaL6Jdys0/0dyXnXuMS7pYAV9bE/soz8zyxtBQS
         ABKLWoYG4u0UzqNHbgsH6z7MDAmhs6K4yk/qsZtS2JRPKdmE15C4JldcqgIWsVfyqPxO
         VnPsAs6r00LrtZXTxDSLbtPT5Oo28icIz+zvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vFNcj75F3NutZNhPqmGm8JOhCRe7NKkC2BE3t7uSe8=;
        b=Jb2aGJ67OwJPqlPkhrmyzZIIoiy+LInc/zbACvAU6hwL4SfI7UDXeHG5ORvphyuwBo
         06jzF3mNqAiP3pd8xRSjTBTL6sy6ZNb+fiIphi/Q72kGN5dJzCtht0m4Vt+Dm9YjfYXU
         Tx4tovOr2thez946szgh/GIBzxJjusSr1XHyK13C0AUPjteGfW47ulFDCK0ssxVQ2ZtZ
         YZvJmuZuFrWidakZpd5XL6itCPqev8Q1Rl3UeU1qqzLe42JCZnakYbWHzkLrZn7wt5IB
         Msp8yha6cULtn9+t+oBxRnkb5s7BY+6ogSKQ8xeOSrJrUjBoXE2xQzV/I4B0kiOHt68j
         8xCA==
X-Gm-Message-State: AOAM5307yifzZFlkxNvvDZ8tg+YDetGqods4Z7kJkH3rRXUGSwntXIYj
        ML7NoM0tZiR4aq0wPJ8h23lMZA==
X-Google-Smtp-Source: ABdhPJyW9HitmKr4gjkxbYOm6U4gcrSYNz7ELomKWnOOL5KQeDBKcx0GknziA/VY5w86xr47cFK25Q==
X-Received: by 2002:a17:906:1f93:: with SMTP id t19mr30567700ejr.443.1615903923365;
        Tue, 16 Mar 2021 07:12:03 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id c15sm3596394ejm.52.2021.03.16.07.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:12:02 -0700 (PDT)
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 15:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEgvR6Wc1xt0qupy@chrisdown.name>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2021 03.30, Chris Down wrote:

> ---
>  MAINTAINERS                          |   5 +
>  arch/arm/kernel/entry-v7m.S          |   2 +-
>  arch/arm/lib/backtrace-clang.S       |   2 +-
>  arch/arm/lib/backtrace.S             |   2 +-
>  arch/arm/mach-rpc/io-acorn.S         |   2 +-
>  arch/arm/vfp/vfphw.S                 |   6 +-
>  arch/ia64/include/uapi/asm/cmpxchg.h |   4 +-
>  arch/openrisc/kernel/entry.S         |   6 +-
>  arch/powerpc/kernel/head_fsl_booke.S |   2 +-
>  arch/um/include/shared/user.h        |   3 +-
>  arch/x86/kernel/head_32.S            |   2 +-
>  fs/seq_file.c                        |  21 +++
>  include/asm-generic/vmlinux.lds.h    |  13 ++
>  include/linux/module.h               |   6 +
>  include/linux/printk.h               |  72 ++++++++++-
>  include/linux/seq_file.h             |   1 +
>  include/linux/string_helpers.h       |   2 +
>  init/Kconfig                         |  14 ++
>  kernel/module.c                      |  14 +-
>  kernel/printk/Makefile               |   1 +
>  kernel/printk/index.c                | 183 +++++++++++++++++++++++++++
>  kernel/printk/printk.c               |  20 ++-
>  lib/string_helpers.c                 |  29 ++++-
>  lib/test-string_helpers.c            |   6 +
>  24 files changed, 386 insertions(+), 32 deletions(-)
>  create mode 100644 kernel/printk/index.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3353de0c4bc8..328b3e822223 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14314,6 +14314,11 @@ S:	Maintained
>  F:	include/linux/printk.h
>  F:	kernel/printk/
>  
> +PRINTK INDEXING
> +R:	Chris Down <chris@chrisdown.name>
> +S:	Maintained
> +F:	kernel/printk/index.c
> +
>  PRISM54 WIRELESS DRIVER
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  L:	linux-wireless@vger.kernel.org
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index d0e898608d30..7bde93c10962 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -23,7 +23,7 @@ __invalid_entry:
>  	adr	r0, strerr
>  	mrs	r1, ipsr
>  	mov	r2, lr
> -	bl	printk
> +	bl	_printk

I think it's pointless renaming the symbol to _printk, with all the
churn and reduced readability that involves (especially when reading
assembly "why are we calling _printk and not printk here?"). There's
nothing wrong with providing a macro wrapper by the same name

#define printk(bla bla) ({ do_stuff; printk(bla bla); })

Only two places would need to be updated to surround the word printk in
parentheses to suppress macro expansion: The declaration and the
definition of printk. I.e.

int (printk)(const char *s, ...)

>  
> +struct module;
> +
> +#ifdef CONFIG_PRINTK_INDEX
> +extern void pi_sec_store(struct module *mod);
> +extern void pi_sec_remove(struct module *mod);
> +
> +struct pi_object {
> +	const char *fmt;
> +	const char *func;
> +	const char *file;
> +	unsigned int line;
> +};
> +
> +extern struct pi_object __start_printk_index[];
> +extern struct pi_object __stop_printk_index[];

Do you need these declarations to be visible to the whole kernel? Can't
they live in printk/index.c?

> +
> +#define pi_sec_elf_embed(_p_func, _fmt, ...)				       \
> +	({								       \
> +		int _p_ret;						       \
> +									       \
> +		if (__builtin_constant_p(_fmt)) {			       \
> +			/*
> +			 * The compiler may not be able to eliminate this, so
> +			 * we need to make sure that it doesn't see any
> +			 * hypothetical assignment for non-constants even
> +			 * though this is already inside the
> +			 * __builtin_constant_p guard.
> +			 */						       \
> +			static struct pi_object _pi			       \

static const struct pi_object?

> +			__section(".printk_index") = {			       \
> +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
> +				.func = __func__,			       \
> +				.file = __FILE__,			       \
> +				.line = __LINE__,			       \
> +			};						       \
> +			_p_ret = _p_func(_pi.fmt, ##__VA_ARGS__);	       \

Is the use of _pi.fmt here a trick to prevent gcc from eliding the _pi
object, so it is seen as "used"? That seems a bit fragile, especially if
the compiler ends up generating the same code in .text - that means gcc
does not load the format string from the _pi object (which it
shouldn't), but then I don't see why it (or the next version of gcc)
couldn't realize that _pi is indeed unused.

There's the __used attribute precisely for this kind of thing. Then you
could also eliminate

> +		} else							       \
> +			_p_ret = _p_func(_fmt, ##__VA_ARGS__);		       \
> +									       \

this and the _p_ret variable

> +		_p_ret;							       \

and just end the ({}) with _p_func(_fmt, ##__VA_ARGS__);

That would also allow you to more easily wrap, say, dev_printk(), which
returns void - it seems that by not handling dev_printk and friends
you're missing quite a few format strings.

Rasmus
