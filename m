Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36AF3F3C71
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhHUUql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhHUUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 16:46:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9DDC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 13:46:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e21so11731475ejz.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jW6WgkkcgqeMv2g70HWibDwKNVYFyjoAOtV6/XbdB3I=;
        b=qqY8UxSxlX5wea3lPQ0OcfWiDDRe3k47+uUluXghkrYr5Iwu/+xTeJVZepCNhD9FDx
         hSnV7rQVGcsYDrNkKL4NK/Iiic0cOQnAVm3a+F85vu25NDyTQS5P+Q2v95e7/V4FpRhw
         AxArOzTMRYHNlwdO5xtWiLJ4EbNU2CYyyvwr1G8ylP2AHFggPe4hO0UDkHZVdJwtjhY/
         vdZH/BjCC8dlxI0p7w6p3CimbD9aEk/QACb27bGRGY64coKJtYtqXGSoGWtYS6UGEno2
         26A1SCtxhH/QTspbix9EuFOWfpliO8a8/0ijMxxyKxPtBwog7NwJUZLfbp7xi2PeQ84d
         1ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jW6WgkkcgqeMv2g70HWibDwKNVYFyjoAOtV6/XbdB3I=;
        b=CvYkWh5bP+WvoPzRGQV2yK7bWgQCB+BljOiEwe0w0D2jT388vcVFKTElCttWO7Pvxd
         jrKcr3h2cIF+nyTBXbiZwoEwX13E0UHjvP84uo66qrwwlM+j8t1bO9Lbsmy4gUaygij4
         4pKudYnvyAVzt7NTHoAYguayzE0gxSELeA25BAyMBhSdxMGacs0a0oBCRWr//6nWLlrl
         YjO7bvdplLYxjwWkZxck1qh69Ghgh018AcVwX3Wf01oXXsFFS0igdAxs89Y3Qo+VhQLG
         Vd8nu3PT0vhiUIQQZWgx2S9wLb9tduwmBNRtiLIMqXrLPo6DtMYkNWV+WUWi5yPRJjLj
         zJPg==
X-Gm-Message-State: AOAM533eqLSI/eRaqirT2FD0xzhC0JOb9uvbTopJqntQ71ZGxg1TuG3M
        94TUEzF1Tyauoz5i0kfK31M=
X-Google-Smtp-Source: ABdhPJylGo+JqRqLQ/39m2bF0KZUWoYNkH79V+Bh47oCk6+evGfniowz7vDAvz9iwcOv5AjqB18Djg==
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr29018008eju.126.1629578758085;
        Sat, 21 Aug 2021 13:45:58 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o6sm229307eje.6.2021.08.21.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 13:45:57 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ASoC: rockchip: add support for i2s-tdm controller
Date:   Sat, 21 Aug 2021 22:45:52 +0200
Message-ID: <3469189.PC3msRC2N5@archbook>
In-Reply-To: <66d6bd43-ee43-eff4-7a68-333fbb996787@linux.intel.com>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com> <20210820182731.29370-2-frattaroli.nicolas@gmail.com> <66d6bd43-ee43-eff4-7a68-333fbb996787@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 20. August 2021 21:02:16 CEST Pierre-Louis Bossart wrote:
> > +	regmap_read(i2s_tdm->regmap, I2S_CLR, &val);
> > +	/* Wait on the clear operation to finish */
> > +	while (val) {
> 
> delay needed here?
> 

The rockchip_i2s.c code doesn't have a delay here either, but I can
add one of 1 usec for good measure, it seems weird to retry the
read as fast as it can.

> > +static int rockchip_i2s_tdm_clk_set_rate(struct rk_i2s_tdm_dev *i2s_tdm,
> > +					 struct clk *clk, unsigned long rate,
> > +					 int ppm)
> > +{
> > +	unsigned long rate_target;
> > +	int delta, ret;
> > +
> > +	if (ppm == i2s_tdm->clk_ppm)
> > +		return 0;
> > +
> > +	delta = (ppm < 0) ? -1 : 1;
> > +	delta *= (int)div64_u64((u64)rate * (u64)abs(ppm) + 500000,
> > +				1000000);
> 
> formula looks odd? looks like you are implementing a round to nearest
> operation, but that shouldn't require this multiplication?
> 

I believe the multiplication is there to compensate for clock drift.
ppm is a value between -1000 and 1000 that specifies the clock drift
in presumably parts per million, going by the variable name.

> > +	pm_runtime_enable(&pdev->dev);
> > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > +		ret = i2s_tdm_runtime_resume(&pdev->dev);
> 
> that looks like dead code? you've just enabled pm_runtime, why would
> this fail?
> 

I've had a look at the upstream rockchip_i2s.c code which does the
same thing, and I believe the idea here is that we need to manually
prepare and enable the master clocks (mclk_rx/mclk_tx) if pm_runtime
is not available. Otherwise, pm_runtime will presumably call our
resume callback at some point.

If runtime power management is disabled in the kernel config then 
pm_runtime_enabled is always going to return false.

> > +err_suspend:
> > +	if (!pm_runtime_status_suspended(&pdev->dev))
> > +		i2s_tdm_runtime_suspend(&pdev->dev);
> 
> why is this necessary?

I believe this is the same kind of situation as before, and the
other driver does this too: if pm_runtime is not available, we
need to stop our clocks manually on probe failure.
 
> > +err_pm_disable:
> > +	pm_runtime_disable(&pdev->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rockchip_i2s_tdm_remove(struct platform_device *pdev)
> > +{
> > +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(&pdev->dev);
> > +
> > +	pm_runtime_disable(&pdev->dev);
> > +	if (!pm_runtime_status_suspended(&pdev->dev))
> > +		i2s_tdm_runtime_suspend(&pdev->dev);
> 
> this looks backwards, if you disable pm_runtime first what is the
> expectation for the rest.

I'm not well versed in the PM code but if my theory of this being
related to unavailable PM is correct, then my best guess is that
pm_runtime_disable does suspend the device, so if it's not
suspended then we don't have pm_runtime and therefore need to call
it manually.

> > +
> > +	if (!IS_ERR(i2s_tdm->mclk_tx))
> > +		clk_prepare_enable(i2s_tdm->mclk_tx);
> > +	if (!IS_ERR(i2s_tdm->mclk_rx))
> > +		clk_prepare_enable(i2s_tdm->mclk_rx);
> > +	if (!IS_ERR(i2s_tdm->hclk))
> > +		clk_disable_unprepare(i2s_tdm->hclk);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> 
> use __maybe_unused

You mean instead of the ifdef stuff to just add this attribute to
the following functions like this?

static int rockchip_i2s_tdm_suspend(struct device *dev) __maybe_unused

> 
> > +static int rockchip_i2s_tdm_suspend(struct device *dev)
> > +{
> > +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(dev);
> > +
> > +	regcache_mark_dirty(i2s_tdm->regmap);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rockchip_i2s_tdm_resume(struct device *dev)
> > +{
> > +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_sync(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = regcache_sync(i2s_tdm->regmap);
> > +	pm_runtime_put(dev);
> > +
> > +	return ret;
> > +}
> > +#endif

Thank you for your review!

Regards,
Nicolas Frattaroli



