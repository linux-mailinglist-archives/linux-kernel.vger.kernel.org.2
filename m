Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740EE451C67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356382AbhKPARW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355084AbhKOXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:39:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F298961B48;
        Mon, 15 Nov 2021 23:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019261;
        bh=TImIHqbp486HLuwHQvsUohXCnLk5VoW2gEDqvRP9Bv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uJTH4aXwYaa+dSQMHLezRwehNizg4YsBHW4nowq/m7HD+udnSv4giJGTdAAJuKhQd
         OWbn3oaOB7gt7gEUN4e0GyWusfn1wGRLjmgvQQj877n1sEok1yrLjVlBdNJjUpDHYW
         mBy0cE6ycLj8/jYrJLVhAexR4HvSlvcjqDuaE8vA3JkSbQrXVYdsHHOssizJV0m2Wl
         Fmh0LtLVsSrZX9GPG31ubLoOf58pUQK+n3B5rPcB7QMRw1TWKaX9d4LU+xs9zXhaVe
         Hn/LpJ2cbVCekxxaoFEOAXcMlW+NdflLDago6i+ZuZHO4eq/eqP8jk4AalYShi+UcK
         jx2t0pvwrgX9Q==
Received: by mail-ed1-f47.google.com with SMTP id z10so52659061edc.11;
        Mon, 15 Nov 2021 15:34:20 -0800 (PST)
X-Gm-Message-State: AOAM532ORZs0bUVYxOoZcFLR7gNsn+UM1BI/y5tOFS+MM4APUYHk4VMK
        KBcLNJqpVZ3r1FKahUJ+j++MJ70GOjZp4Lro1A==
X-Google-Smtp-Source: ABdhPJyigb0xM4tUbMt5283H/raL8mEwtPWWbhCfWI/2StAgMHYuqxQHh9LRuw1npThsAwOZ+I4iT2VnrXstnJeipDM=
X-Received: by 2002:aa7:d3d0:: with SMTP id o16mr3686530edr.159.1637019259273;
 Mon, 15 Nov 2021 15:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20210930155222.5861-1-yongqiang.niu@mediatek.com> <20210930155222.5861-2-yongqiang.niu@mediatek.com>
In-Reply-To: <20210930155222.5861-2-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 16 Nov 2021 07:34:08 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8++T24XmaxneZCEqiWSMmUG=EEd5Jhs+6Szn9fQACt-Q@mail.gmail.com>
Message-ID: <CAAOTY_8++T24XmaxneZCEqiWSMmUG=EEd5Jhs+6Szn9fQACt-Q@mail.gmail.com>
Subject: Re: [PATCH v10, 1/5] drm/mediatek: add component OVL_2L2
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component OVL_2L2

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 33e8789fde8a..4a2abcf3e5f9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -353,6 +353,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matche=
s[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_OVL1]    =3D { MTK_DISP_OVL,       1, &ddp_ovl },
>         [DDP_COMPONENT_OVL_2L0] =3D { MTK_DISP_OVL_2L,    0, &ddp_ovl },
>         [DDP_COMPONENT_OVL_2L1] =3D { MTK_DISP_OVL_2L,    1, &ddp_ovl },
> +       [DDP_COMPONENT_OVL_2L2] =3D { MTK_DISP_OVL_2L,    2, &ddp_ovl },
>         [DDP_COMPONENT_PWM0]    =3D { MTK_DISP_PWM,       0, NULL },
>         [DDP_COMPONENT_PWM1]    =3D { MTK_DISP_PWM,       1, NULL },
>         [DDP_COMPONENT_PWM2]    =3D { MTK_DISP_PWM,       2, NULL },
> --
> 2.25.1
>
