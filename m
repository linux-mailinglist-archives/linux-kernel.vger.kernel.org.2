Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5C348544
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhCXXYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCXXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:24:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:24:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j2so341046ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q43DZqTfht3NrCwrhOoH0GTpptu7qHLVnI4+js1qVVg=;
        b=LEmqw7acR1vo3ktaHg+ANOGf5OggOojszFWfBM09wKWmGvFqAmt8EToX8JUX7hasCc
         nOBhZR2AOq7mV7XtzdIXizoLYCckYM3k1HjPqQ7jBn1cuICTyAyRkoTvJEYrr4TdGP85
         P1jf265cj82sWOjWAXoLxddhlzA9Kpfv4MWVsSnnDsx7AA5xfbw4G0+Mmsx7yegWu/0Y
         uWaqH4jBKT6kZ0WFA2i2vmBIlGEbkRVc1605Qi34pMLGtO2Snm7pbh2yw8fpqr8MNWS9
         VGfahqS9yw+xKDtUP6t94++csS81Kh9T0Lk80egnjnAycqJFPIJy+NdI0xNXmMZf8IW0
         z6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q43DZqTfht3NrCwrhOoH0GTpptu7qHLVnI4+js1qVVg=;
        b=qvhNcfRgPMFn5t8KVgL+a1fLyMVEU0eziBdR7QXOlBoFm8IiUEf1NK8pSFPnPXWvLB
         /bmBHMQUJLj9Dv7K+y6UM7/i3f/nXkuH6eAzXDBDLBCzzFsmv4t1Y+PCFfkNdN9djh43
         sU8eqy5J+ti6O3tAVl/MElY1u3SguurO3eb/e4NSZlgX/HYxgG8ovLZyk0nIai4v16BQ
         qm1xpfWXjAkGtoqBh6I97s2bMp9uZCLGJiIUpuItjtTOMzzqLupIJBl4bBYyPG8UGSEZ
         FXpAdjuzlDpEJb9lxa3Lbz0yYkB4jBiL3lf1MIbYAtPJGKihDg+wxSkcykaI4/l7/B71
         McXg==
X-Gm-Message-State: AOAM533AA6lIqtDre06sZJkVFzWMJ67hnhNWoDmx7OtRA53l/bCvR7yx
        g2zlTl2XJf/XrfUIi6zyMN0kXLG0ATGm/D4L9UMlMmETBKY=
X-Google-Smtp-Source: ABdhPJyi94rqLBo0EzJatuAQiIuyAwh7jg4g0fQ+yDzEJbHPG9HnIMPgOfadaDi6EBNdGuUfuWCI/O7cWKDFDxH0lqE=
X-Received: by 2002:a25:6003:: with SMTP id u3mr8605761ybb.96.1616628259668;
 Wed, 24 Mar 2021 16:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210318230351.982064-1-lyude@redhat.com>
In-Reply-To: <20210318230351.982064-1-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 25 Mar 2021 09:24:08 +1000
Message-ID: <CACAvsv72yRdtsRRWUx183XWEAOU3NSjjsYhEbKSGy=sQ+zdwKQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/kms/nv50-: Correct size checks for cursors
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Martin Peres <martin.peres@mupuf.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 09:04, Lyude Paul <lyude@redhat.com> wrote:
>
> Found this while trying to make some changes to the kms_cursor_crc test.
> curs507a_acquire checks that the width and height of the cursor framebuffer
> are equal (asyw->image.{w,h}). This isn't entirely correct though, as the
> height of the cursor can be larger than the size of the cursor, as long as
> the width is the same as the cursor size and there's no framebuffer offset.
>
> Note that I'm not entirely sure why this wasn't previously breaking
> kms_cursor_crc tests - they all set up cursors with the height being one
> pixel larger than the actual size of the cursor. But this seems to fix
> things, and the code before was definitely incorrect - so it's not really
> worth looking into further imho.
>
> Changes since v1:
> * Don't use crtc_w everywhere for determining cursor layout, just use fb
>   size again
> * Change check so that we only check that the w/h of the cursor plane is
>   the same, the width of the scanout surface is the same as the framebuffer
>   width, and that there's no offset being used for the cursor surface.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Martin Peres <martin.peres@mupuf.org>
> Cc: Jeremy Cline <jcline@redhat.com>
Thanks Lyude!

> ---
>  drivers/gpu/drm/nouveau/dispnv50/curs507a.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
> index 54fbd6fe751d..00e19fd959ea 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
> @@ -98,6 +98,7 @@ static int
>  curs507a_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
>                  struct nv50_head_atom *asyh)
>  {
> +       struct nouveau_drm *drm = nouveau_drm(wndw->plane.dev);
>         struct nv50_head *head = nv50_head(asyw->state.crtc);
>         int ret;
>
> @@ -109,8 +110,20 @@ curs507a_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
>         if (ret || !asyh->curs.visible)
>                 return ret;
>
> -       if (asyw->image.w != asyw->image.h)
> +       if (asyw->state.crtc_w != asyw->state.crtc_h) {
> +               NV_ATOMIC(drm, "Plane width/height must be equal for cursors\n");
>                 return -EINVAL;
> +       }
> +
> +       if (asyw->image.w != asyw->state.crtc_w) {
> +               NV_ATOMIC(drm, "Plane width must be equal to fb width for cursors (height can be larger though)\n");
> +               return -EINVAL;
> +       }
> +
> +       if (asyw->state.src_x || asyw->state.src_y) {
> +               NV_ATOMIC(drm, "Cursor planes do not support framebuffer offsets\n");
> +               return -EINVAL;
> +       }
>
>         ret = head->func->curs_layout(head, asyw, asyh);
>         if (ret)
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
