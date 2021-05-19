Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B023899F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhESXju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:39:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9B9C061574;
        Wed, 19 May 2021 16:38:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y12so11477722qtx.11;
        Wed, 19 May 2021 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYvAq70vcu8d8pGyPATx8ah1ADtc7dJkYhvzYxavXRM=;
        b=urDEFU40r0UQnF+J6TaOanLO2fjQHBtA3/GRbwzlS4943VmmmR5neFEU/pDMSCTzEr
         KviGEzqSD5HOuCwBPJrgM7SO/9qIiCctpeYVdStKO+1kbWH+AWwtUx/iaDPDOiIZFPvU
         XXu+XBy8xO72tp/S1qvkLO28wi4p6xMtjYcvSYoZt6I009yKdDXTezShht1uS+Sm/LPd
         zuCWwQ9OvjNx1kFeA4/KCeRKxKTq1PEtXCRfssvkxMHOC2qObjuqlLTyrcaNYjLzuKN8
         V3MBjBoT+6vyhkkNEaxfoRLxevIDL/KgFuFhOrGKmGXnjOIK/1FRmiNt+rqRh2c5VDVp
         Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYvAq70vcu8d8pGyPATx8ah1ADtc7dJkYhvzYxavXRM=;
        b=iPtb6M4XyiqtwBdkHkJYGULUwZqef8wcLXZdOX6TSGPC4FGrGalFiQynHFMaupNMn0
         /cOcWK4VkoFiddMu6MtHeZ+QtLhJv4IuE+kiycjoVu9C5Xth14cxkffZPFe5su9krTO8
         z0+owVYyyW9bBVuagr0RY9Ynj/wtiefILQxZeHN1UlwLwJ71Fe7fxcZft17BLrj3z3Bu
         t5WfuqLg9vuFFtFLls2QurnzWcrM4DPKbZcR+F7aWpwYFRUlgme/nz6T4PVJk2QHiXmN
         Ue/3F68Ta5FgjqXrCgH3u+6x3EvX8dpIXqp/lvZb+gwjRAYAgsCtCCq1zh6Ux1k1xsrM
         pXBQ==
X-Gm-Message-State: AOAM532qaoYtGq2rN8iTCsFmBZjJr9s9bAU+L9YlAcydjoej5kIZOU1q
        0Aa8GdEHFKVGPGPIbiVraDX9PFe+nF0=
X-Google-Smtp-Source: ABdhPJyok6NfBGLUWlzfH3Zyt5VCWBJLx/2nQ+JPl2O9rlgeyxeZ6hg6aoKbg2k7bF2AFK+JaAEJXA==
X-Received: by 2002:a05:622a:110e:: with SMTP id e14mr2111137qty.283.1621467507706;
        Wed, 19 May 2021 16:38:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5sm977708qkg.122.2021.05.19.16.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 16:38:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/5] hwmon: (pmbus/pim4328) Add function for reading
 direct mode coefficients
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519201015.83989-1-erik.rosen@metormote.com>
 <20210519201015.83989-2-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6319f836-b6ea-96d1-bd84-0b859b5196f0@roeck-us.net>
Date:   Wed, 19 May 2021 16:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519201015.83989-2-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 1:10 PM, Erik Rosen wrote:
> Add the function pmbus_read_coefficients to pmbus_core to be able to
> read and decode the coefficients for the direct format for a certain
> command and read/write direction.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   drivers/hwmon/pmbus/pmbus.h      |  4 ++++
>   drivers/hwmon/pmbus/pmbus_core.c | 38 ++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 3968924f8533..a131b253ebf9 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -499,6 +499,10 @@ int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
>   			      enum pmbus_fan_mode mode);
>   int pmbus_update_fan(struct i2c_client *client, int page, int id,
>   		     u8 config, u8 mask, u16 command);
> +int pmbus_read_coefficients(struct i2c_client *client,
> +			    struct pmbus_driver_info *info,
> +			    enum pmbus_sensor_classes sensor_class,
> +			    u8 command, bool for_reading);
>   struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
>   
>   #endif /* PMBUS_H */
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index bbd745178147..14d3d3352aac 100644
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
> +			    u8 command, bool for_reading)
> +{

The way the code is written, we never need to read coefficients for writing.
With that in mind, I don't think the 'for_reading' parameter is necessary.

Guenter

> +	int rv;
> +	union i2c_smbus_data data;
> +	s8 R;
> +	s16 m, b;
> +
> +	data.block[0] = 2;
> +	data.block[1] = command;
> +	data.block[2] = for_reading ? 0x01 : 0x00;
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
> +EXPORT_SYMBOL_GPL(pmbus_read_coefficients);

EXPORT_SYMBOL_NS_GPL(pmbus_read_coefficients, PMBUS);

> +
>   int pmbus_read_word_data(struct i2c_client *client, int page, int phase, u8 reg)
>   {
>   	int rv;
> 

