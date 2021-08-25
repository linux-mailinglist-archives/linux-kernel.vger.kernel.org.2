Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87163F7A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhHYQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbhHYQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:29:22 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE4C061757;
        Wed, 25 Aug 2021 09:28:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h133so130326oib.7;
        Wed, 25 Aug 2021 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1JCq67PSTupD9FJmm4tagl3GmWyD/tRwIodW+Ti1uM=;
        b=WRNTFyNb8xWMOG/yX8vD+wt9Rc/czhByp3lqiYy3P51tN1EwFDpIoHJcFMEE6Lvf8J
         G7gZpSSg4f99MynHX03BxQMlDEzhxYiTdf9df+iey6SgshbFtIi0VZ/qUTLMzJyJn2rD
         AD1wQ3wJH3ONPab4da8Gee5dmRAaw44UZAoLATfgEU3SmqnFzXqNv3hoLS9MT+0ZFiYb
         gKIRbl0tO9wORBVUsjCWVbAJ06Ll+eWmUjQYkNusC+FMdVZS33ydRd4oxUP387nyRZcc
         QlzHrxpL7CqK61fTcJTdTMX4TORzbT+TepmqFb7vufOCjzt8xCxHfdJNvzbT896XyOZg
         8ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=F1JCq67PSTupD9FJmm4tagl3GmWyD/tRwIodW+Ti1uM=;
        b=lCysJAzZ5gx1JDby27yzBk5gCZMWVZR8s9M/mK83fSd6WIOOmamYHsvAY3a/ZCIQPF
         MUFwT1z+wHWdzJhEtf7R7rVt11G4MF98AAIojORQaiSYVPtUYZYER/AtunA1K6rCPjTy
         WfytS5FrP1MjM37iVNbmmyGjYehlzKVBZ1dZvmKq0lE9BqqILYRA6frnC5Xld5joZRSc
         UpPTWWovncnzgNOP8NX3KduhuYR+X+MJWBifBF4HWu6Hp21Bx5GAChlrv3mOVjQsK8RC
         IiPBAsDBUz6CSeg6npONzS7bvk6IfaA6+zC6kzrsk8ZZ8jnk5DD5OO4qhpZ+a7TseJqM
         1Fng==
X-Gm-Message-State: AOAM532cZRC8C9QHm35V3bcoxZkY0FRJ35V2As1gjRmy+u2pUrc6/Krh
        Dk62QAOPh5ldsZ2YWJuEukc=
X-Google-Smtp-Source: ABdhPJzTVIyhF+rfMioBRL5YYDUBO6jYxLSUMmQnl1VrCv6dUxPOEIITVQlxke0wSndrdhU1eI/UKg==
X-Received: by 2002:aca:42c5:: with SMTP id p188mr5869416oia.158.1629908916329;
        Wed, 25 Aug 2021 09:28:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u194sm61651oie.37.2021.08.25.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:28:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Aug 2021 09:28:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: adt7410: fix hwmon sysfs attrs not being
 created
Message-ID: <20210825162833.GA1174392@roeck-us.net>
References: <20210824210458.GA3418169@roeck-us.net>
 <20210825074228.199070-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825074228.199070-1-demonsingur@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:42:27AM +0300, Cosmin Tanislav wrote:
> sysfs attrs for adt7410 are supposed to be created under
> the hwmon device, but are being created under the i2c
> device.

This is not correct. hwmon sysfs attributes may exist in either location,
and the lm-sensors userspace library handles both just fine.

> Switch to hwmon_device_register_with_groups to create
> the relevant attrs in the correct directory, and
> to also fix the deprecation warning created by
> hwmon_device_register.
> 

There is no "correct" directory. The reason for introducing the
new API was to simplify attribute creation and to avoid potential
race conditions by attaching the attributes to the hwmon device,
and by attaching them during device creation and not independently.
The new APIs also ensure that the "name' attribute exists,
which was not previously the case.

The scope of this patch should simply be the conversion
to a non-deprecated API.

On a side note, conversion to use the with_info API would
reduce driver size significantly and be even more valuable.

> To achieve this, the following changes are also made.
> 
>  * pass client name from adt7410 driver to common
>    driver and use it to register hwmon device
>  * remove attribute_group declaration and use the
>    ATTRIBUTE_GROUPS macro to align with other
>    usages of hwmon_device_register_with_groups
>  * remove name attribute since it is not needed anymore
>    after moving away from hwmon_device_register
>  * store bus device into private data and use it to call
>    the i2c/spi ops both in hwmon sysfs attr contexts and
>    outside of them

This is just mechanics and really not relevant for the
patch description.

> 
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---

FWIW:

<Formletter>  
Change log goes here. If it is missing, I won't know what changed.
That means I will have to dig out older patch versions to compare.
That costs time and would hold up both this patch as well as all other
patches which I still have to review.

For this reason, I will not review patches without change log.
</Formletter>

Thanks,
Guenter

