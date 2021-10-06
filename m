Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEF42403D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhJFOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbhJFOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:40:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282CC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:38:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so4642816pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=toLyWHJoJkqQuDAZVFULHYbRpC2a7rc7kGdAA2+Ap/s=;
        b=mVPihte4nNC4HRWd0T8Meut0fAjfGNtNA7RausOda4tccFPymGrBrrbTD3CVEXT+/v
         0W4rLwA3e+2oyjIicx2PNnb6OFI0hCeMzhmb7Mh4SvkLltLrR19eCPHkjxM7QsHGrrgp
         X/LWbHc15suenyx/NWkH5SKkPkOTvEIQdk61eZyxoHlW+H7ARUa6AsGEdl3NxHSv+kc+
         NgHzIPG00DIqFpkcdRlj3fGqPm/sNwF2vbtx+n9HpGXGpgwl1YCk87S7Yp1RibMvvv0/
         W2zT3lQNYK8xIBAb4zzTXcvKho/RqHy5BduZs1jUg+9wn+fGuyeU5GmNgOfS22LXRZ2+
         4IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=toLyWHJoJkqQuDAZVFULHYbRpC2a7rc7kGdAA2+Ap/s=;
        b=02FGdvw88FV4otVjXLQ4xWyIxLfAEwfsAZh5vxnrFOOH59FzQ0XsHEA7v5Z48xhNr1
         bAC/KdLitE1GHh1dERn5a4Wsz60xnyTdx9YqomWBZ2bH1gj9IhAg/vJCOs8xmRM2Xe+Z
         6STMgJS1PXVSIXCJXlhoH61wdW7jQYPc3iKOvSqIm3K89BTBNUI/s6gANrMMFuRE0nPC
         YiZAWRQL7At58tFrAGUvV5/GM323uVsQDNn+ZmlbO3n+m2yr0IwLuGGaOovn/rrHCF8J
         A9Yhz+9MOCjJQMybn7HogJNrrttw2kk/j3i+g0qKG61fbk4wN6WOd/YNp3YNcLhsOv00
         tdqQ==
X-Gm-Message-State: AOAM530MmqNEi2cvuqJDTk3MTSAA3VURnXESJe8YhkOEHHjZdzeLU8yx
        XLGTmoGJQjfDxyiNx1X9cCmIauDCP25FwN8zSbZi3g==
X-Google-Smtp-Source: ABdhPJx8mP/OwNbvhWWP4VGkIO5MMyQ5lT9Ik+rPv2z3iR4KzszFq2vst4ng5UxZBSxFiBEyYWOnoN0tfDi5SmlYqOw=
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr11553703pjb.232.1633531088484;
 Wed, 06 Oct 2021 07:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632828477.git.agx@sigxcpu.org> <0c214b69fba08f40372b2add044892fcb0ed9c35.1632828477.git.agx@sigxcpu.org>
In-Reply-To: <0c214b69fba08f40372b2add044892fcb0ed9c35.1632828477.git.agx@sigxcpu.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 Oct 2021 16:37:57 +0200
Message-ID: <CAG3jFyteqcPNZqrFsggCrnpDfsGGQvibfHBezW+1Hcf3-z91QQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drm: mxsfb: Print failed bus format in hex
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 14:16, Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> media-bus-formats.h has them in hexadecimal as well so matching with
> that file saves one conversion when debugging.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mx=
sfb_kms.c
> index af6c620adf6e..d6abd2077114 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -89,7 +89,7 @@ static void mxsfb_set_formats(struct mxsfb_drm_private =
*mxsfb,
>                 ctrl |=3D CTRL_BUS_WIDTH_24;
>                 break;
>         default:
> -               dev_err(drm->dev, "Unknown media bus format %d\n", bus_fo=
rmat);
> +               dev_err(drm->dev, "Unknown media bus format 0x%x\n", bus_=
format);
>                 break;
>         }

Reviewed-by: Robert Foss <robert.foss@linaro.org>
