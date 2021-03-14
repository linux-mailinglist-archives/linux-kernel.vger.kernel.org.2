Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E456333A236
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 02:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhCNBnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 20:43:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhCNBmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 20:42:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BDB164EDC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615686167;
        bh=d8r78DmHZoQq/Xpde3tw/rQjLBC2qxYXAEfmbWF2bP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fakOty/OHbvQxSv2CtMch+TMWS3l3uxOlWFWgIOsf5/SWb4lrzStEhsizPP5RLg6V
         Q+pvjsfXPOJPtRs1KgdewqNbHbyKeO2zjqT4o58dbM0DuaxkibyaU2wvOchRXcgF/H
         y9yxakpcigDKbdLQcPyKJWjSNHmS8ooxB3BFyCXRq07lXU4S+/4EKgtQgcVzo7HfR8
         1wIF9lLesMSM5zYdUo1NRs2sGDtH8V1qbVUDk7OM1k0tA+n+5XLKwE0ZX8K/dIZYni
         /hWCSNVE/Madwf4ON7yaoghCRkgdXGRVz4l+N1jmibwnPiyLdkwcwvj+xQHGhCju2j
         GuE1gKc+EAjuA==
Received: by mail-ej1-f52.google.com with SMTP id bm21so60522528ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 17:42:47 -0800 (PST)
X-Gm-Message-State: AOAM531DD0CYsQCxDYr/y9oWuGwxV1IXxd3lIsOFORyslpf9YtOzUCb9
        oNWOqdYvJ2CHimfE1r89redaUX8dYavQMcU5ZQ==
X-Google-Smtp-Source: ABdhPJwt7yggnfbLt0nEaJTQ57OcD/f1c2ihvZExUaKqy5DsREVzfjShGFYpeA+UzbmIb8LIcItruBFVhr25lUHDo/U=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr16649455ejy.63.1615686165972;
 Sat, 13 Mar 2021 17:42:45 -0800 (PST)
MIME-Version: 1.0
References: <1615621683-2122-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1615621683-2122-1-git-send-email-wangqing@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 14 Mar 2021 09:42:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY__77A5ckALr=dxXK4zV3sbm_84_m9Bo0nBKBxPMMv2sxQ@mail.gmail.com>
Message-ID: <CAAOTY__77A5ckALr=dxXK4zV3sbm_84_m9Bo0nBKBxPMMv2sxQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: mediatek: delete redundant printing of return value
To:     Wang Qing <wangqing@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wang:

Wang Qing <wangqing@vivo.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8813=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> platform_get_irq() has already checked and printed the return value,
> the printing here is nothing special, it is not necessary at all.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index b05f900..0ac4962
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -751,10 +751,8 @@ static int mtk_dpi_probe(struct platform_device *pde=
v)
>         }
>
>         dpi->irq =3D platform_get_irq(pdev, 0);
> -       if (dpi->irq <=3D 0) {
> -               dev_err(dev, "Failed to get irq: %d\n", dpi->irq);
> +       if (dpi->irq <=3D 0)
>                 return -EINVAL;
> -       }
>
>         ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>                                           NULL, &dpi->next_bridge);
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
