Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054163F4CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhHWPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:03:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:28930 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhHWPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:03:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="278131483"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="278131483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 08:02:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="492732236"
Received: from ikuon-mobl.amr.corp.intel.com (HELO [10.212.74.116]) ([10.212.74.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 08:02:21 -0700
Subject: Re: [PATCH v2 1/4] ASoC: rockchip: add support for i2s-tdm controller
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
 <20210820182731.29370-2-frattaroli.nicolas@gmail.com>
 <66d6bd43-ee43-eff4-7a68-333fbb996787@linux.intel.com>
 <3469189.PC3msRC2N5@archbook>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a2aa0525-326e-9364-1907-c1d53bca39cf@linux.intel.com>
Date:   Mon, 23 Aug 2021 10:02:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3469189.PC3msRC2N5@archbook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/21 3:45 PM, Nicolas Frattaroli wrote:
> On Freitag, 20. August 2021 21:02:16 CEST Pierre-Louis Bossart wrote:
>>> +	regmap_read(i2s_tdm->regmap, I2S_CLR, &val);
>>> +	/* Wait on the clear operation to finish */
>>> +	while (val) {
>>
>> delay needed here?
>>
> 
> The rockchip_i2s.c code doesn't have a delay here either, but I can
> add one of 1 usec for good measure, it seems weird to retry the
> read as fast as it can.

yep.

>>> +static int rockchip_i2s_tdm_clk_set_rate(struct rk_i2s_tdm_dev *i2s_tdm,
>>> +					 struct clk *clk, unsigned long rate,
>>> +					 int ppm)
>>> +{
>>> +	unsigned long rate_target;
>>> +	int delta, ret;
>>> +
>>> +	if (ppm == i2s_tdm->clk_ppm)
>>> +		return 0;
>>> +
>>> +	delta = (ppm < 0) ? -1 : 1;
>>> +	delta *= (int)div64_u64((u64)rate * (u64)abs(ppm) + 500000,
>>> +				1000000);
>>
>> formula looks odd? looks like you are implementing a round to nearest
>> operation, but that shouldn't require this multiplication?
>>
> 
> I believe the multiplication is there to compensate for clock drift.
> ppm is a value between -1000 and 1000 that specifies the clock drift
> in presumably parts per million, going by the variable name.

I meant using a signed division with lsb round-to-nearest, something like:

delta = (int)div64_u64((u64)rate * (u64)(ppm) + 500000,
			1000000);

> 
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	if (!pm_runtime_enabled(&pdev->dev)) {
>>> +		ret = i2s_tdm_runtime_resume(&pdev->dev);
>>
>> that looks like dead code? you've just enabled pm_runtime, why would
>> this fail?
>>
> 
> I've had a look at the upstream rockchip_i2s.c code which does the
> same thing, and I believe the idea here is that we need to manually
> prepare and enable the master clocks (mclk_rx/mclk_tx) if pm_runtime
> is not available. Otherwise, pm_runtime will presumably call our
> resume callback at some point.
> 
> If runtime power management is disabled in the kernel config then 
> pm_runtime_enabled is always going to return false.

that seems very odd. why not enable the clocks by default and let them
stop in suspend.

>>> +err_suspend:
>>> +	if (!pm_runtime_status_suspended(&pdev->dev))
>>> +		i2s_tdm_runtime_suspend(&pdev->dev);
>>
>> why is this necessary?
> 
> I believe this is the same kind of situation as before, and the
> other driver does this too: if pm_runtime is not available, we
> need to stop our clocks manually on probe failure.

then use pm_runtime_disable() and manually stop the clocks...

>>> +err_pm_disable:
>>> +	pm_runtime_disable(&pdev->dev);>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int rockchip_i2s_tdm_remove(struct platform_device *pdev)
>>> +{
>>> +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(&pdev->dev);
>>> +
>>> +	pm_runtime_disable(&pdev->dev);
>>> +	if (!pm_runtime_status_suspended(&pdev->dev))
>>> +		i2s_tdm_runtime_suspend(&pdev->dev);
>>
>> this looks backwards, if you disable pm_runtime first what is the
>> expectation for the rest.
> 
> I'm not well versed in the PM code but if my theory of this being
> related to unavailable PM is correct, then my best guess is that
> pm_runtime_disable does suspend the device, so if it's not
> suspended then we don't have pm_runtime and therefore need to call
> it manually.

I think this is really doing things backwards. You want to
unconditionally enable all resources on probe, and let them go to idle
when no one needs them - or if pm_runtime is disabled.

>>> +
>>> +	if (!IS_ERR(i2s_tdm->mclk_tx))
>>> +		clk_prepare_enable(i2s_tdm->mclk_tx);
>>> +	if (!IS_ERR(i2s_tdm->mclk_rx))
>>> +		clk_prepare_enable(i2s_tdm->mclk_rx);
>>> +	if (!IS_ERR(i2s_tdm->hclk))
>>> +		clk_disable_unprepare(i2s_tdm->hclk);
>>> +
>>> +	return 0;>>> +}
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>
>> use __maybe_unused
> 
> You mean instead of the ifdef stuff to just add this attribute to
> the following functions like this?
> 
> static int rockchip_i2s_tdm_suspend(struct device *dev) __maybe_unused

yes

> 
>>
>>> +static int rockchip_i2s_tdm_suspend(struct device *dev)
>>> +{
>>> +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(dev);
>>> +
>>> +	regcache_mark_dirty(i2s_tdm->regmap);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int rockchip_i2s_tdm_resume(struct device *dev)
>>> +{
>>> +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	ret = pm_runtime_get_sync(dev);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	ret = regcache_sync(i2s_tdm->regmap);
>>> +	pm_runtime_put(dev);
>>> +
>>> +	return ret;
>>> +}
>>> +#endif
> 
> Thank you for your review!
> 
> Regards,
> Nicolas Frattaroli
> 
> 
> 
