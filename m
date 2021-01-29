Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC56308714
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 09:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhA2Iek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 03:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhA2H7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:59:05 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3386C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:59:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u7so8375871iol.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltHSqOjLUAE8DJaRHWwj9Y5DtRXKvkieuWzd/b6Tr24=;
        b=c47Loy48fu4nC3KT2p3Q2Cueqn27dSpOJn4lfmoj9FajdI4k84S8UtxtFBzL5JTu1v
         xxEkPWUlNx5O8d1FG1H/wke7dYV4gcG4xRvl77Qb8GY2eQk8tEz9gCLLRa2wRKHKMCoE
         W1WAyJ18vULA7zutJwn9Hwkmj+EVmRLY6MMNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltHSqOjLUAE8DJaRHWwj9Y5DtRXKvkieuWzd/b6Tr24=;
        b=PReRsRObnjeoKZUD+a4FEA9Mb62Wu9ilmvVPCF/0sgvDLDK5MxNFQ4S4jCinMh6Su1
         FuK4S/zrNbnWxJqWFMlflupVhbQ0ZDA/aDxFKFsPwjuCWeT0OWEVzXCgMbaHPQGQD2uB
         QKaVm6V3lIWOLxtvyv1uFkWakch1VeBLC6Rct9zhji+0dIne6owkhpSY9tPwBKQ40iTH
         bbhHokRjCLYPdfjEH5f0r0MehyCa/ikxSbkIDoPnr7IFhYFUK+x6cO3Vpdj/GDNArCVx
         qSbD7v1FULCsahx4vF0iWaHX9ULzdsuaa/+ZjvbueHj7liqQKgMpUCsSP4GuE6L5e4HU
         Azjg==
X-Gm-Message-State: AOAM533LEqXZUzonVxo0HX07Osuw7puj4FOnFgJTtpW/b5ERAD5c8Tol
        RfBbZAP9mXLXLRnmq+kpil2bh3PVOPtI+F53dwL71g==
X-Google-Smtp-Source: ABdhPJyOCEXPQU61Tit3pKM+NoR4kp11lwpBLzpH2Si5KRV8JRgeJuQhKhO1ZeT72S4QnSsN3uDFU1kNnSNoOnnw2gE=
X-Received: by 2002:a02:aa9a:: with SMTP id u26mr2600581jai.4.1611907189606;
 Thu, 28 Jan 2021 23:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20210128112314.1304160-1-hsinyi@chromium.org> <20210128112314.1304160-7-hsinyi@chromium.org>
 <1611883982.5226.12.camel@mtksdaap41> <CAJMQK-gKKjLJ5xOAKOx5BM5dL2MxgFq72FVCfGTfzK4ZXzRJfA@mail.gmail.com>
 <1611901808.1947.16.camel@mhfsdcap03> <CAJMQK-hLf6f0mofWMF6eEKtTRTmK4Pm-mkYjAAGzD80uTpZLug@mail.gmail.com>
 <1611906124.1947.22.camel@mhfsdcap03>
