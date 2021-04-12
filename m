Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13035C9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhDLPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240372AbhDLPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 704B261287;
        Mon, 12 Apr 2021 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618241539;
        bh=PfUYz7ehOP36ze9zottzqYLT6YofP1E/5QKb3NCGfRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qo6XIw/903qdy+wsJUt0dbetUSiB8NAUHBi44/AgP/z3CwwzWhjQ3AoUvjMfZAZTw
         wl73pB3333TrKJY9sRfsirNKwk9kx5pYQec6YUTiIuxufuW5dIVNi1TK59Rbd420cT
         32KJjvzHLzKfOoAqS+spaOxLmlEuZ5lXv8vMMZoOXY3Kn2kNK7Zi0r1LvtIu3N9eVP
         Od4cU0zfkt0NeLyF83bVTqmPD4toeE4K0qjUaNli6+SVDc1Zy0PZmkrNY9S1bPz3ga
         BSKPU9rRItSSq3kE59IyWzgn6s3E8rOGe9X5iW3LbXy7Q1MBAyjtNlZQN3o3aUhYct
         CXLvKN1pHOqZQ==
Received: by mail-ej1-f48.google.com with SMTP id r9so20977321ejj.3;
        Mon, 12 Apr 2021 08:32:19 -0700 (PDT)
X-Gm-Message-State: AOAM533/JjFnnn+aGkKGYjHpQ5lO2h0vz7sWOYBwuSwJG8JeKg9wMNs/
        T77x3d6G8VGlZBctIbfjoDa3wEai0NQ8/SQvWw==
X-Google-Smtp-Source: ABdhPJxUH+6kFAMsFOGXnWZU4y+lM9pGKAyUVJwsXhiMUyF3mf1ypBpE74YoOYyllLOSa7Tkz/VEl3gfdNDYBpx1tEY=
X-Received: by 2002:a17:906:c348:: with SMTP id ci8mr8745246ejb.303.1618241538032;
 Mon, 12 Apr 2021 08:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210410034841.16567-1-wangli74@huawei.com>
In-Reply-To: <20210410034841.16567-1-wangli74@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 12 Apr 2021 23:32:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-qNeoZT1CorqhBrQe888tG21TF=LnPkUgymv=rQ8-YAA@mail.gmail.com>
Message-ID: <CAAOTY_-qNeoZT1CorqhBrQe888tG21TF=LnPkUgymv=rQ8-YAA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: Fix PM reference leak in mtk_crtc_ddp_hw_init()
To:     Wang Li <wangli74@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wang:

Wang Li <wangli74@huawei.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8810=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Li <wangli74@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 54ab3a324752..f1954242d8f6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -259,7 +259,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *=
mtk_crtc)
>                 drm_connector_list_iter_end(&conn_iter);
>         }
>
> -       ret =3D pm_runtime_get_sync(crtc->dev->dev);
> +       ret =3D pm_runtime_resume_and_get(crtc->dev->dev);
>         if (ret < 0) {
>                 DRM_ERROR("Failed to enable power domain: %d\n", ret);
>                 return ret;
> --
> 2.17.1
>
