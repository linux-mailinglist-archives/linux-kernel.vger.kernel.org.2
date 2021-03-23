Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E659346230
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhCWPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhCWPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:01:05 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:01:05 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so5004738oor.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVCoKkCqJZzN9wlMxcIT977e4kipSpX9b+GAtdQCUQ4=;
        b=ssWmDwgF/PsJRaCsBF+KVdRE49iM3WN148ZUTQosDfbZ+9Aj8/5N9+zEI3W87YDkpt
         hyjP7bptfqS0vNzYScVS0UnJjxGpfSZRQlrqEhqK02F8q2Tjf5ktx8eiEBBZ75eb1zfO
         A3sMDpeU9Y5SQqTBoMDM1VoSMXeTSLmCaIHylTJtjXGaGu/T1Ayn7EZoJ06IoB72JpN4
         wBPPyuoijAsff35VAHRsM22AzRkfs41mHClT9h9XSRnwWrn21fVKQOh+oxAYKvm/ylS5
         gqSUBSJo2ujq6UhwEe8jOYQMQsh/B0Nzz/1NNaqbiBJcWSPswwWFJeMDFa13VLFwQHno
         eOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVCoKkCqJZzN9wlMxcIT977e4kipSpX9b+GAtdQCUQ4=;
        b=UXzNYrFpwrlDJdotDswMWYmYBiILnrFDhG6xO9fJ907JcbC6SXiDRa/OrbC7e8FZsK
         fPL7FgXgPO7g8ZLVVnky4LpCP7DuiGhig1E2kDpzbHNJjy4RUFJ3EmKlRZiq9D771zMI
         5piDzrzVpL1Hi1a8Z8lPUGDtFT2n64bHXpHTdprIqem+nG6KGFAJjaoqVKhctiP2zpx+
         oGiW+sl4/O2WhA7thCDDxgUMO3MPa7v6DTWmdm4WYc+Knp2CKQT8tG2EHSUdesA/U+5L
         ZKPoMmC+/gprdXxPf+wF0qejhfZAnCoHDX2FsBOpqGPS1zoV2Jr8gnk65/SdDnsgxHzZ
         C5hw==
X-Gm-Message-State: AOAM530I1ZPXyW2Ywn/zdtJqU9LhWqlGe42WYgtkmvWG+eKtXxcYLfe8
        vnBuSiWtp6rsyz0CVy2BFhjqH/w9QMlB94kege8=
X-Google-Smtp-Source: ABdhPJyVXQoRcrIFx3RZdlq5mSTmgKwJUqfUm074Go5J8ggF04dlHskZzeXJgkhMr5CuuYNIRMcVpx3NsjV1sImXTFw=
X-Received: by 2002:a4a:4005:: with SMTP id n5mr4153901ooa.61.1616511664731;
 Tue, 23 Mar 2021 08:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210322115458.3961825-1-arnd@kernel.org>
In-Reply-To: <20210322115458.3961825-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 11:00:53 -0400
Message-ID: <CADnq5_O-nxHA==3RMAZki_Wxgo5dQuJMAQq6xU1q=sze6KN0nw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: avoid incorrect %hu format string
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sonny Jiang <sonny.jiang@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, xinhui pan <xinhui.pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Chen Li <chenli@uniontech.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Mar 22, 2021 at 7:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the %hu format string does not match the type
> of the variables here:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:263:7: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                   version_major, version_minor);
>                                   ^~~~~~~~~~~~~
> include/drm/drm_print.h:498:19: note: expanded from macro 'DRM_ERROR'
>         __drm_err(fmt, ##__VA_ARGS__)
>                   ~~~    ^~~~~~~~~~~
>
> Change it to a regular %u, the same way a previous patch did for
> another instance of the same warning.
>
> Fixes: 0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index e2ed4689118a..c6dbc0801604 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -259,7 +259,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>                 if ((adev->asic_type == CHIP_POLARIS10 ||
>                      adev->asic_type == CHIP_POLARIS11) &&
>                     (adev->uvd.fw_version < FW_1_66_16))
> -                       DRM_ERROR("POLARIS10/11 UVD firmware version %hu.%hu is too old.\n",
> +                       DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
>                                   version_major, version_minor);
>         } else {
>                 unsigned int enc_major, enc_minor, dec_minor;
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
