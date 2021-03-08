Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC05330AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCHKRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:17:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:41296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhCHKQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:16:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615198592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5/Jr2/SEPX6ISzjhwixcBClk4NNP09BxyShmnT5LuI=;
        b=bglKVe4Y/xG8kzlO1995f+JYk/gE1MlW97EIWjvhAmp7RHLPmVceFKShKnxHaFL63UrgzG
        WDupPH76HC0u8VTE1vlMc7mQexI7kdQ3QEF7SGJOZlwHYRxXFM1kPUqctvmLEHas4f9HbK
        ezcoRtT/UKpoEYJzOAaXtXOA2rGvsrE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10F17AD74;
        Mon,  8 Mar 2021 10:16:32 +0000 (UTC)
Date:   Mon, 8 Mar 2021 11:16:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, timur@kernel.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Message-ID: <YEX5fyB16dF6N4Iu@alley>
References: <20210305194206.3165917-1-elver@google.com>
 <20210305194206.3165917-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305194206.3165917-2-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-05 20:42:06, Marco Elver wrote:
> Move the no_hash_pointers warning string into __initconst section, so
> that it is discarded after init. Remove common start/end characters.
> Also remove repeated lines from the array, since the compiler can't
> remove duplicate strings for us since the array must appear in
> __initconst as defined.
> 
> Note, a similar message appears in kernel/trace/trace.c, but compiling
> the feature is guarded by CONFIG_TRACING. It is not immediately obvious
> if a space-concious kernel would prefer CONFIG_TRACING=n. Therefore, it
> makes sense to keep the message for no_hash_pointers as __initconst, and
> not move the NOTICE-printing to a common function.
> 
> Link: https://lkml.kernel.org/r/CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/vsprintf.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 4a14889ccb35..1095689c9c97 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2094,26 +2094,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
>  
> +static const char no_hash_pointers_warning[8][55] __initconst = {
> +	"******************************************************",
> +	"   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> +	" This system shows unhashed kernel memory addresses   ",
> +	" via the console, logs, and other interfaces. This    ",
> +	" might reduce the security of your system.            ",
> +	" If you see this message and you are not debugging    ",
> +	" the kernel, report this immediately to your system   ",
> +	" administrator!                                       ",
> +};
> +
>  static int __init no_hash_pointers_enable(char *str)
>  {
> +	/* Indices into no_hash_pointers_warning; -1 is an empty line. */
> +	const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };
> +	int i;
> +
>  	if (no_hash_pointers)
>  		return 0;
>  
>  	no_hash_pointers = true;
>  
> -	pr_warn("**********************************************************\n");
> -	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> -	pr_warn("** via the console, logs, and other interfaces. This    **\n");
> -	pr_warn("** might reduce the security of your system.            **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("** If you see this message and you are not debugging    **\n");
> -	pr_warn("** the kernel, report this immediately to your system   **\n");
> -	pr_warn("** administrator!                                       **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn("**********************************************************\n");
> +	for (i = 0; i < ARRAY_SIZE(lines); i++)
> +		pr_warn("**%54s**\n", i == -1 ? "" : no_hash_pointers_warning[lines[i]]);

Is this worth it, please? Could anyone provide some numbers how
the kernel size increases between releases?

The number of code lines is basically just growing. The same is true
for the amount of printed messages.

This patch is saving some lines of text that might be effectively
compressed. But it adds some code and array with indexes. Does it
make any significant imrovement in the compressed kernel image?

Geert was primary concerned about the runtime memory consuption.
It will be solved by the  __initconst. The rest affects only
the size of the compressed image on disk.

Best Regards,
Petr
