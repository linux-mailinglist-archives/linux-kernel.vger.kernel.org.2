Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE185399F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:54:31 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41633 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:54:30 -0400
Received: by mail-qk1-f174.google.com with SMTP id c124so5424847qkd.8;
        Thu, 03 Jun 2021 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VhTPRv1m3MXWutv7NtxxxaGMbYU/PIOi1ihYHRt+TU=;
        b=beDTfz77A2PJ7ZfyZZuLrMwX/o/EYeMgsXbJT2/xEgX0m3Qu/sJCxyqoOFxPjA9Qft
         F1PDS59GwizYtmbqhwivT5tTDL4NFTgaylmvaoJwf13Hek1vu1r0+t8qMdqlfEuLP4GN
         9/R4UDoythMlE198kcditRLcKJ6Iak9eE2fqYCpRwn6453aX/HGO4oFev7U3YlZ+OGEw
         aPCfb/S4yrhJf3ge+3N1+m9ZRW1Mk4lQmHIw1P06hKNJriCDPjnUWXIWMc/d3HMRoK0L
         Y8p7rJuLH1ofmjuQkLxM5Jx4RgvZfrohBu9scFaW6uupwmhqLdfrYg/BWDYXli86HPhQ
         orzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1VhTPRv1m3MXWutv7NtxxxaGMbYU/PIOi1ihYHRt+TU=;
        b=kygo0Xispso2vx+NWrKlv3IwtJdMS11paj6t+Dko6ZvIyLToWehMPwu/Bug3t5gCUU
         Zj8ZYjSwH9oMW0SBjACBhmU1C5mZ7GR/AW6QxlD1vmqFmAoOX82nR4bHrNBZoBwrCsHP
         pMTtf2DNMKKIyGKxX3NnMR8KJAYoR8CqNItgLC85DxbitNTcZjHQXY28OiBrZdc+JEPZ
         xJto1yRBQX+Yiv0hga3eKouZImPpkYvhTcoN9kDuhLJeU400GN0LA4h58bmk/RGQ+K1L
         k3InbFjchEnRySq5dZOIye/eBp5E4CwVQK0vCJ98F9Rf594WuBpkaXr7ZbejlEfIE01v
         G7Vg==
X-Gm-Message-State: AOAM532UA6YTN+EFL7FmjfQ+J10X8oNyb5ywHN3FYoaSFShLz+GTeaoK
        qIUeaA0Js9beLfNFoBMAh6b9EXVwGAU=
X-Google-Smtp-Source: ABdhPJyW5ma9LYAngWW5bFrP5ckO5i7BStX+ZfbEg250NneM13IAS0XUEScdtBK/KEGoroWfLzy/7w==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr31836084qki.281.1622717489186;
        Thu, 03 Jun 2021 03:51:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2sm1682243qkc.111.2021.06.03.03.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:51:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Jun 2021 03:51:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Riwen Lu <luriwen@kylinos.cn>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Chen <chenxin@kylinos.cn>
Subject: Re: [PATCH v2] hwmon: (scpi-hwmon) shows the negative temperature
 properly
Message-ID: <20210603105127.GB644104@roeck-us.net>
References: <20210603083845.569751-1-luriwen@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603083845.569751-1-luriwen@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 04:38:45PM +0800, Riwen Lu wrote:
> The scpi hwmon shows the sub-zero temperature in an unsigned integer,
> which would confuse the users when the machine works in low temperature
> environment. This shows the sub-zero temperature in an signed value and
> users can get it properly from sensors.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Tested-by: Xin Chen <chenxin@kylinos.cn>

Please ask Xin Chen to send a separate Tested-by: tag.

> 
> ---
> Changes since v1:
> - Add judgment for sensor->info.class. If it is TEMPERATURE situation,
>   return the sensor value as a signed value, otherwise return it as a
>   unsigned value.
> ---
>  drivers/hwmon/scpi-hwmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 25aac40f2764..45a7e319143d 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -99,7 +99,10 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
>  
>  	scpi_scale_reading(&value, sensor);
>  
> -	return sprintf(buf, "%llu\n", value);
> +	if (sensor->info.class == TEMPERATURE)
> +		return sprintf(buf, "%lld\n", value);

'value' is u64, so it needs a typecast to s64.

Also, please add a comment ahead of the if statement explaining that temperature
sensor values are treated as signed values based on observation even though that
is not explicitly specified, and because an unsigned u64 temperature does not
really make practical sense.

> +	else

else after return is not needed

Thanks,
Guenter

> +		return sprintf(buf, "%llu\n", value);
>  }
>  
>  static ssize_t
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