>  drivers/hwmon/adt7410.c |  2 +-
>  drivers/hwmon/adt7x10.c | 56 ++++++++---------------------------------
>  2 files changed, 12 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 80f8a4673315..a5901ecbb347 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -46,7 +46,7 @@ static int adt7410_i2c_probe(struct i2c_client *client,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
> -	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
> +	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
>  }
>  
>  static int adt7410_i2c_remove(struct i2c_client *client)
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index 3f03b4cf5858..5093911472e8 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -54,8 +54,8 @@
>  /* Each client has this additional data */
>  struct adt7x10_data {
>  	const struct adt7x10_ops *ops;
> -	const char		*name;
>  	struct device		*hwmon_dev;
> +	struct device		*bus_dev;
>  	struct mutex		update_lock;
>  	u8			config;
>  	u8			oldconfig;
> @@ -72,25 +72,25 @@ struct adt7x10_data {
>  static int adt7x10_read_byte(struct device *dev, u8 reg)
>  {
>  	struct adt7x10_data *d = dev_get_drvdata(dev);
> -	return d->ops->read_byte(dev, reg);
> +	return d->ops->read_byte(d->bus_dev, reg);
>  }
>  
>  static int adt7x10_write_byte(struct device *dev, u8 reg, u8 data)
>  {
>  	struct adt7x10_data *d = dev_get_drvdata(dev);
> -	return d->ops->write_byte(dev, reg, data);
> +	return d->ops->write_byte(d->bus_dev, reg, data);
>  }
>  
>  static int adt7x10_read_word(struct device *dev, u8 reg)
>  {
>  	struct adt7x10_data *d = dev_get_drvdata(dev);
> -	return d->ops->read_word(dev, reg);
> +	return d->ops->read_word(d->bus_dev, reg);
>  }
>  
>  static int adt7x10_write_word(struct device *dev, u8 reg, u16 data)
>  {
>  	struct adt7x10_data *d = dev_get_drvdata(dev);
> -	return d->ops->write_word(dev, reg, data);
> +	return d->ops->write_word(d->bus_dev, reg, data);
>  }
>  
>  static const u8 ADT7X10_REG_TEMP[4] = {
> @@ -315,14 +315,6 @@ static ssize_t adt7x10_alarm_show(struct device *dev,
>  	return sprintf(buf, "%d\n", !!(ret & attr->index));
>  }
>  
> -static ssize_t name_show(struct device *dev, struct device_attribute *da,
> -			 char *buf)
> -{
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%s\n", data->name);
> -}
> -
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
>  static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
>  static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
> @@ -336,9 +328,8 @@ static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
>  			     ADT7X10_STAT_T_HIGH);
>  static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
>  			     ADT7X10_STAT_T_CRIT);
> -static DEVICE_ATTR_RO(name);
>  
> -static struct attribute *adt7x10_attributes[] = {
> +static struct attribute *adt7x10_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max.dev_attr.attr,
>  	&sensor_dev_attr_temp1_min.dev_attr.attr,
> @@ -352,9 +343,7 @@ static struct attribute *adt7x10_attributes[] = {
>  	NULL
>  };
>  
> -static const struct attribute_group adt7x10_group = {
> -	.attrs = adt7x10_attributes,
> -};
> +ATTRIBUTE_GROUPS(adt7x10);
>  
>  int adt7x10_probe(struct device *dev, const char *name, int irq,
>  		  const struct adt7x10_ops *ops)
> @@ -367,7 +356,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  		return -ENOMEM;
>  
>  	data->ops = ops;
> -	data->name = name;
> +	data->bus_dev = dev;
>  
>  	dev_set_drvdata(dev, data);
>  	mutex_init(&data->update_lock);
> @@ -399,26 +388,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  	if (ret)
>  		goto exit_restore;
>  
> -	/* Register sysfs hooks */
> -	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
> -	if (ret)
> -		goto exit_restore;
> -
> -	/*
> -	 * The I2C device will already have it's own 'name' attribute, but for
> -	 * the SPI device we need to register it. name will only be non NULL if
> -	 * the device doesn't register the 'name' attribute on its own.
> -	 */
> -	if (name) {
> -		ret = device_create_file(dev, &dev_attr_name);
> -		if (ret)
> -			goto exit_remove;
> -	}
> -
> -	data->hwmon_dev = hwmon_device_register(dev);
> +	data->hwmon_dev = hwmon_device_register_with_groups(dev, name, data,
> +							    adt7x10_groups);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		ret = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove_name;
> +		goto exit_restore;
>  	}
>  
>  	if (irq > 0) {
> @@ -433,11 +407,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  
>  exit_hwmon_device_unregister:
>  	hwmon_device_unregister(data->hwmon_dev);
> -exit_remove_name:
> -	if (name)
> -		device_remove_file(dev, &dev_attr_name);
> -exit_remove:
> -	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>  exit_restore:
>  	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
>  	return ret;
> @@ -452,9 +421,6 @@ int adt7x10_remove(struct device *dev, int irq)
>  		free_irq(irq, dev);
>  
>  	hwmon_device_unregister(data->hwmon_dev);
> -	if (data->name)
> -		device_remove_file(dev, &dev_attr_name);
> -	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>  	if (data->oldconfig != data->config)
>  		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
>  	return 0;
> -- 
> 2.33.0
> 
