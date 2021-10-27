Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2D43CFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhJ0Rpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ0Rpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:45:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68034C061570;
        Wed, 27 Oct 2021 10:43:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q124so4496263oig.3;
        Wed, 27 Oct 2021 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K4risx0TGhNAaFJcqujWqV/2Qa+DXLeA+SV94Gps/ts=;
        b=Iv0cPaCfuJjiAiItqZkUUWuAXF8WjLaCKWn6pLa2GW+5AkuZWM+GteooPqm3VQU/rR
         Sh5gL94onzjGllHIRcLLJjU/arOMkwxg4OVR2nIr1dO5BxgK2qerVXC0Ri1/LsxCzByC
         y/BpjZNmHMGJd+CEXxI9gwoJqDrgUXkgt2BjJTQnchxCCW8VyaCXHjTM8iH8ipv8L6ji
         g3F9MRejeIRdzY885+5XZdkRLlKKAc1IM5qLZ2DivxHP94XCNjKMU2ubOpMSS4aklOOM
         9yWy32csmy+ZT5wiSLB+XVe01cVved9oWtAL54DPk1iOvyK/ZBtZjyr37x52DxzV4gfd
         rlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K4risx0TGhNAaFJcqujWqV/2Qa+DXLeA+SV94Gps/ts=;
        b=EUsc4jZ0DithVkLkbWvx6quD7mYcKVqGddDR4xwsGHcKtRp4iLZQzxSv7mbKN7zyrr
         EN+h12BwG1YXyV6fJZtMNe5TYosAlJwBXVbgfFytMj872oZlAd1wVolRjVYpkI4DX3TH
         fKkU6aTP7rTzNbxDlvKVtFl1xs67gvS5yNCgkJdEKjmOFFkeTFjqUrFcC7xJZwUvsmuk
         sY90wvEtB6vLYuAZrCTqZGrinNp8Qi/lL5wuuuZXu6MzNpwWjErX9LwCr5+419nY7zRP
         ISlE2QQxOnqtiPDU4aL9ev2Ck4p6MvK3qxYm5kB5DTKFHuebsyvvbepw+uwwwPDctDNp
         95EA==
X-Gm-Message-State: AOAM530yO6lHJg0xRs5lwxLOHdl5Pdtsw4xbm55rnS8OppmMSBqB/9V9
        0mDp0gjufoHYNuaa1J+u80A=
X-Google-Smtp-Source: ABdhPJyOUY6E/8SIMxyJdD4+R6JxuOSVHZJ94lpn6AUS6GjdrkJE70PhLP3eW6hiLliaFfniGlBuRw==
X-Received: by 2002:a05:6808:1315:: with SMTP id y21mr4685880oiv.147.1635356603760;
        Wed, 27 Oct 2021 10:43:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm209361otc.79.2021.10.27.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:43:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Oct 2021 10:43:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
Message-ID: <20211027174322.GA2762049@roeck-us.net>
References: <20211020164213.174597-1-osk@google.com>
 <20211020164213.174597-2-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020164213.174597-2-osk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:42:13PM -0400, Oskar Senft wrote:
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present or
> invalid, the input configuration is not modified and left at
> HW defaults.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
> Changes from PATCH v6 and v7:
> - None (resubmitted due to changes in nuvoton,nct7802.yaml).
> 
> Changes from PATCH v5:
> - Removed unused "found_channel_config" variable.
> - Initialize mode_mask and mode_val to defaults.
> ---
>  drivers/hwmon/nct7802.c | 129 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 125 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..d56f78327619 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>  #define REG_CHIP_ID		0xfe
>  #define REG_VERSION_ID		0xff
>  
> +/*
> + * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
> + * Selection Register
> + */
> +#define RTD_MODE_CURRENT	0x1
> +#define RTD_MODE_THERMISTOR	0x2
> +#define RTD_MODE_VOLTAGE	0x3
> +
> +#define MODE_RTD_MASK		0x3
> +#define MODE_LTD_EN		0x40
> +
> +/*
> + * Bit offset for sensors modes in REG_MODE.
> + * Valid for index 0..2, indicating RTD1..3.
> + */
> +#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
> +
>  /*
>   * Data structures and manipulation thereof
>   */
> @@ -1038,7 +1055,112 @@ static const struct regmap_config nct7802_regmap_config = {
>  	.volatile_reg = nct7802_regmap_is_volatile,
>  };
>  
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static int nct7802_get_channel_config(struct device *dev,
> +				      struct device_node *node, u8 *mode_mask,
> +				      u8 *mode_val)
> +{
> +	u32 reg;
> +	const char *type_str, *md_str;
> +	u8 md;
> +
> +	if (!node->name || of_node_cmp(node->name, "channel"))
> +		return 0;
> +
> +	if (of_property_read_u32(node, "reg", &reg)) {
> +		dev_err(dev, "Could not read reg value for '%s'\n",
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg > 3) {
> +		dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg == 0) {
> +		if (!of_device_is_available(node))
> +			*mode_val &= ~MODE_LTD_EN;
> +		else
> +			*mode_val |= MODE_LTD_EN;
> +		*mode_mask |= MODE_LTD_EN;
> +		return 0;
> +	}
> +
> +	/* At this point we have reg >= 1 && reg <= 3 */
> +
> +	if (!of_device_is_available(node)) {
> +		*mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
> +		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +		return 0;
> +	}
> +
> +	if (of_property_read_string(node, "sensor-type", &type_str)) {
> +		dev_err(dev, "No type for '%s'\n", node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (!strcmp(type_str, "voltage")) {
> +		*mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
> +			     << MODE_BIT_OFFSET_RTD(reg - 1);
> +		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +		return 0;
> +	}
> +
> +	if (strcmp(type_str, "temperature")) {
> +		dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
> +			node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (reg == 3) {
> +		/* RTD3 only supports thermistor mode */
> +		md = RTD_MODE_THERMISTOR;
> +	} else {
> +		if (of_property_read_string(node, "temperature-mode",
> +					    &md_str)) {
> +			dev_err(dev, "No mode for '%s'\n", node->full_name);
> +			return -EINVAL;
> +		}
> +
> +		if (!strcmp(md_str, "thermal-diode"))
> +			md = RTD_MODE_CURRENT;
> +		else if (!strcmp(md_str, "thermistor"))
> +			md = RTD_MODE_THERMISTOR;
> +		else {
> +			dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
> +				node->full_name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
> +	*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +
> +	return 0;
> +}
> +
> +static int nct7802_configure_channels(struct device *dev,
> +				      struct nct7802_data *data)
> +{
> +	/* Enable local temperature sensor by default */
> +	u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
> +	struct device_node *node;
> +	int err;
> +
> +	if (dev->of_node) {
> +		for_each_child_of_node(dev->of_node, node) {
> +			err = nct7802_get_channel_config(dev, node, &mode_mask,
> +							 &mode_val);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
> +}
> +
> +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
>  {
>  	int err;
>  
> @@ -1047,8 +1169,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>  	if (err)
>  		return err;
>  
> -	/* Enable local temperature sensor */
> -	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> +	err = nct7802_configure_channels(dev, data);
>  	if (err)
>  		return err;
>  
> @@ -1074,7 +1195,7 @@ static int nct7802_probe(struct i2c_client *client)
>  	mutex_init(&data->access_lock);
>  	mutex_init(&data->in_alarm_lock);
>  
> -	ret = nct7802_init_chip(data);
> +	ret = nct7802_init_chip(dev, data);
>  	if (ret < 0)
>  		return ret;
>  
