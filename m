Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AF388F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhESNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353729AbhESNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621431779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/koiwQpFLFHokjA+K7iK/spImtdAStf6crslcUloYI=;
        b=bteR9tMnvuFnLv6uiRVomJ621dEwn7xZekoQDryQa79sHWpHL+2v4NqjymXgVs5zrRLxmI
        BLd5b22Uch2dgkKxHvAvhILhmQgKU3c30l5Jaw+cqG719rDMhfDRhB+GbzfuR74xcvMDha
        h+bqttrGClEUpER/DOrH8mixG0Rjgcg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-bOiOgmFCNRyq0zI2jOGd-A-1; Wed, 19 May 2021 09:42:58 -0400
X-MC-Unique: bOiOgmFCNRyq0zI2jOGd-A-1
Received: by mail-ed1-f72.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so7722343edu.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V/koiwQpFLFHokjA+K7iK/spImtdAStf6crslcUloYI=;
        b=P/KXls/vw68FmvLEImQ2SixAvBwE5MJZR3D1iNbocZSwYFgOrUIt4ltdPx7Gbvx5da
         mxDh+Yze0HJXj+F6DEgpXkj1dl/fas/kYC7zGRqmMlsTQ0v9oqMDiMENmjKW4ljGtpnZ
         7GekpZtV/0Rji+S5BM2he4oPH0NWerKCOoDrHSkjN6nAG8ei5Jo29MEd+Lsi3P2QVD5V
         a23vpBCAqNM5+tFqTCke2G6Aujn5L9sE7IY27x4G7j70XSyCH+efTXnUISNu7LBwZImb
         Ue1noqus/5CU8vpXsHeo1w+/CrhLz4PK+x1J00Qf6LL5ZS6ealMdLNHeVt6hWMSg9b41
         itvw==
X-Gm-Message-State: AOAM5319/+0Ehlqr6PaCnZop369a2jlTufzes4ntNQvkoFONOOQdk5Ko
        ycNei1IaxB6OgGtPxzPqG2Plwt1xumDtplXY0jXkDFcirZPM1hLwA2lWjtbZfk0fPbfz+5nkfpA
        ryD/qNWdGuE4dUKhOQhB/6k7B
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr11933613ejy.395.1621431777039;
        Wed, 19 May 2021 06:42:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwngxv7ha48B0D3zKb5DLyEfclmLLSjFO1geM/YX/lAlADbmOCO/lLt/CeJGo1/16Yx2OQ+rg==
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr11933594ejy.395.1621431776892;
        Wed, 19 May 2021 06:42:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y6sm2314883eju.56.2021.05.19.06.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:42:56 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] platform/x86: samsung-laptop: use octal numbers
 for rwx file permissions
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <20210517100746.29663-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4d9b5c1c-6bdd-6380-41d3-3690d71a6298@redhat.com>
Date:   Wed, 19 May 2021 15:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517100746.29663-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/17/21 12:07 PM, Wolfram Sang wrote:
> Andy asked me to do it before working further on the code.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> 
> change since v2: added Andy's tag
> 
>  drivers/platform/x86/samsung-laptop.c | 35 +++++++++++----------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index d5cec6e35bb8..763d97cbbe53 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -388,7 +388,7 @@ MODULE_PARM_DESC(force,
>  		"Disable the DMI check and forces the driver to be loaded");
>  
>  static bool debug;
> -module_param(debug, bool, S_IRUGO | S_IWUSR);
> +module_param(debug, bool, 0644);
>  MODULE_PARM_DESC(debug, "Debug enabled or not");
>  
>  static int sabi_command(struct samsung_laptop *samsung, u16 command,
> @@ -705,7 +705,7 @@ static ssize_t set_performance_level(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(performance_level, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(performance_level, 0644,
>  		   get_performance_level, set_performance_level);
>  
>  static int read_battery_life_extender(struct samsung_laptop *samsung)
> @@ -774,7 +774,7 @@ static ssize_t set_battery_life_extender(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(battery_life_extender, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(battery_life_extender, 0644,
>  		   get_battery_life_extender, set_battery_life_extender);
>  
>  static int read_usb_charge(struct samsung_laptop *samsung)
> @@ -843,7 +843,7 @@ static ssize_t set_usb_charge(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(usb_charge, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(usb_charge, 0644,
>  		   get_usb_charge, set_usb_charge);
>  
>  static int read_lid_handling(struct samsung_laptop *samsung)
> @@ -908,7 +908,7 @@ static ssize_t set_lid_handling(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(lid_handling, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(lid_handling, 0644,
>  		   get_lid_handling, set_lid_handling);
>  
>  static struct attribute *platform_attributes[] = {
> @@ -1291,24 +1291,17 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
>  	samsung->debug.sdiag_wrapper.data = samsung->sdiag;
>  	samsung->debug.sdiag_wrapper.size = strlen(samsung->sdiag);
>  
> -	debugfs_create_u16("command", S_IRUGO | S_IWUSR, root,
> -			   &samsung->debug.command);
> -	debugfs_create_u32("d0", S_IRUGO | S_IWUSR, root,
> -			   &samsung->debug.data.d0);
> -	debugfs_create_u32("d1", S_IRUGO | S_IWUSR, root,
> -			   &samsung->debug.data.d1);
> -	debugfs_create_u16("d2", S_IRUGO | S_IWUSR, root,
> -			   &samsung->debug.data.d2);
> -	debugfs_create_u8("d3", S_IRUGO | S_IWUSR, root,
> -			  &samsung->debug.data.d3);
> -	debugfs_create_blob("data", S_IRUGO | S_IWUSR, root,
> -			    &samsung->debug.data_wrapper);
> -	debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR, root,
> +	debugfs_create_u16("command", 0644, root, &samsung->debug.command);
> +	debugfs_create_u32("d0", 0644, root, &samsung->debug.data.d0);
> +	debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
> +	debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
> +	debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
> +	debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
> +	debugfs_create_blob("f0000_segment", 0600, root,
>  			    &samsung->debug.f0000_wrapper);
> -	debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
> +	debugfs_create_file("call", S_IFREG | 0444, root, samsung,
>  			    &samsung_laptop_call_fops);
> -	debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR, root,
> -			    &samsung->debug.sdiag_wrapper);
> +	debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
>  }
>  
>  static void samsung_sabi_exit(struct samsung_laptop *samsung)
> 

