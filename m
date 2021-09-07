Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0FC402D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbhIGRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbhIGRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:07:14 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26495C061575;
        Tue,  7 Sep 2021 10:06:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s20so13654693oiw.3;
        Tue, 07 Sep 2021 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvLnME+IjjXBdlapd7qwu3ckCRmUspxnvArgV5vhrZs=;
        b=p7bvjkWXysVTS4dKlzkBHNI0Mh2Ex6LJErKRsDYC6PVaIdcwIhfzGMNcrVeAvjcB2N
         lPjSwJBCVFki7J736XxBScmH+iYS31DmnOhzzHcq+Yrql2ayrSwZprAv3+CImVQSQVCQ
         psPhSwmoRy0mL7JL4baFLy0N5j4thDzc/tRP2ooL7dF7FFtRCVI4fGbNjrKgzP29Nwal
         BTpKD44nZRaJRiNT6o/tqQzfFxbUi1TKdMNL/cj5LpMvVNKwKK4+UCmfO/FU9Fa3Z22n
         GYhUyvfOQim9/RaYGbZsfFOElPt2QDnQVQkkHEaJJzLSTqlgovAAl4l0CJaGhCJio3D9
         R8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvLnME+IjjXBdlapd7qwu3ckCRmUspxnvArgV5vhrZs=;
        b=TOE8K5UlMm2wcZ9ABSIYytgSJ+F4QFWquzxD17EFrtceJ7gBAUPgfJQ6c3YCbo6GMA
         T+eCax0Cwu86K8cmhE+OKx116k1EZMHvI/TKTrwwoREc7JvssZn0MHDQiRKTTOQmVnSc
         QUIjzFw6YkQwbPkupLjsLqPU14IY23zJBnANHmEI2js3WdW4mGfTDN/Ls9Cq+e5TbU5G
         FE8SJ8NrFm/7JVHMmGJTL7Uhjp6dsx2yorBjjSA4pbj57sV7O/UygSj+uqFhHPyLTrQj
         1jC1ulCutbrvy9L/zWMh4UrEek+zkYYLtx3MMxYKZW/aYOJt+JmrqL5eXQAKDcJS/egA
         CgwQ==
X-Gm-Message-State: AOAM532ZEGq+/YB+aRVv7psT8rszEydeB86608QZQHQOXDWeeZm2HvMM
        dshN5VHMfZN1sEKB3+24HtLNga3PxIwwZAo8JnUpM/fy
X-Google-Smtp-Source: ABdhPJx3mbR9TZRmahMq3/ZF7VUfLVN5NKyz2LJ9Td2mGx+cyp97pCLl0NghVieRW05ckB4pOBB81dxwCcF4itvsl08=
X-Received: by 2002:a05:6808:483:: with SMTP id z3mr3622068oid.5.1631034367521;
 Tue, 07 Sep 2021 10:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210907110913.15499-1-colin.king@canonical.com>
In-Reply-To: <20210907110913.15499-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 13:05:56 -0400
Message-ID: <CADnq5_PsA5KsH5D2=-GKLgq2HQ-_5x=-0SJF3htvKEzK5cKVYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ci_dpm: Remove redundant initialization of
 variables hi_sidd, lo_sidd
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
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

Applied.  Thanks!

Alex

On Tue, Sep 7, 2021 at 7:09 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variables hi_sidd and lo_sidd are being initialized with a values
> that are never read, they are being updated later on. The assignments
> are redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index f0cfb58da467..ac006bed4743 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -390,8 +390,7 @@ static int ci_min_max_v_gnbl_pm_lid_from_bapm_vddc(struct radeon_device *rdev)
>  static int ci_populate_bapm_vddc_base_leakage_sidd(struct radeon_device *rdev)
>  {
>         struct ci_power_info *pi = ci_get_pi(rdev);
> -       u16 hi_sidd = pi->smc_powertune_table.BapmVddCBaseLeakageHiSidd;
> -       u16 lo_sidd = pi->smc_powertune_table.BapmVddCBaseLeakageLoSidd;
> +       u16 hi_sidd, lo_sidd;
>         struct radeon_cac_tdp_table *cac_tdp_table =
>                 rdev->pm.dpm.dyn_state.cac_tdp_table;
>
> --
> 2.32.0
>
