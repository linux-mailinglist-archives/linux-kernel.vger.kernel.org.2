Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EF41716E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbhIXMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245069AbhIXMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:01:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B844C061574;
        Fri, 24 Sep 2021 05:00:00 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so12820874ota.6;
        Fri, 24 Sep 2021 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gaw8hq1tP5dFMMFBJGf09r+9kBtQt8HO+1SL++A5V4w=;
        b=XLAuCVry5neZjaz6bhGYS8n3Dcffaosa/A5/Kt2OIj7WPDqyzsoBf3azQZQQZ9MpPG
         eDVul+SKHKWmwZqd/Sy0gmfkypXqXB5ngtmdgHtH4MwUTBeudVy75fTFTbWu3UmGvkmm
         TykqUajoYG1iJ7QyiX/vW6ynaMxOlho8l12SCzrjcP5TGqG9xvtGcUGfAGg2/7ijdUWz
         NENu7OH/wsfFH+ycPOwHmD9ksnBog9qH9vMLHXYMn2AItsymzKvVjDi3RrzV28DkvH5N
         U7K0w5ktkw9i55K41PShTKYhoJviortNeQ2ZlNqEOcIsa1/GmM/tAUlsD79YbWZN6l08
         AzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gaw8hq1tP5dFMMFBJGf09r+9kBtQt8HO+1SL++A5V4w=;
        b=SL/zLSK4Bx73Fc6l4gsoZDj4HQF1NN04Oxv0Z4jIXQRPCc+RbE5hZqw6aavhfjhLgh
         YZbxDYSok10y9oJZi7FvAH+YqDCz70JIkG63Tnu6yabIFaCL8/EDfvvrMsWBlglGgTOw
         Ou+i2Bs4Ym/3viHXVnJDd7+j0ogwP9qhGAUVcEv+w6dL99YnG+zjiPIICFXhesr3kQ9+
         Vqkbs9kbZWYLNbAGsVOt/mvcRlloqlbE5qScDLna8LP3mPF68e7N8SFQwiamZGNznl1U
         Oeq3YCgrrQJ3CsuxnTNQYvzzEJiuCzGqgVTGhJ+qsxt3llTHEGiDxqqLVM8iFyz6g38o
         f4+A==
X-Gm-Message-State: AOAM532mWjWxkIdLuTEQbEeV6lBQLg41LffGWIfZb6SjH+I2cNYBEUjF
        WxZz4vsrVcuXPa4fpunGrtozeg+wD4Q=
X-Google-Smtp-Source: ABdhPJwV6KDoOL4dJobE5iEtEYDFPM40hBhSDcRGQuodsm2FiwCPKNGDoPT+pRNqKHZ/7YTcDP7h6g==
X-Received: by 2002:a9d:654b:: with SMTP id q11mr3570243otl.184.1632484799865;
        Fri, 24 Sep 2021 04:59:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v16sm2046200oiv.23.2021.09.24.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:59:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 24 Sep 2021 04:59:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hwmon: tmp421: report /PVLD condition as fault
Message-ID: <20210924115958.GA2695448@roeck-us.net>
References: <20210924022020.GA3032273@roeck-us.net>
 <20210924093011.26083-1-fercerpav@gmail.com>
 <20210924093011.26083-2-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924093011.26083-2-fercerpav@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:30:10PM +0300, Paul Fertser wrote:
> For both local and remote sensors all the supported ICs can report an
> "undervoltage lockout" condition which means the conversion wasn't
> properly performed due to insufficient power supply voltage and so the
> measurement results can't be trusted.
> 
> Fixes: 9410700b881f ("hwmon: Add driver for Texas Instruments TMP421/422/423 sensor chips")
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Applied.

Thanks,
Guenter

> ---
> 
> Changes from v2:
>  - Add Fixes: tag
> 
> Changes from v1:
>  - Trivial rebase
> 
>  drivers/hwmon/tmp421.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index e6b2b31d17c8..3a789f21188c 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -182,10 +182,10 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
>  		return 0;
>  	case hwmon_temp_fault:
>  		/*
> -		 * The OPEN bit signals a fault. This is bit 0 of the temperature
> -		 * register (low byte).
> +		 * Any of OPEN or /PVLD bits indicate a hardware mulfunction
> +		 * and the conversion result may be incorrect
>  		 */
> -		*val = tmp421->temp[channel] & 0x01;
> +		*val = !!(tmp421->temp[channel] & 0x03);
>  		return 0;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -198,9 +198,6 @@ static umode_t tmp421_is_visible(const void *data, enum hwmon_sensor_types type,
>  {
>  	switch (attr) {
>  	case hwmon_temp_fault:
> -		if (channel == 0)
> -			return 0;
> -		return 0444;
>  	case hwmon_temp_input:
>  		return 0444;
>  	default:
