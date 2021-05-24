Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB738E49A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhEXKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:53:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:3367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXKxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:53:15 -0400
IronPort-SDR: TZ/3ElWz5whqS+1Pr11qYN868ieCQfxxE9sJR/3gyvmi51C0b/vrzQqHFtri9efYODyH+mv3AW
 croauXIziV0A==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189289906"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189289906"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:51:46 -0700
IronPort-SDR: 9BVhBPKMRiI/LsSQ+8o5QBReQn7b8jvJdlv4k2OZsKoeT1vikQdDcCAyN+vCR15A2Je9VEoM/l
 DyjtZrnCoF9Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="413545226"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:51:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ll8BR-00EIcd-Qt; Mon, 24 May 2021 13:51:41 +0300
Date:   Mon, 24 May 2021 13:51:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Trent Piepho <tpiepho@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org,
        akpm@linux-foundation.org, oskar@scara.com,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
Message-ID: <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
References: <20210523001806.3927609-1-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523001806.3927609-1-tpiepho@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:

Thanks for the fix! My comments below.

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

This misses the test cases (*). Please, develop them with Daniel.

*) We usually don't accept changes in the generic libraries without test cases.

Fixes tag?

> Reported-by: Yiyuan Guo <yguoaz@gmail.com>
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>

...

> +			/* This tests if the semi-convergent is closer than the previous
> +			 * convergent.  If d1 is zero there is no previous convergent as this
> +			 * is the 1st iteration, so always choose the semi-convergent.
>  			 */
> -			if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> +			if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
>  				n1 = n0 + t * n1;
>  				d1 = d0 + t * d1;
>  			}

I think that refactoring may lead us to check first iteration before even going
into the loop. But it's another story and we may do it later (the algo uses
heavy division anyway, so couple of additional branches probably won't affect
performance too much).

-- 
With Best Regards,
Andy Shevchenko


