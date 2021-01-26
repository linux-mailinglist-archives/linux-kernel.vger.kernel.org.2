Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22287305234
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhA0DeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:60635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbhAZVYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:24:30 -0500
IronPort-SDR: hrcVWzczbyQ9A/kbyfNRvw6p84N+59JwTmT/n9bA2Eq5lhh1cxkQrQh+B7fPa7IrGAD39bXUAg
 ywtqm8Oumyeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180120218"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180120218"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:22:44 -0800
IronPort-SDR: /7ux5EuUp7rpqAvFni+HJwFHX0mYdLOdJkMca1nU33NddCp2QV8hD2hW4+rqr1o1tOkmGXrgyn
 ldMlnMPCRbTA==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="429848597"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:22:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4VoN-00Evn5-MM; Tue, 26 Jan 2021 23:23:43 +0200
Date:   Tue, 26 Jan 2021 23:23:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 5/8] lib: bitmap_getnum: separate arg into region and
 field
Message-ID: <YBCIXzUkgjcCTprv@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-6-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-6-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:38PM -0500, Paul Gortmaker wrote:
> The bitmap_getnum is only used on a region's start/end/off/group_len
> field.  Trivially decouple the region from the field so that the region
> pointer is available for a pending change.

Honestly, I don't like this macro trick. It's bad in couple of ways:
 - it hides what actually is done with the fields of r structure
   (after you get that they are fields!)
 - it breaks possibility to compile time (type) checks

I will listen what others say, but I'm in favour not to proceed like this.

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 833f152a2c43..f65be2f148fd 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -533,6 +533,7 @@ static const char *bitmap_getnum(const char *str, unsigned int *num)
>  	*num = n;
>  	return str + len;
>  }
> +#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))
>  
>  static inline bool end_of_str(char c)
>  {
> @@ -571,7 +572,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
>  
>  static const char *bitmap_parse_region(const char *str, struct region *r)
>  {
> -	str = bitmap_getnum(str, &r->start);
> +	str = bitmap_getrnum(str, r, start);
>  	if (IS_ERR(str))
>  		return str;
>  
> @@ -581,7 +582,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>  	if (*str != '-')
>  		return ERR_PTR(-EINVAL);
>  
> -	str = bitmap_getnum(str + 1, &r->end);
> +	str = bitmap_getrnum(str + 1, r, end);
>  	if (IS_ERR(str))
>  		return str;
>  
> @@ -591,14 +592,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>  	if (*str != ':')
>  		return ERR_PTR(-EINVAL);
>  
> -	str = bitmap_getnum(str + 1, &r->off);
> +	str = bitmap_getrnum(str + 1, r, off);
>  	if (IS_ERR(str))
>  		return str;
>  
>  	if (*str != '/')
>  		return ERR_PTR(-EINVAL);
>  
> -	return bitmap_getnum(str + 1, &r->group_len);
> +	return bitmap_getrnum(str + 1, r, group_len);
>  
>  no_end:
>  	r->end = r->start;
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


