Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D9316B38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhBJQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:29:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:23092 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232363AbhBJQ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:29:11 -0500
IronPort-SDR: +A/HPQyqI+L8BthC8ZdYh1Me2m5MK8IIeLSegGe9oYs60dtTqAP5aqypYu55jsh0UYMEJWAfQe
 5OhGLRkw7vNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178594893"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="178594893"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:27:26 -0800
IronPort-SDR: LvgRswj4ujM0TQDKag8IfJgbkvt4hl1So6vNN+Q87LbZo1kTj3LgAQX1HVpu8oW7nlLuALoyFU
 0TkBiVhUGn3g==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="361395355"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:27:22 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9sKl-003lqD-G4; Wed, 10 Feb 2021 18:27:19 +0200
Date:   Wed, 10 Feb 2021 18:27:19 +0200
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
Subject: Re: [PATCH 2/8] lib: test_bitmap: add tests to trigger ERANGE case.
Message-ID: <YCQJZ8LCsuLV3Pdv@smile.fi.intel.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-3-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209225907.78405-3-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:59:01PM -0500, Paul Gortmaker wrote:
> Add tests that specify a valid range, but one that is outside the
> width of the bitmap for which it is to be applied to.  These should
> trigger an -ERANGE response from the code.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/test_bitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 589f2a34ceba..172ffbfa83c4 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -338,6 +338,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  	{-EINVAL, "-1",	NULL, 8, 0},
>  	{-EINVAL, "-0",	NULL, 8, 0},
>  	{-EINVAL, "10-1", NULL, 8, 0},
> +	{-ERANGE, "8-8", NULL, 8, 0},
> +	{-ERANGE, "0-31", NULL, 8, 0},
>  	{-EINVAL, "0-31:", NULL, 32, 0},
>  	{-EINVAL, "0-31:0", NULL, 32, 0},
>  	{-EINVAL, "0-31:0/", NULL, 32, 0},
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


