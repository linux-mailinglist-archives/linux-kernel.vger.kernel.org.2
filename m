Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A739347A81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhCXOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:20:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:64294 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236110AbhCXOUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:20:23 -0400
IronPort-SDR: 2F6HmT+9DYliSUoXyRss3ao0hzxL4kKuLpWwqFXeG4SMC4JGCmjPg/DtmFCBgA6Lni4z807TrU
 uqzFgZRiztqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177829549"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="177829549"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:20:23 -0700
IronPort-SDR: 80dv7UvpNv1i8WG1lBlSw+Fv8hMmck+YI2sStRQkvtAL//Zh/58tt/rojbLhh4Xui1TOQ+3nhp
 xDcmaWNfksoQ==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="452611824"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:20:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP4Mt-00FiAw-TE; Wed, 24 Mar 2021 16:20:19 +0200
Date:   Wed, 24 Mar 2021 16:20:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <YFtKo4IrOGWoX6O3@smile.fi.intel.com>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
 <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
 <20210324115033.GM2916463@dell>
 <YFsv6DijMMiv3D10@smile.fi.intel.com>
 <20210324130723.GN2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324130723.GN2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:07:23PM +0000, Lee Jones wrote:
> On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> 
> > On Wed, Mar 24, 2021 at 11:50:33AM +0000, Lee Jones wrote:
> > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > 
> > > > On Wed, Mar 24, 2021 at 10:47:29AM +0000, Lee Jones wrote:
> > > > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > > > > On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > > > > > > On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> > > > 
> > > > ...
> > > > 
> > > > > Also, past acceptance does not guarantee ideal/correct usage.
> > > > 
> > > > In this case it's hardly can be misused. But I heard you.
> > > > 
> > > > ...
> > > > 
> > > > > > The semantic is min-max range and having two defines (*) here for these seems
> > > > > > to me as an utter overkill.
> > > > > > 
> > > > > > Of course, if you insist I may do it.
> > > > > > 
> > > > > > *) since value is the same, we might have one definition, but it will be even
> > > > > >    more confusion to have it as a min and max at the same time.
> > > > > 
> > > > > It's just tricky to decypher for people who do not know the API, which
> > > > > is most people, myself included.  For APIs like usleep_range() et al.,
> > > > > obviously this makes no sense at all.
> > > > 
> > > > Seem like you are insisting. Okay, I will define them. What do you prefer one
> > > > or two definitions?
> > > 
> > > Actually I'm not.  I'm just trying to get my head around where the
> > > data comes from and what the values actually mean.
> > > 
> > > > ...
> > > > 
> > > > > What defines a vector?
> > > > 
> > > > The combination is solely of the driver-hardware. Driver explicitly tells that
> > > > how many vectors it may consume (taking into account the range asked) and API
> > > > returns amount given or an error.
> > > 
> > > So, where does the information actually come from?
> > > 
> > > Information that comes from a datasheet is usually defined.
> > > 
> > > Information that comes from the F/W is usually read and popped into a
> > > variable.
> > 
> > It's a two way road:
> > a) driver states that it needs only 1 vector and it's enough to it
> > b) hardware must provide at least 1 vector to be served by this driver.
> > 
> > Look again into grepped output. Most of drivers that define it as an variable
> > may dynamically adapt to the different amount of IRQ vectors. When it's static,
> > usually drivers just hard code those values.
> > 
> > I'm really don't see a point to define them _in this driver_.
> 
> That's fine.  I just felt like I had to ask.
> 
> Would you consider a comment that lets people unfamiliar with the API
> what the values mean?
> 
> Something to the tune of:
> 
>   "This driver requests 1 (and only 1) IRQ vector"


Rather

    "This driver requests only 1 (and it's enough) IRQ vector"

or something like this.

Should I send a patch with the comment included? If so, please suggest if it's
good from English grammar/style perspective.

-- 
With Best Regards,
Andy Shevchenko


