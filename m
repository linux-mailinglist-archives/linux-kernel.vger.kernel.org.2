Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31D83925D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhE0EIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhE0EIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:08:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:06:38 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso3159879otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RtGwrkIZZiG/x3fVmHw4MZLqdOdAM4Gg7Y6DlMdvCdw=;
        b=pMPHrGUXErML46PYLsZlta62mAowxd0zO2JEe4M38/eyLaBxeCe4Xefjt7GTG0bxGo
         c3zV+MkFTIeXyqH3dUzGykGN86vNRYfDPsukBpabdLpFuB31Uh7TnSUtb1MaO9VgcTfE
         uTXK/gEpEari421GQlRRMqYqgjZWimNlHZtc+UINdA5SKPENYyNyDgfU+le/knyenmfb
         kgLDj0HbNkwHa+8rJiXRX1TA/GUzv2iGmTysZ/FzWWVauBZj7c13DwMvdAkn90kRDKBV
         ztf9H3Fb0e1yTZWEFcNoY9UjAsOPqH2YngGDPUI/X29iIn+ZpeW67ugUYuE9pHcIp+P/
         bc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RtGwrkIZZiG/x3fVmHw4MZLqdOdAM4Gg7Y6DlMdvCdw=;
        b=GFpUC0vBtQU2J+YDe+fncwb4wIe+Lfzk+0DLITWh1dyRQPgsvJRtA2I1Yf3MHuJotq
         SkHwIIa4x1TJ0YaTotN3ApETmIk4b+s9VxEDakjlhOmhuW5W/SljIxoD/ciQmvoZMz/T
         +DWBBsT3EnV785AdaTyaiS2p98YpgebWNMkq5bEhqoTVN5uXQwiRCoyTFKi9BjciMYca
         uFgdX3e5fiAtwSLQTIV9m7FwSmJYz/Yu1yqW66UHUTC1V7AM8Adek5cM5yv0FZXUCNah
         FgxZIoQMvefQzLKmK74Wrg2yiBr3sJep3daPWRfsYI70QoNTN5Qydrkd4JS8uZo3s49m
         gz7w==
X-Gm-Message-State: AOAM532xXlTOsP3rwDH4uZCYOhc3n2S4hCQmtWQFpUmwEx+JfUd1LrY1
        rJTVX0lXNWsE94/sp0HAT3czQ1DZJTjeKvHOkOI=
X-Google-Smtp-Source: ABdhPJx/wFysi+q75alNDvyWj5aqiElb2rD9pHI15NmXnWIaZUVQIc8U5fEeIBdUzugrq/hHK7fiisx/Y2U5yXXCjiM=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1235375otl.311.1622088398310;
 Wed, 26 May 2021 21:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-15-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-15-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:06:27 -0400
Message-ID: <CADnq5_MMSGX1Ys+n_bm0KkR_xzANYAK37r2JXi532Wzf8t7w0Q@mail.gmail.com>
Subject: Re: [PATCH 14/34] drm/amd/display/dc/gpio/gpio_service: Pass around
 correct dce_{version, environment} types
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

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c: In functio=
n =E2=80=98dal_gpio_service_create=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c:71:4: warni=
ng: implicit conversion from =E2=80=98enum dce_version=E2=80=99 to =E2=80=
=98enum dce_environment=E2=80=99 [-Wenum-conversion]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c:77:4: warni=
ng: implicit conversion from =E2=80=98enum dce_version=E2=80=99 to =E2=80=
=98enum dce_environment=E2=80=99 [-Wenum-conversion]
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
>  drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c   | 12 ++++++------
>  .../drm/amd/display/include/gpio_service_interface.h |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers=
/gpu/drm/amd/display/dc/gpio/gpio_service.c
> index 92280cc05e2db..dae8e489c8cf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> @@ -53,8 +53,8 @@
>   */
>
>  struct gpio_service *dal_gpio_service_create(
> -       enum dce_version dce_version_major,
> -       enum dce_version dce_version_minor,
> +       enum dce_version dce_version,
> +       enum dce_environment dce_environment,
>         struct dc_context *ctx)
>  {
>         struct gpio_service *service;
> @@ -67,14 +67,14 @@ struct gpio_service *dal_gpio_service_create(
>                 return NULL;
>         }
>
> -       if (!dal_hw_translate_init(&service->translate, dce_version_major=
,
> -                       dce_version_minor)) {
> +       if (!dal_hw_translate_init(&service->translate, dce_version,
> +                       dce_environment)) {
>                 BREAK_TO_DEBUGGER();
>                 goto failure_1;
>         }
>
> -       if (!dal_hw_factory_init(&service->factory, dce_version_major,
> -                       dce_version_minor)) {
> +       if (!dal_hw_factory_init(&service->factory, dce_version,
> +                       dce_environment)) {
>                 BREAK_TO_DEBUGGER();
>                 goto failure_1;
>         }
> diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h=
 b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
> index 9c55d247227ea..7e3240e73c1fc 100644
> --- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
> +++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
> @@ -42,8 +42,8 @@ void dal_gpio_destroy(
>         struct gpio **ptr);
>
>  struct gpio_service *dal_gpio_service_create(
> -       enum dce_version dce_version_major,
> -       enum dce_version dce_version_minor,
> +       enum dce_version dce_version,
> +       enum dce_environment dce_environment,
>         struct dc_context *ctx);
>
>  struct gpio *dal_gpio_service_create_irq(
> --
> 2.31.1
>
