Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B7307223
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhA1InN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhA1Iml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:42:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:41:56 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p72so4721778iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mu1RhY5vdfd0PTGfJwJGRCpzx0IqBE4gizmtkvOgrag=;
        b=jkiPQtgKKFoLMfK+SFzZuQc0bycRMssH7w1bBAF7dDfG9hUkPsyg3rqsBsZ7q9bsc5
         xWGTX7X8OxS6qjRZ6u0va7mjVOemzy1AwSRTrVSqMK3wkmyfVqa4TP2sD6s12W8a/5qT
         ruHgEeJDLUy8NNS2DSVNt0qk2kjDH0SrYWz28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mu1RhY5vdfd0PTGfJwJGRCpzx0IqBE4gizmtkvOgrag=;
        b=E0Ga28OEc64DOWNmMjYhRfRpZNkgW7woOt7GW7tMA6knO9sqp1kqf5OemOrK9QWIOb
         gMkxxY2CXydSbsqooOCJ8n3VAozuvO3DkKAgWKE0eaa4KMMA/tCcF0Kk0mh3EezhYL5k
         KcP7L0EAeSGERTM3pk2flQUHWCLHZarBg1J+wQKTtCZnvBNEBZKfrcGeXIeargS+evPm
         LvRmQTmT2o5ezSvsanWP3VBTymXvzme0wuc59vPdAVaDxBOK0lUrvng4iaOyeCyDalju
         vOqGqXMvXvPHEdHxV1mp92CpaX1W3r4WVr8kzFzo7dnqPREJ6fTQg4c6X5eJJbWDpmD7
         XINA==
X-Gm-Message-State: AOAM533LXy2DAJPlHFgRi8R0mkznsk1bk8Ww0YVlHfYewnG8b3bKwTxy
        nRLVeQGTbjO3sMFWdNPtGtcOTKoMI8XNedT0Bibmmg==
X-Google-Smtp-Source: ABdhPJzZiOa3nQIoXOADguUymQXk0d1c2N5Z23LxFqwIuGzQUSONJoOQ2Z0t9YOgq72GDzGog90V2y/lROFB/q16NIY=
X-Received: by 2002:a02:aa9a:: with SMTP id u26mr12050398jai.4.1611823315806;
 Thu, 28 Jan 2021 00:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20210128072802.830971-1-hsinyi@chromium.org> <20210128072802.830971-8-hsinyi@chromium.org>
 <1611819766.16091.4.camel@mtksdaap41> <1611820770.1947.8.camel@mhfsdcap03>
 <1611821233.18369.4.camel@mtksdaap41> <1611821396.1947.10.camel@mhfsdcap03>
 <CAJMQK-h1_d1+SpxMC8LGPJK=X9HHoJ_ueFzV2Sq44buCiaXFUA@mail.gmail.com>
 <1611822524.23925.4.camel@mtksdaap41> <1611822729.1947.14.camel@mhfsdcap03>
In-Reply-To: <1611822729.1947.14.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Jan 2021 16:41:29 +0800
Message-ID: <CAJMQK-g9QRhLVM77KrTscYA74D_Kx1yxxwGN_Bk0dN2Z=Dp6Eg@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] drm/mediatek: enable dither function
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

