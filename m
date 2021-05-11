Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C637A89F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhEKOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:12:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:39052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhEKOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:12:40 -0400
IronPort-SDR: nIpA2S2ypTkC51tHQ4ODD5y8uHkz2c9UAykMPJgZQJr0CHQHFqA7h4cPkfYWf/axICPEwV8GQK
 GSLZyEQN2aaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179044132"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179044132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:11:34 -0700
IronPort-SDR: V7GrQEfQsFjN+DWzOkb5DLz1EaBBY3grFEDntmwP7UbwJC4VOPqhtq/cB8zn9D937X2nNi3UT2
 afTQWr+iMYSQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434463993"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:11:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lgT6g-00BSpA-Kj; Tue, 11 May 2021 17:11:30 +0300
Date:   Tue, 11 May 2021 17:11:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
Message-ID: <YJqQkvqGUScrrWoL@smile.fi.intel.com>
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
 <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
 <YJovqMqJj3mBeRE8@smile.fi.intel.com>
 <55aeec09-63c7-7d1a-13c9-cd8f4b7dc1f9@enneenne.com>
 <YJo3LoDSqr18YiNh@smile.fi.intel.com>
 <04e6d0e4-4ef1-b27b-0b10-7e57280d5c9f@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e6d0e4-4ef1-b27b-0b10-7e57280d5c9f@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:46:01AM +0200, Rodolfo Giometti wrote:
> On 11/05/21 09:50, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 09:26:36AM +0200, Rodolfo Giometti wrote:
> >> On 11/05/21 09:18, Andy Shevchenko wrote:
> >>> On Tue, May 11, 2021 at 09:05:00AM +0200, Rodolfo Giometti wrote:
> >>>> On 10/05/21 16:13, Andy Shevchenko wrote:

...

> >>>>> +	if (clear_wait > CLEAR_WAIT_MAX) {
> >>>>> +		pr_err("clear_wait value should be not greater then %d\n",
> >>>>> +		       CLEAR_WAIT_MAX);
> >>>>> +		return;
> >>>>> +	}
> >>>>> +
> >>>>
> >>>> Why do you need to do so? Maybe a comment would be welcomed.
> >>>
> >>> It's in original code, I just moved it to ->probe().
> >>>
> >>> What comment do you want to have here, because original code has no comment (I
> >>> think in any case it's out of scope of this change, but may be prepended or
> >>> appended to the series)?
> >>
> >> Mmm... these functions can be called at different times, so I don't know if we
> >> can just move the code safely.
> > 
> > I do not see any issue here. TL;DR: it won't be worse, but might even give an
> > improvement.
> > 
> > Before it prevented to module to be initialized,
> > now one may amend this at run time. the downside is that now it will require
> > module removal and inserting versus just two attempts of inserting in a row.
> > 
> > For the built-in case it shouldn't change much (but if
> > /sys/module/.../parameters/... is writable for this, then it will allow to do
> > the similar trick as above, so extending functionality with the flexibility,
> > means direct improvement).
> > 
> > Okay, permissions are 0 there, I don't remember what it means, maybe the
> > parameter won't be available under /sysfs at all, but again, it won't change
> > the functional behaviour, the downside is the memory consumed by the 'built-in'
> > code at run time.
> 
> OK, I see. If so

At least this is my understanding how it works before and after the change.
If anybody has something to clarify here, I would be glad to learn!

> it's OK for me:
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


