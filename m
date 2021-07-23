Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68243D3C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhGWOsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhGWOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:48:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5483C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:28:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so2755793wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NQnI/V0ng7WWg3UXb2UO+GXHp5SVJij1U1V8CX0Oqts=;
        b=Qajr49s0JBbDQrOHN0aLJ/YsOXvKSeWWxjYOxdygW7JtbhXK/uJMDaOjUcZHy0un5O
         8ZY2HFw0rBVOR72JLwsE2Xs/6BK2gs+zAOL2UByYz/TLgN7U3rv1un0fjaV3QFhFyKgS
         z1pLrYxhhNqOoVKzR9olcDxy1vS8t81lV4R2JVCWmD+a/leVYamC0UhzpiPJqRiNNo/i
         dwnNLqWUFh8J8sXkBUMXWlzol/RuV4wOLUBezeysoUXqcY19nL0dPlwCpcPecT5AbVS0
         UoUHfDVGM9eWkcUF+ZKRdH6xq4OMA0E5ZCazSPj90juazqIvL2nkmM6AR8V1TLXVnjHu
         SsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NQnI/V0ng7WWg3UXb2UO+GXHp5SVJij1U1V8CX0Oqts=;
        b=lMDs/bZdIWnSMkNkUUBCgs1ve5QTznWuMKqWvgF1o+hqBofLkLbdK9uhxQK1QqY+Sl
         Ymq2NKMs2lmdWQmvlzzEqpmn3hAhWFDWRkaC+tDO501DT6eTNrXhQ/P6Nj6S65C2AjKX
         hUTEYCl9gKwBB8TAbGbt2NlGmZOpKZK91Why3TJBf3MRxluFUVzf6fHrUnZQt6i8c3zV
         1AOioUQk1+W2UWbuiuJXrPLNx6Ey3oW0O6e+5C3sVj/N61PgoYn42/VzsjKLJjSfF7DO
         2lkeNzfRi3tenBtWsyKzTzqLPjLRMyzgsW5t5fXR6l1G0LflDF3Njx9PzE8pgcAGbbO2
         uirg==
X-Gm-Message-State: AOAM530Ruv1lVO/W7uC+JNWTziYrEAxwqctesV7JDJGY+hLPwa8cewWs
        vTs4UY6ootSS2DkEDeoHKNMcrA==
X-Google-Smtp-Source: ABdhPJzNIx/ZDD6YcyxArPOmckElO1BmTrwWgp2ACtgFWS3dlsen0uYprBfMFdmGOuiqOrdfetHNOg==
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr2383544wrs.136.1627054082820;
        Fri, 23 Jul 2021 08:28:02 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id u2sm5865034wmm.37.2021.07.23.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 08:28:01 -0700 (PDT)
Date:   Fri, 23 Jul 2021 16:27:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Message-ID: <YPrf/5g7JAtf1c4u@google.com>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723135239.388325-3-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021, Clément Léger wrote:

> System controllers can be placed under secure monitor control when running
> under them. In order to keep existing code which accesses such system
> controllers using a syscon, add support for "syscon-smc" compatible.
> 
> When enable, the syscon will handle this new compatible and look for an
> "arm,smc-id" property to execute the appropriate SMC. A SMC regmap is then
> created to forward register access to the secure monitor.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/mfd/syscon.c | 170 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 145 insertions(+), 25 deletions(-)

