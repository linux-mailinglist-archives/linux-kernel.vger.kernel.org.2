Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF43FA108
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhH0VQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhH0VQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:16:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269ECC0613D9;
        Fri, 27 Aug 2021 14:15:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o185so11246971oih.13;
        Fri, 27 Aug 2021 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMJOjuDoILpNvITKCevV3iz99h0iJP9nNqFXRRyQ65Q=;
        b=giAl7GsTZi/gtTQvWxLxUtsOB0756yL17s0PbKz5H5YtHRpG8n3zQt/38kwWylUrn+
         DSJ23lV4yPH/91yL09Ez2rDmMbD94YT+EVQcmRleyZ3ydpo9emjaTQ2E3B4jh0xWeIrA
         ORhs8zl+kNqbYJjcGaU1G9yQEMohdB7U7gHv/qp+WPGmFcExrAHdo18jj74rtuULByFz
         2ibTUIt2eksNYi+oieDnjUt5gng5+30G2Q9dflAECWDq01ihiN/wDZiqz75nTVtBmYP3
         x1siCQsg7NqS9Ivm/074ySXJGgq+8f7DcBGJfsON8+l+/MkknIlLdt1zxfAy43mlOKzK
         l4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JMJOjuDoILpNvITKCevV3iz99h0iJP9nNqFXRRyQ65Q=;
        b=dM4MGnr1dXEEbl6URg66NqxfXEzkIt/uEPMO65QQxha/OR7kIDOf+dxOkiqaGGdA2a
         WP82oXZQnEHwsOdVg2O2jrLUWpiCYSBx3ICa9SIHWLuSNntFUW4qziYDrjKXk3JviSps
         29Vod5w3j1G7sPPauAAETQ/WZF1dSYvBnA+bnS8F/o7beRguFRmlSbFgztsikXjGxxuG
         wt6MXN8bFIdNbYzQkN5m22dKD5zCuEOa989JUYRTHI67TgF158wE5XDmFO57JxN/lLaS
         BxsP4A9J23WpbgYXZmxZOt/KorBWmgF7Sg8tMZ0AzwrHwfI/q5aJpGQoTmPURiGKKa6o
         Xvog==
X-Gm-Message-State: AOAM53133x+yLhSqx86Xfxf6pIM+CBZCKpshpFXSjFdK1DTdKAW2p2KV
        lPf9MEdFtO/SdNp+4cTrE62SBXNswwQ=
X-Google-Smtp-Source: ABdhPJwwetk0DLeKiL+yU8Eab5MLu2OKBshQuBG6d6UEQ1fN8MpNSmKG/vqjrb2SSNpnBynfW6NGgA==
X-Received: by 2002:a05:6808:f04:: with SMTP id m4mr8237667oiw.86.1630098928502;
        Fri, 27 Aug 2021 14:15:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm1532434otp.46.2021.08.27.14.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:15:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 14:15:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] hwmon: (adt7470) Fix some style issues
Message-ID: <20210827211526.GA697658@roeck-us.net>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826024121.15665-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:41:18PM +1200, Chris Packham wrote:
> In preparation for the changes that follow fix up some existing style
> issues.
> Specifically:
> - add blank line between variable declaration and code
> - use strscpy instead of strlcpy
> - remove unnecessary braces
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - new
> 
>  drivers/hwmon/adt7470.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 2e8feacccf84..3358ec58b977 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -174,6 +174,7 @@ struct adt7470_data {
>  static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
>  {
>  	u16 foo;
> +
>  	foo = i2c_smbus_read_byte_data(client, reg);
>  	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
>  	return foo;
> @@ -1282,7 +1283,7 @@ static int adt7470_detect(struct i2c_client *client,
>  	if (revision != ADT7470_REVISION)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, "adt7470", I2C_NAME_SIZE);
> +	strscpy(info->type, "adt7470", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> @@ -1331,9 +1332,8 @@ static int adt7470_probe(struct i2c_client *client)
>  
>  	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
>  					dev_name(hwmon_dev));
> -	if (IS_ERR(data->auto_update)) {
> +	if (IS_ERR(data->auto_update))
>  		return PTR_ERR(data->auto_update);
> -	}
>  
>  	return 0;
>  }
