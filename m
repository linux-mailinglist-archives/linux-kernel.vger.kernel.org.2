Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADF4305240
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhA0D0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:46592 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbhAZVM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:12:57 -0500
IronPort-SDR: G6Q3yaqLPB41xE0cAf5S0ljSVIoSPVPwq5Yx+O6N0iif4pj01ZIzKrn8Ki7bG6kpqRruQ2ZPSp
 Z19RQYrwEHtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="264794159"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="264794159"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:10:26 -0800
IronPort-SDR: xTfDIcKXG41ek8K2XFdVEjJ1kBbsknSDpCl0yi6HYqNK5zxkHDOjTHsz2upEFb5FoPhwOs2GD7
 G3B/aZ51HQvQ==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="406852355"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:10:22 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4VcR-00Ev3u-K1; Tue, 26 Jan 2021 23:11:23 +0200
Date:   Tue, 26 Jan 2021 23:11:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 2/8] lib: test_bitmap: add more start-end:offset/len tests
Message-ID: <YBCFeyVGih5RMuBY@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-3-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-3-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:35PM -0500, Paul Gortmaker wrote:
> There are inputs to bitmap_parselist() that would probably never
> be entered manually by a person, but might result from some kind of
> automated input generator.  Things like ranges of length 1, or group
> lengths longer than nbits, overlaps, or offsets of zero.
> 
> Adding these tests serve two purposes:
> 
> 1) document what might seem odd but nonetheless valid input.
> 
> 2) don't regress from what we currently accept as valid.

Makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/test_bitmap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 3d2cd3b1de84..807d1e8dd59c 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -35,6 +35,8 @@ static const unsigned long exp1[] __initconst = {
>  	BITMAP_FROM_U64(0x3333333311111111ULL),
>  	BITMAP_FROM_U64(0xffffffff77777777ULL),
>  	BITMAP_FROM_U64(0),
> +	BITMAP_FROM_U64(0x00008000),
> +	BITMAP_FROM_U64(0x80000000),
>  };
>  
>  static const unsigned long exp2[] __initconst = {
> @@ -335,6 +337,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
>  	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
>  
> +	{0, "0-0",			&exp1[0], 32, 0},
> +	{0, "1-1",			&exp1[1 * step], 32, 0},
> +	{0, "15-15",			&exp1[13 * step], 32, 0},
> +	{0, "31-31",			&exp1[14 * step], 32, 0},
> +
> +	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
> +	{0, "0-0:1/1",			&exp1[0], 32, 0},
> +	{0, "0-0:1/31",			&exp1[0], 32, 0},
> +	{0, "0-0:31/31",		&exp1[0], 32, 0},
> +	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
> +	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
> +	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
> +	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
> +	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
> +	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
> +	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
> +
> +	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
> +	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
> +
>  	{-EINVAL, "-1",	NULL, 8, 0},
>  	{-EINVAL, "-0",	NULL, 8, 0},
>  	{-EINVAL, "10-1", NULL, 8, 0},	/* (start > end) ; also ERANGE */
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


