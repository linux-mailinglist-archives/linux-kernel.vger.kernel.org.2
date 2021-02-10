Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C850316836
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBJNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:42:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:32792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhBJNmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:42:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612964504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZh1P7BD4ZXrW/ZkNSKyIjszVIwqC1RSuRGUuL4xAE8=;
        b=cdXuXkt+s3WOCkEhU4aTas4r3JPYiekiaW2saKAvRXZ0HCDVour6/vILKAyXncoZX9oWdW
        0EJHkST7ZzRdJzOzu6q2P5VXx9sfvyqEmhdE6M/InDGLWmrBP88Z44PQ5SYfCSX+xq6Edm
        jEuF9sQC5g15ESlO7dZLA9XhptnqZvo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF6E4AC97;
        Wed, 10 Feb 2021 13:41:44 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:41:43 +0100
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
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YCPily3XZY4Cw6tU@alley>
References: <20210210051814.845713-1-timur@kernel.org>
 <20210210051814.845713-4-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210051814.845713-4-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-09 23:18:14, Timur Tabi wrote:
> If the make-printk-non-secret command line parameter is set, then
> printk("%p") will print pointers as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled.
> Unhashed pointers, while useful for debugging, expose kernel
> addresses which can be a security risk.
> 
> Also update test_printf to skip the hashed pointer tests if the
> command-line option is set.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++++++
>  lib/test_printf.c                             |  8 ++++
>  lib/vsprintf.c                                | 38 ++++++++++++++++++-
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..6962379469e4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2613,6 +2613,21 @@
>  			different yeeloong laptops.
>  			Example: machtype=lemote-yeeloong-2f-7inch
>  
> +        make-printk-non-secret
> +			Force pointers printed to the console to be unhashed.
> +			By default, when a pointer is printed to the kernel
> +			console (via %p format string), that pointer is
> +			"hashed", i.e. obscured by hashing the pointer value.
> +			This is a security feature that hides actual kernel
> +			addresses from unprivileged users, but it also makes
> +			debugging the kernel more difficult since unequal
> +			pointers can no longer be compared.  If this option is
> +			specified, then all normal pointers will have their
> +			true value printed.  Pointers printed via %pK may
> +			still be hashed.  This option should only be specified
> +			when debugging the kernel.  Please do not use on
> +			production kernels.
> +
>  	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
>  			than or equal to this physical address is ignored.
>  
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index ad2bcfa8caa1..b0b62d76e598 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -35,6 +35,8 @@ KSTM_MODULE_GLOBALS();
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
>  
> +extern bool debug_never_hash_pointers;
> +
>  static int __printf(4, 0) __init
>  do_test(int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
> @@ -301,6 +303,12 @@ plain(void)
>  {
>  	int err;
>  
> +	if (debug_never_hash_pointers) {
> +		pr_warn("skipping plain 'p' tests");
> +		skipped_tests += 2;
> +		return;
> +	}
> +
>  	err = plain_hash();
>  	if (err) {
>  		pr_warn("plain 'p' does not appear to be hashed\n");
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..1296d9b0b328 100644
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
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> +	pr_warn("** reduce the security of your system.                  **\n");
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
> +early_param("make-printk-non-secret", debug_never_hash_pointers_enable);

The mail about EFENCE, and the different names of the parameter and the
variable, made  realized one important thing. The kernel parameter and
the message does not describe the full effect.

The option causes that vsprintf() will not hash pointers. Yes, it is
primary used by printk(). But it is used also in some other
interfaces, especially trace_printk(), seq_buf() API. The naked
pointers might appear more or less anywhere, including procfs,
sysfs, debugfs.

IMHO, we should fix this. The long discussion was about how to make
this option safe. Users should be aware that it is not only about
the kernel log.

I suggest to rename the parameter "debug_never_hash_pointer" and use
the same name for the parameter and the variable.

We also should make the warning more generic. I suggest to replace the
first paragraph with something like:

	pr_warn("** The hashing of printed pointers has been disabled   **\n");
	pr_warn("** for debugging purposes.                             **\n");

Feel free to use a better wording. I am not a native speaker.

Of course, also kernel-parameters.txt has to be updated accordingly.

Best Regards,
Petr
