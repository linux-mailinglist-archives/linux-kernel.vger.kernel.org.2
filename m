Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F548426CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhJHOVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhJHOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:20:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532FC061570;
        Fri,  8 Oct 2021 07:19:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so11858012otv.4;
        Fri, 08 Oct 2021 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oUfwSCWfmsMljEJ6hcV5o/UMGEJYhMW9kncv2hxpWi0=;
        b=atNXyBXH1+syA5i94D2ML4mi0BzIAN2bxAXFHp6noqyAZNjsxvePwB0APBlnKRQ7M9
         Azr1ZsyxyYjCRy5dkoVuxZnlOcQmkPh9mmLvR+RhHuVhpRXUgiwd/lUsXowf72m7u52r
         mo9Lu9cXS0DAKvW8k+HFwy5eo9hWirhaWjhyYw7JeG19SDtHdcLdQSdLb/v6Od3sQQe3
         OVoIex9YO+96bwpTlhRY0i1jMYRquvT1W4HN7ilxvajGwHmEFZ3TKtcJjI6E3dMHnJI1
         cIaMpFZ0q2FMjPu9TX7hTuLbOMp8Jnw5XbDUwiNUWfDKOYvn84WElzjZmKVDF0aKkQzC
         kyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oUfwSCWfmsMljEJ6hcV5o/UMGEJYhMW9kncv2hxpWi0=;
        b=BTnGrRgKnM9yc3WDP3ie9xqdzEs9iYKAhmFT7vapXsm40kWfPQHZHWKcmD9kO/L/8t
         axyBAyvUARfPke189fPlYYHXX5vtPn1gPd0gczgiBydi6zOCG1+l2WYbZTLuLdOHOQEN
         OWRg/VM/zgwzAfJPkPedvPKv3NKwG4NPVo/S4spj9D4tNymtWYBhOJGQOXbKwIzmnHRr
         +gBGtPS08yK1lyUgWwD2z7xlcKBZtu//nV/J0rD5uBhrvTv13G0oEbt5hq4u/jOVSJNt
         B/15C+0SvQ8C6n9w0tulouZTScSdFD0cZDi/9/bVphCtbwHCdNr7h8TQGm/onpqQ0n+J
         xqsQ==
X-Gm-Message-State: AOAM530AJxdYZxVD6PVoVOLXVLIVGi3/LeNwres63p5YgnD17GwZTn55
        jY3a3fTfBw+vCMPortq69vY=
X-Google-Smtp-Source: ABdhPJyJRoz4Skxqwh5LbG1wHimz2tr9mpUJs6ft9oouNzLATVDm8Wka23rcLqeq6+bGFTyK2QpcNg==
X-Received: by 2002:a05:6830:2a0c:: with SMTP id y12mr3488861otu.377.1633702743527;
        Fri, 08 Oct 2021 07:19:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e29sm553656oow.1.2021.10.08.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:19:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:19:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1] hwmon: (tmp103) Convert tmp103 to use new hwmon
 registration API
Message-ID: <20211008141901.GA2255448@roeck-us.net>
References: <20211007125301.3030-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007125301.3030-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 02:53:01PM +0200, Oleksij Rempel wrote:
> Use devm_hwmon_device_register_with_info() which will make thermal framework
> work.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp103.c | 105 +++++++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
> index a7e202cc8323..5cab4436aa77 100644
> --- a/drivers/hwmon/tmp103.c
> +++ b/drivers/hwmon/tmp103.c
> @@ -51,51 +51,92 @@ static inline u8 tmp103_mc_to_reg(int val)
>  	return DIV_ROUND_CLOSEST(val, 1000);
>  }
>  
> -static ssize_t tmp103_temp_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static int tmp103_read(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long *temp)
>  {
> -	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
>  	struct regmap *regmap = dev_get_drvdata(dev);
>  	unsigned int regval;
> -	int ret;
> +	int err, reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = TMP103_TEMP_REG;
> +		break;
> +	case hwmon_temp_min:
> +		reg = TMP103_TLOW_REG;
> +		break;
> +	case hwmon_temp_max:
> +		reg = TMP103_THIGH_REG;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	ret = regmap_read(regmap, sda->index, &regval);
> -	if (ret < 0)
> -		return ret;
> +	err = regmap_read(regmap, reg, &regval);
> +	if (err < 0)
> +		return err;
> +
> +	*temp = tmp103_reg_to_mc(regval);
>  
> -	return sprintf(buf, "%d\n", tmp103_reg_to_mc(regval));
> +	return 0;
>  }
>  
> -static ssize_t tmp103_temp_store(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> +static int tmp103_write(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long temp)
>  {
> -	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
>  	struct regmap *regmap = dev_get_drvdata(dev);
> -	long val;
> -	int ret;
> -
> -	if (kstrtol(buf, 10, &val) < 0)
> -		return -EINVAL;
> +	int reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_min:
> +		reg = TMP103_TLOW_REG;
> +		break;
> +	case hwmon_temp_max:
> +		reg = TMP103_THIGH_REG;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	val = clamp_val(val, -55000, 127000);
> -	ret = regmap_write(regmap, sda->index, tmp103_mc_to_reg(val));
> -	return ret ? ret : count;
> +	temp = clamp_val(temp, -55000, 127000);
> +	return regmap_write(regmap, reg, tmp103_mc_to_reg(temp));
>  }
>  
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, tmp103_temp, TMP103_TEMP_REG);
> +static umode_t tmp103_is_visible(const void *data, enum hwmon_sensor_types type,
> +				 u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	case hwmon_temp_min:
> +	case hwmon_temp_max:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
>  
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, tmp103_temp, TMP103_TLOW_REG);
> +static const struct hwmon_channel_info *tmp103_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN),
> +	NULL
> +};
>  
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, tmp103_temp, TMP103_THIGH_REG);
> +static const struct hwmon_ops tmp103_hwmon_ops = {
> +	.is_visible = tmp103_is_visible,
> +	.read = tmp103_read,
> +	.write = tmp103_write,
> +};
>  
> -static struct attribute *tmp103_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	NULL
> +static const struct hwmon_chip_info tmp103_chip_info = {
> +	.ops = &tmp103_hwmon_ops,
> +	.info = tmp103_info,
>  };
> -ATTRIBUTE_GROUPS(tmp103);
>  
>  static bool tmp103_regmap_is_volatile(struct device *dev, unsigned int reg)
>  {
> @@ -130,8 +171,10 @@ static int tmp103_probe(struct i2c_client *client)
>  	}
>  
>  	i2c_set_clientdata(client, regmap);
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> -						      regmap, tmp103_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 regmap,
> +							 &tmp103_chip_info,
> +							 NULL);
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
>  
