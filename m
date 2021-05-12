Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E737EFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349474AbhELXf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbhELW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:58:13 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACDC061362;
        Wed, 12 May 2021 15:55:51 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso22146518otg.9;
        Wed, 12 May 2021 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLKwcRobKqjhHeVdngGYVvRGLlg1dR3nc2JxZy1jYv8=;
        b=LTV6KTgf7/eooa2prZcFNZCuE0L4oLUkuDBCSQPGZIkIZ7g2Cq3NvBJOUvbacCw5nx
         B4b+l6BjtRTOy/VGQ2J5KcA4//QtPIWVgnjFfbZM/avktTjMKdHFZJFPwmzTxuvNdfKZ
         0y+Rr7rA+11a698a2JJXJS1JHuvSZ1aZNp2xLH3chZae5uGfu63pNgQcOUvVmMqRhLac
         nBDdnTM+OVXtpnhwiBMjHD5uE6Ub+FVA4Yl0whlgKDRfuafphZ+NVrTfMQVeLDRNJQwA
         gVRcCp5kJs9RDb8dcDuDy2RUoS2Q9WcUfny3aw5s+BVbBfMrr0aGZDN1PbPyrzH3JUxs
         iLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bLKwcRobKqjhHeVdngGYVvRGLlg1dR3nc2JxZy1jYv8=;
        b=Xy73eur5Xmf7ICiKC+FzuGRmkzO+2QFHzkrS3+CkBaOu/40Z0fNw5bH7vBM32SIT5b
         LmQyTcY1MoHl88DGzZ8e0i/WjOF3jkZ2RgZPaIugxWlnJ3hkNL1DNFUxCg6x5UT+mTdV
         SdlGQTu5mc6cOMUGa+FlcMpNYnHh58jGI3HUjDTkfEGRkyXOpES/pOtSn+YOCjWCo+CU
         1O3bMJ4EEzDH1G7qRz3fztqE8Juujp9msQN7fV7FUF/RoyCRFqoX8S9ZglOp6hbZH7Pl
         CEFWdms+ayZEUMsIhnkEfAn1smmcK709iMrtUi84Hfr9dGQz7hxxtJf5y7UDMPhsB/ap
         veXw==
X-Gm-Message-State: AOAM5331QPMXH0d4A/EihhR1UrM4WfA6W9RDgnsLSemszYhfAAIRC+3B
        ootVOrunqlOicyPFK8ItyLs=
X-Google-Smtp-Source: ABdhPJwpOfTWQUIm9Bx06871NaQA3u39rhXnwaIxHz1tVKIXIhN03Gz+f44JkYO0nrfUECZ1NhOBxQ==
X-Received: by 2002:a9d:4115:: with SMTP id o21mr32765294ote.52.1620860150482;
        Wed, 12 May 2021 15:55:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm280004otj.8.2021.05.12.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:55:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 May 2021 15:55:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     linchuyuan@gmail.com, jasonling@google.com, zhongqil@google.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: adm1272: enable adm1272 temperature reporting
Message-ID: <20210512225548.GA2874606@roeck-us.net>
References: <20210512171043.2433694-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512171043.2433694-1-linchuyuan@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 05:10:43PM +0000, Chu Lin wrote:
> adm1272 supports temperature reporting but it is disabled by default.
> 
> Tested:
> ls temp1_*
> temp1_crit           temp1_highest        temp1_max
> temp1_crit_alarm     temp1_input          temp1_max_alarm
> 
> cat temp1_input
> 26642
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>

Applied, after updating the affected driver in the subject line
(the change affects adm1272, but the driver is still the adm1275 driver).

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/adm1275.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index e7997f37b266..0be1b5777d2f 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -611,11 +611,13 @@ static int adm1275_probe(struct i2c_client *client)
>  		tindex = 8;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
> +		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -625,10 +627,6 @@ static int adm1275_probe(struct i2c_client *client)
>  				return -ENODEV;
>  			}
>  		}
> -
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
