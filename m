Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013438B767
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhETTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbhETTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:23:12 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59411C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:21:51 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso4030431oow.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8UnW4lL464SupfU+ewTqWUOAJiPxxvepRI6nrJy0aog=;
        b=rpvbE82xTDInyVqe9a45WfFep9oOZcNx01b+vjen1B9hHI5mWk7mzo5TXi68TdsRwR
         ZjltyDrBegL8B0VN0n2C6rxEXaAG9NqMbnvbDnkYhZFmBBvqNTpYSqmL5CBiLE1iCh1Q
         4hwWkNuAdhi7hXZWnRp/W3s6s1sgWBHCgIg6qt04aUDgt1SLuc4CFlp0eRxSw2hJ8BUQ
         gmMkxMJu3f3+W7FZapF1QzS0qEbsU0weCflW6xye/+jU52D1ayVCwuDWsANo9ZQiw42Z
         2OSTNhuZAtzDfE9HofU/Y2ANZ8JE1sTRx9/zg8pI+QUkJVIlTp5TniFEDgz0W1M5OIQ4
         rqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8UnW4lL464SupfU+ewTqWUOAJiPxxvepRI6nrJy0aog=;
        b=gKKtaChTVAunl1H0jWX9T03LcA04QTDvUJCOgOFh9z4rL2ARv50m61crsEM6uRkBzx
         j1R0Qj7IHVzk9WQZCLS8hLHwiY7Yq5NmOtqYBTs/wIufPhAlrgWiqFoV8R8FgPVrPOWD
         3285o2Y1lIZojTD95jnDeBUSyUkWcMfZGYdkesfZQiqvp/nmBDGFUYzt/KkuGSEspO6F
         wc2ixJYqiHD4vGFnGXHV2HaNQAWR51inuKE8yRNmkTtNwerVvGkEfZHez0mh5HZ8Vr0+
         Ghqm2OPP4WkLUx+Az+uERggEFTObdi2WDCgfQv//yNy6VsFVP/IJ2hYDDf39AETM8myb
         pLmw==
X-Gm-Message-State: AOAM532AAfGU6Z9dC58ZBPKQQj29UMHREfFciEJQvXvv1dl8QEnqAqCb
        L7mEz5NHz/URGJQkqDvTgQS2XJc1QEeHlII8KTA=
X-Google-Smtp-Source: ABdhPJze2+4ds5K9a8squEtefsFNJ0q4Fofl54xgQV9gTyaKMdgvwqw4oCLv1nqKO37ipbe1eXoZajw1jGSJA9EWBqA=
X-Received: by 2002:a4a:d004:: with SMTP id h4mr4982728oor.90.1621538510749;
 Thu, 20 May 2021 12:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-31-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:21:39 -0400
Message-ID: <CADnq5_Nx=Zf=tGBP+V0sJEQRfuygyizdQoTZfLiRccvqcrJFtQ@mail.gmail.com>
Subject: Re: [PATCH 30/38] drm/amd/amdgpu/gfx_v9_4_2: Mark functions called by
 reference as static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1008:5: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_query_ras_error_count=E2=80=99 [-Wmissing-pr=
ototypes]
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1054:6: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_reset_ras_error_count=E2=80=99 [-Wmissing-pr=
ototypes]
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1063:5: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_ras_error_inject=E2=80=99 [-Wmissing-prototy=
pes]
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1133:6: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_query_ras_error_status=E2=80=99 [-Wmissing-p=
rototypes]
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1143:6: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_reset_ras_error_status=E2=80=99 [-Wmissing-p=
rototypes]
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1153:6: warning: no previous pro=
totype for =E2=80=98gfx_v9_4_2_enable_watchdog_timer=E2=80=99 [-Wmissing-pr=
ototypes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_2.c
> index dbad9ef002d59..87ec96a18a5dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -1641,8 +1641,8 @@ static int gfx_v9_4_2_query_utc_edc_count(struct am=
dgpu_device *adev,
>         return 0;
>  }
>
> -int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
> -                                  void *ras_error_status)
> +static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
> +                                           void *ras_error_status)
>  {
>         struct ras_err_data *err_data =3D (struct ras_err_data *)ras_erro=
r_status;
>         uint32_t sec_count =3D 0, ded_count =3D 0;
> @@ -1690,7 +1690,7 @@ static void gfx_v9_4_2_reset_ea_err_status(struct a=
mdgpu_device *adev)
>         mutex_unlock(&adev->grbm_idx_mutex);
>  }
>
> -void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
> +static void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
>  {
>         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>                 return;
> @@ -1699,7 +1699,7 @@ void gfx_v9_4_2_reset_ras_error_count(struct amdgpu=
_device *adev)
>         gfx_v9_4_2_query_utc_edc_count(adev, NULL, NULL);
>  }
>
> -int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject=
_if)
> +static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void =
*inject_if)
>  {
>         struct ras_inject_if *info =3D (struct ras_inject_if *)inject_if;
>         int ret;
> @@ -1772,7 +1772,7 @@ static void gfx_v9_4_2_query_utc_err_status(struct =
amdgpu_device *adev)
>         }
>  }
>
> -void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
> +static void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev=
)
>  {
>         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>                 return;
> @@ -1782,7 +1782,7 @@ void gfx_v9_4_2_query_ras_error_status(struct amdgp=
u_device *adev)
>         gfx_v9_4_2_query_sq_timeout_status(adev);
>  }
>
> -void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev)
> +static void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev=
)
>  {
>         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>                 return;
> @@ -1792,7 +1792,7 @@ void gfx_v9_4_2_reset_ras_error_status(struct amdgp=
u_device *adev)
>         gfx_v9_4_2_reset_sq_timeout_status(adev);
>  }
>
> -void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
> +static void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
>  {
>         uint32_t i;
>         uint32_t data;
> --
> 2.31.1
>
