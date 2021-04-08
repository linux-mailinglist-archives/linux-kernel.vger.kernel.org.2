Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8C357E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhDHIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDHIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:30:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B6C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:30:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q10so904124pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bLnLt1IJMnpnYn973wEDhDqSaKlKmayBaQfbYqGVhRw=;
        b=wFbbzr4H2Ar+FEVgpPeNLqwIsKX7UG61OSn7q8DEv9VROH3hE/yquH+XzegXnJ2YyP
         xdLLTb9w5v3i29T6NMXC/HJL2ZUtJseFJGpkIpkdnOSv3Sh2WUtiLThNLd0v8a5HE44V
         6NNs8Vv11yid1Lm+ZxhuJdSR8URtf7O53rDpJczTBpKeObRZ9cZzDIKIKLZkJFXBsikH
         ftoNZrNLyxjmLAFnwLKVvBXArfu31RDCEXTMiwhqpIGxT+hSceb4b8U74jwgqIa5QcQs
         UxfVz7hzx9Fq042gWV1icJYdL61bfA0uhrXl16AorNm0eAL6u9IDspnXu/IcWvmLV1ux
         Hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bLnLt1IJMnpnYn973wEDhDqSaKlKmayBaQfbYqGVhRw=;
        b=GVWURwSM+CEmt89H4+9mjP74jSI1Cz94A7pYIYejvEVQVzAkkMsT3wqyxjS4y0XMQX
         5he40kfjjjJ4mWaydqip6tZq3pZ/58YWwbeSYkmwqkf/izUnGjE4RUN4udj/g/KsDXBE
         yEAVeZe6UD/gXx9H6f7m6hed9gfVCSMO8OddcVP78xCsdATjrxQAfDlKXFRM+sZSAV8r
         HPPvRytYEA99bekrRs0jOAxUtDWucldaoE7/UoxWJWfIlJjFJqkWQAivZSMr2Fr7NAKd
         FXzQIcpiX+9J7Bd2etQwOe8pGfnM/A7xbauRiFxwR5PPDw2AI4CLJF0lPdO78pK6V6PZ
         ufjA==
X-Gm-Message-State: AOAM531Et4rzs7FA8Tb5/rWibSADoaIQCb4+yKND5zvGTi7ipPvzNGTP
        wiwA4Lr2BqvyRK0fEqSSrJei9C7gtvI6kpnTnA41wg==
X-Google-Smtp-Source: ABdhPJzYw/mE3G7ZIWzSNBZcklmudNeVOBZ3n/jzdfPTPDxZY8eypMcr1oGleFtGj/YOCNyDSWyEqmjS0EhwpklcDy8=
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id
 e10-20020aa7980a0000b029020c54025de9mr6468874pfl.18.1617870632432; Thu, 08
 Apr 2021 01:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210408035435.250677-1-zhangjianhua18@huawei.com>
In-Reply-To: <20210408035435.250677-1-zhangjianhua18@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 8 Apr 2021 10:30:21 +0200
Message-ID: <CAG3jFysgEC9N1CE1UT4fAgp=ad_89cD7r0=7tD8vF9GvyXCS0A@mail.gmail.com>
Subject: Re: [PATCH -next v2] drm/bridge: lt8912b: Add header file <linux/gpio/consumer.h>
To:     Zhang Jianhua <zhangjianhua18@huawei.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        johnny.chenyi@huawei.com, heying24@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zhang,


On Thu, 8 Apr 2021 at 05:54, Zhang Jianhua <zhangjianhua18@huawei.com> wrot=
e:
>
> If CONFIG_DRM_LONTIUM_LT8912B=3Dm, the following errors will be seen whil=
e
> compiling lontium-lt8912b.c
>
> drivers/gpu/drm/bridge/lontium-lt8912b.c: In function
> =E2=80=98lt8912_hard_power_on=E2=80=99:
> drivers/gpu/drm/bridge/lontium-lt8912b.c:252:2: error: implicit
> declaration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99; did y=
ou mean
> =E2=80=98gpio_set_value_cansleep=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
>   gpiod_set_value_cansleep(lt->gp_reset, 0);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   gpio_set_value_cansleep
> drivers/gpu/drm/bridge/lontium-lt8912b.c: In function =E2=80=98lt8912_par=
se_dt=E2=80=99:
> drivers/gpu/drm/bridge/lontium-lt8912b.c:628:13: error: implicit
> declaration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did yo=
u mean
> =E2=80=98devm_gpio_request_one=E2=80=99? [-Werror=3Dimplicit-function-dec=
laration]
>   gp_reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>              ^~~~~~~~~~~~~~~~~~~~~~~
>              devm_gpio_request_one
> drivers/gpu/drm/bridge/lontium-lt8912b.c:628:51: error: =E2=80=98GPIOD_OU=
T_HIGH=E2=80=99
> undeclared (first use in this function); did you mean =E2=80=98GPIOF_INIT=
_HIGH=E2=80=99?
>   gp_reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>                                                    ^~~~~~~~~~~~~~
>                                                    GPIOF_INIT_HIGH
>
> Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
> ---
> v2:
> - add header file <linux/gpio/consumer.h> for lontium-lt8912b.c instead
>   of add config dependence for CONFIG_DRM_LONTIUM_LT8912B
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 61491615bad0..79845b3b19e1 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/gpio/consumer.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>

Add this #include in alphabetical order. With this change, feel free
to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

> --
> 2.17.1
>
