Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAB3448D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhCVPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhCVPI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B086A61983;
        Mon, 22 Mar 2021 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616425739;
        bh=3PQXyCv/6RPiauJW0RbXVxOk51+3YNHHQ4q0ubjIYI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kUnTB41nwt/2gBmhP5ra1WG35j5VTc2LbveK7j4gYYhiDA0OqxLIqzjvVOabd+9hc
         8c5/bpXntK3H7xflMSt0Th2yx9BsVEqcuI9NF4Wn6e2wP5JfgMsrPZwU+jheE+oB+K
         j/tjJr0G/YIBU/+PDC1QZVKxhpIwvNjiOY8bK+KxxcWMUKlT+SdzDnUQ8hd3QqNqt9
         z+A5Ua1kThRlsTSklCyjRjlnm4zUcqkOyECsZ0CH03GglurtOgWsP56zLSaDtfWusJ
         DoQJodK5+AjShphBYD2Pui6068ctfFfdvKYk8QbT0YAEO3PS7bcOODP+Cr1Y2UQWv4
         A2QW0y6P5PFWg==
Received: by mail-ej1-f41.google.com with SMTP id b7so21877397ejv.1;
        Mon, 22 Mar 2021 08:08:58 -0700 (PDT)
X-Gm-Message-State: AOAM531WL76KmPDptQPGwCn+ZHinOsW/EwpJzvRy5kzDFT5oKz5VOh1G
        RHn82X7kk59MFkvGQerVIXfYcNsr4PGifNefgA==
X-Google-Smtp-Source: ABdhPJy9CuEFTxVWjGKeDPfSnb0lRo8CbqOcKlR4LhHv/z1CX1/0nQw1fX42KGso9lasF9MhwTQPQqeELQ+Ao8npxVA=
X-Received: by 2002:a17:906:9888:: with SMTP id zc8mr242694ejb.310.1616425737261;
 Mon, 22 Mar 2021 08:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com> <1609815993-22744-9-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609815993-22744-9-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 22 Mar 2021 23:08:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY__HO1AJ2xjRu7B+0Xs9MRHiifQYGNz5vr-EsVkQ7NeZBA@mail.gmail.com>
Message-ID: <CAAOTY__HO1AJ2xjRu7B+0Xs9MRHiifQYGNz5vr-EsVkQ7NeZBA@mail.gmail.com>
Subject: Re: [PATCH v4, 08/10] soc: mediatek: mmsys: add component RDMA4
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:07=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component RDMA4
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

How do you think about this patch? One drm patch [1] depends on this patch.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2021020208123=
7.774442-4-hsinyi@chromium.org/

Regards,
Chun-Kuang.

> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 13546e9..2c11617 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -38,6 +38,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_RDMA0,
>         DDP_COMPONENT_RDMA1,
>         DDP_COMPONENT_RDMA2,
> +       DDP_COMPONENT_RDMA4,
>         DDP_COMPONENT_UFOE,
>         DDP_COMPONENT_WDMA0,
>         DDP_COMPONENT_WDMA1,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
