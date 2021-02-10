Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367D7316B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBJQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:32:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:21921 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232364AbhBJQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:30:23 -0500
IronPort-SDR: vDV47naPH2tmizffjjgZfuwfXdZ7T13DM9mOMyfV7uZyJ85eOkCYCy2c5EDzhAp1dJaBfqzWFO
 j1Rjv48MP7dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161854858"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="161854858"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:28:37 -0800
IronPort-SDR: q0VrK3w0bojpUzssjCNrgIEQvGfvmpaz24XNAH6SWOs2yBhe9GBqNbQWGaUSwYSQt9j0zDX67x
 JM0KRueGJHlA==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="578463104"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:28:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9sLv-003lqx-4Q; Wed, 10 Feb 2021 18:28:31 +0200
Date:   Wed, 10 Feb 2021 18:28:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/8] lib: bitmap: move ERANGE check from set_region to
 check_region
Message-ID: <YCQJr8iRDiiZJQpF@smile.fi.intel.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-5-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209225907.78405-5-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:59:03PM -0500, Paul Gortmaker wrote:
> It makes sense to do all the checks in check_region() and not 1/2
> in check_region and 1/2 in set_region.
> 
> Since set_region is called immediately after check_region, the net
> effect on runtime is zero, but it gets rid of an if (...) return...

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 75006c4036e9..9596ba53c36b 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -499,25 +499,22 @@ struct region {
>  	unsigned int end;
>  };
>  
> -static int bitmap_set_region(const struct region *r,
> -				unsigned long *bitmap, int nbits)
> +static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
>  {
>  	unsigned int start;
>  
> -	if (r->end >= nbits)
> -		return -ERANGE;
> -
>  	for (start = r->start; start <= r->end; start += r->group_len)
>  		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
> -
> -	return 0;
>  }
>  
> -static int bitmap_check_region(const struct region *r)
> +static int bitmap_check_region(const struct region *r, int nbits)
>  {
>  	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
>  		return -EINVAL;
>  
> +	if (r->end >= nbits)
> +		return -ERANGE;
> +
>  	return 0;
>  }
>  
> @@ -651,13 +648,11 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>  		if (IS_ERR(buf))
>  			return PTR_ERR(buf);
>  
> -		ret = bitmap_check_region(&r);
> +		ret = bitmap_check_region(&r, nmaskbits);
>  		if (ret)
>  			return ret;
>  
> -		ret = bitmap_set_region(&r, maskp, nmaskbits);
> -		if (ret)
> -			return ret;
> +		bitmap_set_region(&r, maskp);
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


