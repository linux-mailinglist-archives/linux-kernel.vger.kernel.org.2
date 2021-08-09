Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878673E4763
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhHIOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234570AbhHIOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:20:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F46B61052
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628518836;
        bh=9LRxU88+82ajaf5N6re5+zCpHlo2zfOM8jRPwlMyA2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ep1D8MWdd6qsC45+D94384qcGF3wKXMIn7Os6ajx0NHL0Ep01DPyMIFC71U5rYshE
         u/j4I5uCgr+Sug9+s5OeI3hwcumOW4ixjMblUxLUleLh4udWT2k6nFj07zB0zVCAmE
         NacXoSks7Xri5KXRtpHNxKGQ7cS8znosje7vuiBgEkk6sU7TolvfWlwM+D0vrkQyzu
         gnkLB4muB40f3mngZtJtHPhjYRuS5uxbaFDJ9eSg/+a/2GzaXgap4J+yVS2CzL0Mx+
         +Nk2lFIfI6PF1BCGDtAJBh8oH9RoejiTDR6gK0qmbMKUaBpAXrX4nrsntChRrqzS6K
         vDRL9pAwqh5+g==
Received: by mail-ej1-f54.google.com with SMTP id u3so29319270ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:20:36 -0700 (PDT)
X-Gm-Message-State: AOAM532L431QZbtkxI2JiMw1SKf/GA4yh/KfyxtGAmechubSKndfwvQZ
        XC9OLxbefEClx8t7wW0mTo8fOnfiIlGoyePBzQ==
X-Google-Smtp-Source: ABdhPJzx0TkKSySgoxITRUizZYSlaMcXitMA6PjSwWV3of8/FHgQGibBSMEC+8T7JOaUryygvDhhlA38CwdbCmy0Cis=
X-Received: by 2002:a17:906:fcd7:: with SMTP id qx23mr9314897ejb.267.1628518834966;
 Mon, 09 Aug 2021 07:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210712181209.27023-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20210712181209.27023-1-dafna.hirschfeld@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 9 Aug 2021 22:20:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY__vy0n_Sw+8a_4h7Er_qdt72x964Dc_uunLg88qx8wPGg@mail.gmail.com>
Message-ID: <CAAOTY__vy0n_Sw+8a_4h7Er_qdt72x964Dc_uunLg88qx8wPGg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Test component initialization earlier in
 the function mtk_drm_crtc_create
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dafna:

Dafna Hirschfeld <dafna.hirschfeld@collabora.com> =E6=96=BC 2021=E5=B9=B47=
=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:12=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> The initialization is currently tested in a later stage in
> the function for no reason.
> In addition, the test '!comp' will never fail since comp is
> set with the '&' operator. Instead, test if a comp was not
> initialized by testing "!comp->dev".

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 474efb844249..06f40e589922 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -755,14 +755,22 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         for (i =3D 0; i < path_len; i++) {
>                 enum mtk_ddp_comp_id comp_id =3D path[i];
>                 struct device_node *node;
> +               struct mtk_ddp_comp *comp;
>
>                 node =3D priv->comp_node[comp_id];
> +               comp =3D &priv->ddp_comp[comp_id];
> +
>                 if (!node) {
>                         dev_info(dev,
>                                  "Not creating crtc %d because component =
%d is disabled or missing\n",
>                                  pipe, comp_id);
>                         return 0;
>                 }
> +
> +               if (!comp->dev) {
> +                       dev_err(dev, "Component %pOF not initialized\n", =
node);
> +                       return -ENODEV;
> +               }
>         }
>
>         mtk_crtc =3D devm_kzalloc(dev, sizeof(*mtk_crtc), GFP_KERNEL);
> @@ -787,16 +795,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 enum mtk_ddp_comp_id comp_id =3D path[i];
>                 struct mtk_ddp_comp *comp;
> -               struct device_node *node;
>
> -               node =3D priv->comp_node[comp_id];
>                 comp =3D &priv->ddp_comp[comp_id];
> -               if (!comp) {
> -                       dev_err(dev, "Component %pOF not initialized\n", =
node);
> -                       ret =3D -ENODEV;
> -                       return ret;
> -               }
> -
>                 mtk_crtc->ddp_comp[i] =3D comp;
>
>                 if (comp->funcs) {
> --
> 2.17.1
>
