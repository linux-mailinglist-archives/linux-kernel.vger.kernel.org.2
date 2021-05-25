Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7472390612
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhEYQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:02:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:31575 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhEYQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:02:32 -0400
IronPort-SDR: +yrcrzh+cFyncYAlLZDffjeUlI9+oYWQVkhakVe09UYI1zk5Q1wO+XJDmMsgzSIGk/uVOVRG+x
 FIZYMQbpM72w==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182551583"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="182551583"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 09:00:32 -0700
IronPort-SDR: RXtY0TTwUjjVwDVzGb8+M2V2NDvtXyS/x84V7NDpW5xHxLYYtNmNvP/Zl4KRZhloqzf2fY4/iP
 wZgG4Ai6/2nw==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="408811337"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 09:00:30 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1llZTo-00EcK2-12; Tue, 25 May 2021 19:00:28 +0300
Date:   Tue, 25 May 2021 19:00:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org,
        akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH v2 1/2] lib/math/rational.c: Fix divide by zero
Message-ID: <YK0fHBtcQ/32QiyT@smile.fi.intel.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525144250.214670-1-tpiepho@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 07:42:49AM -0700, Trent Piepho wrote:
> If the input is out of the range of the allowed values, either larger
> than the largest value or closer to zero than the smallest non-zero
> allowed value, then a division by zero would occur.
> 
> In the case of input too large, the division by zero will occur on the
> first iteration.  The best result (largest allowed value) will be found
> by always choosing the semi-convergent and excluding the denominator
> based limit when finding it.
> 
> In the case of the input too small, the division by zero will occur on
> the second iteration.  The numerator based semi-convergent should not be
> calculated to avoid the division by zero.  But the semi-convergent vs
> previous convergent test is still needed, which effectively chooses
> between 0 (the previous convergent) vs the smallest allowed fraction
> (best semi-convergent) as the result.

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 323dd2c3ed0 ("lib/math/rational.c: fix possible incorrect result from rational fractions helper")
> Reported-by: Yiyuan Guo <yguoaz@gmail.com>
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> ---
>  lib/math/rational.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/math/rational.c b/lib/math/rational.c
> index 9781d521963d..c0ab51d8fbb9 100644
> --- a/lib/math/rational.c
> +++ b/lib/math/rational.c
> @@ -12,6 +12,7 @@
>  #include <linux/compiler.h>
>  #include <linux/export.h>
>  #include <linux/minmax.h>
> +#include <linux/limits.h>
>  
>  /*
>   * calculate best rational approximation for a given fraction
> @@ -78,13 +79,18 @@ void rational_best_approximation(
>  		 * found below as 't'.
>  		 */
>  		if ((n2 > max_numerator) || (d2 > max_denominator)) {
> -			unsigned long t = min((max_numerator - n0) / n1,
> -					      (max_denominator - d0) / d1);
> +			unsigned long t = ULONG_MAX;
>  
> -			/* This tests if the semi-convergent is closer
> -			 * than the previous convergent.
> +			if (d1)
> +				t = (max_denominator - d0) / d1;
> +			if (n1)
> +				t = min(t, (max_numerator - n0) / n1);
> +
> +			/* This tests if the semi-convergent is closer than the previous
> +			 * convergent.  If d1 is zero there is no previous convergent as this
> +			 * is the 1st iteration, so always choose the semi-convergent.
>  			 */
> -			if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> +			if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
>  				n1 = n0 + t * n1;
>  				d1 = d0 + t * d1;
>  			}
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


