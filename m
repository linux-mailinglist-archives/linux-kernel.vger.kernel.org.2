Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A807B3427D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCSVaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:30:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216BC06175F;
        Fri, 19 Mar 2021 14:30:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so9583772otb.7;
        Fri, 19 Mar 2021 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NUIbYpy0NLmrRRI+l4LHw4l+eurqUrE6wLZTOGdF6Vc=;
        b=oROCNLp0vn05j+k+RsiM8BxgWDHgyvspy0SuK3wHvnU7ZeUX8qbb+ECFaKtZZEq9WP
         Xk6bz1YH4dfnK2Q8qtM1T4GM2Ca0mlvxrJ4y89ruceV4mjwUCq2uo6eUFeUleiwsDoC1
         IHo1b49dsOHbCasQkD9bnAbB5uJ6wAhtuIAB7XCj9Fswt3vJeXZWdgC2AUJqtVph7iN0
         mST2DIAGYFYQD/+uDWyeQszRUkIsqY9gUCJ0OihK1pOExM4ImILFKx8ZatL+3zLP37z0
         u1GI7PTDFdGlYIZzBiXVK7WgUTpHOjioBmksLopzk8e3WFkKwXRww9NPUggOJgfvhO85
         xdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUIbYpy0NLmrRRI+l4LHw4l+eurqUrE6wLZTOGdF6Vc=;
        b=Vf7KCtf1+KqvQxvbX5CenYBIFaDrSYnfTH2N7wutVuHh2STdS9Fvyv4Rvpd2FCqpGp
         ieV1flwO+4RO3mmIjCMAl0a21Bli+wy7/X+nlRp3qsIwTC5HfPH/905rV2uqxuf8d/+E
         a2Besi+I36+xFw+9QuQv32Nb7IOz18nohrBatMaFUk+O8sf9oapdNGxJ0q+edqoax7D+
         8bCg47vCC7BI5Pud1gr5Pr5WdqzVGQMYWxFZrwjg1nfJz4D6sIH6taEjcQVay+vQhWj0
         5k8ZJ2mAD8HTERak/EgJKTZaZ4Qo03VkC1M0X+quF05lXexIVCXQXqfuWX7YmgZKTS0c
         cMjA==
X-Gm-Message-State: AOAM533+6aedIMUpd35gMXwD/l2IZAzyJFs9PKLEi8xKhTb5XtBR8IJ9
        veaUhwJcf1iX5lKx1tGnT7Y=
X-Google-Smtp-Source: ABdhPJxNZb84yxHU6RXhE9I4olIKiyJQxPqsyyy6zTDMfjIiloERlr2AGeUsKhFUh8QDoDv+xLof6g==
X-Received: by 2002:a05:6830:225b:: with SMTP id t27mr2598419otd.73.1616189407440;
        Fri, 19 Mar 2021 14:30:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w199sm1507532oif.41.2021.03.19.14.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Mar 2021 14:30:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Mar 2021 14:30:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hwmon: (pmbus): Replace - with _ in device names
 before registration
Message-ID: <20210319213005.GA24260@roeck-us.net>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
 <20210317040231.21490-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:02:30PM +1300, Chris Packham wrote:
> The hwmon sysfs ABI requires that the `name` property doesn't include
> any dashes. But when the pmbus code picks the name up from the device
> tree it quite often does. Replace '-' with '_' before registering the
> device.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - New
> 
>  drivers/hwmon/pmbus/pmbus_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index aadea85fe630..7d2f8f032314 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2557,6 +2557,7 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	struct pmbus_data *data;
>  	size_t groups_num = 0;
>  	int ret;
> +	char *name;
>  
>  	if (!info)
>  		return -ENODEV;
> @@ -2606,10 +2607,15 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  		return -ENODEV;
>  	}
>  
> +	name = devm_kstrdup(dev, client->name, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +	strreplace(name, '-', '_');
> +
>  	data->groups[0] = &data->group;
>  	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
>  	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> -					client->name, data, data->groups);
> +					name, data, data->groups);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		dev_err(dev, "Failed to register hwmon device\n");
>  		return PTR_ERR(data->hwmon_dev);
