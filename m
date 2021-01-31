Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578A309A25
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 04:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhAaD5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 22:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhAaD5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 22:57:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C14FD64E28;
        Sun, 31 Jan 2021 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612065385;
        bh=o/wMeATxWK4/ovdl3osu4aT+CFWCCeBZhexp7L0XdJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X1d2jLQRNnuuWQcvT0TPUItmebn9K6KbW8KUg2BElCc89in1n8kuXMUQeIv3VNg01
         L89XNnwL3W7rakrcIbEwznIMlxjRk9EJoN+ceFiZFVRJ+yjhbiq8160FOgkjLVBnhH
         GxMXbuxVGjHodB3vbIwX1Giz7gJcv0YH40U5hDBrihf8jczoezCvoBMuZsW74puSco
         vKLwIX0xfJeO7grnszPHa3bhMIKhs/cfmGQMWOVaYUtoq2eeu0n8u3klYQSfkf3tWe
         v1nsutxHEkEeaYqzKszBWAUnPlEzrQzaui5nxz8c41koUA8ZjFst4Tiq9iSnkrerbL
         ZYRuZrEhNdrMg==
Received: by mail-ej1-f52.google.com with SMTP id r12so18953399ejb.9;
        Sat, 30 Jan 2021 19:56:24 -0800 (PST)
X-Gm-Message-State: AOAM531vba0oObmVLk8nx401uk8uTjsrrWn/P569dlWfl+xq/sSbo4C5
        jcqr3QbyN4eJAcVdkNqzmeZijrjUVMm9ZXSZpQ==
X-Google-Smtp-Source: ABdhPJxNc0ogbTJjvcRGvMFzWpYCh+9GlGCriZvuZocH6kJJP4x6oFAwWInkVL7LXNp6GnE9l1E7LPwRxCKYeiir/b0=
X-Received: by 2002:a17:906:8a59:: with SMTP id gx25mr3777247ejc.310.1612065383304;
 Sat, 30 Jan 2021 19:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20210129073436.2429834-1-hsinyi@chromium.org> <20210129073436.2429834-5-hsinyi@chromium.org>
 <1611908500.31184.6.camel@mtksdaap41>
In-Reply-To: <1611908500.31184.6.camel@mtksdaap41>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 31 Jan 2021 11:56:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8PhKLEuwq4u9tK7z0yfbU=La+DQ8+Ahg1OTe0d5o4qhw@mail.gmail.com>
Message-ID: <CAAOTY_8PhKLEuwq4u9tK7z0yfbU=La+DQ8+Ahg1OTe0d5o4qhw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for
 multi-layer usecase
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

CK Hu <ck.hu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi, Hsin-Yi:
>
> On Fri, 2021-01-29 at 15:34 +0800, Hsin-Yi Wang wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> >
> > enable OVL_LAYER_SMI_ID_EN for multi-layer usecase, without this patch,
> > ovl will hang up when more than 1 layer enabled.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ovl.c
> > index da7e38a28759b..961f87f8d4d15 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -24,6 +24,7 @@
> >  #define DISP_REG_OVL_RST                     0x0014
> >  #define DISP_REG_OVL_ROI_SIZE                        0x0020
> >  #define DISP_REG_OVL_DATAPATH_CON            0x0024
> > +#define OVL_LAYER_SMI_ID_EN                          BIT(0)
> >  #define OVL_BGCLR_SEL_IN                             BIT(2)
> >  #define DISP_REG_OVL_ROI_BGCLR                       0x0028
> >  #define DISP_REG_OVL_SRC_CON                 0x002c
> > @@ -62,6 +63,7 @@ struct mtk_disp_ovl_data {
> >       unsigned int gmc_bits;
> >       unsigned int layer_nr;
> >       bool fmt_rgb565_is_0;
> > +     bool smi_id_en;
> >  };
> >
> >  /**
> > @@ -134,6 +136,13 @@ void mtk_ovl_start(struct device *dev)
> >  {
> >       struct mtk_disp_ovl *ovl =3D dev_get_drvdata(dev);
> >
> > +     if (ovl->data->smi_id_en) {
> > +             unsigned int reg;
> > +
> > +             reg =3D readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
> > +             reg =3D reg | OVL_LAYER_SMI_ID_EN;
> > +             writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON=
);
> > +     }
> >       writel_relaxed(0x1, ovl->regs + DISP_REG_OVL_EN);
> >  }
> >
> > @@ -142,6 +151,14 @@ void mtk_ovl_stop(struct device *dev)
> >       struct mtk_disp_ovl *ovl =3D dev_get_drvdata(dev);
> >
> >       writel_relaxed(0x0, ovl->regs + DISP_REG_OVL_EN);
> > +     if (ovl->data->smi_id_en) {
> > +             unsigned int reg;
> > +
> > +             reg =3D readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
> > +             reg =3D reg & ~OVL_LAYER_SMI_ID_EN;
> > +             writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON=
);
> > +     }
> > +
> >  }
> >
> >  void mtk_ovl_config(struct device *dev, unsigned int w,
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
