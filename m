Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7633E0EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhHEHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:06:16 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36835 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbhHEHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:06:14 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CA50322172;
        Thu,  5 Aug 2021 09:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1628147159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfQSVvWEeLKNuNRTmCn6mP6inKmDFWltFob+I30CFbY=;
        b=OdkuJrsIhU8SWcPPoCOXYgjoK2Y3HQlxZHcj45D/LEJJMROlZ4B+2OMNsss6evq74+2LSi
        siz/D258+aVAlm9dFyA6P4ygGf8p2z7ZJsKgRGIGGCEYg1gDokx6HoFbYGsG+QEGMQdTlY
        4t/l8KRcWcJsSazQmTyMS1AgTQGe/Ik=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Aug 2021 09:05:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
In-Reply-To: <20210804143744.689238-1-lee.jones@linaro.org>
References: <20210804143744.689238-1-lee.jones@linaro.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <328e69d4d6d57b101af1ab1346b0809f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Am 2021-08-04 16:37, schrieb Lee Jones:
> More devices are cropping up requiring only Regmap initialisation and
> child registration functionality.  We currently only support that if
> all required devices are represented by their own Device Tree nodes
> complete with compatible strings.
> 
> However, not everyone is happy with adding empty nodes that provide no
> additional device information into the Device Tree.
> 
> Rather than have a plethora of mostly empty, function-less drivers in
> MFD, we'll support those simple cases in here instead via MFD cells.
> 
> Cc: Michael Walle <michael@walle.cc>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Michael, could you please test this on your platform to ensure I
>          didn't break anything please?
> 

I'm getting a null pointer dereference.

[..]

>  static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  {
> -	const struct regmap_config *config;
> +	const struct simple_mfd_data *simple_mfd_data;
> +	const struct regmap_config *regmap_config;
>  	struct regmap *regmap;
> +	int ret;
> +
> +	simple_mfd_data = device_get_match_data(&i2c->dev);
> 
> -	config = device_get_match_data(&i2c->dev);
> -	if (!config)
> -		config = &simple_regmap_config;
> +	if (simple_mfd_data->regmap_config)

simple_mfd_data might be NULL.

> +		regmap_config = simple_mfd_data->regmap_config;
> +	else
> +		regmap_config = &regmap_config_8r_8v;
> 
> -	regmap = devm_regmap_init_i2c(i2c, config);
> +	regmap = devm_regmap_init_i2c(i2c, regmap_config);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
> 
> -	return devm_of_platform_populate(&i2c->dev);
> +	if (!simple_mfd_data->mfd_cell)

likewise

> +		return devm_of_platform_populate(&i2c->dev);
> +
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   simple_mfd_data->mfd_cell,
> +				   simple_mfd_data->mfd_cell_size,
> +				   NULL, 0, NULL);
> +	if (!ret)
> +		dev_err(&i2c->dev, "Failed to add child devices\n");
> +
> +	return ret;
>  }

-michael
