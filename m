Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E2343CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCVJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:37:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:37:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v23so6235215ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwUM0uQxUqhm1YVIReKtCkfGLNGPmzKidaPgCqb8BBE=;
        b=gXbh9UMfvUZZiaSKPj0kATlaIUUP7yHi/S4AuIprB1LM1sL3NBD2ibBMw5jhAHgzf9
         Ql66huAzH35AmvpUP3mfQgwNfNL4TYfMotCgXSF/Uk6vSmPfRCWofSCmilHmrg/ie2nw
         GmoBoItlOUdNUdEPYcCY1V1z+lYshyYviRoX6H21LLNR/KFNbds2/uFFKQHdWSrZiRD2
         X78CC9qcZ03bvcUXRclDKKICbYzm4Ey36b7kzC4uf8qqmpmec0/sd3I1yWCrQlmQ47LU
         ca/0OgJgC1owGu3qKZtNtgf1p+Dss+gCs0PkDbm1m6gfFT3auF4SjXPv3rJy6Za2Xgbv
         wQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwUM0uQxUqhm1YVIReKtCkfGLNGPmzKidaPgCqb8BBE=;
        b=d7J5+MlJv2Oq/ldm52FrapuZs0AKv89FHEe+6xGLRoijz7l4MW9NmU6+YJrC25znx9
         bpJw/9Qc5AAAaQQdiNy/x3SuE0g7WmQhlQpwxeDaVyYYoKD6dYK1IDhOha4s2oiHkeXm
         Gq7e2vtwdspHqiv6LJMp51gpmkE+vnno/dT6MUDmi99GdHjbs3bGSEAKJcdFMnICnbKi
         RHW/CcSStDS7YOQOr3acXtW/nnPksJYFd61FRF4Cy4qlbyFvpxzdmWkxw2RrQpCH6JDI
         uTC4W7iq+HigunfXIZn6lO2P9upc3eP1g1FSuFET42sW/96QLrBp/Auzbly8qzUFru23
         B6Xw==
X-Gm-Message-State: AOAM531wMIqWhfttHjmDUPzMe3buVhbOSNg7NYuQuw0PCuq6ZtTmTFOK
        WlT8YFibudff85XYIPr7lfAXqXMLSJS6Jpej1KRo0w==
X-Google-Smtp-Source: ABdhPJwsG4deEbsCFps8vjx+pZ/Q1xmfX79FHPiSz5iek499vlHWh/Zc0A69Qb6RKbutmQfpNMo+NtJTRMLS0jJut+k=
X-Received: by 2002:a17:902:7d8d:b029:e6:4061:b767 with SMTP id
 a13-20020a1709027d8db02900e64061b767mr26216108plm.32.1616405827745; Mon, 22
 Mar 2021 02:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <ff689dae07ba1440b96f4804468d9c4203d22d68.1616135353.git.xji@analogixsemi.com>
In-Reply-To: <ff689dae07ba1440b96f4804468d9c4203d22d68.1616135353.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 22 Mar 2021 10:36:56 +0100
Message-ID: <CAG3jFysRwmx5mN5kHh-L0N2Az_csitr0ckovxJvCAFsfo96ZXA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/bridge: anx7625: fix not correct return value
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

This patch looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Mar 2021 at 07:33, Xin Ji <xji@analogixsemi.com> wrote:
>
> At some time, the original code may return non zero value, force return 0
> if operation finished.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc05982f82..04536cc7afe7 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -189,10 +189,10 @@ static int wait_aux_op_finish(struct anx7625_data *ctx)
>                                AP_AUX_CTRL_STATUS);
>         if (val < 0 || (val & 0x0F)) {
>                 DRM_DEV_ERROR(dev, "aux status %02x\n", val);
> -               val = -EIO;
> +               return -EIO;
>         }
>
> -       return val;
> +       return 0;
>  }
>
>  static int anx7625_video_mute_control(struct anx7625_data *ctx,
> --
> 2.25.1
>
