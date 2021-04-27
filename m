Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471A736C8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhD0Pe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhD0Pe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB75560FE3;
        Tue, 27 Apr 2021 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619537653;
        bh=nRjupLfRtOC1jx4QARvFWp92/DopAWZE+CYvOd1QYs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xf7xrFh15+85qDBGqvjtGZcA6XAk5idTyN4iVWB48cXzrK1wlXyVc9fouKZpB7AjH
         Jju0aYIUHCE1wy6WooMwCPVUeU0XUTFgWWc2B6rxq66IPYL0EjamfS70sXohNoCjQu
         NnnZvlExEMa0rr0Gn+7tchsamcn0byq8AZWrmucpVvK6eA+nRoQriSQi2F5cDM7ZSD
         WRrLRplQZVpE/CgPnxzjtuGINBoM4Kj4DmyYSlEj2Fphte4bBeR/TcFlnXQ17+WxLD
         LZYSucpWRR0mxfQQWuN/FQm/zphGSBo/NYdKMb7+S+x6RRgGZwtIsbY9qUJpjY3tTI
         1eeJ5KyxyiIFg==
Received: by mail-ej1-f42.google.com with SMTP id u3so11436171eja.12;
        Tue, 27 Apr 2021 08:34:13 -0700 (PDT)
X-Gm-Message-State: AOAM532iqrXoapJsBe9LuTEK2lEATrhXWyQUQYo0tbP9hDbzIo07FJ+e
        aVIBv1zFZJwVuvdHeNKBNsuaVikVrBvrkNcgDw==
X-Google-Smtp-Source: ABdhPJwN/fh94a1wvQ0KAftdjjUovYxqjRpSBzYoykWjVdlI+hza7uurmQ86UUDbKXyp07MoytDPBVCc0xoBWlV1ncY=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr2818134ejb.310.1619537652286;
 Tue, 27 Apr 2021 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210427044948.12596-1-hsinyi@chromium.org> <20210427044948.12596-2-hsinyi@chromium.org>
In-Reply-To: <20210427044948.12596-2-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 27 Apr 2021 23:34:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__6agGjApVEkAyhPdV46qTjWdHODBGD_VQcYf5PRhF-hA@mail.gmail.com>
Message-ID: <CAAOTY__6agGjApVEkAyhPdV46qTjWdHODBGD_VQcYf5PRhF-hA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/mediatek: init panel orientation property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Init panel orientation property after connector is initialized. Let the
> panel driver decides the orientation value later.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index ae403c67cbd9..0bd27872f2a4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -964,6 +964,7 @@ static int mtk_dsi_encoder_init(struct drm_device *dr=
m, struct mtk_dsi *dsi)
>                 ret =3D PTR_ERR(dsi->connector);
>                 goto err_cleanup_encoder;
>         }
> +       drm_connector_init_panel_orientation_property(dsi->connector);

Process the return value.

Regards,
Chun-Kuang.

>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
>         return 0;
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
