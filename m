Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7591A4580D4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhKTWsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 17:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhKTWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 17:48:15 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74EC061574;
        Sat, 20 Nov 2021 14:45:11 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so5015048ooi.7;
        Sat, 20 Nov 2021 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z48wGd8lTYwl0bHr+bL0R0C6nwdGTgHuKhzGbg9buKM=;
        b=nuBvcMC4n6Apqk+3pr5nYtgd3G8P/EEizVgUxOPiJFueq6FF2Iky0YipavRPsrGFiH
         MjJndOO3+3ldrXOGNrnHimG3w2QmxslECTOJW3BCn5HKEfj1xxtJaxGSdT0wUQIhdwIs
         HR5UDGVAa+csu9Sv2xP4Gd7Nijw1rwwDg4X8lRaJLPTkG/2xSFetV+B1Uug7EssJ4JsK
         pjQOnYFBgriRGIiLltkQSaLPuI0JL2BaE+sHae4G0Cl7RXA08zLEyLhEGi9dUFqntbC+
         YWeNB+PmGnnt0TaRWSoKzxmDUeGNWaIvM9umWerIqUk8FCqHzD7uxi8FGg2GBk/1FWsd
         oXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z48wGd8lTYwl0bHr+bL0R0C6nwdGTgHuKhzGbg9buKM=;
        b=D52U6EsNMEP9SjRH7bF6qLa92rGakHk/hCz8kPUDkih8NmCxdc0M5UB1a0jXhNISzv
         xoOp9QKaQmNG9HcxpOda+4r5Plx024mfDS7aC0f5gOA0EY8gfxj846KNffbaV+7RHj5R
         1dV6Ee2cyFzxyUYZ4T/kmHTzujAU+XVp6bgEyhSzwtOWnoXf3TeaOR0eb5EHHdcaa+dT
         9oAaXGmcl7IL8tUd4HXqZ3dvM1VyMmn1AjVRMDLN3VR/arToavNlFa53DSYskN3c+OIB
         yb5QoSUhUwRbxekBLSANg/GHdmHL4F9eYfJ/8zgm5u+0AbFKB1/nU6rFtnNIjPF3Z/Lk
         GuBg==
X-Gm-Message-State: AOAM533J/S9Og9QNAeLDDQDGYoNBDfJxpWE/U/j9oHK2XtZ9ZOVi234K
        DhBEcx822feBcBEZBZ7jrpL+ilLenug=
X-Google-Smtp-Source: ABdhPJxiF7YYmsSULu1OLsHv5T/tbugdAuyO3YWJop/MfcYnmJ5+O+KByNSOnjmsK5cszNF1DXBcpA==
X-Received: by 2002:a4a:5b85:: with SMTP id g127mr24852576oob.86.1637448310373;
        Sat, 20 Nov 2021 14:45:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9sm780567oog.43.2021.11.20.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 14:45:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 Nov 2021 14:45:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (sht4x) Fix EREMOTEIO errors
Message-ID: <20211120224508.GA1292983@roeck-us.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
 <20211120212849.2300854-1-davidm@egauge.net>
 <20211120212849.2300854-2-davidm@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120212849.2300854-2-davidm@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 09:28:56PM +0000, David Mosberger-Tang wrote:
> Per datasheet, SHT4x may need up to 8.2ms for a "high repeatability"
> measurement to complete.  Attempting to read the result too early
> triggers a NAK which then causes an EREMOTEIO error.
> 
> This behavior has been confirmed with a logic analyzer while running
> the I2C bus at only 40kHz.  The low frequency precludes any
> signal-integrity issues, which was also confirmed by the absence of
> any CRC8 errors.  In this configuration, a NAK occurred on any read
> that followed the measurement command within less than 8.2ms.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/sht4x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 09c2a0b06444..3415d7a0e0fc 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -23,7 +23,7 @@
>  /*
>   * I2C command delays (in microseconds)
>   */
> -#define SHT4X_MEAS_DELAY	1000
> +#define SHT4X_MEAS_DELAY_HPM	8200	/* see t_MEAS,h in datasheet */
>  #define SHT4X_DELAY_EXTRA	10000
>  
>  /*
> @@ -90,7 +90,7 @@ static int sht4x_read_values(struct sht4x_data *data)
>  	if (ret < 0)
>  		goto unlock;
>  
> -	usleep_range(SHT4X_MEAS_DELAY, SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> +	usleep_range(SHT4X_MEAS_DELAY_HPM, SHT4X_MEAS_DELAY_HPM + SHT4X_DELAY_EXTRA);
>  
>  	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
>  	if (ret != SHT4X_RESPONSE_LENGTH) {
