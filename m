Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8E394807
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhE1UnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1UnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:43:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42141C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:41:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q25so4143400pfn.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dWylf11sBI6NHMXAlL1Myy7IBhthqrQbFB/TTGfNsu4=;
        b=QTT7CKfOBctf/QklY+VuaKaCG4W+5fRQrs+7pOENtX0AgzqNXNBxApAzYHVpDp4po3
         cUJq+wSmes5qa6GSR+MQXCVW6TSs77BWVBxy9Te97vFRCJaC44yFEAkFkvIHXVCKNqmj
         vUfZkY8m2iMOGQ+OWqcw7A0qgMMo5E4Ky6yx/PPmHXnwsta4UvCeYZyAipiiGYmbiucj
         XSd59Zeloe0SWWbcgjk0n3LkTPjP38L27WiM44/9YJp3ZJ4Ml154RS7lH8iC3kgEwS17
         Jtwpth7nQ9FJsvtfNRLyFEqU79bCoGWKL9RPF69hwReojyw9RS0t0lZS90ciofwsWq5L
         Os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dWylf11sBI6NHMXAlL1Myy7IBhthqrQbFB/TTGfNsu4=;
        b=qt2AbysJclNCmODkH0YoU7D9z8hMrVy2btWi6fd7QYqtGXtovKBrRfGat5uvFYTcY5
         PI4U9hnRlwBbUD4qAZxs5GutCDhHPgSg0O2TYvdyAuEnSM3q8qo5JZH7ErxZqfp4UoUX
         oMbqch360pEIu4V8+mrlyu8X9oS7p5iERuMM/s2vHZCxzZBEhDMaCvyXGJGfyjF89ccL
         filxSodgIynh8rRxh7BOU1Vd58bjaqrnhXUiCXf/lq8+hW+lX4RLjDWXR5iD0Pj401A/
         0Clq5rGX6zE+iHWUiyXGMcuAnq3P0l3zPPKroxg3/kLQE0yfGrh3vPiImL8FoJqW8pPY
         d6jA==
X-Gm-Message-State: AOAM5317ASXLaob58qgrl4wPCoO1zDyf59F+SUlA26MAhriT3QgaGuIE
        vKJBkMq0l5LLkR1siR1hraWKgtvCFUk0syRBRWqMVbys6UsJIQ==
X-Google-Smtp-Source: ABdhPJxjKySbjQC4dWE1MMsyN1uUqOjnZnRWr7dwYle9MVt4Kp7uSzKwgCMg/s3bFYJ9BvjdQ3WvpuXHg6qqTGr/YLg=
X-Received: by 2002:a65:4d03:: with SMTP id i3mr10776572pgt.422.1622234504448;
 Fri, 28 May 2021 13:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528203036.17999-1-r.stratiienko@gmail.com> <20210528203036.17999-3-r.stratiienko@gmail.com>
In-Reply-To: <20210528203036.17999-3-r.stratiienko@gmail.com>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Fri, 28 May 2021 23:41:33 +0300
Message-ID: <CAGphcdk8Zg0PbG+dNmaXa8db0QWFXED7X5vQNURe2R7aEo_TRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/sun4i: Use CRTC size instead of primary plane
 size as mixer frame
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org,
        Ondrej Jirman <megous@megous.com>,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        jernej.skrabec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC: jernej.skrabec@gmail.com

=D0=BF=D1=82, 28 =D0=BC=D0=B0=D1=8F 2021 =D0=B3. =D0=B2 23:31, Roman Strati=
ienko <r.stratiienko@gmail.com>:
>
> Fixes corrupted display picture when primary plane isn't full-screen.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
>  2 files changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 5b42cf25cc86..810c731566c0 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -248,6 +248,33 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw=
_format)
>         return -EINVAL;
>  }
>
> +static void sun8i_mode_set(struct sunxi_engine *engine,
> +                          struct drm_display_mode *mode)
> +{
> +       u32 size =3D SUN8I_MIXER_SIZE(mode->crtc_hdisplay, mode->crtc_vdi=
splay);
> +       struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> +       u32 bld_base =3D sun8i_blender_base(mixer);
> +       u32 val;
> +
> +       DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n=
",
> +                        mode->crtc_hdisplay, mode->crtc_vdisplay);
> +       regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
> +       regmap_write(mixer->engine.regs,
> +                    SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
> +
> +       if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +               val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> +       else
> +               val =3D 0;
> +
> +       regmap_update_bits(mixer->engine.regs,
> +                          SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> +                          SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> +                          val);
> +       DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> +                        val ? "on" : "off");
> +}
> +
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>         DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -301,6 +328,7 @@ static struct drm_plane **sun8i_layers_init(struct dr=
m_device *drm,
>  static const struct sunxi_engine_ops sun8i_engine_ops =3D {
>         .commit         =3D sun8i_mixer_commit,
>         .layers_init    =3D sun8i_layers_init,
> +       .mode_set       =3D sun8i_mode_set,
>  };
>
>  static const struct regmap_config sun8i_mixer_regmap_config =3D {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 0db164a774a1..d66fff582278 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_=
mixer *mixer, int channel,
>         insize =3D SUN8I_MIXER_SIZE(src_w, src_h);
>         outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
>
> -       if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> -               bool interlaced =3D false;
> -               u32 val;
> -
> -               DRM_DEBUG_DRIVER("Primary layer, updating global size W: =
%u H: %u\n",
> -                                dst_w, dst_h);
> -               regmap_write(mixer->engine.regs,
> -                            SUN8I_MIXER_GLOBAL_SIZE,
> -                            outsize);
> -               regmap_write(mixer->engine.regs,
> -                            SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize=
);
> -
> -               if (state->crtc)
> -                       interlaced =3D state->crtc->state->adjusted_mode.=
flags
> -                               & DRM_MODE_FLAG_INTERLACE;
> -
> -               if (interlaced)
> -                       val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> -               else
> -                       val =3D 0;
> -
> -               regmap_update_bits(mixer->engine.regs,
> -                                  SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> -                                  SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> -                                  val);
> -
> -               DRM_DEBUG_DRIVER("Switching display mixer interlaced mode=
 %s\n",
> -                                interlaced ? "on" : "off");
> -       }
> -
>         /* Set height and width */
>         DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
>                          state->src.x1 >> 16, state->src.y1 >> 16);
> --
> 2.30.2
>
