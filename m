Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0637B423
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELCWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:22:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:33619 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhELCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:22:47 -0400
IronPort-SDR: jzWAovs4DqC0qOiY/Fi+E+VHXzVC8KICwRbu0wOIfpiQC3CIlJxKAvycG4kxqMxTbKXYyIvvuA
 h8O4hvuvf5Pg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="187032625"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="187032625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 19:21:39 -0700
IronPort-SDR: Il00NeK2IBjFWolNL/9XJdOpXFlaBE0h0sJYaE7ukiG1sN97HbEggiL0Tz2hLktZAcYwbXbQEK
 SJcAyq82l+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="436971462"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2021 19:21:36 -0700
Date:   Wed, 12 May 2021 10:21:36 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com, zhengjun.xing@intel.com
Subject: Re: [PATCH v14 clocksource 6/6] clocksource: Print deviation in
 nanoseconds for unstable case
Message-ID: <20210512022136.GC78351@shbuild999.sh.intel.com>
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
 <20210511233455.2897068-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511233455.2897068-6-paulmck@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:34:55PM -0700, Paul E. McKenney wrote:
> From: Feng Tang <feng.tang@intel.com>
> 
> Currently when an unstable clocksource is detected, the raw counters
> of that clocksource and watchdog will be printed, which can only be
> understood after some math calculation.  So print the existing delta in
> nanoseconds to make it easier for humans to check the results.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/time/clocksource.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index bbe1bcf44ffa..9c45b98e60e2 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -406,10 +406,10 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (abs(cs_nsec - wd_nsec) > md) {
>  			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
>  				smp_processor_id(), cs->name);
> -			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
> -				watchdog->name, wdnow, wdlast, watchdog->mask);
> -			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
> -				cs->name, csnow, cslast, cs->mask);
> +			pr_warn("                      '%s' wd_nesc: %lld wd_now: %llx wd_last: %llx mask: %llx\n",

There is a typo in the message, 'wd_nesc' should be 'wd_nsec' , 
sorry for that.

Thanks,
Feng


> +				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
> +			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
> +				cs->name, cs_nsec, csnow, cslast, cs->mask);
>  			if (curr_clocksource == cs)
>  				pr_warn("                      '%s' is current clocksource.\n", cs->name);
>  			else if (curr_clocksource)
> -- 
> 2.31.1.189.g2e36527f23