I'm going to let Arnd have at this, but just a couple of points.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 765c0210cb52..eb727b146315 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -40,7 +40,15 @@ static const struct regmap_config syscon_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> -static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> +static void syscon_add(struct syscon *syscon)
> +{
> +	spin_lock(&syscon_list_slock);
> +	list_add_tail(&syscon->list, &syscon_list);
> +	spin_unlock(&syscon_list_slock);
> +}
> +
> +static struct syscon *of_syscon_register_mmio(struct device_node *np,
> +					      bool check_clk)
>  {
>  	struct clk *clk;
>  	struct syscon *syscon;
> @@ -132,10 +140,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon->regmap = regmap;
>  	syscon->np = np;
>  
> -	spin_lock(&syscon_list_slock);
> -	list_add_tail(&syscon->list, &syscon_list);
> -	spin_unlock(&syscon_list_slock);
> -
>  	return syscon;
>  
>  err_attach:
> @@ -150,8 +154,49 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	return ERR_PTR(ret);
>  }
>  
> +#ifdef CONFIG_REGMAP_SMCCC
> +static struct syscon *of_syscon_register_smccc(struct device_node *np)
> +{
> +	struct syscon *syscon;
> +	struct regmap *regmap;
> +	u32 reg_io_width = 4, smc_id;
> +	int ret;
> +	struct regmap_config syscon_config = syscon_regmap_config;
> +
> +	ret = of_property_read_u32(np, "arm,smc-id", &smc_id);

So this is Arm specific.

Not sure we want to be creating bespoke support for specific
architectures/platforms in the generic syscon implementation.

> +	if (ret)
> +		return ERR_PTR(-ENODEV);
> +
> +	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
> +	if (!syscon)
> +		return ERR_PTR(-ENOMEM);
> +
> +	of_property_read_u32(np, "reg-io-width", &reg_io_width);
> +
> +	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@smc%x", np, smc_id);
> +	syscon_config.val_bits = reg_io_width * 8;
> +
> +	regmap = regmap_init_smccc(NULL, smc_id, &syscon_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		goto err_regmap;
> +	}
> +
> +	syscon->regmap = regmap;
> +	syscon->np = np;
> +
> +	return syscon;
> +
> +err_regmap:
> +	kfree(syscon_config.name);
> +	kfree(syscon);
> +
> +	return ERR_PTR(ret);
> +}
> +#endif
> +
>  static struct regmap *device_node_get_regmap(struct device_node *np,
> -					     bool check_clk)
> +					     bool check_clk, bool use_smccc)
>  {
>  	struct syscon *entry, *syscon = NULL;
>  
> @@ -165,8 +210,19 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
>  
>  	spin_unlock(&syscon_list_slock);
>  
> -	if (!syscon)
> -		syscon = of_syscon_register(np, check_clk);
> +	if (!syscon) {
> +		if (use_smccc)
> +#ifdef CONFIG_REGMAP_SMCCC
> +			syscon = of_syscon_register_smccc(np);
> +#else
> +			syscon = NULL;
> +#endif

... and we certainly don't want to be doing so using #ifdefery.

Please find a better way to support this feature.

> +		else
> +			syscon = of_syscon_register_mmio(np, check_clk);
> +
> +		if (!IS_ERR(syscon))
> +			syscon_add(syscon);
> +	}
>  
>  	if (IS_ERR(syscon))
>  		return ERR_CAST(syscon);
> @@ -176,16 +232,19 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
>  
>  struct regmap *device_node_to_regmap(struct device_node *np)
>  {
> -	return device_node_get_regmap(np, false);
> +	return device_node_get_regmap(np, false, false);
>  }
>  EXPORT_SYMBOL_GPL(device_node_to_regmap);
>  
>  struct regmap *syscon_node_to_regmap(struct device_node *np)
>  {
> -	if (!of_device_is_compatible(np, "syscon"))
> -		return ERR_PTR(-EINVAL);
> +	if (of_device_is_compatible(np, "syscon"))
> +		return device_node_get_regmap(np, true, false);
> +
> +	if (of_device_is_compatible(np, "syscon-smc"))
> +		return device_node_get_regmap(np, true, true);
>  
> -	return device_node_get_regmap(np, true);
> +	return ERR_PTR(-EINVAL);
>  }
>  EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
>  
> @@ -273,19 +332,19 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
>  
> -static int syscon_probe(struct platform_device *pdev)
> +struct syscon_driver_data {
> +	int (*probe_func)(struct platform_device *pdev, struct device *dev,
> +			  struct syscon *syscon);
> +};
> +
> +static int syscon_probe_mmio(struct platform_device *pdev,
> +			     struct device *dev,
> +			     struct syscon *syscon)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct syscon_platform_data *pdata = dev_get_platdata(dev);
> -	struct syscon *syscon;
>  	struct regmap_config syscon_config = syscon_regmap_config;
>  	struct resource *res;
>  	void __iomem *base;
>  
> -	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
> -	if (!syscon)
> -		return -ENOMEM;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -ENOENT;
> @@ -295,23 +354,84 @@ static int syscon_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	syscon_config.max_register = resource_size(res) - 4;
> -	if (pdata)
> -		syscon_config.name = pdata->label;
> +
>  	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
>  	if (IS_ERR(syscon->regmap)) {
>  		dev_err(dev, "regmap init failed\n");
>  		return PTR_ERR(syscon->regmap);
>  	}
>  
> -	platform_set_drvdata(pdev, syscon);
> +	dev_dbg(dev, "regmap_mmio %pR registered\n", res);
> +
> +	return 0;
> +}
> +
> +static const struct syscon_driver_data syscon_mmio_data = {
> +	.probe_func = &syscon_probe_mmio,
> +};
> +
> +#ifdef CONFIG_REGMAP_SMCCC
> +
> +static int syscon_probe_smc(struct platform_device *pdev,
> +			    struct device *dev,
> +			    struct syscon *syscon)
> +{
> +	struct regmap_config syscon_config = syscon_regmap_config;
> +	int smc_id, ret;
> +
> +	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &smc_id);
> +	if (!ret)
> +		return -ENODEV;
> +
> +	syscon->regmap = devm_regmap_init_smccc(dev, smc_id, &syscon_config);
> +	if (IS_ERR(syscon->regmap)) {
> +		dev_err(dev, "regmap init failed\n");
> +		return PTR_ERR(syscon->regmap);
> +	}
>  
> -	dev_dbg(dev, "regmap %pR registered\n", res);
> +	dev_dbg(dev, "regmap_smccc %x registered\n", smc_id);
> +
> +	return 0;
> +}
> +
> +static const struct syscon_driver_data syscon_smc_data = {
> +	.probe_func = &syscon_probe_smc,
> +};
> +#endif
> +
> +static int syscon_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct syscon_platform_data *pdata = dev_get_platdata(dev);
> +	struct regmap_config syscon_config = syscon_regmap_config;
> +	struct syscon *syscon;
> +	const struct syscon_driver_data *driver_data;
> +
> +	if (pdata)
> +		syscon_config.name = pdata->label;
> +
> +	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
> +	if (!syscon)
> +		return -ENOMEM;
> +
> +	driver_data = (const struct syscon_driver_data *)
> +				platform_get_device_id(pdev)->driver_data;
> +
> +	ret = driver_data->probe_func(pdev, dev, syscon);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, syscon);
>  
>  	return 0;
>  }
>  
>  static const struct platform_device_id syscon_ids[] = {
> -	{ "syscon", },
> +	{ .name = "syscon",	.driver_data = (kernel_ulong_t)&syscon_mmio_data},
> +#ifdef CONFIG_REGMAP_SMCCC
> +	{ .name = "syscon-smc",	.driver_data = (kernel_ulong_t)&syscon_smc_data},
> +#endif
>  	{ }
>  };
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
