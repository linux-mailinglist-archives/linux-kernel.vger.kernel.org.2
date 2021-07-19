Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE53CD2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhGSKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhGSKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:56:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso10078880wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sRFrEgTSpvjsehmSSp0iaOfleoyyGI+ZTodEHrWcdAg=;
        b=Nsg55FZrvTX8d7FbbwdGa4UGQHil2l3OKZ8jGy3cdTwZG4nE9nK/jiK4vBzOXLKJrp
         uUgLBTdVJvbbdzY7Vc2jjL2Sb9hzo80fW2M2kHUHB777MbXoDGDvSxOEjmbYUDpRYQD+
         tz4nK/IpUi0XBOQB8t5GKIWGfopuUpTWwsVCwE6a9QYQ1W/bTghpSie+E7FviNQG/9Mw
         kRL9K5T6SMxCa/dycVHsCN4UAIJ4WgVvHSDRKI4GwqdjMzTvl6xcIpN5U3etwgmQeA+P
         D90u+bHc1z10QRv6Mvhh6GHNGCzX+Tou1N2YTpR3HsrXyRni5ksbeko3p1nF3klBB9ee
         VyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sRFrEgTSpvjsehmSSp0iaOfleoyyGI+ZTodEHrWcdAg=;
        b=ngzpIe2NjTpsNLeDmY3fJFdHW4INTVaSVqcrudcKHTVCXYhGZp88rVw4MPtWYQV5t8
         T03H+4dvCfrEtJ27wmrfUAQE5LAIKuq0BUCmyEYGztv/7p0sIVgNY/JEoLVfRE94LU1B
         ClUrforbUPXzgvTqKlBm+JOj8qAcRUCbc2C6Lu+4+6QKfN1uKwZ5CVc4LlhPxbZ2QMlp
         a4BQR1SlfztgV1QzDGQ4aNGVxwcTvtkiZqJUZAGbxS/wy21gn6dSJ1K0UGNSj56QkGwX
         e5BcYeApkrtdin5RyGILDxF0wPF4Y0T/4YfK0itild2mGLlaAswGWqGPMmj4799Ehmd+
         lWJQ==
X-Gm-Message-State: AOAM531172wjT3spvw0KRjOOwfBXrM3ZPaLlMxei9houhoYdvAwI84lv
        oTbFhvQqdgrCF20PIWNsUScZrQ==
X-Google-Smtp-Source: ABdhPJziHWgomVGdrLrxjjLGVXSJmLd0WgcCHWfffg0QRvIYkNFBWNmJ6qijFCC+ppvm+qcHMNaLTg==
X-Received: by 2002:a05:600c:4a17:: with SMTP id c23mr31653739wmp.50.1626691702058;
        Mon, 19 Jul 2021 03:48:22 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id 19sm13549854wmj.2.2021.07.19.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 03:48:21 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:48:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, C++ / GCC <cpp@gcc.lt>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Add supplied-from property to
 axp288_fuel_gauge cell
Message-ID: <YPVYc/mFKX14s1Yr@google.com>
References: <20210717162528.272797-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210717162528.272797-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021, Hans de Goede wrote:

> The power-supply framework has the notion of one power-supply device
> being supplied by another. A typical example of this is a charger
> charging a battery.
> 
> A tablet getting plugged in to charge (or plugged out) only results in
> events seen by the axp288_charger device / MFD cell. Which means that
> a change udev-event only gets send for the charger power-supply class
> device, not for the battery (the axp288_fuel_gauge device).
> 
> The axp288_fuel_gauge does have an external_power_change'd callback
> which will generate a change udev-event when called. But before this
> commit this never got called because the power-supply core only calls
> this when a power-supply class device's supplier changes and the
> supplier link from axp288_charger to axp288_fuel_gauge was missing.
> 
> Add a "supplied-from" property to axp288_fuel_gauge cell, pointing
> to the "axp288_charger" power-supply class device, so that the
> axp288_fuel_gauge's external_power_change'd callback gets called on
> axp288_charger state changes.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index d0ac019850d1..8161a5dc68e8 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -700,6 +700,18 @@ static const struct resource axp288_charger_resources[] = {
>  	DEFINE_RES_IRQ(AXP288_IRQ_CBTO),
>  };
>  
> +static const char * const axp288_fuel_gauge_suppliers[] = { "axp288_charger" };
> +
> +static const struct property_entry axp288_fuel_gauge_properties[] = {
> +	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", axp288_fuel_gauge_suppliers),
> +	{ }
> +};
> +
> +static const struct software_node axp288_fuel_gauge_sw_node = {
> +	.name = "axp288_fuel_gauge",
> +	.properties = axp288_fuel_gauge_properties,
> +};
> +
>  static const struct mfd_cell axp288_cells[] = {
>  	{
>  		.name		= "axp288_adc",
> @@ -717,6 +729,7 @@ static const struct mfd_cell axp288_cells[] = {
>  		.name		= "axp288_fuel_gauge",
>  		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
>  		.resources	= axp288_fuel_gauge_resources,
> +		.swnode		= &axp288_fuel_gauge_sw_node,
>  	}, {
>  		.name		= "axp221-pek",
>  		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),

That's a lot of code to pass a string.

Is this really the most efficient method?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
