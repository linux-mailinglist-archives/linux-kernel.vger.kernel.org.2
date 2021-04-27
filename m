Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4436C7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhD0Otv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhD0Ott (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:49:49 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD562C061574;
        Tue, 27 Apr 2021 07:49:06 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso6296805oos.6;
        Tue, 27 Apr 2021 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vqmkSRAKVyilaqPijFt/uwQzA200kGE2vIXdVA9pZrA=;
        b=IzZp7HJYy3Sy8EvYw3JRMKcEUnBuFBsu4wjcAwHcGOmkMRSz6b70fSUbRu2+w14z/M
         KSsmCsX/5wLZ80L6BJwVrc8NGlOSRTFzHi68m1nzwpoYTjoQHwv11BqGBXlD4Z2sEuED
         wn+HHHKMYkl9k2Zo6fZKPo1l/VAIW5Cspu2kzGMClpfsTUhizpNmXB6tGvlaL5sIHn9z
         pernJK3mcAfJ0t49BDfdqGvbzFuUTTXoo7T0alhzUWgmwAhShSzMGktat4j73Zc2pSAh
         2VCQRAiIYll+GMWbc9n/vW0o+0Z6zYRgAl7s6n2v/dN6gF7pbaDL2GONnAnkKVU4tLtW
         HlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vqmkSRAKVyilaqPijFt/uwQzA200kGE2vIXdVA9pZrA=;
        b=mE9phJLVWm2nF5NVzNIwFUVEfJgUZUj6YxUZ+K0RBjOb/qzBUWMQ8rlVu8EYSl2tcs
         H0FL/GCkZhaLy31gVBA0pFJdd1kJ+vfBEjrzSgMpQ4zdoDPkEZWgLERojltKlbqkVeuB
         78R3A3D1WuRNizGQpP7OYKO+iO6pr4q1FzO712dx85S9hgHF8mEF3/Tm/B2z7+O1E3Dh
         ujUPJTAVOldCh65ee6Rf2DPyiMG/xLOFwr6jSsuUHuN4a0mNioketEn0u6EkVqJKwHit
         bZB/BJd59qofvdkSB8Udz42cqewp+lM5HUNodyiLWcHZxi4Zb1sr0K8M5zpc2Pu7T1Z5
         6fyA==
X-Gm-Message-State: AOAM533RohlW34gUW5B89gqQ6nro+JrgaWo6+J1iknUeZ89eKj/NPf68
        HFs0cnBkJLuE3+XWmQwOxqc=
X-Google-Smtp-Source: ABdhPJxMh1CdJxG9kkyIIsS1phVzUFgDeIKVaXOduRYdh0ozxWib+Dd8VpMtrHODLpQ+OZurf/tVIw==
X-Received: by 2002:a05:6820:455:: with SMTP id p21mr18181712oou.56.1619534946162;
        Tue, 27 Apr 2021 07:49:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e30sm667094oow.11.2021.04.27.07.49.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 07:49:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Apr 2021 07:49:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] hwmon: Remove unneeded semicolons
Message-ID: <20210427144904.GB202505@roeck-us.net>
References: <20210427044219.7799-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427044219.7799-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 27, 2021 at 12:42:19PM +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/hwmon/corsair-psu.c:379:2-3: Unneeded semicolon
> 
> Remove unneeded semicolons.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks a lot for your patch; applied.

In the future, please add the affected driver to the subject line, as in

hwmon: (corsair-psu) ...

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 3a5807e4a2ef..02298b86b57b 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -355,7 +355,7 @@ static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairpsu_data *p
>  		return 0444;
>  	default:
>  		return 0;
> -	};
> +	}
>  }
>  
>  static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_data *priv, u32 attr,
> @@ -376,7 +376,7 @@ static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_data *priv
>  		break;
>  	default:
>  		break;
> -	};
> +	}
>  
>  	return res;
>  }
> -- 
> 2.25.1
> 
