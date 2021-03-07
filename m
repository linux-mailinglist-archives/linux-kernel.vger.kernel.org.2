Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CFA32FE35
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 01:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCGA3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 19:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhCGA3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 19:29:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D393650D9;
        Sun,  7 Mar 2021 00:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615076952;
        bh=Qm+1G7d1VFcN2FM2tw3fh8YNKthWT/QzzdjeOnpB8Gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fYMeKBDefy8adzWFmPEVaCn9JjNP53bOH8lHJtoCNmiKoEiooKcRTceDmFXuwjs1H
         f1YukAC8x1Rt14Om2H8zVYovJtx0BCrz6K6phb2GVda1KqSLxforFLIKHW+yvK/DOZ
         4G9rrhLHxzxMUgHaVURus2sn8WS4GdLN9eQaM5L+iXdIMUElIJlKbLCWlNkOTPXDvo
         5s6gdqfNmTg4KSMs9G/MmI1Z3pvAiFSqnp1QmcVz+pDrLwq3qYCvo6u3v9Q34UHoqN
         t63GfZXovqK7rhmkuLCuxJFHg1YbO6AwHdauu+eRCuILFKW2giOIzdf8WV4C9bOrQ1
         HhOzh8lUyb+bA==
Received: by mail-ej1-f48.google.com with SMTP id r17so12326936ejy.13;
        Sat, 06 Mar 2021 16:29:12 -0800 (PST)
X-Gm-Message-State: AOAM533fA6YBQxVw/TQQPP3ybA89KsjhQDsCTZWlGk6wpHYiMT1B/CF4
        mgtHxkU+PzkadWWO/rvdECMUKqFs8Q5MYphJyA==
X-Google-Smtp-Source: ABdhPJx86dxHMYU804TmHhrl6hB/nQz8DTF31DqqLkgoli8x+pMuP9LbNuzOW5+hFr6RSCcgkkx4FdK+v0a/8wRS+bw=
X-Received: by 2002:a17:906:b102:: with SMTP id u2mr8671789ejy.303.1615076950598;
 Sat, 06 Mar 2021 16:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20210201033603.12616-1-jitao.shi@mediatek.com> <20210201033603.12616-2-jitao.shi@mediatek.com>
In-Reply-To: <20210201033603.12616-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 7 Mar 2021 08:28:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_99y=wqdspKbcx_kyRRQhzDtPvjrAdn4jzeyhADjnhZgw@mail.gmail.com>
Message-ID: <CAAOTY_99y=wqdspKbcx_kyRRQhzDtPvjrAdn4jzeyhADjnhZgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/mediatek: dsi: Fix EoTp flag
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> SoC will transmit the EoTp (End of Transmission packet) when
> MIPI_DSI_MODE_EOT_PACKET flag is set.

I've modified the title and message as:

drm/mediatek: dsi: Use symbolized register definition

For HSTX_CKLP_EN and DIS_EOT, use symbolized register
definition instead of magic number.


And applied to mediatek-drm-next [1], thanks.

https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/=
?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.


>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 65fd99c528af..2bc46f2350f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -401,8 +401,11 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi=
)
>                 break;
>         }
>
> -       tmp_reg |=3D (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) <<=
 6;
> -       tmp_reg |=3D (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
> +       if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
> +               tmp_reg |=3D HSTX_CKLP_EN;
> +
> +       if (!(dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET))
> +               tmp_reg |=3D DIS_EOT;
>
>         writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>  }
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
