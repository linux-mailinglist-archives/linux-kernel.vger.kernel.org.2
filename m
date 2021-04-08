Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FD357FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhDHJr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:47:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F279CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:47:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k8so1032013pgf.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wx8MYiZlUE5pbxRfwsCl1OlR8aGmQOE5tCtoCPsygq4=;
        b=WeLkbj3r/iOMchz9Ce3Si5iRa44gWVC1uBW4P2AjedCLiiR5IDywCZtKbNfVGxlJOF
         WD9GPotB4FQL3zeuaFfZpnE2e2bp9hRgFNWClt/Oe6yZrOLKtTcsesFXV90rJ3tPr7KD
         nk2LC504BsusA3+aI7gJXgcCpM5gajTyNmzuj72cUolCvv+b+l52H3W4P4PAHHFg62II
         iHEV5XNS9J3bqIhnAeoFDVfqBKFcl2XdhN5PEW1GxSqCrWTbgt/8YKG8fb+8FA8JrQmi
         8b4sFrJf06fehM5AVFaAHV17MVqtGvm47q0soXCJpD68g0mghExq+rcBxv53PjTaiAVV
         OxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wx8MYiZlUE5pbxRfwsCl1OlR8aGmQOE5tCtoCPsygq4=;
        b=ZS55p/kFc7kLlcgrNr6UXvVJZP9bp6ayDF9h+rIrU7PnlNcxv277YgAfJ42m5fNRZy
         3ZO2Kz80aBeUW9CjvfTiVEq11x5OBHXzNqxTRcEWzDtXcg/rxISqPtV96oEiSFJnCM77
         8jzKlOTwh5Fo6vaIPIYrXptkH9km2s48Tkyfn+9slE7IWIx/2ivn18ZDZD6hG6Aw0vJN
         HhrA+o2/KAa/5sKtzg9Tq7oTB5O2gvfLbXKeZTCi9MpHWA3RPL0VHppaktELeSwEmwUj
         14B9Mz4nE5WdLUsxB7w75cUz+cDDaX0HscDeyguSur1edQq3JHa6xZK2jiUZTTT4QFLg
         RVGQ==
X-Gm-Message-State: AOAM53043FhHsOrtIeTsOKTSHYGcS6y86vU4keIO6Za7hbk+LXCe94MQ
        9HZ8NpgNiUEHwUmkfX1jcujSaE2URUIvHSVu5y+i8Q==
X-Google-Smtp-Source: ABdhPJz3CqwRR9ZuK3onI97NXQdgaNEArs1YyVJb+6DWcf9Ktln4/0MEWwGfWIqhbOluU6wIPlrS61cbUOdbFLDaGMo=
X-Received: by 2002:aa7:98c9:0:b029:242:18fc:562d with SMTP id
 e9-20020aa798c90000b029024218fc562dmr6369255pfm.39.1617875232450; Thu, 08 Apr
 2021 02:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210408093822.207917-1-zhangjianhua18@huawei.com>
In-Reply-To: <20210408093822.207917-1-zhangjianhua18@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 8 Apr 2021 11:47:01 +0200
Message-ID: <CAG3jFysH0Ms_7oP0npKZAv7uXs+uAoO=+FBbCYyBV6dULe3dNg@mail.gmail.com>
Subject: Re: [PATCH -next v3] drm/bridge: lt8912b: Add header file <linux/gpio/consumer.h>
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

Pushed to https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D7513ce4902=
7c8218a6fce7ec45c3289b903ba4bd


On Thu, 8 Apr 2021 at 11:38, Zhang Jianhua <zhangjianhua18@huawei.com> wrot=
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
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
> v2:
> - add header file <linux/gpio/consumer.h> for lontium-lt8912b.c instead
>   of add config dependence for CONFIG_DRM_LONTIUM_LT8912B
> v3:
> - change the #include in alphabetical order
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 61491615bad0..4f693123985b 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
> --
> 2.17.1
>
