Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D747342494
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:24:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:24:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l79so5744268oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bcw5RupkibLZJIssKn/HrlopTaukHSpPItO2c/relWo=;
        b=M5wR/G3qdMGXM1MTTQEYVBpbX/44DhQ8WqR9oyZnPq2hpZTLv5ck7LHOPlz606CBUz
         05cqgkjfsJbtSePcgIJrYxiMseKby3aCvtulqImT0z2R90H+qJuv3CrkyCoLRxm0KmUL
         a3nmM7WbRGJ6A3acz0ivDfLz70gLWw2rW3TYNyxhRxFIGlMEQ2TVzkM5Gm2i9NH+gTw8
         Kz8e1djtvNBR4R/0L0+vp3OAYmRGCeDXRj/YjD+fwR6oZzfIJG1meAveXX3DFbMx49Dd
         BHGKJQCOlT8jM612M2zF361mTp90QBDxl30k0ludFlJxqiQCmmf6JQN6iMobmJC5S1vJ
         tvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bcw5RupkibLZJIssKn/HrlopTaukHSpPItO2c/relWo=;
        b=sTbhsx744oCdOwHKEj2jLhdMf02CyB6t4cIC4Rt0aXMDjFFAGElqaENjuoxEo4rePG
         KpOg6y4fmndmt0jBqKM9ntzqHDSWzisBL4Xw8H5RlV3Nw2o9X5TVQk0Whv2GFW2VlJmz
         dhk0npenzNE2/5uxgwHP+eoUN+um/TesVXTDN6cfmYnEe3bHcKFt5QzXdk/7jvlxzQdY
         d0z0SfRjHeppl7c0y3k1RTX4mUDl7xS7umLojNjE4bDN+1aRx/yubYsWtEVMjR2//SRu
         xisQq0g9sU7Y+3fueUnW1S36gvGInmOCZiB43pnjLbASP46CEdHrpKWy1SL0E7UuLyj4
         3HpQ==
X-Gm-Message-State: AOAM532mxA2Glykz1KqnFxGraBGpgzN2YGXwCHkLALNkGz6v0MeX1CFT
        ioTcup8bEpb0ZdphW+75GvTt35G/dLB2pn/a2gsSleSE
X-Google-Smtp-Source: ABdhPJyy3N3qJKjKFgm4fgpqhvgVBz1b2x8B62Ny15EF/rJe5Bi8kqn8rSYh9pFR/NsmTVn/+rOwdGxKBmga09GtVOU=
X-Received: by 2002:aca:af10:: with SMTP id y16mr1950101oie.120.1616178283865;
 Fri, 19 Mar 2021 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-9-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 14:24:33 -0400
Message-ID: <CADnq5_OuAC99FOz3x3QtdEF+rGpbsoGH11VA_BvoDFQnz_FrGA@mail.gmail.com>
Subject: Re: [PATCH 08/19] drm/amd/display/dc/dce80/dce80_resource: Make local
 functions static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:527:17: =
warning: no previous prototype for =E2=80=98dce80_aux_engine_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:565:20: =
warning: no previous prototype for =E2=80=98dce80_i2c_hw_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:581:20: =
warning: no previous prototype for =E2=80=98dce80_i2c_sw_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:715:22: =
warning: no previous prototype for =E2=80=98dce80_link_encoder_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:754:22: =
warning: no previous prototype for =E2=80=98dce80_clock_source_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:778:6: w=
arning: no previous prototype for =E2=80=98dce80_clock_source_destroy=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:868:6: w=
arning: no previous prototype for =E2=80=98dce80_validate_bandwidth=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:913:16: =
warning: no previous prototype for =E2=80=98dce80_validate_global=E2=80=99 =
[-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  .../drm/amd/display/dc/dce80/dce80_resource.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 612450f992782..725d92e40cd30 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -526,7 +526,7 @@ static struct output_pixel_processor *dce80_opp_creat=
e(
>         return &opp->base;
>  }
>
> -struct dce_aux *dce80_aux_engine_create(
> +static struct dce_aux *dce80_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -564,7 +564,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>  };
>
> -struct dce_i2c_hw *dce80_i2c_hw_create(
> +static struct dce_i2c_hw *dce80_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -580,7 +580,7 @@ struct dce_i2c_hw *dce80_i2c_hw_create(
>         return dce_i2c_hw;
>  }
>
> -struct dce_i2c_sw *dce80_i2c_sw_create(
> +static struct dce_i2c_sw *dce80_i2c_sw_create(
>         struct dc_context *ctx)
>  {
>         struct dce_i2c_sw *dce_i2c_sw =3D
> @@ -714,7 +714,7 @@ static const struct encoder_feature_support link_enc_=
feature =3D {
>                 .flags.bits.IS_TPS3_CAPABLE =3D true
>  };
>
> -struct link_encoder *dce80_link_encoder_create(
> +static struct link_encoder *dce80_link_encoder_create(
>         const struct encoder_init_data *enc_init_data)
>  {
>         struct dce110_link_encoder *enc110 =3D
> @@ -753,7 +753,7 @@ static struct panel_cntl *dce80_panel_cntl_create(con=
st struct panel_cntl_init_d
>         return &panel_cntl->base;
>  }
>
> -struct clock_source *dce80_clock_source_create(
> +static struct clock_source *dce80_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -777,7 +777,7 @@ struct clock_source *dce80_clock_source_create(
>         return NULL;
>  }
>
> -void dce80_clock_source_destroy(struct clock_source **clk_src)
> +static void dce80_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src =3D NULL;
> @@ -867,7 +867,7 @@ static void dce80_resource_destruct(struct dce110_res=
ource_pool *pool)
>         }
>  }
>
> -bool dce80_validate_bandwidth(
> +static bool dce80_validate_bandwidth(
>         struct dc *dc,
>         struct dc_state *context,
>         bool fast_validate)
> @@ -912,7 +912,7 @@ static bool dce80_validate_surface_sets(
>         return true;
>  }
>
> -enum dc_status dce80_validate_global(
> +static enum dc_status dce80_validate_global(
>                 struct dc *dc,
>                 struct dc_state *context)
>  {
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
