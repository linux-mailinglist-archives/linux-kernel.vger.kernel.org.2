Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA239173F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhEZMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:21:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60932 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhEZMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:21:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 590581F42D14
Subject: Re: [PATCH] mfd: cros_ec_dev: Load lightbar module only present
To:     Gwendal Grignou <gwendal@chromium.org>, lee.jones@linaro.org,
        bleung@chromium.org, groeck@chromium.org, swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20210526034500.954219-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0d113ad0-2f99-8f07-8e8a-86453a285fc8@collabora.com>
Date:   Wed, 26 May 2021 14:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526034500.954219-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 26/5/21 5:45, Gwendal Grignou wrote:
> The pixel lightbar is only present on chromebook pixel (link), pixel 2
> and pixel C. For the latter two, the EC reports its presence.
> Instead of always loading the lightbar driver on all chromebook, only
> load it when reported by the EC or Link device.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/mfd/cros_ec_dev.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d07b43d7c761a..a9700436e5e51 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
>  
> +#include <linux/dmi.h>
>  #include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
> @@ -112,10 +113,13 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  static const struct mfd_cell cros_ec_platform_cells[] = {
>  	{ .name = "cros-ec-chardev", },
>  	{ .name = "cros-ec-debugfs", },
> -	{ .name = "cros-ec-lightbar", },
>  	{ .name = "cros-ec-sysfs", },
>  };
>  
> +static const struct mfd_cell cros_ec_lightbar_cells[] = {
> +	{ .name = "cros-ec-lightbar", }
> +};
> +
>  static const struct mfd_cell cros_ec_vbc_cells[] = {
>  	{ .name = "cros-ec-vbc", }
>  };
> @@ -206,6 +210,20 @@ static int ec_device_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * Lightbar is a special case. Newer devices support autodetection,
> +	 * but older ones do not.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
> +	    dmi_match(DMI_PRODUCT_NAME, "Link")) {
> +		retval = mfd_add_hotplug_devices(ec->dev,
> +					cros_ec_lightbar_cells,
> +					ARRAY_SIZE(cros_ec_lightbar_cells));
> +		if (retval)
> +			dev_warn(ec->dev, "failed to add lightbar: %d\n",
> +				 retval);
> +	}
> +
>  	/*
>  	 * The PD notifier driver cell is separate since it only needs to be
>  	 * explicitly added on platforms that don't have the PD notifier ACPI
> 
