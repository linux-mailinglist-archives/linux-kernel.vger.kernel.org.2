Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4145834FFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhCaLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234377AbhCaLpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:45:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146AD6199A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617191135;
        bh=cDe4OjB/cbS5HTDVYg7h362Cs5BammVyqKu/0uQ+P0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mAEcUxi/xVimrj34vKUlkJ3sjV4d9uFeZs6mqnlgjWKUrPwthX1uuv76oSEVgueBm
         LwjNPYS89rUv3i6mriw8OqOXHj27wNIxPky4orockzFmdDPtpzDvgBufSaTMCvw9AQ
         7of0JfiUi7MRxhv9EmJ16/UfvbsS2fPs71WJfRoVI99f7R1UIIy0WJJyV1lB1tunw/
         lYRt0uvUEUXr75VAWHS5QlZNTICVNgXvwW69auH9ofwzmKyHM84vs1IbchOA/X4oSK
         9ZVmHSvsX/2zg8KfSHnkEp9K1B2ZS6VvvagBw31h0EHjH+if9LLtW61XeGFJ3KHgRi
         SO4DqXSEcnlKw==
Received: by mail-ej1-f52.google.com with SMTP id kt15so29557177ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:45:34 -0700 (PDT)
X-Gm-Message-State: AOAM533r7qgPfooAcsneRZN5pUCR5Yo9jHGt0rJoiTSptGHs9Z1w0tLM
        YJ8FOSS+mrvYpIq/uUo7o1pbD9DWzinQlx9C3g==
X-Google-Smtp-Source: ABdhPJxeQ0vEWM2/DbBY7gb7TVueFOpb1LFucBbuIOFcN1gdvrRTfseG6I5VwDo3lUEIJVM37SyMy5PkEVwJAuvfn5s=
X-Received: by 2002:a17:907:629c:: with SMTP id nd28mr3099988ejc.267.1617191133354;
 Wed, 31 Mar 2021 04:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210203110717.686204-1-enric.balletbo@collabora.com> <8c8309fb-babe-3ed4-d2a1-111fbab91e9f@collabora.com>
In-Reply-To: <8c8309fb-babe-3ed4-d2a1-111fbab91e9f@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 31 Mar 2021 19:45:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9O2v10eac9KCDqBNCwRymX_1sr38gVJsZeBpd2mESvvA@mail.gmail.com>
Message-ID: <CAAOTY_9O2v10eac9KCDqBNCwRymX_1sr38gVJsZeBpd2mESvvA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Add missing MODULE_DEVICE_TABLE()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2021=E5=B9=
=B43=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:43=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 3/2/21 12:07, Enric Balletbo i Serra wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > This patch adds the missing MODULE_DEVICE_TABLE definitions on differen=
t
> > Mediatek drivers which generates correct modalias for automatic loading
> > when these drivers are compiled as an external module.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> A gentle ping for someone to review this patchset :-)
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

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
> > diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/media=
tek/mtk_cec.c
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
> > @@ -247,6 +248,7 @@ static const struct of_device_id mtk_cec_of_ids[] =
=3D {
> >       { .compatible =3D "mediatek,mt8173-cec", },
> >       {}
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
> >
> >  struct platform_driver mtk_cec_driver =3D {
> >       .probe =3D mtk_cec_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 52f11a63a330..2680370652fd 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -822,6 +822,7 @@ static const struct of_device_id mtk_dpi_of_ids[] =
=3D {
> >       },
> >       { },
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
> >
> >  struct platform_driver mtk_dpi_driver =3D {
> >       .probe =3D mtk_dpi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index 5f49a809689b..e4645c8ae1c0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -470,6 +470,7 @@ static const struct of_device_id mtk_drm_of_ids[] =
=3D {
> >         .data =3D &mt8183_mmsys_driver_data},
> >       { }
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> >
> >  static int mtk_drm_probe(struct platform_device *pdev)
> >  {
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 0527480c07be..c71ce62d1bec 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1193,6 +1193,7 @@ static const struct of_device_id mtk_dsi_of_match=
[] =3D {
> >         .data =3D &mt8183_dsi_driver_data },
> >       { },
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
> >
> >  struct platform_driver mtk_dsi_driver =3D {
> >       .probe =3D mtk_dsi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index 8ee55f9e2954..b4696a9d73f7 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -1818,6 +1818,7 @@ static const struct of_device_id mtk_drm_hdmi_of_=
ids[] =3D {
> >       },
> >       {}
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_of_ids);
> >
> >  static struct platform_driver mtk_hdmi_driver =3D {
> >       .probe =3D mtk_drm_hdmi_probe,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/=
mediatek/mtk_hdmi_ddc.c
> > index 62dbad5675bb..6207eac88550 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> > @@ -335,6 +335,7 @@ static const struct of_device_id mtk_hdmi_ddc_match=
[] =3D {
> >       { .compatible =3D "mediatek,mt8173-hdmi-ddc", },
> >       {},
> >  };
> > +MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
> >
> >  struct platform_driver mtk_hdmi_ddc_driver =3D {
> >       .probe =3D mtk_hdmi_ddc_probe,
> >
