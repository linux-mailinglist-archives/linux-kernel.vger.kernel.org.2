Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DE43D781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJ0XdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJ0XdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:33:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1E7D610E5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635377448;
        bh=Tn75VzarQbc5QgLHek0RK4HW2XH2u4J1JDqisUkgpqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UJekR0JZaL9yDHPomHOW1TXTbkxwC8wWAMo9qu2ELak/JzDOgggi4ow3k2KFciFjS
         JaXYwfLmT1zMZEAZ8uHScJtnHoTRG5ZxgKCwitOQpHftd6KDjD0tR9OrNWTZ0YS+yI
         OG3ZGmBj5YAjVYL3acF9GyXkwXsbTOmVi1dEDh5OsaqEKv5zXYLA3xyPjuCsuZ82s1
         0kD4uioaNCUNSZGhz5VllceNEBMKM3dlaLFJYygYoBYjhliGgCvpliwAkJ3QIDs2R7
         V/EeuwdSHMa2zIe89HRo+Zbc0UCLcN9MSpcPXevZXFrBoGdVGFSMGx9zD1PbSTqEmz
         5/cyuhbW2Xvuw==
Received: by mail-ed1-f50.google.com with SMTP id 5so16484990edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:30:48 -0700 (PDT)
X-Gm-Message-State: AOAM530YdgK6JQkw+B8d+OqsE/LJ2Kn6UkpdN8gtJqUeTH9UgXTHVd8O
        kYpcFQu2alZ6IyHS4lY9LZUXJ6KtmCrGseGJcQ==
X-Google-Smtp-Source: ABdhPJzUHykGHts37AdltmTcOjjKPYdJdGgU/ReeYi6xz9u0NbxyDwQULshIj1Ado65mhw4sC4r/wUEqBnoJ9X7sBhw=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr1131395edu.357.1635377447059;
 Wed, 27 Oct 2021 16:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211027021857.20816-1-jason-jh.lin@mediatek.com> <20211027021857.20816-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20211027021857.20816-6-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 28 Oct 2021 07:30:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85V6HHaK4LT+jUyJ9-0dh4KgtLfS-ZBconLja0_S2wbg@mail.gmail.com>
Message-ID: <CAAOTY_85V6HHaK4LT+jUyJ9-0dh4KgtLfS-ZBconLja0_S2wbg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm/mediatek: Add mbox_free_channel in mtk_drm_crtc_destroy
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fshao@chromium.org,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
27=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add mbox_free_channel in mtk_drm_crtc_destroy.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index ffa54b416ca7..31f05efc1bc0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -156,6 +156,10 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *cr=
tc)
>         mtk_mutex_put(mtk_crtc->mutex);
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
> +
> +       if (mtk_crtc->cmdq_client.chan)
> +               mbox_free_channel(mtk_crtc->cmdq_client.chan);
> +                                 mtk_crtc->cmdq_client.chan =3D NULL;

Except the indent,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>  #endif
>         drm_crtc_cleanup(crtc);
>  }
> --
> 2.18.0
>
