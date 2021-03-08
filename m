Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019C9330B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhCHKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:33:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:65129 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhCHKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:33:29 -0500
IronPort-SDR: EoydsZvAOwv0Ae03kvTUtA2gJzc0phExPZxqM8zqv/9V/LPeZ2ipYiaXCGG9awQiRVsIFFpPaT
 gXRMOLbcWhOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="184639094"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="184639094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:33:28 -0800
IronPort-SDR: HhyRFaji92hkYH/IcTXTNVLyKx6k6Odu/UMT+FJ39Nx8CtWciGdUn4pWzakHR/WhgpUNa5PyfH
 lQDyY3cFkM6w==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="385807735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:33:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJDCV-00An4O-2k; Mon, 08 Mar 2021 12:33:23 +0200
Date:   Mon, 8 Mar 2021 12:33:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, timur@kernel.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Message-ID: <YEX9c+Sx/TGvFTCY@smile.fi.intel.com>
References: <20210305194206.3165917-1-elver@google.com>
 <20210305194206.3165917-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305194206.3165917-2-elver@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:42:06PM +0100, Marco Elver wrote:
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

This seems to have 2-in-1 patch. Care to split?
Feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to the __initconst part, but the rest.


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
>  
>  	return 0;
>  }
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

-- 
With Best Regards,
Andy Shevchenko


