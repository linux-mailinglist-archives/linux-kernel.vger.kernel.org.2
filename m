Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D56424366
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhJFQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:55:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:34040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhJFQzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:55:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="206164954"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="206164954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:50:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="589827690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:50:48 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYA7x-009GE4-DA;
        Wed, 06 Oct 2021 19:50:45 +0300
Date:   Wed, 6 Oct 2021 19:50:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use
 devm_clk_get_optional() for mclk
Message-ID: <YV3T5evF+hghuwge@smile.fi.intel.com>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
 <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
 <YV3NZnb6mg43nUC1@smile.fi.intel.com>
 <015e084e-70ed-7b5c-b103-8426ef0842d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015e084e-70ed-7b5c-b103-8426ef0842d4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 11:37:24AM -0500, Pierre-Louis Bossart wrote:
> On 10/6/21 11:23 AM, Andy Shevchenko wrote:
> > On Wed, Oct 06, 2021 at 10:51:52AM -0500, Pierre-Louis Bossart wrote:
> >> On 10/6/21 10:04 AM, Andy Shevchenko wrote:

...

> >>>  	if (SND_SOC_DAPM_EVENT_ON(event)) {
> >>> -		if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
> >>> -			ret = clk_prepare_enable(priv->mclk);
> >>> -			if (ret < 0) {
> >>> -				dev_err(card->dev,
> >>> -					"could not configure MCLK state");
> >>> -				return ret;
> >>> -			}
> >>> +		ret = clk_prepare_enable(priv->mclk);
> >>> +		if (ret < 0) {
> >>> +			dev_err(card->dev, "could not configure MCLK state");
> >>> +			return ret;
> >>>  		}
> >>
> >> I don't get why you removed the test on the BYT_RT5651_MCLK_EN quirk,
> >> see below it was designed as a fall-back mode. We don't want to return
> >> an error when we know the clock is not present/desired.
> > 
> > Why should we do a unneeded test? When we switch to the optional, there
> > will be no error from these CCF APIs. Besides that it drops indentation
> > level and makes code neat.
> 
> By looking at this code only one cannot really visualize that it's a
> no-op. I personally prefer to see explicit intent rather than have to
> dig hundreds of lines below what this clock is optional.
> 
> I am also not even sure that in real products this clock is actually
> optional,

The code tells that it's optional. If it's not the case, the code has
to be fixed accordingly.

> the default is to make use of it:
> 
> #define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
> 
> and the only platform without this clock is "Minnowboard Max B3" -
> probably not used by anyone. I fried mine a long time ago.
> 
> We'd need to Hans to comment on this since he's really the only one
> maintaining this code.

Additional pair of eyes and a brain is always good to have!

...

> >> that part in the probe looks fine, but the changes above are controversial.
> > 
> > I didn't get. How controversial? Why? The whole point of _optional is to get
> > rid of unneeded checks (since they are _anyway_ be called).
> 
> It's inconsistent since you kept the following part but no longer use it:

It's used in some cases, but not with CLK APIs where it's redundant.

Otherwise I would remove it completely (actually it's possible to replace
it with the !priv->mclk test.

> +		/*
> +		 * Fall back to bit clock usage when clock is not
> +		 * available likely due to missing dependencies.
> +		 */
> +		if (!priv->mclk)
> +			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;

-- 
With Best Regards,
Andy Shevchenko


