Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381E3E9B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhHKXGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232434AbhHKXGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B45C6105A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628723170;
        bh=UsOaT4gmVMtsJlz3K9nEUp4WRF9PrNQoOdiLg+j11SA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EkFP1qBEjK0Mb4zMCvRF5exzxAY/75d6muJUDKjoNyYJUPEzWv+BVbY3EDDLrLkLR
         Mo9tF0vqCaqGYN193KYYVcFKG+e0EQHEgMBS5cVBcbiV7KjYKa60QKDevbzas8qqwT
         TWMDxcahb3Lc/kUqoz1JD+XGSabDG87fu1xee/3ileHn4wNvEMYmzpYnKvSRWbgpOT
         RMZctrDRRjqRNZkQmOcF51FiuJKvFL8MjvzHWMyB/YZ0Ts2qZH4UO1WkifY0lGu/7/
         pqEW+PxGjSnTaIa2DxFfPYPqv6GAtJnFB8/WjKo8uj/zGn2sGlVvOSjYLRR2XwcGWJ
         3Rg6rAJYW/SPQ==
Received: by mail-ej1-f53.google.com with SMTP id gs8so7460015ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:06:09 -0700 (PDT)
X-Gm-Message-State: AOAM531qEFQybXsLQlW7neuVNvQtMVwi8oOJPRcynw4huS6JNLB2wVek
        JN12M1FwZaLJ76plgBwiz0KJ6/tledQ66hmHTg==
X-Google-Smtp-Source: ABdhPJxVx9j6cw6zRR+hy0FCROJIHdxukPmtOkwM48DK03ECqZ6PGm117swZuRW/lAgUJ0t+Mtru1ea+F5t65uJJCWY=
X-Received: by 2002:a17:906:4156:: with SMTP id l22mr824214ejk.75.1628723168648;
 Wed, 11 Aug 2021 16:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210810040148.17157-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20210810040148.17157-1-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 12 Aug 2021 07:05:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9+G92rhKCiZZS39VCjo6g3Zj+Ag=SeEuRtbP3c=jsSug@mail.gmail.com>
Message-ID: <CAAOTY_9+G92rhKCiZZS39VCjo6g3Zj+Ag=SeEuRtbP3c=jsSug@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Add component_del in OVL and COLOR
 remove function
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>, fshao@chromium.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=881=
0=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:02=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add component_del in OVL and COLOR remove function.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: ff1395609e20 ("drm/mediatek: Move mtk_ddp_comp_init() from sub dri=
ver to DRM driver")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> Change in v2:
> - add component_del function in COLOR remove function
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/=
mediatek/mtk_disp_color.c
> index 6f4c80bbc0eb..473f5bb5cbad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -133,6 +133,8 @@ static int mtk_disp_color_probe(struct platform_devic=
e *pdev)
>
>  static int mtk_disp_color_remove(struct platform_device *pdev)
>  {
> +       component_del(&pdev->dev, &mtk_disp_color_component_ops);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index fa9d79963cd3..5326989d5206 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -423,6 +423,8 @@ static int mtk_disp_ovl_probe(struct platform_device =
*pdev)
>
>  static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  {
> +       component_del(&pdev->dev, &mtk_disp_ovl_component_ops);
> +
>         return 0;
>  }
>
> --
> 2.18.0
>
