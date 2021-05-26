Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7225390F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhEZEGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhEZEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:06:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9464C061574;
        Tue, 25 May 2021 21:04:30 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so268126oib.5;
        Tue, 25 May 2021 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kw02UOm+gvYzlVaD+urN8TTUijZZK4B3fBuc8WdNWRo=;
        b=B2ErviFdDUVSiovnWho6LkswDmgVXWEw0O7s8kea7knez+DuZWuaedFI3QOhXqzQQz
         lCNAwFkNaAaTgx1vDlZXt+TV4vGpnsa3YrNsBvbIdw23ZPb5Kpn8QT0VPsUqYMml0tyG
         0NiFhWBpSy9Y83SnqT8KUIxqTT0m95NCJMKjCbiaWUCKivL8SInuP3EE6vyMLfbJbLfY
         xphIrzAFWpxgixT8ak+E+Z6WtWXx5VxbO5cvGClP/ptPNgFVasO1Edz0ejnspSEX2jUH
         MRe6Zf58oMW0QjhW6ef+obGUDqrAqWRWoa7SNoiCY2kmCjb8JoIaA5TjbwhY/+RzCHsu
         kE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kw02UOm+gvYzlVaD+urN8TTUijZZK4B3fBuc8WdNWRo=;
        b=oAief/l19w6VWi9jC0pEcse2f0iNFlFMjfOwRLPMeRCf30l/gQ8UWRol6MZYYwAXfY
         N331p7hlc3P7skU28gIboCwb2WM5jD/22JXgbqdFxWqfqcJv3bHiMdE4PK1ZCm3JC4s8
         NcJoBZXDdyl/2AfXlu27BoFKlPgpY0VNnTPNpEQAC4OMMsbLzCK3mxxXyWaNk743JzNy
         zDOuyC5L7fsW5LopT7FdszX6HSzebTQ0sDbu9G4BQaKQt4jUZoqe7wkqqU50wgOhVfIK
         Dv/Qc+Ms2l0WiSDBeqyI7yXqLotyTsbl5UB3vkOtpXTK7qwrgnE/AFOHp3dJlSSz/voI
         TkAg==
X-Gm-Message-State: AOAM533X3OmmvXHEj+58l9tkFXQptv3X5Wb/STcFHEIzpp+QKfclY69G
        +onxcbpq2e2Xwd4Q8vCnbCpEdJUzmFc=
X-Google-Smtp-Source: ABdhPJzNRjp2aORpb/IXVM2lYhHiNoK+z8JnZ+iY0gUk99FU3/KtCDIM/hsxz9LFbsJVq+LzMaWrdg==
X-Received: by 2002:a05:6808:290:: with SMTP id z16mr568964oic.147.1622001869862;
        Tue, 25 May 2021 21:04:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13sm4185788ote.32.2021.05.25.21.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 21:04:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 2/6] hwmon: (pmbus/pim4328) Add function for reading
 direct mode coefficients
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210524150246.90546-1-erik.rosen@metormote.com>
 <20210524150246.90546-3-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e358bc76-a06a-47dc-1729-cf1a8b6e5e27@roeck-us.net>
Date:   Tue, 25 May 2021 21:04:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524150246.90546-3-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 8:02 AM, Erik Rosen wrote:
> Add the function pmbus_read_coefficients to pmbus_core to be able to
> read and decode the coefficients for the direct format for a certain
> command.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   drivers/hwmon/pmbus/pmbus.h      |  4 ++++
>   drivers/hwmon/pmbus/pmbus_core.c | 38 ++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 3968924f8533..d9ed9736b480 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -499,6 +499,10 @@ int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
>   			      enum pmbus_fan_mode mode);
>   int pmbus_update_fan(struct i2c_client *client, int page, int id,
>   		     u8 config, u8 mask, u16 command);
> +int pmbus_read_coefficients(struct i2c_client *client,
> +			    struct pmbus_driver_info *info,
> +			    enum pmbus_sensor_classes sensor_class,
> +			    u8 command);
>   struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
>   
>   #endif /* PMBUS_H */
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index cb885efc4fba..460cbfd716e4 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -301,6 +301,44 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_update_fan, PMBUS);
>   
> +/*
> + * Read the coefficients for direct mode.
> + */
> +int pmbus_read_coefficients(struct i2c_client *client,
> +			    struct pmbus_driver_info *info,
> +			    enum pmbus_sensor_classes sensor_class,
> +			    u8 command)
> +{
> +	int rv;
> +	union i2c_smbus_data data;
> +	s8 R;
> +	s16 m, b;
> +
> +	data.block[0] = 2;
> +	data.block[1] = command;
> +	data.block[2] = 0x01;
> +
> +	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +			    I2C_SMBUS_WRITE, PMBUS_COEFFICIENTS,
> +			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
> +
> +	if (rv < 0)
> +		return rv;
> +
> +	if (data.block[0] != 5)
> +		return -EIO;
> +
> +	m = data.block[1] | (data.block[2] << 8);
> +	b = data.block[3] | (data.block[4] << 8);
> +	R = data.block[5];
> +	info->m[sensor_class] = m;
> +	info->b[sensor_class] = b;
> +	info->R[sensor_class] = R;
> +
> +	return rv;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmbus_read_coefficients, PMBUS);

I don't think this function needs to be exported.
> +
>   int pmbus_read_word_data(struct i2c_client *client, int page, int phase, u8 reg)
>   {
>   	int rv;
> 

