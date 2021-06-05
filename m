Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB139C4A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 02:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFEAya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 20:54:30 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34568 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 20:54:28 -0400
Received: by mail-qt1-f170.google.com with SMTP id u20so144559qtx.1;
        Fri, 04 Jun 2021 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A/NbVLmcG0lBcH68iu6lVYiPN9nwO8RaKdiPfXZrVVY=;
        b=j8OSPmckhGqpUL5vCkGl//ViHATkzAQw9s//SahHY9KItYAOj9IzGfIK5IbY8bSy1n
         pDLGy8b2vj+82pA1Dv06puwUMUDqRHHI2Ve83LUAli2O/7p7uLpXZJ1vK8h/5tyDIn+O
         7c7DWkg0PzKeo21FFOzUlwa56ApaJT3W1XHnv31mw7VD8+FAJu61AH8275cuOYOvDZ6H
         /X/qkl4sEz3v1Svxgqe8w++R/RJ1vZYeYR+toFOFzMZ+RlBDQftgXOpHDtLF9Gli6dt5
         iGOIaPCdL3j0SX0319EzKfgNhc2BLXYEWQ7wXKaTxjMTf4tfNgXdCv+xUnEdTsSfo1hH
         gd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A/NbVLmcG0lBcH68iu6lVYiPN9nwO8RaKdiPfXZrVVY=;
        b=CcTRCwdUAU2TKTbEcUq10KnLeR62G7Ui7DZJxrX274dKP6YMbbfzIbTTrXGo8fEgJN
         9H9Suk2nf3tnzcxgHtAOIpUsE8SyG0pfgZwaNgS8pzhASpPZrSoKulN8S96hgX70ZamF
         w3fwlOdk8CzrYPQQdI6cpvHOXfmZ26cYah1X/kFQP8Zphpn+OjrEoemdtbPFuJzsbUf4
         WzmQFSIxEPpjkPi5K66FVWQYPxNRYmZeBcntXiUFJgPfoq/v9IKSMF7kb6wSjVOtckES
         fPBDWHxn+RYba9arDMNofKD0JzrxcSfqUE20H9Ckfz4sPSpnGmc86yzNNSrVA0/l4HcS
         BF4g==
X-Gm-Message-State: AOAM531HAV3a+v2Cf8LM0RYWKh0ayK9Ozegyq/uz8dGziJknZrx9PQUr
        bkg/glEZySXZSUdM2oIv8R8=
X-Google-Smtp-Source: ABdhPJy5jqM8o3KAgrH0xF9E9ruOdM0AclDoCS8tldzjuNNNvN4NkHirGT1sxaYTLm6bPhyqzovj7w==
X-Received: by 2002:a05:622a:392:: with SMTP id j18mr7133758qtx.6.1622854286408;
        Fri, 04 Jun 2021 17:51:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j30sm4989563qki.60.2021.06.04.17.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:51:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 17:51:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus_core) Check adapter PEC support
Message-ID: <20210605005124.GA255680@roeck-us.net>
References: <20210604135714.529042-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604135714.529042-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:57:14PM +0200, Paul Menzel wrote:
> From: Madhava Reddy Siddareddygari <msiddare@cisco.com>
> 
> Currently, for Packet Error Checking (PEC) only the controller
> is checked for support. This causes problems on the cisco-8000
> platform where a SMBUS transaction errors are observed. This is
> because PEC has to be enabled only if both controller and
> adapter support it.
> 
> Added code to check PEC capability for adapter and enable it
> only if both controller and adapter supports PEC.
> 
> Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
> [Upstream from SONiC https://github.com/Azure/sonic-linux-kernel/pull/215]
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index bbd745178147..7fbd82b7560d 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2214,11 +2214,13 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  		data->has_status_word = true;
>  	}
>  
> -	/* Enable PEC if the controller supports it */
> -	if (!(data->flags & PMBUS_NO_CAPABILITY)) {

What is the rationale for removing this check ?
AFAICS that will render the ibm-cffps driver unusable.

Guenter

> -		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> -		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> +	/* Enable PEC if the controller and bus supports it */
> +	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> +	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
> +		if (i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_PEC)) {
>  			client->flags |= I2C_CLIENT_PEC;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.32.0.rc2
> 
