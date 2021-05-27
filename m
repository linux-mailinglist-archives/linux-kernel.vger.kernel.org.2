Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB03925BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhE0EAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:00:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC795C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:59:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so3167828oty.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GwO6hJTK9pMNiwOSyto0K/M7BIjvwe2kKr/NYGp3HmM=;
        b=fyrsG2+DIYTWujXjBGM4BV9gq0EDSmTSnTWiaPcjmz/R5tkMVNrDYRs4JBtcr3FAN7
         qY56UgKx7lo7AIKwadaHdjFDyI+Yqq4qNrcUVHMUaNY/NytUHe/gZEtCdieaD0ucEGLY
         iKg8/JcFyrM2DuTAbuacIk83HFxhxikO62ECTt9p6561AFo7qYtUSzqXZN3SufbjV3EB
         8jDxtnxyM1Bhteu5cHh+qZNDJ8TWmSSEs9cPUkNf1dXFCVORXKhQTZS/neSjgkj9L+Kj
         wQStrH0lKOpiNPn2LS4WrDLovPKyrk+9YmlvfA9EH0rLOeuTpV08+byU9QDhTV2uxGH9
         6qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GwO6hJTK9pMNiwOSyto0K/M7BIjvwe2kKr/NYGp3HmM=;
        b=T5XMKY4WwL6SbT+FL0kRAoAxHXHq9/nMTPUh6zO4yoHGCT0JwyewrG1Qeca4xMCxuX
         c0cTWkirccp+zdK5NPXv2IR3oHOqZivgHx+ZOl6g4JZHcOJog+4fVPFuxdK8I8b5Enb6
         mDQjGbrdHEQ5ugcmd+WPEfDygAQAwgv6Nl+nyk0SHp8xy5m805Up4qMYvGRvvy66p+k+
         Ic4GdZQKI1FkXLw3nF9FBAVQtMtmyoC2oeHyAeD+sB3ymRhEVvWjWyBir8v9TOVLXTWl
         XTt2ctZcQZZxOwLG7mYtH+gGHXOn13Jol5ZzMvxQfzEXEbyr0Sn/Ya66mHsSAIWm8nyy
         Ye6w==
X-Gm-Message-State: AOAM532qQ0r9Tu3Zo11eQaTqEyj/k4yPKMHTWfBcLnq4tl+bMLgrCAP3
        zVw/VP3Y3b8BSJKKTuS/3X44BJQPPmoA+HcfElg=
X-Google-Smtp-Source: ABdhPJyATqLeX4DjT0DHydcZY1XslJVIVgJQsHnV55ps2XsRxhAGo5OyUKoCOIt7xtwjLTxMvz62nA4/v7zSGdPQAn8=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1214250otl.311.1622087959271;
 Wed, 26 May 2021 20:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-13-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:59:08 -0400
Message-ID: <CADnq5_N=O8-4POzw2_vviyKmNxKSREZwCAfiDxEhoPC-4x249Q@mail.gmail.com>
Subject: Re: [PATCH 12/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Functions must
 directly follow their headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
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

Applied.  Thanks!

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:608: warning=
: Function parameter or member 'interrupt_params' not described in 'dm_dcn_=
vertical_interrupt0_high_irq'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b4e95d3ff3b88..ae0a95c5f1d8c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -601,6 +601,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>  /**
>   * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrup=
t0 for
>   * DCN generation ASICs
> @@ -608,7 +609,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   *
>   * Used to set crc window/read out crc value at vertical line 0 position
>   */
> -#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>  static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>  {
>         struct common_irq_params *irq_params =3D interrupt_params;
> --
> 2.31.1
>
