Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC6F30D0D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBCBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhBCBbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:31:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:30:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k142so10606639oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N4ycux3ItpzlVV20JZk2WwYJccOUczhtx2vBl6ttTL8=;
        b=frmXj98jjk9vfiPSFLNcIOFv4UNRvrBUzc8WH5G9BhhgXNnQK/He6ZqGQeK2EydGz7
         rcDf6vKhOMr3oTu9iaku/bxhp/7TuqEj20KnEktiRKlidywa6mbfA+3rVE5chzaGC4AU
         3wDiUNQ+TrF7s5p2iGgQaIsPVMp5efTGc0knXhVxer1bO86GEFweX6YUAmPIGWNZlYwM
         xJ7o2x6GBANdn2LhZhW8WoAqWgntqhQNIPMiAREil633TvUGiGrHx6wUca1JGJomM0Ey
         vel/iqNV9udJJyWJ5iPhj0fsPPxk7ollXYJi/9kAKVGB42qPgM9aasoVHVs15r7VQ+MX
         KJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N4ycux3ItpzlVV20JZk2WwYJccOUczhtx2vBl6ttTL8=;
        b=sUt8LlboYLUaYL977tiMsshrrOZ4GCoSCMleNBoJs12SkIWEhyY1IBoq8MLsK6mPmF
         PivhTLe6Y/1SQ6E+TS/nJDwhE2GxmGJd8Oc1JVOUFYFOmFj2Y9Oeey6WTONcsYZSV4v7
         K52gbvWt7zodQyVs8TB4Yr3ewyfXVmQRIXbTdyjJefnH5pR2V7p1rmJPmL6qjJngaqji
         0/ekXbp4poa56WLKVssXD6Zsbel5brWmZjUVCnK1Cy29mrBIAoc9XtIHr+koMStbgmNa
         AfMYGu3PDxeW/dHV0LBui1addZtataahO69DKGlshBgzx2WJkKqpceM6+2gO2KQR8kCc
         WA4Q==
X-Gm-Message-State: AOAM532eMY3BMVogJ2qIWfVV5d40BnzdoABygTYM0flfPpT8kCAUJiiX
        8x/sth7DcYUrXnrJtvA5lyv2xdJot+k=
X-Google-Smtp-Source: ABdhPJwnBRgunruCbVB1HPiqkSoJHjLDzj/9EI8uWDyGEJNmcdVQ7gTXGrBLkMGN70MQeF9HNJmnzQ==
X-Received: by 2002:aca:b78a:: with SMTP id h132mr502807oif.44.1612315852355;
        Tue, 02 Feb 2021 17:30:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm164085oib.52.2021.02.02.17.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 17:30:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 25/37] hwmon: (scmi) port driver to the new
 scmi_sensor_proto_ops interface
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, Jean Delvare <jdelvare@suse.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-26-cristian.marussi@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4f4d20b0-8de9-f1b6-c89d-659484b3cf0c@roeck-us.net>
Date:   Tue, 2 Feb 2021 17:30:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202221555.41167-26-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 2:15 PM, Cristian Marussi wrote:
> Port driver to the new SCMI Sensor interface based on protocol handles
> and common devm_get_ops().
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Assuming this will be handled with the series.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v4 --> v5
> - using renamed devm_get/put_protocol
> ---
>  drivers/hwmon/scmi-hwmon.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 17d064e58938..c5a260c6e3c6 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface(SCMI) based hwmon sensor driver
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.
>   * Sudeep Holla <sudeep.holla@arm.com>
>   */
>  
> @@ -13,8 +13,10 @@
>  #include <linux/sysfs.h>
>  #include <linux/thermal.h>
>  
> +static const struct scmi_sensor_proto_ops *sensor_ops;
> +
>  struct scmi_sensors {
> -	const struct scmi_handle *handle;
> +	const struct scmi_protocol_handle *ph;
>  	const struct scmi_sensor_info **info[hwmon_max];
>  };
>  
> @@ -69,10 +71,9 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  	u64 value;
>  	const struct scmi_sensor_info *sensor;
>  	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
> -	const struct scmi_handle *h = scmi_sensors->handle;
>  
>  	sensor = *(scmi_sensors->info[type] + channel);
> -	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
> +	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
>  	if (ret)
>  		return ret;
>  
> @@ -169,11 +170,16 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  	struct hwmon_channel_info *scmi_hwmon_chan;
>  	const struct hwmon_channel_info **ptr_scmi_ci;
>  	const struct scmi_handle *handle = sdev->handle;
> +	struct scmi_protocol_handle *ph;
>  
> -	if (!handle || !handle->sensor_ops)
> +	if (!handle)
>  		return -ENODEV;
>  
> -	nr_sensors = handle->sensor_ops->count_get(handle);
> +	sensor_ops = handle->devm_get_protocol(sdev, SCMI_PROTOCOL_SENSOR, &ph);
> +	if (IS_ERR(sensor_ops))
> +		return PTR_ERR(sensor_ops);
> +
> +	nr_sensors = sensor_ops->count_get(ph);
>  	if (!nr_sensors)
>  		return -EIO;
>  
> @@ -181,10 +187,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  	if (!scmi_sensors)
>  		return -ENOMEM;
>  
> -	scmi_sensors->handle = handle;
> +	scmi_sensors->ph = ph;
>  
>  	for (i = 0; i < nr_sensors; i++) {
> -		sensor = handle->sensor_ops->info_get(handle, i);
> +		sensor = sensor_ops->info_get(ph, i);
>  		if (!sensor)
>  			return -EINVAL;
>  
> @@ -236,7 +242,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  	}
>  
>  	for (i = nr_sensors - 1; i >= 0 ; i--) {
> -		sensor = handle->sensor_ops->info_get(handle, i);
> +		sensor = sensor_ops->info_get(ph, i);
>  		if (!sensor)
>  			continue;
>  
> 

