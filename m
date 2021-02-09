Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E776231578C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhBIUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:13:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233232AbhBISYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:24:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FBFFAB71;
        Tue,  9 Feb 2021 18:06:51 +0000 (UTC)
Subject: Re: [PATCH mm] kfence: make reporting sensitive information
 configurable
To:     Marco Elver <elver@google.com>, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Timur Tabi <timur@kernel.org>,
        Petr Mladek <pmladek@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210209151329.3459690-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4f39ad95-a773-acc6-dd9e-cb04f897ca16@suse.cz>
Date:   Tue, 9 Feb 2021 19:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209151329.3459690-1-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 4:13 PM, Marco Elver wrote:
> We cannot rely on CONFIG_DEBUG_KERNEL to decide if we're running a
> "debug kernel" where we can safely show potentially sensitive
> information in the kernel log.
> 
> Therefore, add the option CONFIG_KFENCE_REPORT_SENSITIVE to decide if we
> should add potentially sensitive information to KFENCE reports. The
> default behaviour remains unchanged.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Hi,

could we drop this kconfig approach in favour of the boot option proposed here?
[1] Just do the prints with %p unconditionally and the boot option takes care of
it? Also Linus mentioned dislike of controlling potential memory leak to be a
config option [2]

Thanks,
Vlastimil

[1] https://lore.kernel.org/linux-mm/20210202213633.755469-1-timur@kernel.org/
[2]
https://lore.kernel.org/linux-mm/CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com/

> ---
>  Documentation/dev-tools/kfence.rst | 6 +++---
>  lib/Kconfig.kfence                 | 8 ++++++++
>  mm/kfence/core.c                   | 2 +-
>  mm/kfence/kfence.h                 | 3 +--
>  mm/kfence/report.c                 | 6 +++---
>  5 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
> index 58a0a5fa1ddc..5280d644f826 100644
> --- a/Documentation/dev-tools/kfence.rst
> +++ b/Documentation/dev-tools/kfence.rst
> @@ -89,7 +89,7 @@ A typical out-of-bounds access looks like this::
>  The header of the report provides a short summary of the function involved in
>  the access. It is followed by more detailed information about the access and
>  its origin. Note that, real kernel addresses are only shown for
> -``CONFIG_DEBUG_KERNEL=y`` builds.
> +``CONFIG_KFENCE_REPORT_SENSITIVE=y`` builds.
>  
>  Use-after-free accesses are reported as::
>  
> @@ -184,8 +184,8 @@ invalidly written bytes (offset from the address) are shown; in this
>  representation, '.' denote untouched bytes. In the example above ``0xac`` is
>  the value written to the invalid address at offset 0, and the remaining '.'
>  denote that no following bytes have been touched. Note that, real values are
> -only shown for ``CONFIG_DEBUG_KERNEL=y`` builds; to avoid information
> -disclosure for non-debug builds, '!' is used instead to denote invalidly
> +only shown for ``CONFIG_KFENCE_REPORT_SENSITIVE=y`` builds; to avoid
> +information disclosure otherwise, '!' is used instead to denote invalidly
>  written bytes.
>  
>  And finally, KFENCE may also report on invalid accesses to any protected page
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> index 78f50ccb3b45..141494a5f530 100644
> --- a/lib/Kconfig.kfence
> +++ b/lib/Kconfig.kfence
> @@ -55,6 +55,14 @@ config KFENCE_NUM_OBJECTS
>  	  pages are required; with one containing the object and two adjacent
>  	  ones used as guard pages.
>  
> +config KFENCE_REPORT_SENSITIVE
> +	bool "Show potentially sensitive information in reports"
> +	default y if DEBUG_KERNEL
> +	help
> +	  Show potentially sensitive information such as unhashed pointers,
> +	  context bytes on memory corruptions, as well as dump registers in
> +	  KFENCE reports.
> +
>  config KFENCE_STRESS_TEST_FAULTS
>  	int "Stress testing of fault handling and error reporting" if EXPERT
>  	default 0
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index cfe3d32ac5b7..5f7e02db5f53 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -648,7 +648,7 @@ void __init kfence_init(void)
>  	schedule_delayed_work(&kfence_timer, 0);
>  	pr_info("initialized - using %lu bytes for %d objects", KFENCE_POOL_SIZE,
>  		CONFIG_KFENCE_NUM_OBJECTS);
> -	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +	if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE))
>  		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
>  			(void *)(__kfence_pool + KFENCE_POOL_SIZE));
>  	else
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 1accc840dbbe..48a8196b947b 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -16,8 +16,7 @@
>  
>  #include "../slab.h" /* for struct kmem_cache */
>  
> -/* For non-debug builds, avoid leaking kernel pointers into dmesg. */
> -#ifdef CONFIG_DEBUG_KERNEL
> +#ifdef CONFIG_KFENCE_REPORT_SENSITIVE
>  #define PTR_FMT "%px"
>  #else
>  #define PTR_FMT "%p"
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 901bd7ee83d8..5e2dbabbab1d 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -148,9 +148,9 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
>  	for (cur = (const u8 *)address; cur < end; cur++) {
>  		if (*cur == KFENCE_CANARY_PATTERN(cur))
>  			pr_cont(" .");
> -		else if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +		else if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE))
>  			pr_cont(" 0x%02x", *cur);
> -		else /* Do not leak kernel memory in non-debug builds. */
> +		else /* Do not leak kernel memory. */
>  			pr_cont(" !");
>  	}
>  	pr_cont(" ]");
> @@ -242,7 +242,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
>  
>  	/* Print report footer. */
>  	pr_err("\n");
> -	if (IS_ENABLED(CONFIG_DEBUG_KERNEL) && regs)
> +	if (IS_ENABLED(CONFIG_KFENCE_REPORT_SENSITIVE) && regs)
>  		show_regs(regs);
>  	else
>  		dump_stack_print_info(KERN_ERR);
> 

