Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F131C1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBOSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBOSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:50:12 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D5C061756;
        Mon, 15 Feb 2021 10:49:31 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d20so8709779oiw.10;
        Mon, 15 Feb 2021 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB2e39wmNlyzoYXIMSc69EsNZtZJAfxV8F103w5KYGI=;
        b=oXYEVDu4uTGML/zfEiarbYcXKEQcPNMwtPPdMJWa4jXS30e2OU6f48biZk7RQwqezn
         99bmlupbkxFnjs1aK+hmbuDi5sgbHqikxMjQuhR3nlbWMQZrHGQXO5B7nUbN5CN+y761
         OcZBPECUbFKAjQu/gRUi8gaLlNr0mQQeMDv/AHfHGDll26NYz7i31vmUqzFXeSn1M/d8
         9H0NZQVdCFuK29XYKlKDPSHbpZI/IBWB21DvxEJvSaKew3bEFNhPEFWBY9bsWQMYP8H4
         tLb8MiNcg+rw7Xa7SL0rDxpLM/IIfUTwqQra1hwYVEFfDTslvHgYosDGhWxaBUJstbPQ
         FgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB2e39wmNlyzoYXIMSc69EsNZtZJAfxV8F103w5KYGI=;
        b=XKHgDPAcKmwjq7k8T8iviQ1geAYPaFZNW5QEeLFJUIJlURgJrwqXeSVJubdX7mUeiS
         AwpxjauNRfKHgsHwFAIomlCBeq6eOVXri9JIFFoy6otAxGpYWWoJ8ELjUqNj9xJ8ZAGA
         eD4IzIQn/m0WBREXcmBd4i1yqUgUAn6vBo3o2/OnLK3xp72KFsp2zb7PCyTFdYswG7yp
         RU7Vrvdb1MSd4vgZhXnAOLS3QcZ6R1nxfZZyWkgHqKnXfoXYaA2TzGAuZdH9+l2SEFiX
         dBzqbuAL2sZYBS5EBFuYCkfuMxfWUxTXieot7ubrSEW5BEy91/I3HscaRF23menvM7BU
         iuCA==
X-Gm-Message-State: AOAM533gJ9VlPg/+rNjwcTJVkEbytZSf5fRFoO/Zcn3S1a52IqIQeoDh
        NDUOdaO6NkKzKwUWKn282bsEGlwG/lj8HrOpF9g=
X-Google-Smtp-Source: ABdhPJwtNcR+iy1OFkd46IBqezbb6PuDuK3CNJ9h15rAjsTAG8bDhXVe9+Ue5E0HqMfp7H7iOOiO4n6Ukn2d+9HXkyM=
X-Received: by 2002:aca:c786:: with SMTP id x128mr208317oif.120.1613414970760;
 Mon, 15 Feb 2021 10:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20210210120330.54066-1-colin.king@canonical.com>
In-Reply-To: <20210210120330.54066-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 13:49:19 -0500
Message-ID: <CADnq5_NHvHgUzd=3xS0VTKVTWyQx2uQn5d2cMrDMso_o0UiUOA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: fix spelling mistake in various
 messages "power_dpm_force_perfomance_level"
To:     Colin King <colin.king@canonical.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 7:03 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in error and warning messages, the text
> power_dpm_force_perfomance_level is missing a letter r and should be
> power_dpm_force_performance_level.  Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index ed05a30d1139..d1358a6dd2c8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>         }
>
>         if (!smu10_data->fine_grain_enabled) {
> -               pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +               pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 093b01159408..8abb25a28117 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1462,7 +1462,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>
>         if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
>                 dev_warn(smu->adev->dev,
> -                       "pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +                       "pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 5faa509f0dba..b59156dfca19 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -351,7 +351,7 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
>
>         if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
>                 dev_warn(smu->adev->dev,
> -                       "pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +                       "pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> --
> 2.30.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
