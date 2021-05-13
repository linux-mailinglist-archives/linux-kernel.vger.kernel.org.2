Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2F380001
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhEMWYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 18:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEMWYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 18:24:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D4C061574;
        Thu, 13 May 2021 15:23:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j11so20952777qtn.12;
        Thu, 13 May 2021 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d59T7/Gnr5WFSplRsZPqTtWmM8+6FQk9CHZe0ykiJIU=;
        b=I89JJMvE4oQCa69eOZFqqx9LtwxbEN1x6t/tONIe7Xb6dicLwiFH9LQ1qF/871oQNd
         oM7zPSya9NgbNODWwgDo0n1CBg1x1TxvvCETOcngfDO4sGbWs0OnFteqLTBs9hb+tQak
         HtjlDsAbq2BxbS4I1JpLBTmTobH55AqpFfbMk1J34kwRbJQ7eXj1j3UaBeGfOm0Z8/cb
         bCm5UAnS8qvCT35h7loedUD6HIuYtW06xlMo/WVTvkbNDI9h2dwpXl4S22yZAiPQHVdO
         QBK2j2W8vtaaK0OaoGPitIR70oeTznlhxaA/ZHmlT3hHPppHKAPxm9DHEE+f6BLpwK3/
         M6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=d59T7/Gnr5WFSplRsZPqTtWmM8+6FQk9CHZe0ykiJIU=;
        b=DDd0YGyRUm9fBBjEz7SuVTFRCbOpCFH47DYROXeQxuIodne3NXL4eSLeF3/2ACS6CK
         1YVAkVKBapj3w1oilABwEcKmpjEozjs28pvKz6w23lBtRpczTPISEfKmw4hxYTgHpPl+
         EUP5MHxSkBt0CA3XDGqDom5NnzjONwsrZSlX+GpD+HLNIL4tfgdsv1GX7OXaY8o9peBN
         Ju5+KV21N47/GT9ESOjBCOXOYmJiXboB17oT8nQECqWkV6e8mmBCoEtatUBxh9/Sr6Gm
         Vqc8VB37eI8JyrkX4oAJ+DYRR9CP/7LHSCFlFSCAxY0S7DYIFy7hdwjM7h/zAgKIol8n
         OFcw==
X-Gm-Message-State: AOAM530qefJEaPUBwR5wv8bHfMSdOVh4U2TQsrgtGZdlRBkA5jvmw8DV
        7RGWxCUD+LvKfeqnr9Yu0ZE=
X-Google-Smtp-Source: ABdhPJxncGMpXolHQktQohqKxgt5ZkOno4CZpdwhhAmZS46L1+KGMpsPxOmPG1E+tfySKBlZ3GPLlA==
X-Received: by 2002:a05:622a:1016:: with SMTP id d22mr9098206qte.44.1620944584529;
        Thu, 13 May 2021 15:23:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm3186496qtp.65.2021.05.13.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 15:23:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 13 May 2021 15:23:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E VOUT
Message-ID: <20210513222302.GA915998@roeck-us.net>
References: <20210513201110.313523-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513201110.313523-1-kubernat@cesnet.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:11:10PM +0200, Václav Kubernát wrote:
> After testing new YH-5151E devices, we found out that not all YH-5151E
> work the same. The newly tested devices actually report vout correctly
> in linear16 (even though they're still YH-5151E). We suspect that it is
> because these new devices have a different firmware version, but that is
> unconfirmed. The version cannot be queried through PMBus.
> 
> The compliant versions of YH-5151E report VOUT_MODE normally, so we turn
> on the linear11 workaround only if VOUT_MODE doesn't report anything.
> 
What a mess. But thanks for keeping on top of this, and for the fix.
Applied.

Thanks,
Guenter

> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  drivers/hwmon/pmbus/fsp-3y.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> index 46252b17c008..073d960a0af5 100644
> --- a/drivers/hwmon/pmbus/fsp-3y.c
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -37,6 +37,8 @@ struct fsp3y_data {
>  	struct pmbus_driver_info info;
>  	int chip;
>  	int page;
> +
> +	bool vout_linear_11;
>  };
>  
>  #define to_fsp3y_data(x) container_of(x, struct fsp3y_data, info)
> @@ -108,11 +110,9 @@ static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
>  	int rv;
>  
>  	/*
> -	 * YH5151-E outputs vout in linear11. The conversion is done when
> -	 * reading. Here, we have to inject pmbus_core with the correct
> -	 * exponent (it is -6).
> +	 * Inject an exponent for non-compliant YH5151-E.
>  	 */
> -	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
> +	if (data->vout_linear_11 && reg == PMBUS_VOUT_MODE)
>  		return 0x1A;
>  
>  	rv = set_page(client, page);
> @@ -161,10 +161,9 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
>  		return rv;
>  
>  	/*
> -	 * YH-5151E is non-compliant and outputs output voltages in linear11
> -	 * instead of linear16.
> +	 * Handle YH-5151E non-compliant linear11 vout voltage.
>  	 */
> -	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
> +	if (data->vout_linear_11 && reg == PMBUS_READ_VOUT)
>  		rv = sign_extend32(rv, 10) & 0xffff;
>  
>  	return rv;
> @@ -256,6 +255,25 @@ static int fsp3y_probe(struct i2c_client *client)
>  
>  	data->info = fsp3y_info[data->chip];
>  
> +	/*
> +	 * YH-5151E sometimes reports vout in linear11 and sometimes in
> +	 * linear16. This depends on the exact individual piece of hardware. One
> +	 * YH-5151E can use linear16 and another might use linear11 instead.
> +	 *
> +	 * The format can be recognized by reading VOUT_MODE - if it doesn't
> +	 * report a valid exponent, then vout uses linear11. Otherwise, the
> +	 * device is compliant and uses linear16.
> +	 */
> +	data->vout_linear_11 = false;
> +	if (data->chip == yh5151e) {
> +		rv = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
> +		if (rv < 0)
> +			return rv;
> +
> +		if (rv == 0xFF)
> +			data->vout_linear_11 = true;
> +	}
> +
>  	return pmbus_do_probe(client, &data->info);
>  }
>  
