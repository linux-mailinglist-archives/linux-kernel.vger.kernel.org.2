Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D780347C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhCXPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:20:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:5443 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236622AbhCXPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:20:05 -0400
IronPort-SDR: 8B0I7IHkDmVn7MCYwijv7T5kqXYfB/AnwAEf43KvE20aMUgtTVFN9X9A0QH4maxSEl9KhGQRjS
 Oj623A0+hdGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177843099"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="177843099"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:20:04 -0700
IronPort-SDR: 0Csxo38hYG0gOWjX4f8jYtke/oOzK7BN7YMXUE1uQxG3pye9fUXjGOMOwlDz/Tf+xGLjli431t
 w3AjDvzB7v1w==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="408895864"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:20:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP5If-00Fj94-4b; Wed, 24 Mar 2021 17:20:01 +0200
Date:   Wed, 24 Mar 2021 17:20:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <YFtYoefcG6+jI3mQ@smile.fi.intel.com>
References: <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
 <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
 <20210324115033.GM2916463@dell>
 <YFsv6DijMMiv3D10@smile.fi.intel.com>
 <20210324130723.GN2916463@dell>
 <YFtKo4IrOGWoX6O3@smile.fi.intel.com>
 <20210324151035.GO2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324151035.GO2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:10:35PM +0000, Lee Jones wrote:
> On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > On Wed, Mar 24, 2021 at 01:07:23PM +0000, Lee Jones wrote:
> > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > > On Wed, Mar 24, 2021 at 11:50:33AM +0000, Lee Jones wrote:

...

> > > > It's a two way road:
> > > > a) driver states that it needs only 1 vector and it's enough to it
> > > > b) hardware must provide at least 1 vector to be served by this driver.
> > > > 
> > > > Look again into grepped output. Most of drivers that define it as an variable
> > > > may dynamically adapt to the different amount of IRQ vectors. When it's static,
> > > > usually drivers just hard code those values.
> > > > 
> > > > I'm really don't see a point to define them _in this driver_.
> > > 
> > > That's fine.  I just felt like I had to ask.
> > > 
> > > Would you consider a comment that lets people unfamiliar with the API
> > > what the values mean?
> > > 
> > > Something to the tune of:
> > > 
> > >   "This driver requests 1 (and only 1) IRQ vector"
> > 
> > 
> > Rather
> > 
> >     "This driver requests only 1 (and it's enough) IRQ vector"
> 
>  "This driver only requires 1 IRQ vector"

Thanks! v3 has been sent.

> > or something like this.
> > 
> > Should I send a patch with the comment included? If so, please suggest if it's
> > good from English grammar/style perspective.

-- 
With Best Regards,
Andy Shevchenko


