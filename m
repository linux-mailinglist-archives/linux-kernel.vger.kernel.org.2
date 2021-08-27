Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC63FA12B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhH0Vaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhH0Vae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:30:34 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54273C0613D9;
        Fri, 27 Aug 2021 14:29:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so9641281otf.6;
        Fri, 27 Aug 2021 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9loi6rYVBIbSW3ILes00XaIut5iSfuAjQvw0o+MDE4=;
        b=VaOvyNrEz5HT7JnJX3aSqRR/KYkk7v3nZ2KqaRn+Rk6gA4e6gSE5Qf5wqsYDPJCWpa
         sK/Ab/E+eKVowMVPfjJ7gftA5xDhcKmZOHwOHhn5frHJ5Gikbmj4NIVtiIhkE08eLR3G
         KlWuv8HHXSKsJPhpvDEqZxgDAFnHlw6XkFI6/q9ujSKLw2+tLZ0mn+0Lm3ahKS3AaTk+
         VndMVQQxjC+ZdzBFobMEl6t3vEyx/kDreHjd46pACbiX4v4r44JU+9zLsXLPMrs7xz1p
         46Q2MBWYcPPaMXy4GyzBOfsWczNu9F8TSJSb4uMZkvueT9rwYzKamoXRlA2f40jI4y89
         io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=N9loi6rYVBIbSW3ILes00XaIut5iSfuAjQvw0o+MDE4=;
        b=FQGzmoxWElkbNvz+Cr7TGZWSKcPDdHxQ4z06ccFkJ0X6Px3olxW3YYVsWHq/Q8DnhZ
         wOZEXkwc/z/sMbTpBKbVpAWjOgX7qqku8cHWzVdHXjE8vD5NJodfBbfY7CYIBJxKqEVc
         BvpII48aI4WsKZx28Kkocgl7tY4BcLb2mp2/yF+v36WaTdwpYqce20pYT2wRdQQ7Bogx
         emoHSMFITdBu/hNuRc2pNEUqtseIUFl7PRnh4nVcazSb4f2R7X+u10At3fRtt6s/ljZY
         BEK/xm/9OzoDLMfnPrwZQaYas6GnConjTQBmoM3Vn3fseJ6/X0w2jenFNHmwIEbDrHsk
         JoHw==
X-Gm-Message-State: AOAM531eNB49wmS4oXHUZa5RWzTlRQ4WN4OF6cA7oDcOrddbDq61Zj8y
        dYyk1aQjc2QQYdIAIv45oBBw6svKSRo=
X-Google-Smtp-Source: ABdhPJyktt1TjmNFsAckWfLrCWO/RlRm06k4KtQ7zYsKJwZoMT6DBGiChLUWL7hLbgWHDJKd/ENxQg==
X-Received: by 2002:a05:6830:13c4:: with SMTP id e4mr9713858otq.58.1630099784743;
        Fri, 27 Aug 2021 14:29:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u27sm1514572otj.6.2021.08.27.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:29:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 14:29:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
Message-ID: <20210827212942.GA716764@roeck-us.net>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:41:21PM +1200, Chris Packham wrote:
> Instead of the non-standard auto_update_interval make use of the
> update_interval property that is supported by the hwmon core.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     I kind of anticipate a NAK on this because it affects the ABI. But I figured
>     I'd run it past the ML to see if moving towards the hwmon core is worth the hit
>     in ABI compatibility.
>     
I personally don't mind (most likely no one is using it anyway), but let's
wait until after the upcoming commit window closes to give people time to
complain.

Guenter

>     Changes in v2:
>     - none
> 
>  drivers/hwmon/adt7470.c | 64 +++++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index db19a52b13de..7afbd1e4721e 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -469,35 +469,37 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>  	return err < 0 ? ERR_PTR(err) : data;
>  }
>  
> -static ssize_t auto_update_interval_show(struct device *dev,
> -					 struct device_attribute *devattr,
> -					 char *buf)
> -{
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	return sprintf(buf, "%d\n", data->auto_update_interval);
> -}
> -
> -static ssize_t auto_update_interval_store(struct device *dev,
> -					  struct device_attribute *devattr,
> -					  const char *buf, size_t count)
> +static int adt7470_chip_read(struct device *dev, u32 attr, long *val)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	long temp;
>  
> -	if (kstrtol(buf, 10, &temp))
> -		return -EINVAL;
> +	switch (attr) {
> +	case hwmon_chip_update_interval:
> +		*val = data->auto_update_interval;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	temp = clamp_val(temp, 0, 60000);
> +	return 0;
> +}
>  
> -	mutex_lock(&data->lock);
> -	data->auto_update_interval = temp;
> -	mutex_unlock(&data->lock);
> +static int adt7470_chip_write(struct device *dev, u32 attr, long val)
> +{
> +	struct adt7470_data *data = dev_get_drvdata(dev);
>  
> -	return count;
> +	switch (attr) {
> +	case hwmon_chip_update_interval:
> +		val = clamp_val(val, 0, 60000);
> +		mutex_lock(&data->lock);
> +		data->auto_update_interval = val;
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
>  }
>  
>  static ssize_t num_temp_sensors_show(struct device *dev,
> @@ -1034,7 +1036,6 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(alarm_mask);
>  static DEVICE_ATTR_RW(num_temp_sensors);
> -static DEVICE_ATTR_RW(auto_update_interval);
>  
>  static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
>  
> @@ -1066,7 +1067,6 @@ static SENSOR_DEVICE_ATTR_RW(pwm4_auto_channels_temp, pwm_auto_temp, 3);
>  static struct attribute *adt7470_attrs[] = {
>  	&dev_attr_alarm_mask.attr,
>  	&dev_attr_num_temp_sensors.attr,
> -	&dev_attr_auto_update_interval.attr,
>  	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
> @@ -1097,6 +1097,8 @@ static int adt7470_read(struct device *dev, enum hwmon_sensor_types type, u32 at
>  			int channel, long *val)
>  {
>  	switch (type) {
> +	case hwmon_chip:
> +		return adt7470_chip_read(dev, attr, val);
>  	case hwmon_temp:
>  		return adt7470_temp_read(dev, attr, channel, val);
>  	case hwmon_fan:
> @@ -1112,6 +1114,8 @@ static int adt7470_write(struct device *dev, enum hwmon_sensor_types type, u32 a
>  			int channel, long val)
>  {
>  	switch (type) {
> +	case hwmon_chip:
> +		return adt7470_chip_write(dev, attr, val);
>  	case hwmon_temp:
>  		return adt7470_temp_write(dev, attr, channel, val);
>  	case hwmon_fan:
> @@ -1129,6 +1133,15 @@ static umode_t adt7470_is_visible(const void *_data, enum hwmon_sensor_types typ
>  	umode_t mode = 0;
>  
>  	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			mode = 0644;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>  	case hwmon_temp:
>  		switch (attr) {
>  		case hwmon_temp:
> @@ -1187,6 +1200,7 @@ static const struct hwmon_ops adt7470_hwmon_ops = {
>  };
>  
>  static const struct hwmon_channel_info *adt7470_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
>  	HWMON_CHANNEL_INFO(temp,
>  			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
>  			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
