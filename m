Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131330A8E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhBANhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhBANhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:37:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B026A64EA3;
        Mon,  1 Feb 2021 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612186627;
        bh=Ca6sILXG4fwyLv608fCB+3JeQwCE0JDKDmcvJPplyMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kr3EddrrKwSTCkaYxO9jNkuvl767WrHxraPzTgsh4dCinF9nC9h87lejDgnzya/Ur
         4pYiK/WYT3DZcpGcUEaxv16ICA8WV8K/zFA8ClVI+n1eGnkAah+rFP+77cYjpjG8hc
         dS0I46/hqxrB6Lcq+If/Flrv0P6GQHEh2sls7pR/61KY5h0fY8QJzcfzXrNz6XuiwC
         Dd4pQBy5IX78RJWVC+3aWfUqm4eYd3XvtftJ4rKGlDGcmXGJUihWXC/8xOm676x+Gz
         t21RHf9rTVE+ADr+WAL42yx3ANpCerxEj2DOF5rfF9ZvzpEOHuEosMIR0VTVmT9vat
         Roj3n/x8TXrDw==
Received: by mail-wr1-f48.google.com with SMTP id c4so13887695wru.9;
        Mon, 01 Feb 2021 05:37:06 -0800 (PST)
X-Gm-Message-State: AOAM530XIFIykRBKZY+aH3HUKEVj1KTbJD8w9ix7bLiqtnCcfuHHn80H
        P8VPqLG3KA1SXpP9VZERiAwPvp5UoT6d19OUFw==
X-Google-Smtp-Source: ABdhPJwGbLbPXA9ztMTVXLGo0SWhr8NHgerLg6mdo4pyBi7dlYyviEPBb6aW4ApZKN9NnopTRVp50+8iSm8fx35JTCw=
X-Received: by 2002:a5d:524a:: with SMTP id k10mr18325193wrc.394.1612186625106;
 Mon, 01 Feb 2021 05:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20210131051058.3407985-1-hsinyi@chromium.org> <CAAOTY_9kOnYDs=_22qBV7kOM74zcfKaobN0wBZaXzx31KsrG5Q@mail.gmail.com>
In-Reply-To: <CAAOTY_9kOnYDs=_22qBV7kOM74zcfKaobN0wBZaXzx31KsrG5Q@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 1 Feb 2021 21:36:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY__VKeP0Z-Up5gpaB9SwcCbwQdB5cHXfssQB77s_G1U63w@mail.gmail.com>
Message-ID: <CAAOTY__VKeP0Z-Up5gpaB9SwcCbwQdB5cHXfssQB77s_G1U63w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: enable dither function
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8812:20=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Hsin-Yi:
>
> Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=881:11=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> >
> > Enable dither function to improve the display quality.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > Previous version:
> > https://patchwork.kernel.org/project/linux-mediatek/patch/2021012909220=
9.2584718-7-hsinyi@chromium.org/
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/=
drm/mediatek/mtk_drm_ddp_comp.c
> > index c730029ac8fc7..0444b429daf00 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -53,6 +53,7 @@
> >  #define DITHER_EN                              BIT(0)
> >  #define DISP_DITHER_CFG                                0x0020
> >  #define DITHER_RELAY_MODE                      BIT(0)
> > +#define DITHER_ENGINE_EN                       BIT(1)
> >  #define DISP_DITHER_SIZE                       0x0030
> >
> >  #define LUT_10BIT_MASK                         0x03ff
> > @@ -315,8 +316,12 @@ static void mtk_dither_config(struct device *dev, =
unsigned int w,
> >  {
> >         struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> >
> > -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->reg=
s, DISP_DITHER_SIZE);
> > -       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, pri=
v->regs, DISP_DITHER_CFG);
> > +       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->reg=
s,
> > +                     DISP_DITHER_SIZE);
> > +       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, pri=
v->regs,
> > +                     DISP_DITHER_CFG);
> > +       mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, DISP_DI=
THER_CFG,
> > +                             DITHER_ENGINE_EN, cmdq_pkt);
> >  }
> >
> >  static void mtk_dither_start(struct device *dev)
> > --
> > 2.30.0.365.g02bc693789-goog
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
