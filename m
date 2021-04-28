Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0C36DCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhD1QZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhD1QZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:25:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB1C061573;
        Wed, 28 Apr 2021 09:24:30 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so4106116otj.5;
        Wed, 28 Apr 2021 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/rne7W0ki+yU2liZj6G6QiCY1bW/h0NIzivkTOi4xM=;
        b=tkH02VmwVTOvETMc0AqIFlskdS8Z2mNcfvVVrLu/pL9qpf42C7sQZzgohAHLxTLeXp
         xTINlUQBU8Cq9WNCtvMkAjWRT3uMk+by3IlJbhSSRAGF5QgWQrO4mHjK9Irk+qgR0mPq
         TkVtIsXnRBUCU1kN3/9PvBygddjNUmiI8n2hW1hBUoEfW6CEXXYKi23utlL1fB4S5Tb6
         r7XLsRXtoaZmBPzHxX4t125le15x0jM95snYCKxXIzyvtYLp0n+lIfX1lkfBzF1AxSAp
         as9fUCbQlFLylCmhe98CgUjdMx1xpzVAqK2Y9iGQoxU83Seb6DboZ7ZDzQoj5QVjEmht
         nRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O/rne7W0ki+yU2liZj6G6QiCY1bW/h0NIzivkTOi4xM=;
        b=A8xQWFBEjisElZNbgeIlRPdz43YkHU0MMrU5caliIsL0PvtZKTUCRPomuX/Z179O3v
         kbF8BYyT5UZF/rctm0VMIVLy74mrEtrsawoKgsCjycnICQFGNpI6OpLN5W6v49c6zzNt
         dv3maONd7Il++ILTxLuZ6oQQzn2iL+HFskaaJoIjWQuGlV2QUaz8hkMI11LmwNZOewl4
         FTK34YSnUE2nIvbo0GMHDuozoRh1bS3F5RVDNGX+gPnfp7RGiW3wgYuxJGNsW3lx3XGe
         +rS+hB3+qjeegrpQadZ2ZuJzGv5iZKb+dD1tDsd7FK5aIjh5ich/V6sl+HWpv1Jf5kWO
         bcbA==
X-Gm-Message-State: AOAM5306zGEf5iVluXCBYWM/UfjB8Zgx3iKv9O7RrKcl/Fnl4N4ZhRng
        O4O7Q8J8jrzmuTTy4KR+1KvOVod6NpQ=
X-Google-Smtp-Source: ABdhPJzjcRO95cAeozRUH4zAr9wAQ2n0QFkmPj2TYsy9XD38nD76DkuLkytwEhN/OGV5gKDWbZp7Zg==
X-Received: by 2002:a9d:3424:: with SMTP id v33mr24018169otb.137.1619627069767;
        Wed, 28 Apr 2021 09:24:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h59sm91545otb.29.2021.04.28.09.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:24:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] Fix FSP-3Y YH-5151E non-compliant vout encoding
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210428083833.4136346-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ed8b9e7f-6588-284d-6eb0-cd779a5693ed@roeck-us.net>
Date:   Wed, 28 Apr 2021 09:24:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428083833.4136346-1-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 1:38 AM, Václav Kubernát wrote:
> I didn't properly test the driver for YH-5151E, so it was completely
> broken. Firstly, the log/real mapping was incorrect in one case.
> Secondly, PMBus specifies that output voltages should be in the linear16
> encoding. However, the PDU is non-compliant and uses linear11. YM-2151E
> isn't affected by this. Fix this by converting the values inside the
> read functions. linear16 gets the exponent from the VOUT_MODE command.
> The device doesn't support it, so I have to manually supply the value
> for it.
> 
> Both supported devices have now been tested to report correct vout
> values.
> 

Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")

> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  drivers/hwmon/pmbus/fsp-3y.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> index 564649e87e34..dc147a79d6aa 100644
> --- a/drivers/hwmon/pmbus/fsp-3y.c
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -57,7 +57,7 @@ static int page_log_to_page_real(int page_log, enum chips chip)
>  		case YH5151E_PAGE_12V_LOG:
>  			return YH5151E_PAGE_12V_REAL;
>  		case YH5151E_PAGE_5V_LOG:
> -			return YH5151E_PAGE_5V_LOG;
> +			return YH5151E_PAGE_5V_REAL;
>  		case YH5151E_PAGE_3V3_LOG:
>  			return YH5151E_PAGE_3V3_REAL;
>  		}
> @@ -103,17 +103,28 @@ static int set_page(struct i2c_client *client, int page_log)
>  
>  static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
>  {
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
>  	int rv;
>  
>  	rv = set_page(client, page);
>  	if (rv < 0)
>  		return rv;
>  
> +	/*
> +	 * YH5151-E outputs vout in linear11. The conversion is done later, but
> +	 * I have to inject pmbus_core with the correct exponent.

s/I/we/

Also, it might be useful to mention the actual exponent (-6 ?) in the comment.

> +	 */
> +	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
> +		return 0x1A;

Can this code be moved ahead of set_page() ?

> +
>  	return i2c_smbus_read_byte_data(client, reg);
>  }
>  
>  static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
>  	int rv;
>  
>  	/*
> @@ -144,7 +155,18 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
>  	if (rv < 0)
>  		return rv;
>  
> -	return i2c_smbus_read_word_data(client, reg);
> +	rv = i2c_smbus_read_word_data(client, reg);
> +	if (rv < 0)
> +		return rv;
> +
> +	/*
> +	 * The PDU is non-compliant and outputs output voltages in linear11

s/The PDU/YH-5151E/

> +	 * instead of linear16.
> +	 */
> +	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
> +		rv = ((s16)((rv & 0x7ff) << 5)) >> 5;

Problem with this is that it auto-converts to int and will return a
negative value if bit 10 is set (I wrote some test code and confirmed it,
just to be sure).
		rv = sign_extend32(rv, 10) & 0xffff;
should work here.

Thanks,
Guenter

> +
> +	return rv;
>  }
>  
>  struct pmbus_driver_info fsp3y_info[] = {
> 

