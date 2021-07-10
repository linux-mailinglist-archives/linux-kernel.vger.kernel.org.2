Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000993C2C38
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGJA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhGJAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:55:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D68C0613E9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 17:53:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 53-20020a9d0eb80000b02904b6c4d33e84so2580774otj.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 17:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=80EMDUL2y212IWzBP3EignI3P/60xzx8R9qkp2zmAAE=;
        b=faLVA7KZSixsQswmsneNZ3KOvh0yFTBasKIaawmyCPuUSMqNYbxVd9EtP95XE1fapS
         zTOWD/5cec+KYRokdqLyFi9sR0q/GnjtpaOSVL+49IwcMqAEub4TKmCErYRXw9rSIhGj
         hcchOvjeQp2pnpOtFy0XpyfTIs3MieCOgHaQ/KOwJcDgU7d8BLhSbfo+Tqpsp4rQ1tbd
         r/xVLGcKJb5G+veP6TZVZTTFRt21Ove0wrWBIXSmuuW0xHGiYvm3cBbTcEUcB1u+lDM+
         Jy1UOXW1EGf9uqe/GBRTwPszO8h6iHK1zuLedsEVXWN2er9gLqdb1vQDKfbR48VxGrFD
         TN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80EMDUL2y212IWzBP3EignI3P/60xzx8R9qkp2zmAAE=;
        b=TqkQc0FC4JdVZkBadXF/C6smbcnWhlTv6Wr/wthlCuMEGomHmoV/YMHXlY3aES7Xf5
         C1JOHRjIr8XvKXlhe00yveuAbUmOywTE0V8k4KH7XAj9K6sgMNiifF5wWMDH6BSsN2nr
         10grhD+JsjlJbmmy/QepqsPdh8/YLv24ZU5ZT/OQHVf2rm0VKTXWg+w7hQwEgztTJXgP
         9LCB3fFfpT2nC7jyL1WKjEPdnFQLb/dxgaTYzXNypLJpdn2qcdK+fBl/AB1Ofofjd7m8
         Qr1F1FMemwE/r1ijPh2kU1i+FTiyNxxWJswdZsdpkNDG25c4hx3Z9dV+wY6uuJnFcI0j
         L5BA==
X-Gm-Message-State: AOAM5314jeP1tyjPHo3TzEQ7IZw3+Nkhsu0GOpIpvdQX5MMveNiyZcgw
        YJPcQApCQTfgZn5lFdwQ+J/KBg==
X-Google-Smtp-Source: ABdhPJwZJs6WWI1Szs6QLwP8Q51dhExAPGz5+K7xWcC/u8pSbFtcC01UqGRmFAWvRJaDvPYDYnMF0Q==
X-Received: by 2002:a9d:d04:: with SMTP id 4mr32193329oti.251.1625878393136;
        Fri, 09 Jul 2021 17:53:13 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x31sm1483387ota.24.2021.07.09.17.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 17:53:12 -0700 (PDT)
Date:   Fri, 9 Jul 2021 19:53:10 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] clk: qcom: gdsc: call runtime PM functions for
 the provider device
Message-ID: <YOjvdmCAhVC+s2OP@yoga>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
 <20210709173202.667820-5-dmitry.baryshkov@linaro.org>
 <YOibXCHvnG70ftQ0@yoga>
 <613b2f07-ffea-9c65-ebd0-6ad3b4fe10b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613b2f07-ffea-9c65-ebd0-6ad3b4fe10b8@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 17:10 CDT 2021, Dmitry Baryshkov wrote:

