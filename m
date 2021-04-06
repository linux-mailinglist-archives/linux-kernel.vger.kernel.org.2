Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0C3550B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbhDFKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbhDFKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:21:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:21:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t23so4435027pjy.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPJH6QirhbWWBe6IX++gDDlQT8BPbNxs95bEGDNNMp4=;
        b=PjpjxAu0/8swyFenE28pAjGbjDKj0YbH2Pn+EsV2b6AVqCvfCzf53IFD4VTNiiZ9jW
         rl6pZg2Pj3bLVP79SMS/sVVz/6EP4/zLT665qpgba14Y0FwD8awyS/3lBkR6G+/0GC1g
         uRBcM6r9jjLQ4TXaBEA8tG4FmrFGE9w4ngu5jqnN2gbCUDQGa8ZEUV1RiI/mAhqGPxVi
         2TEj6N/u4V1dqR5FvvMZp9/qxvhU9XtIF4/cd8I/CUyrT/BElFTXNgTf/rL+QSq37CiG
         4unG45mvI+LkVfSBztQqL6h2BMlEa4kFCcIYa1Y3gXDTmtUMOPGN4DSLXCcH8fGuazpW
         4GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPJH6QirhbWWBe6IX++gDDlQT8BPbNxs95bEGDNNMp4=;
        b=oBGlp5CbeUKfBywRLzHoIdIcLSGQnaxcjSKmRS8bdoLv6g+CQKtObST5WZl2iPs2ia
         y/7C7RPb7xWjQht9Fp8cB/1pTS6/vZ86wJUuf1TnxRtAw6q2HCm+lS7Ps6tdPe3b2X8S
         Z2BiE4am8dBZwhmi3CuByR3TiLRt1icY6IgI1VgwDIRLVKht6nLz8T3uJBj0LE2P1Knn
         cVOacBTh/iuRZiaTmvRCpDYfXHmQ/BjUaScsxZ+miQ+weZNWo0ZT7B/xUpASNvGQWVVo
         ezKhfgoD8popvjFIi0Gh/IzTscv/UuhZcNIhjNNb5U3xNKf+MmHZgsWpDJe3Pevs9A9f
         tO9w==
X-Gm-Message-State: AOAM532Eob3zAubvTCyK1UM3eM5Gycw6rLUB8Fw2dk+JHLJV0NVeBFd/
        l8b87KkE7nXpxrxbTkj8nsXBAbTzmf80xxtLvLkuGw==
X-Google-Smtp-Source: ABdhPJzRICRTLgbK/lqYyX8NKzVUpbzEPj3oEp2uFeuX9dgzSJaEn18ktVH53cpHvxXFnFDtlp++/W/tyadb7IWWqKU=
X-Received: by 2002:a17:902:7e8b:b029:e9:2ba0:20a2 with SMTP id
 z11-20020a1709027e8bb02900e92ba020a2mr5356970pla.69.1617704502090; Tue, 06
 Apr 2021 03:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210406090733.169989-1-zhangjianhua18@huawei.com>
In-Reply-To: <20210406090733.169989-1-zhangjianhua18@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 6 Apr 2021 12:21:31 +0200
Message-ID: <CAG3jFyvC6ozPxQ=TPdPgLAugKky5AhOZGJSiw0Dc3Kn5Pba0cA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select GPIOLIB
To:     Zhang Jianhua <zhangjianhua18@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
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

Hey Zhang

On Tue, 6 Apr 2021 at 11:07, Zhang Jianhua <zhangjianhua18@huawei.com> wrot=
e:
>
> If CONFIG_DRM_LONTIUM_LT8912B=3Dy, the following errors will be seen whil=
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
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index dba62f92d051..caa9658ec933 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -67,6 +67,7 @@ config DRM_LONTIUM_LT8912B
>         select DRM_PANEL_BRIDGE
>         select DRM_KMS_HELPER
>         select REGMAP_I2C
> +       select GPIOLIB

This appears like the right fix for this problem. However, a number of
drm/bridge drivers seem to call both gpio_set_value_cansleep() and
devm_gpiod_get_optional() without having the GPIOLIB kconfig option
selected so this can't be a new issue. Maybe some more investigation
is in order.
