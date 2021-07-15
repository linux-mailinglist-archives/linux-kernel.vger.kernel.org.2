Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514663C9D82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhGOLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbhGOLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:12:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB5C06175F;
        Thu, 15 Jul 2021 04:09:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so5762000oti.2;
        Thu, 15 Jul 2021 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnIvSXzuiLKWuvgulqfarspmLG2dOzwb7htWyTzwsjw=;
        b=jZSvmaYSy8ADTgcCb9b7ny+VGlsNNLLNOYJdU7McebyVX4mq0pGAcstpYcMq1Aiv6S
         XOo3xy1FWet7MXd7e7bhh9ULV6oDNaPZwU83/HY/YN+avkBCc7WRn8rrw01zsWV94kqD
         zveDrhVhYXZNw9+xQg2SBfo7OMbtziipz+BPTRr2nVTwTX5Zbj3LNmo5gqPZla4YgjUr
         CMVnzDdH9YVyJCAxYWCz6i0n7jvRINXJv0bLBQO52VA4L5QduTy2cR8drOamqk/LOftw
         kysUkWgyiG6dY9FlEfnonTf57JurQjQ+0MQUH4y/eduUeozIhN6rWYTFT2mAUx+bFtCa
         eVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnIvSXzuiLKWuvgulqfarspmLG2dOzwb7htWyTzwsjw=;
        b=KwRU5pI0eHmpWdNwfAceggBerHHJ9bFpPowu0ElVx1W1nxvvBvJ9zwsey8z71fo3Ld
         i/jN6Q0lyx9r+zbZhEY52/dUaLpFt+xxrJjK/3y2hYUyFP5A0YOUZZQ+VQKojSAPnXuS
         WZK4RHwotDPxvyIeZpUMQQNwIIjiXtjpEfD1sG0IiJQq/bFwmlQoDREWMisrTPpYar50
         XOLgewSCbLJmd2WhVM1JU2YE4Yjt/gcq7o340q4JsTfzYGlKYp5haFJXeIP6c4588ppa
         fQ0tAULFaQvhQRAN/1EN7QaprqTCrKPLa5CqAzBSicBMfp/i3JgHUopckO16h2RtZmT8
         nw1g==
X-Gm-Message-State: AOAM531JvcsbwM0E7xji2ylkmg3QglrtLq+TwTswEdu7FtAJgtW3zBn7
        l53ci6DSF0yW5uceJL+v1fvBEyYXfNEwlkB7wPY=
X-Google-Smtp-Source: ABdhPJyE6O2CsuPYvTE0fEvIRod8YkMOcqSCGJb0RhRrpq/XyumDEFhAFhjuy8zGn19Bma0gQJuRs9BuxAPgAU8c3Mw=
X-Received: by 2002:a05:6830:19cd:: with SMTP id p13mr2307456otp.362.1626347395013;
 Thu, 15 Jul 2021 04:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210624105517.3886963-1-hsinyi@chromium.org> <20210624105517.3886963-2-hsinyi@chromium.org>
In-Reply-To: <20210624105517.3886963-2-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 15 Jul 2021 13:09:43 +0200
Message-ID: <CAFqH_51zDMC6N-1DBiSfARTM-SG0SH9VAXOX=G1W6yHJaVBL3A@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 2/3] drm/mediatek: init panel orientation property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 24 de juny
2021 a les 12:55:
>
> Init panel orientation property after connector is initialized. Let the
> panel driver decides the orientation value later.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

As together with the other two patches works and I don't see any
problem on the Lenovo IdeaPad Duet, and the panel has the proper
orientation


> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ae403c67cbd92..9da1fd6491319 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -964,6 +964,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>                 ret = PTR_ERR(dsi->connector);
>                 goto err_cleanup_encoder;
>         }
> +
> +       ret = drm_connector_init_panel_orientation_property(dsi->connector);
> +       if (ret) {
> +               DRM_ERROR("Unable to init panel orientation\n");
> +               goto err_cleanup_encoder;
> +       }
> +
>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
>         return 0;
> --
> 2.32.0.288.g62a8d224e6-goog
>
