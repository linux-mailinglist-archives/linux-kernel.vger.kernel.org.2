Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF4309A1F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 04:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhAaDkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 22:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhAaDkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 22:40:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E64664E28;
        Sun, 31 Jan 2021 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612064399;
        bh=RNiZ5TCNkSv22cSv6EJs8IrM1JowIcGzF+Sj2oYNTVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/zhaf7333eKKO8CNnVmYAmmBD8cKv1vWAuXkYVpz7S13Er+f9hv52Jdt9AjQmMM2
         dSfCkb+XmaA3hKpuP48Xgz/cfje3ON4af/SI85nVCDip7Q+T5yTGEx/7wBf/ydmZhU
         rxAN+RyCUXPRFbR6nmv+Xy/EhWWE8HWYIDz8FvyJp5wuOIROm9NjRBfK38lnwbj8nh
         cZDAVDrPP2sx6lbVnxkOaiymSn8z6Vbsh5XYw67e5ePFTAlQZysBcv4/Vedvn3tZlI
         60atmGSgVe9Gir19dYd00Fa21qNQOzBdfmnI1YZB/Slu/KMVaVEllQQEcAxGTe77sx
         W5ruG1Lx7Rnjw==
Received: by mail-ej1-f44.google.com with SMTP id g12so18931212ejf.8;
        Sat, 30 Jan 2021 19:39:59 -0800 (PST)
X-Gm-Message-State: AOAM532rG5dJgkZowmvlERr/fVxeDRFtw//vmwA4GAevHkFOFBwuEVvn
        M8iXbiwrK7F1Zf2jHnl0NCU48iY7u+UCZ716Yw==
X-Google-Smtp-Source: ABdhPJzYuzld2+PJhQ77huEimQis5+AK40LnLsdUu5MXFQj1YUc24jKH4JV04Fx95lTBI8IU35UcMjMy/jMWXoOmQq0=
X-Received: by 2002:a17:907:9687:: with SMTP id hd7mr11529326ejc.303.1612064397966;
 Sat, 30 Jan 2021 19:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20210129092209.2584718-1-hsinyi@chromium.org> <20210129092209.2584718-7-hsinyi@chromium.org>
In-Reply-To: <20210129092209.2584718-7-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 31 Jan 2021 11:39:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8rAAiiwtUJ_8nkp3WZKZ05Mo4oGxWnncywabGNHu3Ffg@mail.gmail.com>
Message-ID: <CAAOTY_8rAAiiwtUJ_8nkp3WZKZ05Mo4oGxWnncywabGNHu3Ffg@mail.gmail.com>
Subject: Re: [PATCH v13 6/8] drm/mediatek: enable dither function
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
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

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Enable dither function to improve the display quality for dither
> supported bpc 4, 6, 8. For not supported bpc, use relay mode.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index ac2cb25620357..5761dd15eedf2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -53,6 +53,7 @@
>  #define DITHER_EN                              BIT(0)
>  #define DISP_DITHER_CFG                                0x0020
>  #define DITHER_RELAY_MODE                      BIT(0)
> +#define DITHER_ENGINE_EN                       BIT(1)
>  #define DISP_DITHER_SIZE                       0x0030
>
>  #define LUT_10BIT_MASK                         0x03ff
> @@ -314,9 +315,17 @@ static void mtk_dither_config(struct device *dev, un=
signed int w,
>                               unsigned int bpc, struct cmdq_pkt *cmdq_pkt=
)
>  {
>         struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,=
 DISP_DITHER_SIZE);
> -       mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv-=
>regs, DISP_DITHER_CFG);
> +       bool valid_bpc =3D (bpc =3D=3D 4 || bpc =3D=3D 6 || bpc =3D=3D 8)=
;
> +
> +       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
> +                     DISP_DITHER_SIZE);
> +       if (valid_bpc)
> +               mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc,
> +                                     DISP_DITHER_CFG, DITHER_ENGINE_EN,
> +                                     cmdq_pkt);
> +       else
> +               mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_re=
g,
> +                             priv->regs, DISP_DITHER_CFG);

od has relay mode,

static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
  unsigned int h, unsigned int vrefresh,
  unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
{
mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_OD_SIZE);
mtk_ddp_write(cmdq_pkt, OD_RELAYMODE, comp, DISP_OD_CFG);
mtk_dither_set(comp, bpc, DISP_OD_CFG, cmdq_pkt);
}

and it does not check valid bpc (I think drm core already set bpc to
4, 6, 8 or 0), so align implementation of mtk_dither_config() with
mtk_od_config().
gamma also has relay mode (refer to [1] page 689), but we need to
enable gamma's gamma function, so we do not set gamma to relay mode.
So I think maybe we could implement mtk_dither_config() as:

mtk_dither_config()
{
        mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg,
priv->regs, DISP_DITHER_SIZE);
        mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
priv->regs, DISP_DITHER_CFG);
        mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc,
DISP_DITHER_CFG, DITHER_ENGINE_EN, cmdq_pkt);
}

[1] https://www.96boards.org/documentation/consumer/mediatekx20/additional-=
docs/docs/MT6797_Register_Table_Part_2.pdf

Regards,
Chun-Kuang.

>  }
>
>  static void mtk_dither_start(struct device *dev)
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
