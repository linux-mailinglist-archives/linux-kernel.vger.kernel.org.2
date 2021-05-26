Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0443915CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEZLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234060AbhEZLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622027820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZhb8zuVnnjhU4y7wnecCuH3x05R6lnJG5XgPPhjXY0=;
        b=SQ+vZyPsA/ceVLHoE8GHvNLwswQPrPSXDLYzp7gSosiy2d5NcpgYGlDxI0gbNHXkO1gUMx
        cnmAaITpQsTqgjwU19KH4XuAz/W8sslklao7XAKI8OZK3HBhnpcdtXIP3IOydr5+EJ6dAd
        IyscvHMvaZn+5Cixuco9lEHKNgMNn1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-g4ytirTgOR6grKSK7dX1GQ-1; Wed, 26 May 2021 07:16:57 -0400
X-MC-Unique: g4ytirTgOR6grKSK7dX1GQ-1
Received: by mail-wr1-f70.google.com with SMTP id p11-20020adfcc8b0000b029011277d49b71so239810wrj.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 04:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZhb8zuVnnjhU4y7wnecCuH3x05R6lnJG5XgPPhjXY0=;
        b=iR/2WMQJoN4vmGCWe6pTEaAQgpUs4gjkdI27GRGaaI82PzE0rua3zsiV6j9uMSFcxU
         2q8lo41PqeKkyX5ekej56/FygJjzXO3n/ZlodbwjytqAn5/jIuZA+CiEc23lJuoHPRkg
         hAqp240R+QQOFK0dYmWbc2sEAqwc69ncvh0aLmFIBcBAnucI36MFGUC01k5AChqIYj12
         2pZhyBwT7KP27OueYbWNHK09tJi2thB3KLZUl06v82W/61Zmbwa4mr40jFdYxAHYYyF4
         qAA6sq+/l6rGOcSxCiZCRLS+kbLnDgfjTCxPh4B9aEkxEc0VzJVrzby7t5N551M06KsU
         /Wsg==
X-Gm-Message-State: AOAM531NDU6sGvW65cG5YefTqc+YRfIaHWxE5T0u53SSEax+o5sGURM/
        ztYLhlhOqnu8LVv29PYPKvsC6hq4WJIo/9wJ7FHr/t5z1uf4xi3S+WJ1puCKOPr6rgRozwui/9j
        laOWNUfCcVfcnIT7yHCAMzpWVVxb8FjtIo341Rh3H
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr30747650wrq.177.1622027816753;
        Wed, 26 May 2021 04:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC/kfOOQw4CwfWnJy7tsT5TwYrdsCpahCbg0flnKAJcY+E6BvxvK01g0k+BcUw5O2u46vOYYCfvWQxIboZsY8=
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr30747629wrq.177.1622027816562;
 Wed, 26 May 2021 04:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-12-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-12-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 26 May 2021 13:16:46 +0200
Message-ID: <CACO55tuGiW=e+ee83jhvQOJxA+tedH5r_pHS+ESbEQVABgfvnQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 11/34] drm/nouveau/nvkm/subdev/mc/tu102: Make
 functions called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Alistair Popple <apopple@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:50:1: warning: no previou=
s prototype for =E2=80=98tu102_mc_intr_unarm=E2=80=99 [-Wmissing-prototypes=
]
>  drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:62:1: warning: no previou=
s prototype for =E2=80=98tu102_mc_intr_rearm=E2=80=99 [-Wmissing-prototypes=
]
>  drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:74:1: warning: no previou=
s prototype for =E2=80=98tu102_mc_intr_mask=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/mc/tu102.c
> index 58db83ebadc5f..a96084b34a788 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
> @@ -46,7 +46,7 @@ tu102_mc_intr_update(struct tu102_mc *mc)
>                 nvkm_wr32(device, 0xb81610, 0x6);
>  }
>
> -void
> +static void
>  tu102_mc_intr_unarm(struct nvkm_mc *base)
>  {
>         struct tu102_mc *mc =3D tu102_mc(base);
> @@ -58,7 +58,7 @@ tu102_mc_intr_unarm(struct nvkm_mc *base)
>         spin_unlock_irqrestore(&mc->lock, flags);
>  }
>
> -void
> +static void
>  tu102_mc_intr_rearm(struct nvkm_mc *base)
>  {
>         struct tu102_mc *mc =3D tu102_mc(base);
> @@ -70,7 +70,7 @@ tu102_mc_intr_rearm(struct nvkm_mc *base)
>         spin_unlock_irqrestore(&mc->lock, flags);
>  }
>
> -void
> +static void
>  tu102_mc_intr_mask(struct nvkm_mc *base, u32 mask, u32 intr)
>  {
>         struct tu102_mc *mc =3D tu102_mc(base);
> --
> 2.31.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

Reviewed-by: Karol Herbst <kherbst@redhat.com>

