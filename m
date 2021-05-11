Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7770837A12E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEKHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:51:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:36203 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhEKHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:51:19 -0400
IronPort-SDR: 4/hIxdxVbkWn/YLgqIL5ub8xhNeLW8T0KkL/PgZxRYxW4cNTdpQ7dDfJDzvLbdrUG9XUIHJx/L
 DUlLVcv2nJ+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220337636"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="220337636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:50:10 -0700
IronPort-SDR: 7oO+BRX87gISiJgQtxt2jgefw/vqrAplI64s97gQa0B6xSGlGX31LUzzhA865gVWAuqdYUaxZM
 MMb8UVSf9hFw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="468731982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:50:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lgN9a-00BNff-5e; Tue, 11 May 2021 10:50:06 +0300
Date:   Tue, 11 May 2021 10:50:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
Message-ID: <YJo3LoDSqr18YiNh@smile.fi.intel.com>
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
 <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
 <YJovqMqJj3mBeRE8@smile.fi.intel.com>
 <55aeec09-63c7-7d1a-13c9-cd8f4b7dc1f9@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55aeec09-63c7-7d1a-13c9-cd8f4b7dc1f9@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:26:36AM +0200, Rodolfo Giometti wrote:
> On 11/05/21 09:18, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 09:05:00AM +0200, Rodolfo Giometti wrote:
> >> On 10/05/21 16:13, Andy Shevchenko wrote:
> >>> Switch to use module_parport_driver() to reduce boilerplate code.
> >>>
> >>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>> ---
> >>>  drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
> >>>  1 file changed, 8 insertions(+), 34 deletions(-)
> >>>
> >>> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> >>> index 7a41fb7b0dec..42f93d4c6ee3 100644
> >>> --- a/drivers/pps/clients/pps_parport.c
> >>> +++ b/drivers/pps/clients/pps_parport.c
> >>> @@ -22,8 +22,6 @@
> >>>  #include <linux/parport.h>
> >>>  #include <linux/pps_kernel.h>
> >>>  
> >>> -#define DRVDESC "parallel port PPS client"
> >>> -
> >>>  /* module parameters */
> >>>  
> >>>  #define CLEAR_WAIT_MAX		100
> >>> @@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
> >>>  		.dev		= NULL
> >>>  	};
> >>>  
> >>> +	if (clear_wait > CLEAR_WAIT_MAX) {
> >>> +		pr_err("clear_wait value should be not greater then %d\n",
> >>> +		       CLEAR_WAIT_MAX);
> >>> +		return;
> >>> +	}
> >>> +
> >>
> >> Why do you need to do so? Maybe a comment would be welcomed.
> > 
> > It's in original code, I just moved it to ->probe().
> > 
> > What comment do you want to have here, because original code has no comment (I
> > think in any case it's out of scope of this change, but may be prepended or
> > appended to the series)?
> 
> Mmm... these functions can be called at different times, so I don't know if we
> can just move the code safely.

I do not see any issue here. TL;DR: it won't be worse, but might even give an
improvement.

Before it prevented to module to be initialized,
now one may amend this at run time. the downside is that now it will require
module removal and inserting versus just two attempts of inserting in a row.

For the built-in case it shouldn't change much (but if
/sys/module/.../parameters/... is writable for this, then it will allow to do
the similar trick as above, so extending functionality with the flexibility,
means direct improvement).

Okay, permissions are 0 there, I don't remember what it means, maybe the
parameter won't be available under /sysfs at all, but again, it won't change
the functional behaviour, the downside is the memory consumed by the 'built-in'
code at run time.

> Maybe Alexander (in CC) can help us? :)

-- 
With Best Regards,
Andy Shevchenko


