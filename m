Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1958930942D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhA3KOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhA3KN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:13:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB9C964DE7;
        Sat, 30 Jan 2021 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612001567;
        bh=N5xKQ7D7bbQAxoHSV1A03B0Qf2d9erN8a0kxiDAMWXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sILany1Q3l1Jka8eKGJzp3yNvZKM0f5gBIlD0J+NN8OVmOWwd5eZi3uPadHSGgbuG
         zsswNk+/phPYZITk+uJtLtu6lBHIq+oBpyW8v7gzWruu/R/YPPQdcC15/OCILWtKnr
         ppC1cwLnxUKC3GmIXjXUTQzZcwa/57amfKpah9NeUlFcDMDSVkjNtmZmLrCaPH6Kpg
         ggVA7OrfefeR+w1mEaDGWQlT5AKhKBMprjTfINxohGWX9k95y+pd9/0hxLWA0uavXl
         4QdOvq00nLCCxNoqBrKVyGepL7NVdbk3lzSKhqOJ3VssWOUl5MlGZUNxz+y+wBvfGR
         VtVQ5Oy3eXPzg==
Received: by mail-ej1-f47.google.com with SMTP id w1so16602324ejf.11;
        Sat, 30 Jan 2021 02:12:46 -0800 (PST)
X-Gm-Message-State: AOAM532/H3oKsFwntrIcAayC/H6jXjJgfRPVeMd+cfuBQrohexTAXwRE
        a8PRVJutBGe2ocM6x/7dziO0+NrhteLsogyE9Q==
X-Google-Smtp-Source: ABdhPJy//YfGdlHPfWkuPSgx+JETf8NnC/t1qkUJybbWz8gEYP7LSsFu1qKJhn/0GYHqhW+ASitPV/FrQ5rMLv8vrGQ=
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr8516170ejf.127.1612001565308;
 Sat, 30 Jan 2021 02:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20210129092209.2584718-1-hsinyi@chromium.org> <20210129092209.2584718-6-hsinyi@chromium.org>
In-Reply-To: <20210129092209.2584718-6-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 Jan 2021 18:12:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8B_pca0GeJoASLOh1ROkErPZBJcew1N7+jZia7csHNMA@mail.gmail.com>
Message-ID: <CAAOTY_8B_pca0GeJoASLOh1ROkErPZBJcew1N7+jZia7csHNMA@mail.gmail.com>
Subject: Re: [PATCH v13 5/8] drm/mediatek: add has_dither private data for gamma
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
> Not all SoC has dither function in gamma module.
> Add private data to control this function setting.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> index 6b520807921e3..5092a27ccc28b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -27,7 +27,7 @@
>  #define LUT_10BIT_MASK                         0x03ff
>
>  struct mtk_disp_gamma_data {
> -       u32 reserved;
> +       bool has_dither;
>  };
>
>  /**
> @@ -93,8 +93,9 @@ void mtk_gamma_config(struct device *dev, unsigned int =
w,
>
>         mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->reg=
s,
>                       DISP_GAMMA_SIZE);
> -       mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GA=
MMA_CFG,
> -                             GAMMA_DITHERING, cmdq_pkt);
> +       if (gamma->data && gamma->data->has_dither)
> +               mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc,
> +                                     DISP_GAMMA_CFG, GAMMA_DITHERING, cm=
dq_pkt);
>  }
>
>  void mtk_gamma_start(struct device *dev)
> @@ -174,8 +175,13 @@ static int mtk_disp_gamma_remove(struct platform_dev=
ice *pdev)
>         return 0;
>  }
>
> +static const struct mtk_disp_gamma_data mt8173_gamma_driver_data =3D {
> +       .has_dither =3D true,
> +};
> +
>  static const struct of_device_id mtk_disp_gamma_driver_dt_match[] =3D {
> -       { .compatible =3D "mediatek,mt8173-disp-gamma"},
> +       { .compatible =3D "mediatek,mt8173-disp-gamma",
> +         .data =3D &mt8173_gamma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
