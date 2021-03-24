Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292003476FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhCXLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:20:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:54144 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhCXLUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:20:35 -0400
IronPort-SDR: 1ws+mNzisgPu2pYDA9W7wsbcTt0VnGqhXph71VpC0AG+GGj7McdDFlLgfAwIl0GyAeNpJfxk39
 SyoG3HAGETpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="275794389"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="275794389"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:20:35 -0700
IronPort-SDR: o6f5Y/LzjPV5OHVsv3qF0h5gPh8qMGWJzCQfDV3VqrcqM5Zg2MOapco2OTA6wV0ztg2jqtTUbI
 M1uWhb5EHaVg==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="452554484"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:20:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP1Yt-00FeUs-CW; Wed, 24 Mar 2021 13:20:31 +0200
Date:   Wed, 24 Mar 2021 13:20:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324104729.GL2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:47:29AM +0000, Lee Jones wrote:
> On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > > On Tue, 23 Mar 2021, Andy Shevchenko wrote:

...

> Also, past acceptance does not guarantee ideal/correct usage.

In this case it's hardly can be misused. But I heard you.

...

> > The semantic is min-max range and having two defines (*) here for these seems
> > to me as an utter overkill.
> > 
> > Of course, if you insist I may do it.
> > 
> > *) since value is the same, we might have one definition, but it will be even
> >    more confusion to have it as a min and max at the same time.
> 
> It's just tricky to decypher for people who do not know the API, which
> is most people, myself included.  For APIs like usleep_range() et al.,
> obviously this makes no sense at all.

Seem like you are insisting. Okay, I will define them. What do you prefer one
or two definitions?

...

> What defines a vector?

The combination is solely of the driver-hardware. Driver explicitly tells that
how many vectors it may consume (taking into account the range asked) and API
returns amount given or an error.

-- 
With Best Regards,
Andy Shevchenko


