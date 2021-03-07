Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA132FE38
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 01:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCGAau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 19:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhCGAaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 19:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 354DF64F09;
        Sun,  7 Mar 2021 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615077025;
        bh=uJwXubSaOLTt7He4mvFNkPoPWLDyc08NNbEFTffP5l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j4MbRNNUmEswJ2GkrZPTMQ6/C/vz7TUhGrgd2hQkHC16WNbiHBqF4EieYFrMdwQK6
         R3BK+U2hz0I9Bux1sOMv/s0TdCl6tpozUKhjwwzcRHGZYs/vJ1IHB9a7C4fVvMab2+
         yQNHSvkbhsn91uRi4LStWTdXjnR4E1NSH8RdRXlo5Ey7kFY8eBfJr+CGiVvGuPkiPy
         5eksEqvOcmuBSZGPc1ZkBLqGdAxuNhNG8EX1U+l/aRW0BZ8S27FRYxbLZeqrLU9wIY
         6+sKjBha8ADITStjwB0GyfZ0yOp9vpaGKzJmGvS0IHfIr7k+01DeRK0E/7uk6IHaYv
         JeI5ItiHK8p3A==
Received: by mail-ej1-f42.google.com with SMTP id w1so12365963ejf.11;
        Sat, 06 Mar 2021 16:30:25 -0800 (PST)
X-Gm-Message-State: AOAM532YqZb1V8SQ2Ucn+EagenkwfDnOFcsujYLIbZGidVTeTPS+SPzQ
        tT+9dRdShhBsFyFdrxFRPNN/N3yUXXMnyzAhEg==
X-Google-Smtp-Source: ABdhPJzkevcLiDsincX3P/xDWHQn213RalKdvB/BL2ujct31lwjYiYLZ5AyLmSo+zrQMgDe32l0l5PXBMIfb1+LDPRE=
X-Received: by 2002:a17:906:400b:: with SMTP id v11mr8684303ejj.194.1615077023864;
 Sat, 06 Mar 2021 16:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20210201033603.12616-1-jitao.shi@mediatek.com> <20210201033603.12616-3-jitao.shi@mediatek.com>
In-Reply-To: <20210201033603.12616-3-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 7 Mar 2021 08:30:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8cvuEx49SseiCDcVTdZbT6JMFKUH7t6tvaGoHy7T4dEg@mail.gmail.com>
Message-ID: <CAAOTY_8cvuEx49SseiCDcVTdZbT6JMFKUH7t6tvaGoHy7T4dEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/mediatek: dsi: fine tune the line time cause
 by EOTp
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
> Enabling EoTp will make the line time larger, so the hfp and
> hbp should be reduced to keep line time.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 2bc46f2350f1..8c70ec39bfe1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -481,6 +481,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>                           timing->da_hs_zero + timing->da_hs_exit + 3;
>
>         delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
> +       delta +=3D dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET ? 2 : 0;
>
>         horizontal_frontporch_byte =3D vm->hfront_porch * dsi_tmp_buf_bpp=
;
>         horizontal_front_back_byte =3D horizontal_frontporch_byte + horiz=
ontal_backporch_byte;
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
