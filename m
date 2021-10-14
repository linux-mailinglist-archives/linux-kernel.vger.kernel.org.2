Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39CE42E4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhJNXp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhJNXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:45:24 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D7C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:43:09 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k29so4724130qve.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7Isl4QOCcY0eFas2cTgbyTZfPWz2wwFdAIcWRYre7Y=;
        b=PjuIacqaroe9e7akOnjznTZzvaYEQs53UCr321AtQruM5hAZBg92Qj8kesAnbb7Muy
         qMyCuA6zzoG9BjWGJkG3AUzx167f73QL6aeUPu/LReks/1mIUnrk5z/B5qDTtrMszNiU
         YKvlgeUM3yXHj7PZ+FF3LnyQOfymhIhwnyq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7Isl4QOCcY0eFas2cTgbyTZfPWz2wwFdAIcWRYre7Y=;
        b=K+91spP78X9p6nMrO/UdYE10VIzmEnyDy0gN4rpkCpZkTdSz1Z3C00Q4/lMyNP6BIM
         0iLsblSjIGMn0PSFlXgdiekCINKDl7tI97c1qIxpmuacEhCDz8Afn+PExNQcUmNiEG4T
         baqlX4lBLNN2bdsxLIAuiiczfL/ZCs2JRA0ZO9825/0JGjoHiQ2SdIoFoPP2ZhglR70k
         gATz2MupAtqQaw6CDXT54XS/bL5qhkroaLFwn8oVu7CQecBCodLJvFl4jaEKVODqac8u
         mshWG9Uo4SZA4Ca25AcYEJeVrT9pccwZsH0SW/k8wQcjJnZtvXawdthoZvYSrSoyAC5T
         5I6g==
X-Gm-Message-State: AOAM533NnV2ne0vnK1Pi7W0VYdPbLAX82fKitPlmTLh44taHuCdLibSt
        /dWrxzFhhxqnzwdcU+he0l9frBYYyvyBtO0F
X-Google-Smtp-Source: ABdhPJws7/NlJahWzjRAuH9kAEi9PDVcb/1f4jLDdYT9XutVaat0ogBe6A/WMzpVzdhvBU8fHCzuXw==
X-Received: by 2002:a05:6214:c26:: with SMTP id a6mr8370730qvd.40.1634254987634;
        Thu, 14 Oct 2021 16:43:07 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id q184sm1922764qkd.35.2021.10.14.16.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 16:43:06 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id n65so18489536ybb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:43:06 -0700 (PDT)
X-Received: by 2002:a25:4251:: with SMTP id p78mr9457761yba.47.1634254985831;
 Thu, 14 Oct 2021 16:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210929194012.3433306-1-markyacoub@chromium.org>
 <20211013181228.1578201-1-markyacoub@chromium.org> <20211013181228.1578201-2-markyacoub@chromium.org>
In-Reply-To: <20211013181228.1578201-2-markyacoub@chromium.org>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Thu, 14 Oct 2021 19:42:29 -0400
X-Gmail-Original-Message-ID: <CAOw6vb+AaG2B1zRfLW54TDjinuirXAT+v2AvXeWmVjYNyJJXMQ@mail.gmail.com>
Message-ID: <CAOw6vb+AaG2B1zRfLW54TDjinuirXAT+v2AvXeWmVjYNyJJXMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes
 using DRM Core check
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, harry.wentland@amd.com,
        Mark Yacoub <markyacoub@google.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 2:12 PM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> From: Mark Yacoub <markyacoub@google.com>
>
> [Why]
> drm_atomic_helper_check_crtc now verifies both legacy and non-legacy LUT
> sizes. There is no need to check it within amdgpu_dm_atomic_check.
>
> [How]
> Remove the local call to verify LUT sizes and use DRM Core function
> instead.
>
> Tested on ChromeOS Zork.
>
> v1:
> Remove amdgpu_dm_verify_lut_sizes everywhere.
>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 35 -------------------
>  3 files changed, 4 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f74663b6b046e..47f8de1cfc3a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10244,6 +10244,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>                 }
>         }
>  #endif
> +       ret = drm_atomic_helper_check_crtcs(state);
> +       if (ret)
> +               return ret;
> +
>         for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>                 dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>
> @@ -10253,10 +10257,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>                         dm_old_crtc_state->dsc_force_changed == false)
>                         continue;
>
> -               ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
> -               if (ret)
> -                       goto fail;
> -
>                 if (!new_crtc_state->enable)
>                         continue;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index fcb9c4a629c32..22730e5542092 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -617,7 +617,6 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
>  #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
>
>  void amdgpu_dm_init_color_mod(void);
> -int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>  int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
>  int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
>                                       struct dc_plane_state *dc_plane_state);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index a022e5bb30a5c..319f8a8a89835 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -284,37 +284,6 @@ static int __set_input_tf(struct dc_transfer_func *func,
>         return res ? 0 : -ENOMEM;
>  }
>
> -/**
> - * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
> - * the expected size.
> - * Returns 0 on success.
> - */
> -int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
> -{
> -       const struct drm_color_lut *lut = NULL;
> -       uint32_t size = 0;
> -
> -       lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
> -       if (lut && size != MAX_COLOR_LUT_ENTRIES) {
> -               DRM_DEBUG_DRIVER(
> -                       "Invalid Degamma LUT size. Should be %u but got %u.\n",
> -                       MAX_COLOR_LUT_ENTRIES, size);
> -               return -EINVAL;
> -       }
> -
> -       lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
> -       if (lut && size != MAX_COLOR_LUT_ENTRIES &&
> -           size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
> -               DRM_DEBUG_DRIVER(
> -                       "Invalid Gamma LUT size. Should be %u (or %u for legacy) but got %u.\n",
> -                       MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,
> -                       size);
> -               return -EINVAL;
> -       }
> -
> -       return 0;
> -}
> -
>  /**
>   * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
>   * @crtc: amdgpu_dm crtc state
> @@ -348,10 +317,6 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>         bool is_legacy;
>         int r;
>
> -       r = amdgpu_dm_verify_lut_sizes(&crtc->base);
> -       if (r)
> -               return r;
> -
>         degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
>         regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
>
> --
> 2.33.0.882.g93a45727a2-goog
>
