Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC383369DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhDXA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232614AbhDXA0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 870D161476
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 00:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619223948;
        bh=hhjXoFOS7MULhaH2eAbg6aq5dkXrvOaI7xjS7HFqXe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GK0G8zXN66tUHlussUN5Vjc/K9oqAXRK0abA6s2QxZ3tq7fsDvvuIjbGa3BUDZ99N
         zitv2zz9omc0KoAjqrKMIsTu3lNQ/Ac5+39OZb6THfNzGyzgeVDL8ffkbFiyhIt/TK
         uTbPFThojEWgWHZhFvH0eIpWdYHX3xWGBDUPg86ryNd3EdzH7v6nZmANtvSW5+Kw2t
         3ZgeECGqb+I6TYT0WPYu1de7+OCaUEyBGi4vmvKtlvSY9i9kZt7Wp3M0olYVslN4UN
         8//viqJDSSgxHHdmz33CLjDjOH8tID7a4Lz3o7qOQ9P8MR2otzLTyKllx4cJ65069B
         z1gINSiwDiHNA==
Received: by mail-ed1-f44.google.com with SMTP id h8so19121575edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:25:48 -0700 (PDT)
X-Gm-Message-State: AOAM5332D+lVPSorwRR+jpJd6Zz/mDhmGz2OHpYfn8caDSNQ04gQqYq7
        vAOZ3AAUziyzVjiXCrzrxRuHsu7hjKXU8Jr5og==
X-Google-Smtp-Source: ABdhPJxBTXib/RTXK9IEyyqRWQN2gM044cLDarwNUaBYySdbYao+uXwAkbPJ8CvcyZEI+UG1zkDReajVBv2wkbv96lQ=
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr7578022eds.166.1619223947148;
 Fri, 23 Apr 2021 17:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210419073244.2678688-1-narmstrong@baylibre.com> <20210419073244.2678688-6-narmstrong@baylibre.com>
In-Reply-To: <20210419073244.2678688-6-narmstrong@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 24 Apr 2021 08:25:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9PyKK4+gqiU4aP48fB-y34EdW7RULBxOfU2KU+V1toXw@mail.gmail.com>
Message-ID: <CAAOTY_9PyKK4+gqiU4aP48fB-y34EdW7RULBxOfU2KU+V1toXw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] gpu/drm: mediatek: hdmi: add MT8167 configuration
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil:

Neil Armstrong <narmstrong@baylibre.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=881=
9=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The MT8167 SoC have a hard limit on the maximal supported HDMI TMDS clock=
,
> and is not validated and supported for HDMI modes out of HDMI CEA modes,
> so add a configuration entry linked to the MT8167 compatible.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index bc50d97f2553..c1651a83700d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1787,10 +1787,18 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_m=
t2701 =3D {
>         .tz_disabled =3D true,
>  };
>
> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 =3D {
> +       .max_mode_clock =3D 148500,
> +       .cea_modes_only =3D true,
> +};
> +
>  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-hdmi",
>           .data =3D &mtk_hdmi_conf_mt2701,
>         },
> +       { .compatible =3D "mediatek,mt8167-hdmi",
> +         .data =3D &mtk_hdmi_conf_mt8167,
> +       },
>         { .compatible =3D "mediatek,mt8173-hdmi",
>         },
>         {}
> --
> 2.25.1
>
