Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6484134243E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCSSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSSOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:14:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26211C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:14:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso9369761otd.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t7kii8i5MvpTK371d7gij4/ROdmy9ZS9dtdrdIgpERw=;
        b=tH30REVX7GFAAVKCT2DKJGA3jKve8kd/s5uEfAZozZFPLTDcg8nCiuJuMDhw8EylBz
         QTY8aFlMFr1cjP4EJE5murjfj8zTcEzijciI7ZZOfHavd4iF1idyHTjhYqkksJHjf5R5
         GnYxH2DWML8qBdOOsqgfLm0mfUNKxVwB5zVeyAOfX3FEOXCFxS7ewqF72Dn3IAix0eoT
         w3ZbfvphE8BbUbB+lW4GrE+Wr/vrsx3RVr170DEcrK1VH9/yVs6SqPf9Ti/D3LnmOD6p
         bDazwTrFeYkd0AHhkDx6BYOPq5QcLofhxVyMEPEYfwtTHJX5+De0oNUTWJ7LSTxFnss3
         TmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t7kii8i5MvpTK371d7gij4/ROdmy9ZS9dtdrdIgpERw=;
        b=pL3dY4W50YxEJdYQTWSk7ECDEZZE2aAeUiHlAmUr1K4HMK+HCn5PAC7L8rE5AggAai
         N271b2TBMYgoUu8zlmrJC7P/1VrPbPeOFDOJtpRquuLD7uDTY3vLe5zIjzyORU5/YSIU
         2S3VGy2lqjOs1hS0qVK/ANW43BJV5qaI3+mSx4elotxPfNl2yySpCIjg2C8XoH/M6F+S
         73+6sWhAt0y971KMXggoUN4eUkcxek5aFYUR4UCXFOQYYZ6UmM+h+7az3zjno6rkey4i
         uOMH8WVcPYn9fzgIXZDGpIsFYP0jYwZDFZJXH3lnHfddXY8PXz19aXGsojhAdT1phVkq
         OPyQ==
X-Gm-Message-State: AOAM533EVKgxN8tLxEyDPm/2XEo559ez07iZsgurR7kgZ91kwEwc3lKN
        7IIPwUHopWbBRzwBM7me0kUzQ1sGoTK/yWnPh7q03K0Q5E8=
X-Google-Smtp-Source: ABdhPJyq79eRJv6Lt71XlLYgAXxA5utNtq+TeEHiEydT5TE6pXG6B9q90X21Evzyqb3ckNgB6X/lYjxskHZCoMTmuxk=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr2110488ots.23.1616177650625;
 Fri, 19 Mar 2021 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-7-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 14:13:59 -0400
Message-ID: <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Harry, Nick

On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function =
=E2=80=98calculate_bandwidth=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warni=
ng: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-=
than=3D]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32 ++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/g=
pu/drm/amd/display/dc/calcs/dce_calcs.c
> index e633f8a51edb6..9d8f2505a61c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
>         int32_t num_cursor_lines;
>
>         int32_t i, j, k;
> -       struct bw_fixed yclk[3];
> -       struct bw_fixed sclk[8];
> +       struct bw_fixed *yclk;
> +       struct bw_fixed *sclk;
>         bool d0_underlay_enable;
>         bool d1_underlay_enable;
>         bool fbc_enabled;
>         bool lpt_enabled;
>         enum bw_defines sclk_message;
>         enum bw_defines yclk_message;
> -       enum bw_defines tiling_mode[maximum_number_of_surfaces];
> -       enum bw_defines surface_type[maximum_number_of_surfaces];
> +       enum bw_defines *tiling_mode;
> +       enum bw_defines *surface_type;
>         enum bw_defines voltage;
>         enum bw_defines pipe_check;
>         enum bw_defines hsr_check;
> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
>         int32_t number_of_displays_enabled_with_margin =3D 0;
>         int32_t number_of_aligned_displays_with_no_margin =3D 0;
>
> +       yclk =3D kcalloc(3, sizeof(*yclk), GFP_KERNEL);
> +       if (!yclk)
> +               return;
> +
> +       sclk =3D kcalloc(8, sizeof(*sclk), GFP_KERNEL);
> +       if (!sclk)
> +               goto free_yclk;
> +
> +       tiling_mode =3D kcalloc(maximum_number_of_surfaces, sizeof(*tilin=
g_mode), GFP_KERNEL);
> +       if (!tiling_mode)
> +               goto free_sclk;
> +
> +       surface_type =3D kcalloc(maximum_number_of_surfaces, sizeof(*surf=
ace_type), GFP_KERNEL);
> +       if (!surface_type)
> +               goto free_tiling_mode;
> +


Harry or Nick can correct me if I'm wrong, but for this patch and the
next one, I think this can be called from an atomic context.

Alex

>         yclk[low] =3D vbios->low_yclk;
>         yclk[mid] =3D vbios->mid_yclk;
>         yclk[high] =3D vbios->high_yclk;
> @@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
>                         }
>                 }
>         }
> +
> +       kfree(surface_type);
> +free_tiling_mode:
> +       kfree(tiling_mode);
> +free_yclk:
> +       kfree(yclk);
> +free_sclk:
> +       kfree(sclk);
>  }
>
>  /***********************************************************************=
********
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
