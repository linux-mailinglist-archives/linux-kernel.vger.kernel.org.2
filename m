Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484183BDA25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhGFP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhGFP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:28:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1EC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 08:26:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q23so24888688oiw.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2eAq2G01Bet4muv8xBvSxbgi0B+md3//Y5qHP0O3G8=;
        b=b9vQOKl2dGzKP3tFq4e7Mx6iP4z3rPwm7RMfqSC1Bo6Y17H52+i/DT4dSBua051Iy3
         H/TADdyu93N2+ZsvinXhsgnXErofkUDyYr2CJxKg/cuI9/Z+eXOTzgKrikLtIj53H0SO
         OtSe+OarQC3/6BuLPyShQBuNtrFagVBGxIswNPPCijlpohn8KWQ32o2jfFkRT4K/Hpf5
         LJFEpRWZC4yrcwY3dT9dS87ANVskb933925ZaNhjcEgqzuJGZotBnlFQTAOpONwUSwcc
         OP7wrAeNFdODDY1DOdAceJvlj1gArJFmrn5cRrXR8+KACy6In853tUu9tGA1rovsBFaV
         uThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2eAq2G01Bet4muv8xBvSxbgi0B+md3//Y5qHP0O3G8=;
        b=gRXSox/M/KknaHyvtV3iVMSvKb606OqaE98n2jFLlKGzEeywfyE2SyOUOLY9jRVIFT
         7+voInO0sWMd6ifFABpPHj3fe7B56qODNKXex1poNDvPfITOb5M24cMDCmx3/tjbluZf
         b7ts5oievhF/HnwOfAg4whHCwDDleXIrcuVDpXVLBouj0rC9NzzeVILakALPam47AsuO
         PFdUlIZ1I7cKgLLXZGiZ++sEajyTCCWJbQwmH4cRKf9seiOvdU5ZhAZjhcaE05aIA+2J
         5NLSZHhRoKOBhlcxjCIgM+oOxQtQYrcFs9mV7NopxvebgAJiY4JssfY7xkCkdsK8J5SF
         d/OA==
X-Gm-Message-State: AOAM533WtRb3weQNDKFUy5yrh5GMRtauELu84LttiA7Ab8U1nb6nGiG/
        QZFDXnRd7mW3Q4S7ljypzM91lB9kQC/sVtRfGPo=
X-Google-Smtp-Source: ABdhPJzwULEvfrF85bAMkeqO5Vtm349xcz5bNFcYDKxb2SxpX8XXeQVkPvFpiWm4BXrd0g0I7ALU+ZQCWnWhLUFWx3s=
X-Received: by 2002:aca:f12:: with SMTP id 18mr14381235oip.123.1625585171669;
 Tue, 06 Jul 2021 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <a836cafa-86a9-3d72-1f02-f9f2d58ee127@amd.com> <20210702230455.31196-1-luben.tuikov@amd.com>
In-Reply-To: <20210702230455.31196-1-luben.tuikov@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Jul 2021 11:25:59 -0400
Message-ID: <CADnq5_MMc0b6Cy+A46oqa1Pdy=GFZjFmC8NqJK=rOV6B-Ba7aQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Return error if no RAS
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>, Tom Rix <trix@redhat.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        John Clements <john.clements@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 7:05 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> In amdgpu_ras_query_error_count() return an error
> if the device doesn't support RAS. This prevents
> that function from having to always set the values
> of the integer pointers (if set), and thus
> prevents function side effects--always to have to
> set values of integers if integer pointers set,
> regardless of whether RAS is supported or
> not--with this change this side effect is
> mitigated.
>
> Also, if no pointers are set, don't count, since
> we've no way of reporting the counts.
>
> Also, give this function a kernel-doc.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Reported-by: Tom Rix <trix@redhat.com>
> Fixes: a46751fbcde505 ("drm/amdgpu: Fix RAS function interface")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 49 ++++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 +--
>  2 files changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index c6ae63893dbdb2..ed698b2be79023 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -813,7 +813,7 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
>
>  /* query/inject/cure begin */
>  int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
> -       struct ras_query_if *info)
> +                                 struct ras_query_if *info)
>  {
>         struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
>         struct ras_err_data err_data = {0, 0, 0, NULL};
> @@ -1047,17 +1047,32 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>         return ret;
>  }
>
> -/* get the total error counts on all IPs */
> -void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> -                                 unsigned long *ce_count,
> -                                 unsigned long *ue_count)
> +/**
> + * amdgpu_ras_query_error_count -- Get error counts of all IPs
> + * adev: pointer to AMD GPU device
> + * ce_count: pointer to an integer to be set to the count of correctible errors.
> + * ue_count: pointer to an integer to be set to the count of uncorrectible
> + * errors.
> + *
> + * If set, @ce_count or @ue_count, count and return the corresponding
> + * error counts in those integer pointers. Return 0 if the device
> + * supports RAS. Return -EINVAL if the device doesn't support RAS.
> + */
> +int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> +                                unsigned long *ce_count,
> +                                unsigned long *ue_count)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>         struct ras_manager *obj;
>         unsigned long ce, ue;
>
>         if (!adev->ras_enabled || !con)
> -               return;
> +               return -EINVAL;

Maybe return -ENOTSUPP or -ENODEV here or something like that since
the device doesn't support RAS in that case?  Other than that, looks
good to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +
> +       /* Don't count since no reporting.
> +        */
> +       if (!ce_count && !ue_count)
> +               return 0;
>
>         ce = 0;
>         ue = 0;
> @@ -1065,9 +1080,11 @@ void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>                 struct ras_query_if info = {
>                         .head = obj->head,
>                 };
> +               int res;
>
> -               if (amdgpu_ras_query_error_status(adev, &info))
> -                       return;
> +               res = amdgpu_ras_query_error_status(adev, &info);
> +               if (res)
> +                       return res;
>
>                 ce += info.ce_count;
>                 ue += info.ue_count;
> @@ -1078,6 +1095,8 @@ void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>
>         if (ue_count)
>                 *ue_count = ue;
> +
> +       return 0;
>  }
>  /* query/inject/cure end */
>
> @@ -2145,9 +2164,10 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
>
>         /* Cache new values.
>          */
> -       amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
> -       atomic_set(&con->ras_ce_count, ce_count);
> -       atomic_set(&con->ras_ue_count, ue_count);
> +       if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) == 0) {
> +               atomic_set(&con->ras_ce_count, ce_count);
> +               atomic_set(&con->ras_ue_count, ue_count);
> +       }
>
>         pm_runtime_mark_last_busy(dev->dev);
>  Out:
> @@ -2320,9 +2340,10 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
>
>         /* Those are the cached values at init.
>          */
> -       amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
> -       atomic_set(&con->ras_ce_count, ce_count);
> -       atomic_set(&con->ras_ue_count, ue_count);
> +       if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) == 0) {
> +               atomic_set(&con->ras_ce_count, ce_count);
> +               atomic_set(&con->ras_ue_count, ue_count);
> +       }
>
>         return 0;
>  cleanup:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 283afd791db107..4d9c63f2f37718 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -491,9 +491,9 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
>  void amdgpu_ras_resume(struct amdgpu_device *adev);
>  void amdgpu_ras_suspend(struct amdgpu_device *adev);
>
> -void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> -                                 unsigned long *ce_count,
> -                                 unsigned long *ue_count);
> +int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> +                                unsigned long *ce_count,
> +                                unsigned long *ue_count);
>
>  /* error handling functions */
>  int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
