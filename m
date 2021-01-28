Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB79306C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhA1FKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhA1FKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:10:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C32C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:09:53 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q129so4366708iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wm/YQVXUMhIB/BMDJogyUbmGWPEi6vcYSKKfpvve88M=;
        b=XfARxNdjxfvwbLx87S4vCHGZ+hfoFXMjUJwaPdnI3B5svpibAJe2bxnEiivIvlareH
         nLMmddqGzyG0sSKdPR6iM7yvKfFBSzPSZ/UdDvm6ZTbORRtrQ52843Z4tTH4K/cmZhBr
         HouPPShhc/heV0RPWVfOFxAJ3hTmLn0UViKMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wm/YQVXUMhIB/BMDJogyUbmGWPEi6vcYSKKfpvve88M=;
        b=CCGeKo92s4FxEqG8cFksrh0bxx/i5toO/ey5JRnriHWnRWpQm3RsqQRVLZWvELkW5T
         UKcMiinJLMMMMKLS7TxiaUzilreS2KIVvRDRB2LcmjYg+CLbZr8hLDh9bNRYl0+qop9n
         cGpmczfIIOF8wmnXAKSFjyiW1++cIn7K61fThs+8jgm486D5/uEdH55H78Y/72L8tUOv
         +khlxG0nxQtTUKLpVjUvnSaY9YPl/Y8oAeAQmUYnvR8tkHrh8WSvp4LScrwzbfA/OR9Q
         Mklij9rGViBmC+Sztk9yt0D3btrVUYE0qVJ5TQQMYo09p1zynrwIVFeNfWI7vmSeeq8x
         Tu8g==
X-Gm-Message-State: AOAM533imgdGeaul5bxYUzrdRWrsTIKAUzQGwTsA55ZmyvF9JOm4dMzf
        DCMUAlBU0rq02c7gGC9KzPOTOq/0+XyXvJPWunSVYQ==
X-Google-Smtp-Source: ABdhPJw9RDW4YOgrrY0K/Zhny0x/8TzsFk5NQqU8SfevdJcvgReB/EkAPUFQ4VOQjiKOfFg40N4g+dqfJBA6RuMZM68=
X-Received: by 2002:a05:6638:138e:: with SMTP id w14mr11568954jad.98.1611810592540;
 Wed, 27 Jan 2021 21:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20210127045422.2418917-1-hsinyi@chromium.org> <20210127045422.2418917-5-hsinyi@chromium.org>
 <1611808753.19104.2.camel@mtksdaap41>
In-Reply-To: <1611808753.19104.2.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Jan 2021 13:09:26 +0800
Message-ID: <CAJMQK-jeBBsxZ1RnFJfT5ouNJsBwEkLbZ_+6T+VUFZ_xDQ7rpQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] drm/mediatek: generalize mtk_dither_set() function
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:39 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-Yi:
>
> On Wed, 2021-01-27 at 12:54 +0800, Hsin-Yi Wang wrote:
> > There may be data structure other than mtk_ddp_comp_dev that would call
> > mtk_dither_set(), so use regs as parameter instead of device.
>
> You does not change the interface of mtk_dither_set(). You move the
> common part in mtk_dither_set() to a new function which could be called
> by another caller.
>
> Regards,
> CK.
>
Current mtk_dither_set() cast dev data to struct mtk_ddp_comp_dev. But
mtk_disp_gamma in next patch would also call this function. But it's
dev data is struct mtk_disp_gamma, which is different, so we can't
cast to mtk_ddp_comp_dev. I separate the necessary parameters (regs,
cmdq_reg) out, so both component dither and gamma can both call this
separated function.

This is similar to the mtk_gamma_set_common() in the next patch, which
gamma and aal both used.

> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  4 ++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 25 +++++++++++++--------
> >  2 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > index 46d199b7b4a29..c50d5fc9fd349 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > @@ -17,6 +17,10 @@ void mtk_color_config(struct device *dev, unsigned int w,
> >                     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> >  void mtk_color_start(struct device *dev);
> >
> > +void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
> > +                        unsigned int bpc, unsigned int CFG,
> > +                        struct cmdq_pkt *cmdq_pkt);
> > +
> >  void mtk_dpi_start(struct device *dev);
> >  void mtk_dpi_stop(struct device *dev);
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 7b5293429426d..53d25823a37cc 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -151,33 +151,40 @@ static void mtk_ddp_clk_disable(struct device *dev)
> >       clk_disable_unprepare(priv->clk);
> >  }
> >
> > -static void mtk_dither_set(struct device *dev, unsigned int bpc,
> > -                 unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
> > -{
> > -     struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> >
> > +void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
> > +                        unsigned int bpc, unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
> > +{
> >       /* If bpc equal to 0, the dithering function didn't be enabled */
> >       if (bpc == 0)
> >               return;
> >
> >       if (bpc >= MTK_MIN_BPC) {
> > -             mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_DITHER_5);
> > -             mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_DITHER_7);
> > +             mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5);
> > +             mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7);
> >               mtk_ddp_write(cmdq_pkt,
> >                             DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
> >                             DITHER_ADD_LSHIFT_R(MTK_MAX_BPC - bpc) |
> >                             DITHER_NEW_BIT_MODE,
> > -                           &priv->cmdq_reg, priv->regs, DISP_DITHER_15);
> > +                           cmdq_reg, regs, DISP_DITHER_15);
> >               mtk_ddp_write(cmdq_pkt,
> >                             DITHER_LSB_ERR_SHIFT_B(MTK_MAX_BPC - bpc) |
> >                             DITHER_ADD_LSHIFT_B(MTK_MAX_BPC - bpc) |
> >                             DITHER_LSB_ERR_SHIFT_G(MTK_MAX_BPC - bpc) |
> >                             DITHER_ADD_LSHIFT_G(MTK_MAX_BPC - bpc),
> > -                           &priv->cmdq_reg, priv->regs, DISP_DITHER_16);
> > -             mtk_ddp_write(cmdq_pkt, DISP_DITHERING, &priv->cmdq_reg, priv->regs, CFG);
> > +                           cmdq_reg, regs, DISP_DITHER_16);
> > +             mtk_ddp_write(cmdq_pkt, DISP_DITHERING, cmdq_reg, regs, CFG);
> >       }
> >  }
> >
> > +static void mtk_dither_set(struct device *dev, unsigned int bpc,
> > +                 unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
> > +{
> > +     struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> > +
> > +     mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, CFG, cmdq_pkt);
> > +}
> > +
> >  static void mtk_od_config(struct device *dev, unsigned int w,
> >                         unsigned int h, unsigned int vrefresh,
> >                         unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>
