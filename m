Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554343D0F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhGUMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhGUMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:25:34 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15238C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:06:11 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id c20so798905uar.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sE5V6logeIB6yN4Rh0mfzUJ1rGMZI822LGADa05C45E=;
        b=Bj7bk/C1PKkuSzV5YRthYWTCkuufUKTTiVbPn4NU1EPzJdN8DRLfPg6ae8XCATPHBq
         pd+kUYv9wqu2Rr+Y6yw7c/BUKey/G2MxviKwFxh/HOdNK7Ui5sbpLQ0o+eOECLOrZ8wL
         pdVA1KzoZq1MjDKOvgaP1gL63WJWVdsOK0OBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sE5V6logeIB6yN4Rh0mfzUJ1rGMZI822LGADa05C45E=;
        b=bZJylB0I9j8lJPO3TwEfwp77+OxUOAUfhRc2qsbMvBhws+RzEZFNFE4p8WN+oAReuu
         iLHvqvgk44rOQ0iFBVHDU/U3izwf5dUN+8nVQbCdq6k29XbRd6K3AD6SCe+/dk7f/Cfj
         FXRjR0mI12qnklxBEX0gacHpR0PNfu1v8gDc/ZNhMV23x6F6eKntvL+a2RfAWgV0sUAP
         ZUrQI/djPZ38ZnFK43eDPJJEoDfqfzLbT32gZ6YEXkRLnz4GQtvjGQ8ZCtEPFL/PP5h9
         PLVnNuYQR2Rje1UwR+f/Odwd2U0x3utg6dMy8Ep3Ckp6cs69qVyAJIRw7aToBt9pkuPJ
         F+2g==
X-Gm-Message-State: AOAM532NeWk/9vEqR0U6rxqYm0yBiK9G7F3hwEYQmZABN9FdJSc/UgEr
        APtcCMqHTdZVPO6KdQNHmUtYCzFSrI5fUlTu
X-Google-Smtp-Source: ABdhPJxlywv4JTEFYIloZ8aaaE85ALjwcrfb4dXyCLSKB4hzdVp6cBowTCrtiZbVFtZg8eYbE2b+dg==
X-Received: by 2002:ab0:140e:: with SMTP id b14mr36923274uae.94.1626872769527;
        Wed, 21 Jul 2021 06:06:09 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id j7sm3360193vsn.24.2021.07.21.06.06.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 06:06:08 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id k9so512614vki.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:06:08 -0700 (PDT)
X-Received: by 2002:a1f:ae4e:: with SMTP id x75mr31887451vke.2.1626872768157;
 Wed, 21 Jul 2021 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210720074734.22287-1-jason-jh.lin@mediatek.com> <20210720074734.22287-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20210720074734.22287-2-jason-jh.lin@mediatek.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Wed, 21 Jul 2021 09:05:29 -0400
