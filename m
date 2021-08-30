Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E43FB9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhH3QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhH3QIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:08:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A341C061575;
        Mon, 30 Aug 2021 09:07:11 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x10-20020a056830408a00b004f26cead745so19011084ott.10;
        Mon, 30 Aug 2021 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ruwp3iijqIwZVSgXNeIhFJbwgJtXDZCn8fxCLBnVSpo=;
        b=s3cvyYzQ9YyjSHdAUvCw6BZcy4J6QWSJo6UK76LFVfTEVetuG5AwfDUCCvgJDsFYYo
         ntx0y3ExhGaYY/ArvFblOVtM0WTYCj4/VLqaCfRiYIBhnVxwtwUeqe+79ygj+hUE6FEM
         asWOBsNirtXtPkqWn3QF9ALTxodu+uy0f9/5wUPmWlt0Tc2+hVCBQi7jTnEHS0MQifRP
         UFLc9SvrBJjMn/R23zohpAo+KOwbw+02Gqi2L5iUZldkYyZoBNZojfQwkyW4JKQJjj3g
         Q8L9MaY1ORB4EvZeEC/DnMzyDchoFkLbSAAbk03jno2JWlEvnRs1qRYoLPr2GLG6FNQN
         w7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ruwp3iijqIwZVSgXNeIhFJbwgJtXDZCn8fxCLBnVSpo=;
        b=ICt+BIpMGEljdtx1ZRsSKaZuuRt+o2VExzflyEV4mkWgAQfikT6WAhn7t4HR8m8VG7
         OQuACP0CVuGdYk0m/cttpIFiYjGzHRkKQDGjReo92b893pJyaM7rD2xajP1bYEJTugFD
         xt7obdo9Es0Kl2fxWKMgKnUgg0sgqytC1CGcxcVZC+cCFjNV3I7lXWGXA1hUMSv9LKyB
         o6W7oFCTZIIsCWJykAzYSd10VVGRIEIBZvEjfyXfoqmr/TnbbiUX+AJbkf4YoA7yMXqk
         yiYh9OFNegmzdmlCu6HL2AtlxtYqNZevToZ26ky7p4aItlaNopvqh6v9HnTJ5/bi72Lz
         oChw==
X-Gm-Message-State: AOAM532FeYLJhvsUPCvJsvPhz2OSma6mMFdMwYxc+LxDEMZ85w0muSFj
        13neSefvj4HflsQyBmTNiPe5pFSqcgjnZeAssUOd9+i2
X-Google-Smtp-Source: ABdhPJzYjOG/T5oPCIUruDBmzAlPMcIH2mAh4iRhp/OybEGs5JtN4FWYzVB/ir1+/bJwtN0eKFAyVfymflI8BY45PxY=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr19848810otf.311.1630339630660;
 Mon, 30 Aug 2021 09:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210827185914.507508-1-colin.king@canonical.com>
In-Reply-To: <20210827185914.507508-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Aug 2021 12:06:59 -0400
Message-ID: <CADnq5_MFawF+Cq26-HxHAc1e2Pefrwg_95kYj9p=jHdpiBoRvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: fix spelling mistake "minimun" -> "minimum"
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

On Fri, Aug 27, 2021 at 2:59 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are three identical spelling mistakes in dev_err messages.
> Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index ad52f7ecfb87..629bb8e926fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1869,7 +1869,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>                 } else {
>                         if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
>                                 dev_err(smu->adev->dev,
> -                                       "The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
> +                                       "The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
>                                         smu->gfx_actual_hard_min_freq,
>                                         smu->gfx_actual_soft_max_freq);
>                                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index b39138041141..5aa175e12a78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -426,7 +426,7 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
>                 } else {
>                         if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
>                                 dev_err(smu->adev->dev,
> -                                       "The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
> +                                       "The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
>                                         smu->gfx_actual_hard_min_freq,
>                                         smu->gfx_actual_soft_max_freq);
>                                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 0f17c2522c85..627ba2eec7fd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -731,7 +731,7 @@ static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM
>                 } else {
>                         if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
>                                 dev_err(smu->adev->dev,
> -                                       "The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
> +                                       "The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
>                                         smu->gfx_actual_hard_min_freq,
>                                         smu->gfx_actual_soft_max_freq);
>                                 return -EINVAL;
> --
> 2.32.0
>