In-Reply-To: <1611906124.1947.22.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 29 Jan 2021 15:59:23 +0800
Message-ID: <CAJMQK-hqkcY05QmNT5Kk3MiaV5Lg3uGnDZFt2-_4rhf5tQ54gg@mail.gmail.com>
Subject: Re: [PATCH v12 6/8] drm/mediatek: enable dither function
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 3:42 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> On Fri, 2021-01-29 at 14:46 +0800, Hsin-Yi Wang wrote:
> > On Fri, Jan 29, 2021 at 2:30 PM Yongqiang Niu
> > <yongqiang.niu@mediatek.com> wrote:
> > >
> > > On Fri, 2021-01-29 at 14:24 +0800, Hsin-Yi Wang wrote:
> > > > On Fri, Jan 29, 2021 at 9:33 AM CK Hu <ck.hu@mediatek.com> wrote:
> > > > >
> > > > > Hi, Hsin-Yi:
> > > > >
> > > > > On Thu, 2021-01-28 at 19:23 +0800, Hsin-Yi Wang wrote:
> > > > > > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > > > >
> > > > > > for 5 or 6 bpc panel, we need enable dither function
> > > > > > to improve the display quality
> > > > > >
> > > > > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 15 +++++++++++++--
> > > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > index ac2cb25620357..6c8f246380a74 100644
> > > > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > @@ -53,6 +53,7 @@
> > > > > >  #define DITHER_EN                            BIT(0)
> > > > > >  #define DISP_DITHER_CFG                              0x0020
> > > > > >  #define DITHER_RELAY_MODE                    BIT(0)
> > > > > > +#define DITHER_ENGINE_EN                     BIT(1)
> > > > > >  #define DISP_DITHER_SIZE                     0x0030
> > > > > >
> > > > > >  #define LUT_10BIT_MASK                               0x03ff
> > > > > > @@ -314,9 +315,19 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
> > > > > >                             unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> > > > > >  {
> > > > > >       struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> > > > > > +     bool enable = (bpc == 5 || bpc == 6);
> > > > >
> > > > > I strongly believe that dither function in dither is identical to the
> > > > > one in gamma and od, and in mtk_dither_set_common(), 'bpc >=
> > > > > MTK_MIN_BPC' is valid, so I believe we need not to limit bpc to 5 or 6.
> > > > > But we should consider the case that bpc is invalid in
> > > > > mtk_dither_set_common(). Invalid case in gamma and od use different way
> > > > > to process. For gamma, dither is default relay mode, so invalid bpc
> > > > > would do nothing in mtk_dither_set_common() and result in relay mode.
> > > > > For od, it set to relay mode first, them invalid bpc would do nothing in
> > > > > mtk_dither_set_common() and result in relay mode. I would like dither,
> > > > > gamma and od to process invalid bpc in the same way. One solution is to
> > > > > set relay mode in mtk_dither_set_common() for invalid bpc.
> > > > >
> > > > > Regards,
> > > > > CK
> > > > >
> > > >
> > > > I modify the mtk_dither_config() to follow:
> > > >
> > > >
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > index ac2cb25620357..5b7fcedb9f9a8 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > @@ -53,6 +53,7 @@
> > > >  #define DITHER_EN                              BIT(0)
> > > >  #define DISP_DITHER_CFG                                0x0020
> > > >  #define DITHER_RELAY_MODE                      BIT(0)
> > > > +#define DITHER_ENGINE_EN                       BIT(1)
> > > >  #define DISP_DITHER_SIZE                       0x0030
> > > >
> > > >  #define LUT_10BIT_MASK                         0x03ff
> > > > @@ -166,6 +167,8 @@ void mtk_dither_set_common(void __iomem *regs,
> > > > struct cmdq_client_reg *cmdq_reg,
> > > >                               DITHER_ADD_LSHIFT_G(MTK_MAX_BPC - bpc),
> > > >                               cmdq_reg, regs, DISP_DITHER_16);
> > > >                 mtk_ddp_write(cmdq_pkt, dither_en, cmdq_reg, regs, cfg);
> > > > +       } else {
> > > > +               mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, cmdq_reg, regs, cfg);
> > > >         }
> > > >  }
> > > >
> > > > @@ -315,8 +318,12 @@ static void mtk_dither_config(struct device *dev,
> > > > unsigned int w,
> > > >  {
> > > >         struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> > > >
> > > > -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg,
> > > > priv->regs, DISP_DITHER_SIZE);
> > > > -       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
> > > > priv->regs, DISP_DITHER_CFG);
> > > > +       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
> > > > +                     DISP_DITHER_SIZE);
> > > > +       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs,
> > > > +                     DISP_DITHER_CFG);
> > > > +       mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, DISP_DITHER_CFG,
> > > > +                              DITHER_ENGINE_EN, cmdq_pkt);
> > > >  }
> > > >
> > > > So now, not only bpc==5 or 6, but all valid bpc, dither config will
> > > > call mtk_dither_set_common() with the flag DITHER_ENGINE_EN(BIT(1)).
> > > > od config will call mtk_dither_set_common() with the flag
> > > > DISP_DITHERING(BIT(2)).
> > > > Additionally for 8173, gamma config will call mtk_dither_set_common()
> > > > with the flag DISP_DITHERING (BIT(2))
> > > >
> > > > For invalid mode all of them will be DITHER_RELAY_MODE.
> > > >
> > > > Just to make sure that this follows the spec? thanks
> > > >
> > >
> > > for mt8173 gamma, there is no relay mode, only dither enable or not(bit
> > > 2).
> > > for mt8183 dither, there is dither enable bit 1, and relay mode bit 0
> > >
> > CK suggested to set relay mode for invalid cases. Or should I just set
> > invalid case in mtk_dither_config()? So that invalid case for gamma
> > and od would remain its default mode?
> >
> od and gamma has no relay mode
> set relay mode in  mtk_dither_config is better
>
>
> > Besides that, the major difference of this patch and original version
> > is that not only bpc ==5 or 6 will set dither enable bit 1. Does this
> > looks good to you?
>
> dither only support  bpc 4 6 8 , there is no bpc 5 use case,
> please modify this error.
>

Only bpc 4, 6, 8 case will call mtk_dither_set_common, other bpc will
be considered invalid and stays in relay mode.

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ac2cb25620357..5761dd15eedf2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -53,6 +53,7 @@
 #define DITHER_EN                              BIT(0)
 #define DISP_DITHER_CFG                                0x0020
 #define DITHER_RELAY_MODE                      BIT(0)
+#define DITHER_ENGINE_EN                       BIT(1)
 #define DISP_DITHER_SIZE                       0x0030

 #define LUT_10BIT_MASK                         0x03ff
@@ -314,9 +315,17 @@ static void mtk_dither_config(struct device *dev,
unsigned int w,
                              unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
        struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
-
-       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg,
priv->regs, DISP_DITHER_SIZE);
-       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
priv->regs, DISP_DITHER_CFG);
+       bool valid_bpc = (bpc == 4 || bpc == 6 || bpc == 8);
+
+       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
+                     DISP_DITHER_SIZE);
+       if (valid_bpc)

+               mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc,
+                                     DISP_DITHER_CFG, DITHER_ENGINE_EN,
+                                     cmdq_pkt);
+       else
+               mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
+                             priv->regs, DISP_DITHER_CFG);
 }


> > >
> > > > > >
> > > > > > -     mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_DITHER_SIZE);
> > > > > > -     mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
> > > > > > +     if (enable) {
> > > > > > +             mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc,
> > > > > > +                                   DISP_DITHER_CFG, DITHER_ENGINE_EN,
> > > > > > +                                   cmdq_pkt);
> > > > > > +     } else {
> > > > > > +             mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
> > > > > > +                           priv->regs, DISP_DITHER_CFG);
> > > > > > +     }
> > > > > > +
> > > > > > +     mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
> > > > > > +                   DISP_DITHER_SIZE);
> > > > > >  }
> > > > > >
> > > > > >  static void mtk_dither_start(struct device *dev)
> > > > >
> > >
>
