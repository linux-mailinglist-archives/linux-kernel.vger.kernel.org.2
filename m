Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B617D305241
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhA0D01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:45761 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbhAZVF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:05:56 -0500
IronPort-SDR: AWFxL7GkofAP7ls3K3aw9u64BsK2VyicG4/JJsQK6dvW1YuuAggVO9n/PVLx59kIY4JrI4mXnC
 iBYcgFBXZ1AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167069620"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="167069620"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:03:58 -0800
IronPort-SDR: /Lmsqp35f0SffDdQMt6cIHCsdq40jhQnXwk1JUVld9WYxOdLUGVEIx2632ys15tM3HAxxDuhx2
 TVjR40YmiI8g==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="406850842"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:03:55 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4VWD-00Eugo-TP; Tue, 26 Jan 2021 23:04:57 +0200
Date:   Tue, 26 Jan 2021 23:04:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from
 EINVAL tests.
Message-ID: <YBCD+czt+6IjAymI@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-2-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:34PM -0500, Paul Gortmaker wrote:
> This block of tests was meant to find/flag incorrect use of the ":"
> and "/" separators (syntax errors) and invalid (zero) group len.
> 
> However they were specified with an 8 bit width and 32 bit operations,
> so they really contained two errors (EINVAL and ERANGE).
> 
> Promote them to 32 bit so it is clear what they are meant to target,
> and then add tests specific for ERANGE (no syntax errors, just doing
> 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).
> 
> Note that the remaining "10-1" on 8 is left as-is, since that captures
> the fact that we check for (r->start > r->end) ---> EINVAL before we
> check for (r->end >= nbits) ---> ERANGE.  If the code is ever re-ordered
> then this test will pick up the mismatched errno value.

I didn't get the last statement. You meant code in the bitmap library itself,
and not in the test cases? Please, clarify this somehow.

I don't really much care, since it's not a tricky commit, but it might be split
to two or three separated ones. Anyway, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/test_bitmap.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 4425a1dd4ef1..3d2cd3b1de84 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -337,13 +337,15 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  
>  	{-EINVAL, "-1",	NULL, 8, 0},
>  	{-EINVAL, "-0",	NULL, 8, 0},
> -	{-EINVAL, "10-1", NULL, 8, 0},
> -	{-EINVAL, "0-31:", NULL, 8, 0},
> -	{-EINVAL, "0-31:0", NULL, 8, 0},
> -	{-EINVAL, "0-31:0/", NULL, 8, 0},
> -	{-EINVAL, "0-31:0/0", NULL, 8, 0},
> -	{-EINVAL, "0-31:1/0", NULL, 8, 0},
> -	{-EINVAL, "0-31:10/1", NULL, 8, 0},
> +	{-EINVAL, "10-1", NULL, 8, 0},	/* (start > end) ; also ERANGE */
> +	{-ERANGE, "8-8", NULL, 8, 0},
> +	{-ERANGE, "0-31", NULL, 8, 0},
> +	{-EINVAL, "0-31:", NULL, 32, 0},
> +	{-EINVAL, "0-31:0", NULL, 32, 0},
> +	{-EINVAL, "0-31:0/", NULL, 32, 0},
> +	{-EINVAL, "0-31:0/0", NULL, 32, 0},
> +	{-EINVAL, "0-31:1/0", NULL, 32, 0},
> +	{-EINVAL, "0-31:10/1", NULL, 32, 0},
>  	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
>  
>  	{-EINVAL, "a-31", NULL, 8, 0},
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


