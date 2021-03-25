Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FDD348606
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhCYAqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239378AbhCYApz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:45:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E4961A13;
        Thu, 25 Mar 2021 00:45:54 +0000 (UTC)
Date:   Wed, 24 Mar 2021 20:45:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: rename vprintk_func to vprintk
Message-ID: <20210324204552.7470f992@oasis.local.home>
In-Reply-To: <20210323144201.486050-1-linux@rasmusvillemoes.dk>
References: <20210323144201.486050-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 15:42:01 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> The printk code is already hard enough to understand. Remove an
> unnecessary indirection by renaming vprintk_func to vprintk (adding
> the asmlinkage annotation), and removing the vprintk definition from
> printk.c. That way, printk is implemented in terms of vprintk as one
> would expect, and there's no "vprintk_func, what's that? Some function
> pointer that gets set where?"
> 
> The declaration of vprintk in linux/printk.h already has the
> __printf(1,0) attribute, there's no point repeating that with the
> definition - it's for diagnostics in callers.
> 
> linux/printk.h already contains a static inline {return 0;} definition
> of vprintk when !CONFIG_PRINTK.
> 
> Since the corresponding stub definition of vprintk_func was not marked
> "static inline", any translation unit including internal.h would get a
> definition of vprintk_func - it just so happens that for
> !CONFIG_PRINTK, there is precisely one such TU, namely printk.c. Had
> there been more, it would be a link error; now it's just a silly waste
> of a few bytes of .text, which one must assume are rather precious to
> anyone disabling PRINTK.

I'm guessing that at commit: 42a0bb3f7138 ("printk/nmi: generic
solution for safe printk in NMI"), the special name for vprintk_func()
became obsolete.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> $ objdump -dr kernel/printk/printk.o
> 00000330 <vprintk_func>:
>  330:   31 c0                   xor    %eax,%eax
>  332:   c3                      ret
>  333:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>  33a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  kernel/printk/internal.h    | 3 ---
>  kernel/printk/printk.c      | 8 +-------
>  kernel/printk/printk_safe.c | 3 ++-
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 3a8fd491758c..1c7554f0e71b 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -21,7 +21,6 @@ int vprintk_store(int facility, int level,
>  
>  __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
>  __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> -__printf(1, 0) int vprintk_func(const char *fmt, va_list args);
>  void __printk_safe_enter(void);
>  void __printk_safe_exit(void);
>  
> @@ -56,8 +55,6 @@ void defer_console_output(void);
>  
>  #else
>  
> -__printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
> -
>  /*
>   * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
>   * semaphore and some of console functions (console_unlock()/etc.), so
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 575a34b88936..458707a06124 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2104,12 +2104,6 @@ asmlinkage int vprintk_emit(int facility, int level,
>  }
>  EXPORT_SYMBOL(vprintk_emit);
>  
> -asmlinkage int vprintk(const char *fmt, va_list args)
> -{
> -	return vprintk_func(fmt, args);
> -}
> -EXPORT_SYMBOL(vprintk);
> -
>  int vprintk_default(const char *fmt, va_list args)
>  {
>  	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> @@ -2143,7 +2137,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
>  	int r;
>  
>  	va_start(args, fmt);
> -	r = vprintk_func(fmt, args);
> +	r = vprintk(fmt, args);
>  	va_end(args);
>  
>  	return r;
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 2e9e3ed7d63e..87d2e86af122 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -367,7 +367,7 @@ void __printk_safe_exit(void)
>  	this_cpu_dec(printk_context);
>  }
>  
> -__printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> +asmlinkage int vprintk(const char *fmt, va_list args)
>  {
>  #ifdef CONFIG_KGDB_KDB
>  	/* Allow to pass printk() to kdb but avoid a recursion. */
> @@ -420,3 +420,4 @@ void __init printk_safe_init(void)
>  	/* Flush pending messages that did not have scheduled IRQ works. */
>  	printk_safe_flush();
>  }
> +EXPORT_SYMBOL(vprintk);