> On 09/07/2021 21:54, Bjorn Andersson wrote:
> > On Fri 09 Jul 12:31 CDT 2021, Dmitry Baryshkov wrote:
> > 
> > > In order to properly handle runtime PM status of the provider device,
> > > call pm_runtime_get/pm_runtime_put on the clock controller device.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/clk/qcom/gdsc.c | 66 ++++++++++++++++++++++++++++++++++++++---
> > >   drivers/clk/qcom/gdsc.h |  2 ++
> > >   2 files changed, 64 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > index ccd36617d067..6bec31fccb09 100644
> > > --- a/drivers/clk/qcom/gdsc.c
> > > +++ b/drivers/clk/qcom/gdsc.c
> > > @@ -11,6 +11,7 @@
> > >   #include <linux/kernel.h>
> > >   #include <linux/ktime.h>
> > >   #include <linux/pm_domain.h>
> > > +#include <linux/pm_runtime.h>
> > >   #include <linux/regmap.h>
> > >   #include <linux/regulator/consumer.h>
> > >   #include <linux/reset-controller.h>
> > > @@ -50,6 +51,30 @@ enum gdsc_status {
> > >   	GDSC_ON
> > >   };
> > > +static int gdsc_pm_runtime_get(struct gdsc *sc)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!sc->rpm_dev)
> > > +		return 0;
> > > +
> > > +	ret = pm_runtime_get_sync(sc->rpm_dev);
> > > +	if (ret < 0) {
> > > +		pm_runtime_put_noidle(sc->rpm_dev);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int gdsc_pm_runtime_put(struct gdsc *sc)
> > > +{
> > > +	if (!sc->rpm_dev)
> > > +		return 0;
> > > +
> > > +	return pm_runtime_put_sync(sc->rpm_dev);
> > > +}
> > > +
> > >   /* Returns 1 if GDSC status is status, 0 if not, and < 0 on error */
> > >   static int gdsc_check_status(struct gdsc *sc, enum gdsc_status status)
> > >   {
> > > @@ -232,9 +257,8 @@ static void gdsc_retain_ff_on(struct gdsc *sc)
> > >   	regmap_update_bits(sc->regmap, sc->gdscr, mask, mask);
> > >   }
> > > -static int gdsc_enable(struct generic_pm_domain *domain)
> > > +static int _gdsc_enable(struct gdsc *sc)
> > >   {
> > > -	struct gdsc *sc = domain_to_gdsc(domain);
> > >   	int ret;
> > >   	if (sc->pwrsts == PWRSTS_ON)
> > > @@ -290,11 +314,28 @@ static int gdsc_enable(struct generic_pm_domain *domain)
> > >   	return 0;
> > >   }
> > > -static int gdsc_disable(struct generic_pm_domain *domain)
> > > +static int gdsc_enable(struct generic_pm_domain *domain)
> > >   {
> > >   	struct gdsc *sc = domain_to_gdsc(domain);
> > >   	int ret;
> > > +	ret = gdsc_pm_runtime_get(sc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = _gdsc_enable(sc);
> > > +	if (ret) {
> > > +		gdsc_pm_runtime_put(sc);
> > 
> > I presume what you do here is to leave the pm_runtime state of dispcc
> > active if we succeeded in enabling the gdsc. But the gdsc is a subdomain
> > of the parent domain, so the framework should take case of its
> > dependency.
> > 
> > So the reason for gdsc_pm_runtime_get()/put() in this code path is so
> > that you can access the dispcc registers, i.e. I think you should
> > get()/put() regardless of the return value.
> 
> pm domain code will handle enabling MMCX, so this code is not required
> strictly speaking. Ulf suggested adding it back, so I followed the
> suggestion. Maybe I misunderstood his suggestion.
> 
> putting pm_runtime after gdsc_enable does not sound like a logical case.
> However it would simplify code a bit. Let me try...
> 

If you consider this device's and the individual gdsc's power state as
separate consumers of MMCX, then it perhaps makes more sense?

Similar to how a regulator driver would rely on the regulator framework
to deal with parent regulators...

Regards,
Bjorn

> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int _gdsc_disable(struct gdsc *sc)
> > > +{
> > > +	int ret;
> > > +
> > >   	if (sc->pwrsts == PWRSTS_ON)
> > >   		return gdsc_assert_reset(sc);
> > > @@ -329,6 +370,18 @@ static int gdsc_disable(struct generic_pm_domain *domain)
> > >   	return 0;
> > >   }
> > > +static int gdsc_disable(struct generic_pm_domain *domain)
> > > +{
> > > +	struct gdsc *sc = domain_to_gdsc(domain);
> > > +	int ret;
> > > +
> > 
> > If the gdsc is found to be on at initialization, the next operation that
> > will happen is gdsc_disable() and as you didn't activate the pm_runtime
> > state in gdsc_init() you would in theory get here with registers
> > unaccessible.
> > 
> > In practice though, the active gdsc should through the being a subdomain
> > of the parent domain keep power on for you, so you won't notice this
> > issue.
> 
> Nice catch.
> 
> > 
> > But as above, I think you should wrap _gdsc_disable() in a get()/put()
> > pair.
> > 
> > > +	ret = _gdsc_disable(sc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return gdsc_pm_runtime_put(sc);
> > > +}
> > > +
> > >   static int gdsc_init(struct gdsc *sc)
> > >   {
> > >   	u32 mask, val;
> > > @@ -425,6 +478,8 @@ int gdsc_register(struct gdsc_desc *desc,
> > >   	for (i = 0; i < num; i++) {
> > >   		if (!scs[i])
> > >   			continue;
> > > +		if (pm_runtime_enabled(dev))
> > > +			scs[i]->rpm_dev = dev;
> > >   		scs[i]->regmap = regmap;
> > >   		scs[i]->rcdev = rcdev;
> > >   		ret = gdsc_init(scs[i]);
> > > @@ -486,7 +541,10 @@ void gdsc_unregister(struct gdsc_desc *desc)
> > >    */
> > >   int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
> > >   {
> > > +	struct gdsc *sc = domain_to_gdsc(domain);
> > > +
> > >   	/* Do nothing but give genpd the impression that we were successful */
> > > -	return 0;
> > > +	/* Get the runtime PM device only */
> > > +	return gdsc_pm_runtime_get(sc);
> > 
> > Per above, if you let the framework deal with the gdsc's dependencies on
> > the parent domain and you only get()/put() for the sake of dispcc then
> > you don't need you don't need to do this to keep the subsequent
> > gdsc_disable() in balance.
> > 
> > >   }
> > >   EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
> > > diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> > > index 5bb396b344d1..a82982df0a55 100644
> > > --- a/drivers/clk/qcom/gdsc.h
> > > +++ b/drivers/clk/qcom/gdsc.h
> > > @@ -25,6 +25,7 @@ struct reset_controller_dev;
> > >    * @resets: ids of resets associated with this gdsc
> > >    * @reset_count: number of @resets
> > >    * @rcdev: reset controller
> > > + * @rpm_dev: runtime PM device
> > >    */
> > >   struct gdsc {
> > >   	struct generic_pm_domain	pd;
> > > @@ -58,6 +59,7 @@ struct gdsc {
> > >   	const char 			*supply;
> > >   	struct regulator		*rsupply;
> > > +	struct device 			*rpm_dev;
> > 
> > This isn't just the "runtime pm device", it's the device this gdsc is
> > associated with. So "dev" sounds sufficient to me, but that requires
> > that you have a separate bool rpm_enabled to remember if
> > pm_runtime_enabled() was true during probe.
> > 
> > So unless we need "dev" for something else this might be sufficient.
> > 
> > Regards,
> > Bjorn
> > 
> > >   };
> > >   struct gdsc_desc {
> > > -- 
> > > 2.30.2
> > > 
> 
> 
> -- 
> With best wishes
> Dmitry
