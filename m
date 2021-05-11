Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA737A090
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEKHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:19:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:27686 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKHTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:19:11 -0400
IronPort-SDR: gyt+xFQ7QfTSFTYOfXD9F2WzKtkcseSA+vI7HuVzkhMjzua6RseHPE6bUySKcYaAzdJtHK/CIk
 5pWlJszAygfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179639124"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179639124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:18:04 -0700
IronPort-SDR: NFs2EGgwrUQTeLLZhJRoctJWp6RIxj1y2dI2PoRkDIihvJrMUEc5yeuYZRmyRYJ3sDkbVul2+T
 NzKypVJfKwrw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="391298212"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:18:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lgMeW-00BNIS-Tl; Tue, 11 May 2021 10:18:00 +0300
Date:   Tue, 11 May 2021 10:18:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
Message-ID: <YJovqMqJj3mBeRE8@smile.fi.intel.com>
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
 <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:05:00AM +0200, Rodolfo Giometti wrote:
> On 10/05/21 16:13, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
> >  1 file changed, 8 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> > index 7a41fb7b0dec..42f93d4c6ee3 100644
> > --- a/drivers/pps/clients/pps_parport.c
> > +++ b/drivers/pps/clients/pps_parport.c
> > @@ -22,8 +22,6 @@
> >  #include <linux/parport.h>
> >  #include <linux/pps_kernel.h>
> >  
> > -#define DRVDESC "parallel port PPS client"
> > -
> >  /* module parameters */
> >  
> >  #define CLEAR_WAIT_MAX		100
> > @@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
> >  		.dev		= NULL
> >  	};
> >  
> > +	if (clear_wait > CLEAR_WAIT_MAX) {
> > +		pr_err("clear_wait value should be not greater then %d\n",
> > +		       CLEAR_WAIT_MAX);
> > +		return;
> > +	}
> > +
> 
> Why do you need to do so? Maybe a comment would be welcomed.

It's in original code, I just moved it to ->probe().

What comment do you want to have here, because original code has no comment (I
think in any case it's out of scope of this change, but may be prepended or
appended to the series)?

-- 
With Best Regards,
Andy Shevchenko


