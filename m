Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6A34E5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhC3KtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhC3Ksv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:48:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:48:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x16so15916337iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rP4kknX4xAvleYYg0u92Em0z72hot5F8BzD9RddRRUk=;
        b=EbUxrwGTbHNhFj3dhzWvOVejXKYejKx9ObBGEO2MgczgMKQnT+vXFQRfGg8vrNb/79
         KL/A0537a2GEjEYCAl7GY3oVE68vAS1j+oDWC6SotMtY9X5GCV/J4ATA4Uek1T+EnTTF
         /S+nYVBYnx+p8PzqDMOT6+sZ1DJeuObbYabHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rP4kknX4xAvleYYg0u92Em0z72hot5F8BzD9RddRRUk=;
        b=f7S3bmzeWdh3cynpCBL99tV3p+4escnUqScTDPSf31JQfUZjDCUKhy6Hfw3pEDnePs
         QW+yyABvyJyT5M7yJXRsiRoa/d9JzNnjWdreWieBar8ikNryiGuxb0E0FP55xfiz5pF4
         smej0h4VA8Uc5DegqnqvmgfSFYel+QuV7B9Jv3xHZOlJCyfG+XBW6oRZdcMe5PPZeIDc
         BlW+4jNAoGxSaDxv1ydwlaFgm7vzG3/FbUlI/+UxRpwc3pVfkB8+6zv2vH27Cy/D6KQW
         lAjk2bv25y5dxxKC6u3/Wdit282V7NDR6Jq3H3mspk34Y2PltU4tvl4EvCtpa0Z0Fb/e
         Y5jg==
X-Gm-Message-State: AOAM531g8wsshcTAFki2YfTeJpINhyGTsmoj5Q9560Enmx6+B2ra0qmJ
        LmIbZeQzQBiAazi7j59Nua8nInQRmh1PjQZEAIG7GQ==
X-Google-Smtp-Source: ABdhPJw/U5SlztC8bxQ7GW+0c8uKyz5qnR7FWLJK/549d5I/fXM+w1ZQvMlnX4P6c7fKXRSF8zGbDwvXCWFsbPHN0hA=
X-Received: by 2002:a05:6638:2bb:: with SMTP id d27mr28069519jaq.98.1617101330606;
 Tue, 30 Mar 2021 03:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210203110717.686204-1-enric.balletbo@collabora.com> <8c8309fb-babe-3ed4-d2a1-111fbab91e9f@collabora.com>
In-Reply-To: <8c8309fb-babe-3ed4-d2a1-111fbab91e9f@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 30 Mar 2021 18:48:24 +0800
Message-ID: <CAJMQK-hNwBm8r9GokjjbapyS+1MwtfL_DJda9q4xjK2Ud6SvvA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Add missing MODULE_DEVICE_TABLE()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 5:43 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 3/2/21 12:07, Enric Balletbo i Serra wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > This patch adds the missing MODULE_DEVICE_TABLE definitions on different
> > Mediatek drivers which generates correct modalias for automatic loading
> > when these drivers are compiled as an external module.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

>
> A gentle ping for someone to review this patchset :-)
>
> Thanks,
>   Enric
>
> > ---
> >
> >  drivers/gpu/drm/mediatek/mtk_cec.c      | 2 ++
> >  drivers/gpu/drm/mediatek/mtk_dpi.c      | 1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 1 +
> >  drivers/gpu/drm/mediatek/mtk_dsi.c      | 1 +
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c     | 1 +
> >  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 1 +
> >  6 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> > index cb29b649fcdb..3b86e626e459 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -247,6 +248,7 @@ static const struct of_device_id mtk_cec_of_ids[] = {
> >       { .compatible = "mediatek,mt8173-cec", },
> >       {}
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
> >
> >  struct platform_driver mtk_cec_driver = {
> >       .probe = mtk_cec_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 52f11a63a330..2680370652fd 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -822,6 +822,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
> >       },
> >       { },
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
> >
> >  struct platform_driver mtk_dpi_driver = {
> >       .probe = mtk_dpi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 5f49a809689b..e4645c8ae1c0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -470,6 +470,7 @@ static const struct of_device_id mtk_drm_of_ids[] = {
> >         .data = &mt8183_mmsys_driver_data},
> >       { }
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> >
> >  static int mtk_drm_probe(struct platform_device *pdev)
> >  {
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 0527480c07be..c71ce62d1bec 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1193,6 +1193,7 @@ static const struct of_device_id mtk_dsi_of_match[] = {
> >         .data = &mt8183_dsi_driver_data },
> >       { },
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
> >
> >  struct platform_driver mtk_dsi_driver = {
> >       .probe = mtk_dsi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > index 8ee55f9e2954..b4696a9d73f7 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -1818,6 +1818,7 @@ static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
> >       },
> >       {}
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_of_ids);
> >
> >  static struct platform_driver mtk_hdmi_driver = {
> >       .probe = mtk_drm_hdmi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> > index 62dbad5675bb..6207eac88550 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> > @@ -335,6 +335,7 @@ static const struct of_device_id mtk_hdmi_ddc_match[] = {
> >       { .compatible = "mediatek,mt8173-hdmi-ddc", },
> >       {},
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
> >
> >  struct platform_driver mtk_hdmi_ddc_driver = {
> >       .probe = mtk_hdmi_ddc_probe,
> >
