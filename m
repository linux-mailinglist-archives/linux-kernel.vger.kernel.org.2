Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FE38FD57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhEYJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:04:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:44599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232040AbhEYJE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:04:26 -0400
IronPort-SDR: QdFFDbZPjnQw+yR7qMWf8xagLY2Vr40sSFuK8rbkKr1WLtfYb1qKlmQyhmJPL9/abCygxUMsxn
 qRzPRcGJJN0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="200245320"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="200245320"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:02:57 -0700
IronPort-SDR: Qh4xH2fUQEeDZqhStU3nSwFfjW3TTpXUaxY3SOKmv+FWHVU38KYMbqo1TOaQfpB/Vxb+kNz/q6
 BxWXjJ4XaLfg==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="630156052"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:02:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1llSxg-00EXxn-9Y; Tue, 25 May 2021 12:02:52 +0300
Date:   Tue, 25 May 2021 12:02:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>, linux-kernel@vger.kernel.org,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
Message-ID: <YKy9PHIbuhsomsTq@smile.fi.intel.com>
References: <20210523001806.3927609-1-tpiepho@gmail.com>
 <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 01:17:48PM -0700, Trent Piepho wrote:
> On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
> >
> > This misses the test cases (*). Please, develop them with Daniel.
> >
> > *) We usually don't accept changes in the generic libraries without test cases.
> >
> > Fixes tag?
> 
> Is there a bug report on a tracker?  I just got the email from Yigua.

Fixes tag refers to the existing commit that brought the bug.
Also you may need to add Reported-by tag since Yigua reported it.

...

> > I think that refactoring may lead us to check first iteration before even going
> > into the loop. But it's another story and we may do it later (the algo uses
> 
> I started that, but it had no advantages and some disadvantages.
> 
> Basically, there are three cases: too large, too small & closest to
> zero, too small & closest to non-zero.  This code can handle those
> three cases by adding three branches, if(d1), if(n1), and if(!d1).
> The truth values we need already exist at this point the algorithm.
> 
> If it's at the start, then there still needs to be the three branches
> for each case.  But the values to test must be calculated too.
> 
> What's more, it's possible that the value is exactly representable in
> the allowed range.  That's actual appears to be the most common use
> case, reducing a fraction to lowest terms (*).  By putting the tests
> in the "terminate because of limits" case, they don't need to happen
> when "terminate because exact value find" is the result. If the check
> was first, then it would always happen, even if it wouldn't have been
> necessary.
> 
> And the time it took to find this bug shows us that out of bounds
> inputs are not a common case, so putting that on the hot path by
> checking it first at the expense of the reducing to lowest terms path
> doesn't make sense.

Thanks for detailed explanation of your view to the current state of the code.
As you noticed I am not insisting on refactoring or so, I was rather wondering
if it can be done in the future. Still we might need some performance tests.

Daniel, does KUnit have a capability to test performance?
Like running test case 1M times or so and calc average (median?) time of
execution.

> (*)  One could write a reduce to lowest terms function with an easier
> interface.  It could be a trivial one expression wrapper around
> rational_best_approximation().  It could also be a simpler function,
> but I think it would still perform the exact same sequence of
> divisions and moduli, so it wouldn't really make any difference.

-- 
With Best Regards,
Andy Shevchenko