On Thu, Jan 28, 2021 at 4:32 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> On Thu, 2021-01-28 at 16:28 +0800, CK Hu wrote:
> > On Thu, 2021-01-28 at 16:18 +0800, Hsin-Yi Wang wrote:
> > > On Thu, Jan 28, 2021 at 4:10 PM Yongqiang Niu
> > > <yongqiang.niu@mediatek.com> wrote:
> > > >
> > > > On Thu, 2021-01-28 at 16:07 +0800, CK Hu wrote:
> > > > > On Thu, 2021-01-28 at 15:59 +0800, Yongqiang Niu wrote:
> > > > > > On Thu, 2021-01-28 at 15:42 +0800, CK Hu wrote:
> > > > > > > Hi, Hsin-Yi:
> > > > > > >
> > > > > > > On Thu, 2021-01-28 at 15:28 +0800, Hsin-Yi Wang wrote:
> > > > > > > > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > > > > > >
> > > > > > > > for 5 or 6 bpc panel, we need enable dither function
> > > > > > > > to improve the display quality
> > > > > > > >
> > > > > > > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > > > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 44 ++++++++++++++++++++-
> > > > > > > >  1 file changed, 43 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > > > index 8173f709272be..e85625704d611 100644
> > > > > > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > > > > > > @@ -53,7 +53,9 @@
> > > > > > > >  #define DITHER_EN                              BIT(0)
> > > > > > > >  #define DISP_DITHER_CFG                                0x0020
> > > > > > > >  #define DITHER_RELAY_MODE                      BIT(0)
> > > > > > > > +#define DITHER_ENGINE_EN                       BIT(1)
> > > > > > > >  #define DISP_DITHER_SIZE                       0x0030
> > > > > > > > +#define DITHER_REG(idx)                                (0x100 + (idx) * 4)
> > > > > > > >
> > > > > > > >  #define LUT_10BIT_MASK                         0x03ff
> > > > > > > >
> > > > > > > > @@ -313,8 +315,48 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
> > > > > > > >  {
> > > > > > > >         struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> > > > > > > >
> > > > > > > > +       bool enable = false;
> > > > > > > > +
> > > > > > > > +       /* default value for dither reg 5 to 14 */
> > > > > > > > +       const u32 dither_setting[] = {
> > > > > > > > +               0x00000000, /* 5 */
> > > > > > > > +               0x00003002, /* 6 */
> > > > > > > > +               0x00000000, /* 7 */
> > > > > > > > +               0x00000000, /* 8 */
> > > > > > > > +               0x00000000, /* 9 */
> > > > > > > > +               0x00000000, /* 10 */
> > > > > > > > +               0x00000000, /* 11 */
> > > > > > > > +               0x00000011, /* 12 */
> > > > > > > > +               0x00000000, /* 13 */
> > > > > > > > +               0x00000000, /* 14 */
> > > > > > >
> > > > > > > Could you explain what is this?
> > > > > >
> > > > > > this is dither 5 to dither 14 setting
> > > > > > this will be useless, we just need set dither 5 and dither 7 like
> > > > > > mtk_ddp_write(cmdq_pkt, 0, comp, DISP_DITHER_5);
> > > > > > mtk_ddp_write(cmdq_pkt, 0, comp, DISP_DITHER_7);
> > > > > > other value is same with hardware default value.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > +       };
> > > > > > > > +
> > > > > > > > +       if (bpc == 5 || bpc == 6) {
> > > > > > > > +               enable = true;
> > > > > > > > +               mtk_ddp_write(cmdq_pkt,
> > > > > > > > +                             DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
> > > > > > > > +                             DITHER_ADD_LSHIFT_R(MTK_MAX_BPC - bpc) |
> > > > > > > > +                             DITHER_NEW_BIT_MODE,
> > > > > > > > +                             &priv->cmdq_reg, priv->regs, DITHER_REG(15));
> > > > > > > > +               mtk_ddp_write(cmdq_pkt,
> > > > > > > > +                             DITHER_LSB_ERR_SHIFT_B(MTK_MAX_BPC - bpc) |
> > > > > > > > +                             DITHER_ADD_LSHIFT_B(MTK_MAX_BPC - bpc) |
> > > > > > > > +                             DITHER_LSB_ERR_SHIFT_G(MTK_MAX_BPC - bpc) |
> > > > > > > > +                             DITHER_ADD_LSHIFT_G(MTK_MAX_BPC - bpc),
> > > > > > >
> > > > > > > This result in 0x50505050, but previous version is 0x50504040, so this
> > > > > > > version is correct and previous version is incorrect?
> > > > > >
> > > > > > the new version set r g b 3 channel same, seams more reasonable
> > > > > >
> > > > > >
> > > > >
> > > > > So all the setting of DISP_DITHER_5, DISP_DITHER_7, DISP_DITHER_15,
> > > > > DISP_DITHER_16 is identical to mtk_dither_set(), so call
> > > > > mtk_dither_set() instead of duplication here.
> > > > >
> > > >
> > > > dither enable set in mtk_dither_set is
> > > > mtk_ddp_write(cmdq_pkt, DISP_DITHERING, comp, CFG);
> > > >
> > > > that is different 8183 and mt8192.
> > > > mt8173 dither enable in gamma is bit2
> > > > mt8183 and mt8192 dither engine enable is bit 1
> > > >
> > > >
> > >
> > > We can still call mtk_dither_set() for bpc is 5 or 6 here, though it
> > > will be set to bit2,
> > > but later in mtk_ddp_write(cmdq_pkt, enable ? DITHER_ENGINE_EN :
> > > DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG); it
> > > will be correct back to bit 1.
> > >
> > > Is this reasonable?
> >
> > Looks weird. Maybe pass some information into mtk_dither_set() to set
> > DISP_DITHERING correctly.
> >
> > I find one thing need to be fixed. CFG should be lower case.
>
> we could modify this like this:
>
> void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>                     unsigned int cfg, u32 dither_enable, struct cmdq_pkt *cmdq_pkt)
>
>                 mtk_ddp_write(cmdq_pkt, dither_enable, comp, cfg);
>
>
>

Thanks, I'll add another flag to mtk_dither_set_common.

> >
> > Regards,
> > CK
> >
> > >
> > > > > Regards,
> > > > > CK
> > > > > > >
> > > > > > > Regards,
> > > > > > > CK
> > > > > > >
> > > > > > > > +                             &priv->cmdq_reg, priv->regs, DITHER_REG(16));
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +
> > > > > > > > +       if (enable) {
> > > > > > > > +               u32 idx;
> > > > > > > > +
> > > > > > > > +               for (idx = 0; idx < ARRAY_SIZE(dither_setting); idx++)
> > > > > > > > +                       mtk_ddp_write(cmdq_pkt, dither_setting[idx], &priv->cmdq_reg, priv->regs,
> > > > > > > > +                                     DITHER_REG(idx + 5));
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >         mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_DITHER_SIZE);
> > > > > > > > -       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
> > > > > > > > +        mtk_ddp_write(cmdq_pkt, enable ? DITHER_ENGINE_EN : DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void mtk_dither_start(struct device *dev)
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > >
> >
> >
>
