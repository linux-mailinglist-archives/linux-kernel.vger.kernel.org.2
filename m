Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2880E39CF2F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFFMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:53:33 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34429 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFFMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:53:28 -0400
Received: by mail-oi1-f178.google.com with SMTP id u11so15144677oiv.1;
        Sun, 06 Jun 2021 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzPmmTSd9f81mgE13fCWqQLxiSdjVDOHgMzyzpM78iE=;
        b=OTPnOy1V51RHfNRi0tHuaj2w4hLWmglGkN+9hLO0ycblyTTXD7PjubrpRm6uZaMsQ1
         EHLHlxU3SLaxgTVvWdtuj3uoo8b5pJzTPajfW3j8TkAe4drVmvjyGHAdUy0EhulN81i3
         rpZBLyzyixWzRUcfXQwBRFriSgE+hhiXyGJOmy2wyPTvhnaBeIb1OWJ6xlvyn0WPmUDt
         R2iTe8ht8etm1pPzuV4dztHAMqdccbCsMJdNUaTC8xN+JD/TLxudJfmZqSrvAw+FDPcL
         hYN7BLFrINnpJGunZz7d2K6+DrPAuor8Nfxn6hrqNQFUR2FjXaYX0PRNK01MsSAY13cu
         DXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FzPmmTSd9f81mgE13fCWqQLxiSdjVDOHgMzyzpM78iE=;
        b=FOU+/AcLLJBuz3x92aRiimo32l7f+Wn6M4o5PCtwAmAa4aZ9AvZJu6hVCS0z7taTbh
         /iMnFDkmGit+cpo/ei5YpcWr0gMSRXvCZhuP4eDSDcP11Wyo5LS2+wA0rA/epjH41DrD
         dyaxCwFFUs8cYJkh2FrELPfI7hnn9HJnOMIItrloNGXT+1QaP+oXx4VeKN6XTtYJ4jxG
         b/jpETC4Vih+gvCeD97QsAfpjiqlJtKeJyV6WfZLWDOJPwuymLJVFq9znUxFlCrgMQY1
         Hu6A4XZJVddG59OkvP7pZXEe3kinoAZqMJOJFPQjENHEKhIzC7Eva1dx5+hSaUzPcO46
         O0lA==
X-Gm-Message-State: AOAM531Lj86Ts3MRE3GPxK8Rs62rDCdKmA1Mfhg/9vBk1TTHh81OsPn0
        lEMCH/ppnHJSFwxwIIDhazrtF7Kzphw=
X-Google-Smtp-Source: ABdhPJwUzw4EHVBwhQtj5t3UEbv9VfevSWK0ECWfk46pyQv+H8J6s4UYGM/WT5O3XCyWg33tdyQx3g==
X-Received: by 2002:a05:6808:1396:: with SMTP id c22mr15943162oiw.85.1622983813900;
        Sun, 06 Jun 2021 05:50:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i133sm1623068oia.2.2021.06.06.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:50:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Jun 2021 05:50:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus_core) Check adapter PEC support
Message-ID: <20210606125012.GA2887349@roeck-us.net>
References: <20210605052700.541455-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605052700.541455-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 07:27:02AM +0200, Paul Menzel wrote:
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

Applied.

Thanks,
Guenter

> ---
> v2: Do not revert check introduced by commit e5befc02 (hwmon: (pmbus)
>     Add a PMBUS_NO_CAPABILITY platform data flag).
> 
>  drivers/hwmon/pmbus/pmbus_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index bbd745178147..2fd0fec59d4f 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2214,11 +2214,15 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  		data->has_status_word = true;
>  	}
>  
> -	/* Enable PEC if the controller supports it */
> +	/* Enable PEC if the controller and bus supports it */
>  	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
>  		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> -		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> -			client->flags |= I2C_CLIENT_PEC;
> +		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
> +			if (i2c_check_functionality(client->adapter,
> +						I2C_FUNC_SMBUS_PEC)) {
> +				client->flags |= I2C_CLIENT_PEC;
> +			}
> +		}
>  	}
>  
>  	/*
