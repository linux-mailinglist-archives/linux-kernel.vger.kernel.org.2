Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB83109D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBELGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:06:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:40306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231722AbhBEK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:59:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B180AD29;
        Fri,  5 Feb 2021 10:59:07 +0000 (UTC)
To:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
References: <20210202213633.755469-1-timur@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <3baace45-38af-a59b-c376-9a4c39a17b2d@suse.cz>
Date:   Fri, 5 Feb 2021 11:59:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202213633.755469-1-timur@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 10:36 PM, Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>

Thanks a lot. Should this also affect %pK though? IIUC, there's currently no way
to achieve non-mangled %pK in all cases, even with the most permissive
kptr_restrict=1 setting:
- in IRQ, there's "pK-error" instead
- in a context of non-CAP_SYSLOG process, nulls are printed

Yes, neither should matter if %pK were only used for prints that generate
content of some kind of /proc file read by a CAP_SYSLOG process, but that
doesn't seem to be the case and there are %pK used for printing to dmesg too...

> ---
>  lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..b9f87084afb0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Disable pointer hashing if requested */
> +static bool debug_never_hash_pointers __ro_after_init;
> +
> +static int __init debug_never_hash_pointers_enable(char *str)
> +{
> +	debug_never_hash_pointers = true;
> +	pr_warn("**********************************************************\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** All pointers that are printed to the console will    **\n");
> +	pr_warn("** be printed as unhashed.                              **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> +	pr_warn("** compromise security on your system.                  **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** If you see this message and you are not debugging    **\n");
> +	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**********************************************************\n");
> +	return 0;
> +}
> +early_param("make-printk-non-secret", debug_never_hash_pointers_enable);
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2297,8 +2321,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		}
>  	}
>  
> -	/* default is to _not_ leak addresses, hash before printing */
> -	return ptr_to_id(buf, end, ptr, spec);
> +	/*
> +	 * default is to _not_ leak addresses, so hash before printing, unless
> +	 * make-printk-non-secret is specified on the command line.
> +	 */
> +	if (unlikely(debug_never_hash_pointers))
> +		return pointer_string(buf, end, ptr, spec);
> +	else
> +		return ptr_to_id(buf, end, ptr, spec);
>  }
>  
>  /*
> 

