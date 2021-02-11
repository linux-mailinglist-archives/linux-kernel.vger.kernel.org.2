Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB6E319212
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhBKSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:17:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:34226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhBKRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613065992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMijG7NLW9To4N0+pnio697Rv712tGLsXLWAq0jcB1U=;
        b=U7Q+Tn2H8w5xUm0QcpkoJKlvKLwCgDlbwsSdIITPyN8SNzTUpAFJfKHo20uW5+N4pgSFBL
        6bCwJB1DeKoGsTTIY6MkyqcI84EsFPYIiT41n3y5mqSu/zFHwpAMzf5qlP5wBH9dMFRdYz
        WRwNwF9UBtJjJfCTZzRR8ZHOGzHCcA0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B80EAC69;
        Thu, 11 Feb 2021 17:53:12 +0000 (UTC)
Date:   Thu, 11 Feb 2021 18:53:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
Message-ID: <YCVvB7skjoN18HKO@alley>
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210213453.1504219-4-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-10 15:34:53, Timur Tabi wrote:
> If the debug_never_hash_pointers command line parameter is set, then
> printk("%p") will print pointers as unhashed, which is useful for
> debugging purposes.  This also applies to any function that uses
> vsprintf, such as print_hex_dump() and seq_buf_printf().
> 
> A large warning message is displayed if this option is enabled.
> Unhashed pointers expose kernel addresses, which can be a security
> risk.
> 
> Also update test_printf to skip the hashed pointer tests if the
> command-line option is set.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++++++
>  lib/test_printf.c                             |  8 ++++
>  lib/vsprintf.c                                | 38 ++++++++++++++++++-
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..2a97e787f49c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -810,6 +810,21 @@
>  			1 will print _a lot_ more information - normally
>  			only useful to kernel developers.
>  
> +	debug_never_hash_pointers
> +			Force pointers printed to the console or buffers to be
> +			unhashed.  By default, when a pointer is printed via %p
> +			format string, that pointer is "hashed", i.e. obscured
> +			by hashing the pointer value.  This is a security feature
> +			that hides actual kernel addresses from unprivileged
> +			users, but it also makes debugging the kernel more
> +			difficult since unequal pointers can no longer be
> +			compared.  However, if this command-line option is
> +			specified, then all normal pointers will have their true
> +			value printed.  Pointers printed via %pK may still be
> +			hashed.  This option should only be specified when
> +			debugging the kernel.  Please do not use on production
> +			kernels.

I like this description.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..b4e07ecb1cb2 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,34 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Disable pointer hashing if requested */
> +bool debug_never_hash_pointers __ro_after_init;
> +EXPORT_SYMBOL_GPL(debug_never_hash_pointers);
> +
> +static int __init debug_never_hash_pointers_enable(char *str)
> +{
> +	debug_never_hash_pointers = true;
> +
> +	pr_warn("**********************************************************\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** All pointers that are printed to the console will    **\n");
> +	pr_warn("** be printed as unhashed.                              **\n");

I would really like to make it clear here that it is not only about
consoles. Most people will see only this message. Only few people read
documentation. Many people will learn the parameter name from another
context by googling.

I know that it is not easy to find good words. Especially because
pointers printed by %pK might still be hashed.

> +	pr_warn("**                                                      **\n");
> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> +	pr_warn("** reduce the security of your system.                  **\n");

What about replacing the first two paragraphs with something like:

"This system shows unhashed kernel memory addresses via logs and
 other interfaces. It might reduce the security of your system."

Best Regards,
Petr

> +	pr_warn("**                                                      **\n");
> +	pr_warn("** If you see this message and you are not debugging    **\n");
> +	pr_warn("** the kernel, report this immediately to your system   **\n");
> +	pr_warn("** administrator!                                       **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**********************************************************\n");
> +
> +	return 0;
> +}
> +early_param("debug_never_hash_pointers", debug_never_hash_pointers_enable);
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2297,8 +2325,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		}
>  	}
>  
> -	/* default is to _not_ leak addresses, hash before printing */
> -	return ptr_to_id(buf, end, ptr, spec);
> +	/*
> +	 * default is to _not_ leak addresses, so hash before printing,
> +	 * unless debug_never_hash_pointers is specified on the command line.
> +	 */
> +	if (unlikely(debug_never_hash_pointers))
> +		return pointer_string(buf, end, ptr, spec);
> +	else
> +		return ptr_to_id(buf, end, ptr, spec);
>  }
>  
>  /*
> -- 
> 2.25.1
