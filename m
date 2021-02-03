Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0330DF70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhBCQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbhBCQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:15:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F13AC64F78;
        Wed,  3 Feb 2021 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612368862;
        bh=2j6xZSHse5/vWFXEbPe4Tom1Lq44aH5uvDph6suuG9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l5eB50zhryrOtBzXUW4scEBTe3aL/wjCcAr3ZHeix2pDpBwHvyIdhKzAHYqizqW/f
         cZZlF+21YEl11theaYsOla92ULA6yJaldSFRJXnouRkR9ELCAIye+bpA+IZhMZSYzl
         AFrXy8OoCBCoytoRagyXbcBK3m6Z07Ixok+byyHFWipc/LUoCv6XIGsWnPi/yzVuvP
         KrmhjwyFCDahkNgsU8XpBuM7MZvc9WiAq6zeICb88KPSI9AF9CVn3cMNuQttJOEeVv
         IIQAGuoDKh6oYi60+ZvZqrexCklSHSHqsNUS7du+rjc7gUYTQioqxxT+Ln0CUXGCWb
         XqMvIut628ojA==
Received: by mail-ej1-f50.google.com with SMTP id y9so15066313ejp.10;
        Wed, 03 Feb 2021 08:14:21 -0800 (PST)
X-Gm-Message-State: AOAM533/6+ua6n7vRwEckZoYF3V380ySB1KCsPkv7wXzznrySJ0tNe6t
        iSCl7TFVd2SO+XL7X9hKVR5zGWMLPGsWLL4D3A==
X-Google-Smtp-Source: ABdhPJzUxapZjf0CiPgsCzLt+/mcXdK/9Nl57HTN8izsI5mwQlW+19VCPpmaJdV//kMXcO7RI7pnsxaDbEcORWo4gG0=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr3931340ejy.63.1612368860432;
 Wed, 03 Feb 2021 08:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20210202081237.774442-1-hsinyi@chromium.org> <20210202081237.774442-7-hsinyi@chromium.org>
In-Reply-To: <20210202081237.774442-7-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 4 Feb 2021 00:14:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pHX7nGc6hNjtoVcsjnzRbxF0eFPfBUXKrtxZ=A0HVtQ@mail.gmail.com>
Message-ID: <CAAOTY_9pHX7nGc6hNjtoVcsjnzRbxF0eFPfBUXKrtxZ=A0HVtQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] drm/mediatek: add matrix_bits private data for ccorr
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

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Add matrix_bits and coeffs_precision to ccorr private data:
> - matrix bits of mt8183 is 10
> - matrix bits of mt8192 is 11

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 27 ++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> index 6c86673a835c3..141cb36b9c07b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -30,7 +30,7 @@
>  #define DISP_CCORR_COEF_4                      0x0090
>
>  struct mtk_disp_ccorr_data {
> -       u32 reserved;
> +       u32 matrix_bits;
>  };
>
>  /**
> @@ -85,21 +85,22 @@ void mtk_ccorr_stop(struct device *dev)
>         writel_relaxed(0x0, ccorr->regs + DISP_CCORR_EN);
>  }
>
> -/* Converts a DRM S31.32 value to the HW S1.10 format. */
> -static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
> +/* Converts a DRM S31.32 value to the HW S1.n format. */
> +static u16 mtk_ctm_s31_32_to_s1_n(u64 in, u32 n)
>  {
>         u16 r;
>
>         /* Sign bit. */
> -       r =3D in & BIT_ULL(63) ? BIT(11) : 0;
> +       r =3D in & BIT_ULL(63) ? BIT(n + 1) : 0;
>
>         if ((in & GENMASK_ULL(62, 33)) > 0) {
> -               /* identity value 0x100000000 -> 0x400, */
> +               /* identity value 0x100000000 -> 0x400(mt8183), */
> +               /* identity value 0x100000000 -> 0x800(mt8192), */
>                 /* if bigger this, set it to max 0x7ff. */
> -               r |=3D GENMASK(10, 0);
> +               r |=3D GENMASK(n, 0);
>         } else {
> -               /* take the 11 most important bits. */
> -               r |=3D (in >> 22) & GENMASK(10, 0);
> +               /* take the n+1 most important bits. */
> +               r |=3D (in >> (32 - n)) & GENMASK(n, 0);
>         }
>
>         return r;
> @@ -114,6 +115,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm=
_crtc_state *state)
>         uint16_t coeffs[9] =3D { 0 };
>         int i;
>         struct cmdq_pkt *cmdq_pkt =3D NULL;
> +       u32 matrix_bits =3D ccorr->data->matrix_bits;
>
>         if (!blob)
>                 return;
> @@ -122,7 +124,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm=
_crtc_state *state)
>         input =3D ctm->matrix;
>
>         for (i =3D 0; i < ARRAY_SIZE(coeffs); i++)
> -               coeffs[i] =3D mtk_ctm_s31_32_to_s1_10(input[i]);
> +               coeffs[i] =3D mtk_ctm_s31_32_to_s1_n(input[i], matrix_bit=
s);
>
>         mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
>                       &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
> @@ -199,8 +201,13 @@ static int mtk_disp_ccorr_remove(struct platform_dev=
ice *pdev)
>         return 0;
>  }
>
> +static const struct mtk_disp_ccorr_data mt8183_ccorr_driver_data =3D {
> +       .matrix_bits =3D 10,
> +};
> +
>  static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] =3D {
> -       { .compatible =3D "mediatek,mt8183-disp-ccorr"},
> +       { .compatible =3D "mediatek,mt8183-disp-ccorr",
> +         .data =3D &mt8183_ccorr_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
