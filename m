Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7438451C63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbhKPARJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355091AbhKOXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:39:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2871163258;
        Mon, 15 Nov 2021 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019297;
        bh=FVoHwv6pHc6/6XgellUtHB1/7EFg1uG9jPVCejpir7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qsl+5FNENbc0k27C3spFWxSg6s8O7fi7SluuoB5HnfClaxMEDiVlwxbNPRSlX6cAM
         TO2rnQ5fssRyJU2YXnQVwWcx00vE6rWoed64fA14OSlUdizF4ccQWT3+CmBMl4eWj2
         yiYHP2nMoBJ5owOEpyk1CPf0KoZ0wH5kMxwylJIZ7SxzmmPf0zPDIpAkYrDeZv1+sN
         umbo0G9OF9Ysjal6vS5K1f69PuXGtUvouExEXeSCDyKRI5BfHlU4eo4vj55qp5lZ0d
         N+4BDECfWJtAhzEXU44QqV3p7THZNxVp6613mDYHZ9HJTK8PTOv3NpM7UukZQSnfMm
         5Y6Rg8GP2lnhg==
Received: by mail-ed1-f51.google.com with SMTP id m20so33341507edc.5;
        Mon, 15 Nov 2021 15:34:57 -0800 (PST)
X-Gm-Message-State: AOAM532HoMbWjHzfWoY8WLRkV//p0pb9ROiqjqwxvhUqY6MceDEX1hXJ
        KZkqivWP4/jCxfEnYea83NSArBKDhuUoAwJ+Kg==
X-Google-Smtp-Source: ABdhPJyAPUR8GQnQdfQ/dYtoPvmL7xu/FHsDaxqbWig0ok/Gn8g9Eu8SXqp+w5jYbe0YDdBmmqGHHyMrlvvqlvxjdb0=
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr3449107ejo.511.1637019295668;
 Mon, 15 Nov 2021 15:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20210930155222.5861-1-yongqiang.niu@mediatek.com> <20210930155222.5861-4-yongqiang.niu@mediatek.com>
In-Reply-To: <20210930155222.5861-4-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 16 Nov 2021 07:34:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8DPwrJMR3rJXHbBw31ex40h=T_e=Y+v8y_1CfbL1BYBQ@mail.gmail.com>
Message-ID: <CAAOTY_8DPwrJMR3rJXHbBw31ex40h=T_e=Y+v8y_1CfbL1BYBQ@mail.gmail.com>
Subject: Re: [PATCH v10, 3/5] drm/mediatek: add component RDMA4
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
> This patch add component RDMA4

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
> index 89170ad825fd..6491eadf34c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -402,6 +402,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matche=
s[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_RDMA0]           =3D { MTK_DISP_RDMA,      0, &ddp=
_rdma },
>         [DDP_COMPONENT_RDMA1]           =3D { MTK_DISP_RDMA,      1, &ddp=
_rdma },
>         [DDP_COMPONENT_RDMA2]           =3D { MTK_DISP_RDMA,      2, &ddp=
_rdma },
> +       [DDP_COMPONENT_RDMA4]           =3D { MTK_DISP_RDMA,      4, &ddp=
_rdma },
>         [DDP_COMPONENT_UFOE]            =3D { MTK_DISP_UFOE,      0, &ddp=
_ufoe },
>         [DDP_COMPONENT_WDMA0]           =3D { MTK_DISP_WDMA,      0, NULL=
 },
>         [DDP_COMPONENT_WDMA1]           =3D { MTK_DISP_WDMA,      1, NULL=
 },
> --
> 2.25.1
>
