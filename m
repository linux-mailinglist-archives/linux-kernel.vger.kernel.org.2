Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD326304FED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhA0Deg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:28234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbhAZViQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:38:16 -0500
IronPort-SDR: NTX5gQhwG68c5KZynhv2mJqg6pKQm9GZTQH4AI3VXQr+oEJjYOMsJKtrR46W0goO2zrM3zB6d4
 uQO9W501OLAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180055535"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180055535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:36:31 -0800
IronPort-SDR: 7I4VIefGvSRnZH7SU/O/OQ3K4BLrl366YzUSnxjV1R6vsD3Oft1fGAoptSOxJMro2b7pFuuYeF
 7q6Z8YkKTsbw==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="472899901"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:36:28 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4W1i-00Ewav-PS; Tue, 26 Jan 2021 23:37:30 +0200
Date:   Tue, 26 Jan 2021 23:37:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-7-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-7-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:39PM -0500, Paul Gortmaker wrote:
> While this is done for all bitmaps, the original use case in mind was
> for CPU masks and cpulist_parse() as described below.
> 
> It seems that a common configuration is to use the 1st couple cores for
> housekeeping tasks.  This tends to leave the remaining ones to form a
> pool of similarly configured cores to take on the real workload of
> interest to the user.
> 
> So on machine A - with 32 cores, it could be 0-3 for "system" and then
> 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> setting up the worker pool of CPUs.
> 
> But then newer machine B is added, and it has 48 cores, and so while
> the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
> 
> Multiple deployment becomes easier when we can just simply replace 31
> and 47 with "N" and let the system substitute in the actual number at
> boot; a number that it knows better than we do.

I would accept lower 'n' as well.

...

> -static const char *bitmap_getnum(const char *str, unsigned int *num)
> +static const char *__bitmap_getnum(const char *str, unsigned int nbits,
> +				    unsigned int *num)
>  {
>  	unsigned long long n;
>  	unsigned int len;
>  
> +	if (str[0] == 'N') {
> +		*num = nbits - 1;
> +		return str + 1;
> +	}

But locating it here makes possible to enter a priori invalid input, like N for
start of the region.

I think this should be separate helper which is called in places where it makes
sense.

>  	len = _parse_integer(str, 10, &n);
>  	if (!len)
>  		return ERR_PTR(-EINVAL);


-- 
With Best Regards,
Andy Shevchenko


