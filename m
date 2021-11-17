Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3164454F55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhKQVaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhKQVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:30:16 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:27:17 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso7065948otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWeefiJ5livj3e6BWt4hjU8yGGELMqtOre4WtaX2Gbs=;
        b=LuY9E+Jqf/LZGNHiCVIRq34c0ZTvIsrfZzICm88+fWPe6/zPKQ8zoSNt0/iAf1yd1z
         EMZMe7myvAZJ9DkwmByAaxBd1aLyAol+E1ZoFlBapH4t5msPbk2vj+XxPvl4+HClES5K
         I1RnAU/uVkAtGumAiu4iAlkTimBRULRULvXsAR2woyD0LRyPCM4k1bngbqhmsSRhlz6a
         GgffeAwnMR7+PXRzZ2WkgaSHU9f7goYZK6QvoeM6kpLWwiUNuuQwCyKpmpYf2fez8gSY
         DL1BlOStJBB1WfcbAEJ30AIa8HrmAIqlcW/r5DKBFIlWCCbv1iJNcK9D5OR6yt8eQXk3
         bdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWeefiJ5livj3e6BWt4hjU8yGGELMqtOre4WtaX2Gbs=;
        b=jZXykGLpKSs7KEhJbO5DS9nl6Ylu/98CCE2pcA4ljH6T/T2+AbwnT/pxvwVElaVqii
         dgeDU2sGXJT6jeiBhWUAtBWAVdUJbNCJxpu0VLqzw/FNhHfNKtX/UFQ4Ug9KibrJY6+W
         Z4ddIByGUfocVFIiGjjTspLuNOycSGaxuyWSuhc13JOEI/QiWqmURP0CNWX/MiAFE28G
         SYuYKv9V7ko6rkIAeh4bjDac6veglF7T3CCWHLbY/AO6WTIkWEijyrvR4zTy/M8oH3FP
         rJpbQYtQ6oTrc9gquGmqrxb3UaWabnK6zebKqmzeegt7vDZjmRoTfZvqFSzbquaDxF5s
         jf1g==
X-Gm-Message-State: AOAM533pEUAEDRDwTk8PWN7v7+BAD8QhMC+aLyqClueSUaYPs96oZJNu
        FqTHBEqWaQn8qhP29Gijq8XcFfYJZoz/3SYZxR4=
X-Google-Smtp-Source: ABdhPJwecPSYncmBG+lhhVpKmPa76s4Aj/GYsqYX6jde/d7KTVbtQ4h15ZYf5HAvnyUU4qObMUmVMz1kgr8CXTRW+ak=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr16988381otn.299.1637184436945;
 Wed, 17 Nov 2021 13:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20211115120910.10318-1-bernard@vivo.com>
In-Reply-To: <20211115120910.10318-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:27:06 -0500
Message-ID: <CADnq5_P8DDkzHxySARAdOckgwvqnO3J_mL8-kpGD5udqa-t-eA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: cleanup the code style a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Candice Li <candice.li@amd.com>, Monk liu <monk.liu@amd.com>,
        John Clements <john.clements@amd.com>,
        Jingwen Chen <Jingwen.Chen2@amd.com>,
        Peng Ju Zhou <PengJu.Zhou@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>,
        Bokun Zhang <bokun.zhang@amd.com>,
        Zhigang Luo <zhigang.luo@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 15, 2021 at 7:09 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This change is to cleanup the code style a bit.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 04cf9b207e62..3fc49823f527 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -283,17 +283,15 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>
>         *data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data), GFP_KERNEL);
>         if (!*data)
> -               return -ENOMEM;
> +               goto data_failure;
>
>         bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
> -       bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
> +       if (!bps)
> +               goto bps_failure;
>
> -       if (!bps || !bps_bo) {
> -               kfree(bps);
> -               kfree(bps_bo);
> -               kfree(*data);
> -               return -ENOMEM;
> -       }
> +       bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
> +       if (!bps_bo)
> +               goto bps_bo_failure;
>
>         (*data)->bps = bps;
>         (*data)->bps_bo = bps_bo;
> @@ -303,6 +301,13 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>         virt->ras_init_done = true;
>
>         return 0;
> +
> +bps_bo_failure:
> +       kfree(bps);
> +bps_failure:
> +       kfree(*data);
> +data_failure:
> +       return -ENOMEM;
>  }
>
>  static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
> --
> 2.33.1
>
