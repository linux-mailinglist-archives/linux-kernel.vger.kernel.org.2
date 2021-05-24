Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0649938F2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhEXSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEXSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:13:47 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30EFC061574;
        Mon, 24 May 2021 11:12:17 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so6543564ooa.5;
        Mon, 24 May 2021 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9I9jlaYCJwm7GMK8vCa+XPnOfqmkJZLcMPH2lbyCHI=;
        b=nzCpeBr7dDnoasU9Kv35bQBN1pMvKkUb21yqjebcNR2NJdUbJQcfCM/tzozKsoET/0
         uRTBHjIf65/dksUaZ6hQKSniPIUhnWbn84k8THLUecpHq6CvZeJnM6xyXqcZWRd2kKeG
         FPbHQEbOwZN+EoTMnq7lEWNmenmgzpzKltRDQ8yy3W/c7yn1FE4h8VKbIQfGAzUGzL4K
         ZyMvbhSOIKL1tn1GKT39I0eYmVguLX3dG458TVDrp96RUjLhWnFoYWhQ35Ubl4nsPzRL
         CdIWHCDVaqLD9QJuY1LhiLLmgnjCL8jG22j2BF5VIGNAoPfGswRu1a7C35eWEDZSwxWr
         UbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9I9jlaYCJwm7GMK8vCa+XPnOfqmkJZLcMPH2lbyCHI=;
        b=C4TVg7lZv85JIK3Z68lU5tXdifH4ajyAkjwXq2HTuJgtqB3lyFjyQpdxCACOnNvSNu
         u1U26ofBK6JjwtZYY/HvT7Vm/jqkuSIq5Y3kFs5bPcZwVr0chuZt1HvwWTmVgvvLEAuf
         GNmuEEWeQWVa/abtjdpLsRPvjJuxguOABpU0qfBgxcJYOaLzLOJzx58RI9+fG1iIZYMe
         A+8TRvhrAYiMyJ4L/UccDBdbzjqUOc/6OLzODtpr7PcM7zuZfwbBkn6KQZ8zYO517Gp3
         cjlkOB7RkZZefxVK/MtW3E5Diom/ro+dn8ccH2HcWegRnuHO6V4beSKHRR+J5dcmFUj0
         kRlQ==
X-Gm-Message-State: AOAM5330TRxXS50UDnB/9ZJPA9FgdxgRk8M/dSaDP4U33QbM3fG2+iIE
        Mt3T1hr8TjpKR0pg+++eEfcxe5ZwSzg4wN1oex0=
X-Google-Smtp-Source: ABdhPJzhVFLRxGfoyzWVJh3tF9KW/NhQHanjStmXRL3+N/qojxCqMzyXV6pZNW3TG8IVKGKFaI7lHeuVsvrsYP+dFK0=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr19301783oor.61.1621879937282;
 Mon, 24 May 2021 11:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133548.2361943-1-weiyongjun1@huawei.com>
In-Reply-To: <20210524133548.2361943-1-weiyongjun1@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 May 2021 14:12:06 -0400
Message-ID: <CADnq5_Os1fKouKSkfmmiWgjLxkX3FQ1Ny5Wcno7VQcheG4-26Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: fix error return code in amdgpu_acpi_init()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Prike Liang <Prike.Liang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Ye Bin <yebin10@huawei.com>, Likun Gao <Likun.Gao@amd.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 9:25 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

I don't see any other cases in this function where we return an error.
It could arguably be made a void.  All of these APCI methods are
optional.

Alex

>
> Fixes: 77bf762f8b30 ("drm/amdgpu/acpi: unify ATCS handling (v3)")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 49563ff87f1a..9564690b21b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -895,12 +895,15 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>  atcs:
>         /* Probe for ATCS, and initialize it if found */
>         atcs_handle = amdgpu_atcs_probe_handle(handle);
> -       if (!atcs_handle)
> +       if (!atcs_handle) {
> +               ret = -ENODEV;
>                 goto out;
> +       }
>
>         atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
>         if (!atcs) {
>                 DRM_WARN("Not enough memory to initialize ATCS\n");
> +               ret = -ENOMEM;
>                 goto out;
>         }
>         atcs->handle = atcs_handle;
>
