Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8A3CFD44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhGTOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbhGTOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:24:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E1BC0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:02:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so1692026wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gVmaCt5/XbrZO/QfODNESpk+UsX8YFkJnEb84924lkg=;
        b=I4nSicJtKaoaaiPT1FLXnOCg9BUDBBpHQKjhbTlCq5TblXDiPIl0VjL9RLrYxHcVwG
         0IAVM9gdEKAvlZR5pkTzKasJC3MM28VxWneaoqr9iZcjhthdqBXUnDKnZa4xMhN0p28M
         SkksAZnIgF0lk9f+y/PG1Ve60C0x/pQOYzusERALXFFrUvN5QHa3k0Kx4zIDG5/gBloe
         ZGogolZtKt+/q0G5/tZ7/0i1E5AEwrMlPcCpDUnwikql1pLsUCNnWoNhFhz8HzNhe4yh
         jD80wYlZttYpysCG5UWNbm8X0rkrGgZQJT+rGIHHMn/08yq/PXO0cVFc1ZPTYcH6Syyf
         sHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gVmaCt5/XbrZO/QfODNESpk+UsX8YFkJnEb84924lkg=;
        b=exjahtCswYxOK75WpxO3CiQFMMaDnQKjzLJdu2hAObkaKIfdwigfHGSMpCSIBsMVd9
         HtENNfPa+8jpj04WUCwLDOKRLF9kGTpZg8OVf78jY1xG24Q6vER4p4g0l+225apzpn6w
         7AfuESspp6GcjVxrSVrEOHjDrcn4dDUtigkZLxLenHzUxang3IBRU6pMxvKPnL57OKj8
         K5F+b9CdKyxcaJJa1N2o1rmLhR8l631AeMlRD15F+yx896PGmopgqTWiYC9gqyvqIOlY
         vdW2iNkANjXbDLmtdNzKYSzrwnwikpDZJ1gUBJCM1np4cNTjfRbtJiG4gtsjMuqPSHTj
         GlgQ==
X-Gm-Message-State: AOAM530C9P8dS6rvoBEmqMoSfAe9CRa1zcYjL58x0vFGvQY0h3UBnaig
        OBl5gIyOmRVnXITq9IrCrWdFPqsVjA+RHg==
X-Google-Smtp-Source: ABdhPJxEtv60iiBR7xE5LcVjTXGD4B289FnwDkjnK4ukW5CgdvPOubv8wIaixzyVt192iWPHQMBrIA==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr38881932wmm.7.1626793347746;
        Tue, 20 Jul 2021 08:02:27 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id l39sm2121998wms.1.2021.07.20.08.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:02:27 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:02:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
Subject: Re: [PATCH v7 2/6] thermal: sy7636a: Add thermal driver for sy7636a
Message-ID: <YPblgabAObekmVZs@google.com>
References: <20210708115804.212-1-alistair@alistair23.me>
 <20210708115804.212-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708115804.212-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021, Alistair Francis wrote:

> From: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
> 
> Add thermal driver to enable kernel based polling
> and shutdown of device for temperatures out of spec
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/thermal/Kconfig           |   7 ++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/sy7636a_thermal.c | 107 ++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/thermal/sy7636a_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..7112c63d9021 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -450,6 +450,13 @@ depends on (ARCH_STI || ARCH_STM32) && OF
>  source "drivers/thermal/st/Kconfig"
>  endmenu
>  
> +config SY7636A_THERMAL
> +	tristate "SY7636A thermal management"
> +	depends on MFD_SY7636A
> +	help
> +	  Enable the sy7636a thermal driver, which supports the
> +	  temperature sensor embedded in Silabs SY7636A chip.
> +
>  source "drivers/thermal/tegra/Kconfig"
>  
>  config GENERIC_ADC_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..2e1aca8a0a09 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>  obj-y				+= intel/
>  obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>  obj-y				+= st/
> +obj-$(CONFIG_SY7636A_THERMAL)	+= sy7636a_thermal.o
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
> new file mode 100644
> index 000000000000..705a16fb1045
> --- /dev/null
> +++ b/drivers/thermal/sy7636a_thermal.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Functions to access SY3686A power management chip temperature
> +//
> +// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> +//
> +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> +//          Alistair Francis <alistair@alistair23.me>
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +struct sy7636a_data {
> +	struct sy7636a *sy7636a;
> +	struct thermal_zone_device *thermal_zone_dev;
> +};
> +
> +static int sy7636a_get_temp(void *arg, int *res)
> +{
> +	unsigned int reg_val, mode_ctr;
> +	int ret;
> +	struct sy7636a_data *data = arg;
> +	bool isVoltageActive;
> +
> +	ret = regmap_read(data->sy7636a->regmap,
> +			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
> +	if (ret)
> +		return ret;
> +
> +	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
> +
> +	if (!isVoltageActive) {
> +		ret = regmap_write(data->sy7636a->regmap,
> +				SY7636A_REG_OPERATION_MODE_CRL,
> +				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->sy7636a->regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (!isVoltageActive) {
> +		ret = regmap_write(data->sy7636a->regmap,
> +				SY7636A_REG_OPERATION_MODE_CRL,
> +				mode_ctr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*res = *((signed char*)&reg_val);
> +	*res *= 1000;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops ops = {
> +	.get_temp	= sy7636a_get_temp,
> +};
> +
> +static int sy7636a_thermal_probe(struct platform_device *pdev)
> +{
> +	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
> +	struct sy7636a_data *data;
> +
> +	if (!sy7636a)
> +		return -EPROBE_DEFER;

How is this possible?

> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);

sizeof(*data)

> +	if (!data)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->sy7636a = sy7636a;
> +	data->thermal_zone_dev = devm_thermal_zone_of_sensor_register(
> +			pdev->dev.parent,
> +			0,
> +			data,

Why don't you just pass in your initial ddata?

> +			&ops);
> +
> +	return PTR_ERR_OR_ZERO(data->thermal_zone_dev);
> +}
> +
> +static const struct platform_device_id sy7636a_thermal_id_table[] = {
> +	{ "sy7636a-thermal", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, sy7636a_thermal_id_table);
> +
> +static struct platform_driver sy7636a_thermal_driver = {
> +	.driver = {
> +		.name = "sy7636a-thermal",
> +	},
> +	.probe = sy7636a_thermal_probe,
> +	.id_table = sy7636a_thermal_id_table,
> +};
> +module_platform_driver(sy7636a_thermal_driver);
> +
> +MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
> +MODULE_DESCRIPTION("SY7636A thermal driver");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
