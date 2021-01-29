Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155AA308D71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhA2T3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhA2T3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:29:34 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C361C061573;
        Fri, 29 Jan 2021 11:28:54 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i20so9698940otl.7;
        Fri, 29 Jan 2021 11:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTlFa+FhQ9E3hhXfUpHEFEwCBTVYyl2tyI+bhrzBYYc=;
        b=HFD5J2YGALukCCHDNdUuWUGonkc1xmVsI1d3GEijBb8667YTNlXUdOAG88IFOwVKwM
         O6Yu1YojShf0ToL3HOpg7BzIaSuQT93GgaiAcmwXUD/xt6IDxmVTp65+9h7dvzaFAktN
         cfiOlUNf8jKAM4t+v1grcMJGGAYiN3lmYLNhcXZ2Z6Py40ujQHWr2wdjSW6TX3VBqvI1
         6i1OHd9husSAeIWsJxQ2jBQLTeVnDJ5T3/8hZSOLDH5amJHUpTEBUba9CZRBboNEPQjk
         FPmSB6iyiKFPlBo9Q5uFm3JMrOr57NnEGYVekWikGXwddj783DGt/Tv/qs4Qc0R7+CT0
         0sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTlFa+FhQ9E3hhXfUpHEFEwCBTVYyl2tyI+bhrzBYYc=;
        b=Aw+mVaTZs3VYY42J34gQHTNKbefHYrVQUXMORDtY9piuzeb970wS4yDbCzuXhs/g4C
         3Ha5pD5QOqGcCg/kuRjMUXHQVhyefLbhibLPoI7VvnfjpvlTfRAy5vdApzH2woMiTJZ4
         W3XT03o3V5c4ClCsh39QoVQs44x2PuITg8R6eHLU2mGipxGq/qFWNUP9vUa2rZuC30eE
         Icbx3TlO27JJcYNHqA7lculrcS6WOoRIGuBpsWKFBSYiSjZZKBNkE90A+UXe27eqMRBg
         PXIdie2uwCoUDAPHoPxVR/BguzAQuG3dpR0tDcJ3qY5sHvZOYU/Ysh2zfyZsQQkOZezV
         WGxA==
X-Gm-Message-State: AOAM530mO0S1b9li1u0rc2KJrDjLfgBpfTQ4cyk4gbymMOiXYorhNskl
        gAz4AukrGLtNUU92JodrwxtSge9nBcDFRC7F9/A=
X-Google-Smtp-Source: ABdhPJxeJccHQSNbhg5zM7E4+pnL0FyDxpIvUiHsVHtDscx7vBeclhvpXx/FSZrPFKM7KT0j6hQkBi0B1zyn07NtQ3Y=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr4094218otm.132.1611948533511;
 Fri, 29 Jan 2021 11:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20210129120759.375725-1-colin.king@canonical.com>
In-Reply-To: <20210129120759.375725-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Jan 2021 14:28:42 -0500
Message-ID: <CADnq5_O2MKy7jPc2o7u8H-VsDxweumxGHc7oBprg7ZyP_BMu2w@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix memory leak of object caps on error
 return paths
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 7:08 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently there are three error return paths that don't kfree object
> caps.  Fix this by performing the allocation of caps after the checks
> and error return paths to avoid the premature allocation and memory
> leaking.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 555fc7fbb2a2 ("drm/amdgpu: add INFO ioctl support for querying video caps")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 84b666fcfaf6..730f4ac7487b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -988,10 +988,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                 struct drm_amdgpu_info_video_caps *caps;
>                 int r;
>
> -               caps = kzalloc(sizeof(*caps), GFP_KERNEL);
> -               if (!caps)
> -                       return -ENOMEM;
> -
>                 switch (info->video_cap.type) {
>                 case AMDGPU_INFO_VIDEO_CAPS_DECODE:
>                         r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
> @@ -1009,6 +1005,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                                       info->video_cap.type);
>                         return -EINVAL;
>                 }
> +
> +               caps = kzalloc(sizeof(*caps), GFP_KERNEL);
> +               if (!caps)
> +                       return -ENOMEM;
> +
>                 for (i = 0; i < codecs->codec_count; i++) {
>                         int idx = codecs->codec_array[i].codec_type;
>
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
