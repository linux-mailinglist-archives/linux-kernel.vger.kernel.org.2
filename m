Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7A445CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKEAD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232435AbhKEADZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:03:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EADE6121E;
        Fri,  5 Nov 2021 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636070446;
        bh=gecQ0nukzSqLw2rZdP9krP19f9e4VSUL6mOBSXKSTkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mK4Mr1FteUnVP4YznUeFazG/YgAGzji5dNB8U9oXl9/J2au6HJlsFtPKH3c/vrr9R
         nBjRXntR4RCXAfvkn2rfwnBtZ0vdOBKxI69bXnXKLVRGPe1rz43MTypJv3VoavIvQd
         XCCkiLhsV7icEhCsC+lbJJgG/OC15dNBohIURONMEaYly9uc6+M9USvPUoxZVdvzs0
         pNzEyrqgWdlOzyIxaefijWzhak/3bJe282XXuYAzvsX1evgPmaRstHb5oggZr2+RVm
         w9BkU+arQa4O0qjhJwuMRkf59ckoCRGfnXgNcVPbvX9iF9A7NOG3nN9zLpG6mhikB7
         Hw7Ex91dkoIdA==
Received: by mail-ed1-f50.google.com with SMTP id ee33so27316182edb.8;
        Thu, 04 Nov 2021 17:00:46 -0700 (PDT)
X-Gm-Message-State: AOAM533zqctJeDigIPbp32zLdSysrwyfHWYDtiyvQ+QaDDd9iVGXJswD
        4zJPOvUDmb07tLjYYX8d+y35/maJYpDPDVtP0Q==
X-Google-Smtp-Source: ABdhPJx/WMm8hJQXmws5vs/A8Eq/kJboI9Ajg4xbaZCnrwqe3NFwsFluqpKG7WJR/yu5SJJOXENMxG3a9r06A35Nhwg=
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr524429ejc.388.1636070444817;
 Thu, 04 Nov 2021 17:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211029075203.17093-1-nancy.lin@mediatek.com> <20211029075203.17093-18-nancy.lin@mediatek.com>
In-Reply-To: <20211029075203.17093-18-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 5 Nov 2021 08:00:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-PMzZu-nKweOpL_ybEPAaGD4PpaO=7zsY2rb=B8ubG3A@mail.gmail.com>
Message-ID: <CAAOTY_-PMzZu-nKweOpL_ybEPAaGD4PpaO=7zsY2rb=B8ubG3A@mail.gmail.com>
Subject: Re: [PATCH v7 17/20] drm/mediatek: add mediatek-drm plane color
 encoding info
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nancy:

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add plane color encoding information for color space conversion.
> It's a preparation for adding support for mt8195 ovl_adaptor mdp_rdma
> csc control.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_plane.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index 734a1fb052df..81bd5d6e8df5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -137,6 +137,7 @@ static void mtk_plane_update_new_state(struct drm_pla=
ne_state *new_state,
>         mtk_plane_state->pending.width =3D drm_rect_width(&new_state->dst=
);
>         mtk_plane_state->pending.height =3D drm_rect_height(&new_state->d=
st);
>         mtk_plane_state->pending.rotation =3D new_state->rotation;
> +       mtk_plane_state->pending.color_encoding =3D new_state->color_enco=
ding;
>  }
>
>  static void mtk_plane_atomic_async_update(struct drm_plane *plane,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.h
> index d454bece9535..2d5ec66e3df1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
> @@ -24,6 +24,7 @@ struct mtk_plane_pending_state {
>         bool                            dirty;
>         bool                            async_dirty;
>         bool                            async_config;
> +       enum drm_color_encoding         color_encoding;
>  };
>
>  struct mtk_plane_state {
> --
> 2.18.0
>