X-Gmail-Original-Message-ID: <CAOw6vbLuhmRwWSUx9ODP59VK6Xe=RzLwGOn6FB=OLxs04oQmbw@mail.gmail.com>
Message-ID: <CAOw6vbLuhmRwWSUx9ODP59VK6Xe=RzLwGOn6FB=OLxs04oQmbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm/mediatek: Fix cursor plane didn't update
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        fshao@chromium.org, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        singo.chang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nancy.lin@mediatek.com, linux-mediatek@lists.infradead.org,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        David-YH.Chiu@mediatek.com, Hsin-Yi Wang <hsinyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 3:47 AM jason-jh.lin <jason-jh.lin@mediatek.com> wr=
ote:
>
> The cursor plane should use the current plane state hook in
> atomic_async_update because it would not be the new plane state in
> the global atomic state, since drm_atomic_helper_swap_state happened
> when those plane state hook are run.
>
> Fix cursor plane didn't update issue by below modification:
> 1. Remove plane_helper_funcs->atomic_update(plane, state) in
>    mtk_drm_crtc_async_update.
> 2. Add mtk_drm_update_new_state into mtk_plane_atomic_async_update to
>    update the cursor plane by current plane state hook and add it into
>    mtk_plane_atomic_update to update others plane by the new_state.
>
> Fixes: 37418bf14c13 ("drm: Use state helper instead of the plane state po=
inter")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |  1 -
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 60 ++++++++++++++----------
>  2 files changed, 34 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 474efb844249..063c75bab3a8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -538,7 +538,6 @@ void mtk_drm_crtc_async_update(struct drm_crtc *crtc,=
 struct drm_plane *plane,
>         if (!mtk_crtc->enabled)
>                 return;
>
> -       plane_helper_funcs->atomic_update(plane, state);

plane_helper_funcs is now unused

../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:578:39: warning: unused
variable =E2=80=98plane_helper_funcs=E2=80=99 [-Wunused-variable]

>
>         mtk_drm_crtc_update_config(mtk_crtc, false);
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index b5582dcf564c..e6dcb34d3052 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -110,6 +110,35 @@ static int mtk_plane_atomic_async_check(struct drm_p=
lane *plane,
>                                                    true, true);
>  }
>
> +static void mtk_plane_update_new_state(struct drm_plane_state *new_state=
,
> +                                      struct mtk_plane_state *mtk_plane_=
state)
> +{
> +       struct drm_framebuffer *fb =3D new_state->fb;
> +       struct drm_gem_object *gem;
> +       struct mtk_drm_gem_obj *mtk_gem;
> +       unsigned int pitch, format;
> +       dma_addr_t addr;
> +
> +       gem =3D fb->obj[0];
> +       mtk_gem =3D to_mtk_gem_obj(gem);
> +       addr =3D mtk_gem->dma_addr;
> +       pitch =3D fb->pitches[0];
> +       format =3D fb->format->format;
> +
> +       addr +=3D (new_state->src.x1 >> 16) * fb->format->cpp[0];
> +       addr +=3D (new_state->src.y1 >> 16) * pitch;
> +
> +       mtk_plane_state->pending.enable =3D true;
> +       mtk_plane_state->pending.pitch =3D pitch;
> +       mtk_plane_state->pending.format =3D format;
> +       mtk_plane_state->pending.addr =3D addr;
> +       mtk_plane_state->pending.x =3D new_state->dst.x1;
> +       mtk_plane_state->pending.y =3D new_state->dst.y1;
> +       mtk_plane_state->pending.width =3D drm_rect_width(&new_state->dst=
);
> +       mtk_plane_state->pending.height =3D drm_rect_height(&new_state->d=
st);
> +       mtk_plane_state->pending.rotation =3D new_state->rotation;
> +}
> +
>  static void mtk_plane_atomic_async_update(struct drm_plane *plane,
>                                           struct drm_atomic_state *state)
>  {
> @@ -126,8 +155,10 @@ static void mtk_plane_atomic_async_update(struct drm=
_plane *plane,
>         plane->state->src_h =3D new_state->src_h;
>         plane->state->src_w =3D new_state->src_w;
>         swap(plane->state->fb, new_state->fb);
> -       new_plane_state->pending.async_dirty =3D true;
>
> +       mtk_plane_update_new_state(new_state, new_plane_state);
> +       wmb(); /* Make sure the above parameters are set before update */
> +       new_plane_state->pending.async_dirty =3D true;
>         mtk_drm_crtc_async_update(new_state->crtc, plane, state);
>  }
>
> @@ -189,14 +220,8 @@ static void mtk_plane_atomic_update(struct drm_plane=
 *plane,
>         struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_st=
ate(state,
>                                                                          =
  plane);
>         struct mtk_plane_state *mtk_plane_state =3D to_mtk_plane_state(ne=
w_state);
> -       struct drm_crtc *crtc =3D new_state->crtc;
> -       struct drm_framebuffer *fb =3D new_state->fb;
> -       struct drm_gem_object *gem;
> -       struct mtk_drm_gem_obj *mtk_gem;
> -       unsigned int pitch, format;
> -       dma_addr_t addr;
>
> -       if (!crtc || WARN_ON(!fb))
> +       if (!new_state->crtc || WARN_ON(!new_state->fb))
>                 return;
>
>         if (!new_state->visible) {
> @@ -204,24 +229,7 @@ static void mtk_plane_atomic_update(struct drm_plane=
 *plane,
>                 return;
>         }
>
> -       gem =3D fb->obj[0];
> -       mtk_gem =3D to_mtk_gem_obj(gem);
> -       addr =3D mtk_gem->dma_addr;
> -       pitch =3D fb->pitches[0];
> -       format =3D fb->format->format;
> -
> -       addr +=3D (new_state->src.x1 >> 16) * fb->format->cpp[0];
> -       addr +=3D (new_state->src.y1 >> 16) * pitch;
> -
> -       mtk_plane_state->pending.enable =3D true;
> -       mtk_plane_state->pending.pitch =3D pitch;
> -       mtk_plane_state->pending.format =3D format;
> -       mtk_plane_state->pending.addr =3D addr;
> -       mtk_plane_state->pending.x =3D new_state->dst.x1;
> -       mtk_plane_state->pending.y =3D new_state->dst.y1;
> -       mtk_plane_state->pending.width =3D drm_rect_width(&new_state->dst=
);
> -       mtk_plane_state->pending.height =3D drm_rect_height(&new_state->d=
st);
> -       mtk_plane_state->pending.rotation =3D new_state->rotation;
> +       mtk_plane_update_new_state(new_state, mtk_plane_state);
>         wmb(); /* Make sure the above parameters are set before update */
>         mtk_plane_state->pending.dirty =3D true;
>  }
> --
> 2.18.0
>
