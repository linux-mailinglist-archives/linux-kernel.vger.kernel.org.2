Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92AC40749E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhIKC1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 22:27:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9415 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKC1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:27:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5xM04fSPz8yM8;
        Sat, 11 Sep 2021 10:21:32 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 10:25:55 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 11 Sep 2021 10:25:54 +0800
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <roman.fietze@magna.com>, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        <akinobu.mita@gmail.com>, <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <467a3c3c-8a52-9a74-c77f-bcb51b03d603@huawei.com>
Date:   Sat, 11 Sep 2021 10:25:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210214161348.369023-4-timur@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/15 0:13, Timur Tabi wrote:
> If the no_hash_pointers command line parameter is set, then
> printk("%p") will print pointers as unhashed, which is useful for
> debugging purposes.  This change applies to any function that uses
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
> Acked-by: Marco Elver <elver@google.com>
> ---
>   .../admin-guide/kernel-parameters.txt         | 15 ++++++++
>   lib/test_printf.c                             |  8 +++++
>   lib/vsprintf.c                                | 36 +++++++++++++++++--
>   3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..c8993a296e71 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3281,6 +3281,21 @@
>   			in certain environments such as networked servers or
>   			real-time systems.
>   
> +	no_hash_pointers
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
> +
>   	nohibernate	[HIBERNATION] Disable hibernation and resume.
>   
>   	nohz=		[KNL] Boottime enable/disable dynamic ticks
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index ad2bcfa8caa1..a6755798e9e6 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -35,6 +35,8 @@ KSTM_MODULE_GLOBALS();
>   static char *test_buffer __initdata;
>   static char *alloced_buffer __initdata;
>   
> +extern bool no_hash_pointers;
> +
>   static int __printf(4, 0) __init
>   do_test(int bufsize, const char *expect, int elen,
>   	const char *fmt, va_list ap)
> @@ -301,6 +303,12 @@ plain(void)
>   {
>   	int err;
>   
> +	if (no_hash_pointers) {
> +		pr_warn("skipping plain 'p' tests");
> +		skipped_tests += 2;
> +		return;
> +	}
> +
>   	err = plain_hash();
>   	if (err) {
>   		pr_warn("plain 'p' does not appear to be hashed\n");
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..41ddc353ebb8 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,32 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>   	return widen_string(buf, buf - buf_start, end, spec);
>   }
>   
> +/* Disable pointer hashing if requested */
> +bool no_hash_pointers __ro_after_init;
> +EXPORT_SYMBOL_GPL(no_hash_pointers);

Why do we need to export the no_hash_pointers variable and not declare 
it in any header file?

Thanks.
Xiaoming Ni


> +
> +static int __init no_hash_pointers_enable(char *str)
> +{
> +	no_hash_pointers = true;
> +
> +	pr_warn("**********************************************************\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> +	pr_warn("** via the console, logs, and other interfaces. This    **\n");
> +	pr_warn("** might reduce the security of your system.            **\n");
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
> +early_param("no_hash_pointers", no_hash_pointers_enable);
> +
>   /*
>    * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>    * by an extra set of alphanumeric characters that are extended format
> @@ -2297,8 +2323,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>   		}
>   	}
>   
> -	/* default is to _not_ leak addresses, hash before printing */
> -	return ptr_to_id(buf, end, ptr, spec);
> +	/*
> +	 * default is to _not_ leak addresses, so hash before printing,
> +	 * unless no_hash_pointers is specified on the command line.
> +	 */
> +	if (unlikely(no_hash_pointers))
> +		return pointer_string(buf, end, ptr, spec);
> +	else
> +		return ptr_to_id(buf, end, ptr, spec);
>   }
>   
>   /*
> 

