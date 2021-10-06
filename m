Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB33424287
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhJFQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:25:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:44926 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhJFQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:25:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="213157983"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="213157983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:23:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439175129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:23:05 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY9h8-009FoT-9J;
        Wed, 06 Oct 2021 19:23:02 +0300
Date:   Wed, 6 Oct 2021 19:23:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use
 devm_clk_get_optional() for mclk
Message-ID: <YV3NZnb6mg43nUC1@smile.fi.intel.com>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
 <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:51:52AM -0500, Pierre-Louis Bossart wrote:
> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> > The devm_clk_get_optional() helper returns NULL when devm_clk_get()
> > returns -ENOENT. This makes things slightly cleaner. The added benefit
> > is mostly cosmetic.

...

> >  	if (SND_SOC_DAPM_EVENT_ON(event)) {
> > -		if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
> > -			ret = clk_prepare_enable(priv->mclk);
> > -			if (ret < 0) {
> > -				dev_err(card->dev,
> > -					"could not configure MCLK state");
> > -				return ret;
> > -			}
> > +		ret = clk_prepare_enable(priv->mclk);
> > +		if (ret < 0) {
> > +			dev_err(card->dev, "could not configure MCLK state");
> > +			return ret;
> >  		}
> 
> I don't get why you removed the test on the BYT_RT5651_MCLK_EN quirk,
> see below it was designed as a fall-back mode. We don't want to return
> an error when we know the clock is not present/desired.

Why should we do a unneeded test? When we switch to the optional, there
will be no error from these CCF APIs. Besides that it drops indentation
level and makes code neat.

...

> same here, why was the quirk removed?

Same answer.

...

> that part in the probe looks fine, but the changes above are controversial.

I didn't get. How controversial? Why? The whole point of _optional is to get
rid of unneeded checks (since they are _anyway_ be called).

-- 
With Best Regards,
Andy Shevchenko


