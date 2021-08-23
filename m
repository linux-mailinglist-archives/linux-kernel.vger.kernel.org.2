Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5030F3F4C78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhHWOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:35:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B802C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:35:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso22031230ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgOXv9hBmtE5f7y6QsBO8K1XJAJ8y+cvtkl7Fv+4L6Q=;
        b=eoAs6ywolFNJ1+ayQ9E5Zf8t9YpcloyJtBG7I3KV556wk1qKb5NqzH1GyQMo+mlV3g
         4kSwBvR87oZbF/Lusto9T+PNUgLqTAzr0Po4C70VWruNfembRzBuSH0rBjCXgxzZ0Vfo
         Tb6FMe9U5hRELjGmC2bUajciCyZF13rLbV6r0IjIs6Dnh0cvBNW0qVT+xunyf/+nU9D6
         hF2wI6HJmJQf83TGGyLx82XQr0bHqjlGxTQEtKN4r0G+6fYPc8J7H3GV9ICgkIsID7xB
         2f0RXGzM4egqJzLPPLsKNDFqnrtTRfRkm1tpK1wNNNSYr+RJnttOErhzJsco9ayXKILp
         BUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgOXv9hBmtE5f7y6QsBO8K1XJAJ8y+cvtkl7Fv+4L6Q=;
        b=rKcAwipfjxOT4FGSPvH8E4A/4CfMYco8210bN/DJ2ZE4mhA8c9x/spaO2P8CTSNCtZ
         mY0kChdSYzfT0bOc+kD2buXrgmusE1ipVgAQJLqbYMiJYjPxaY0iqNvDWzDW6rzBvryX
         BoOHgxFNIR9QfLUYAzJj9zYqcczDSVw9czhUYRPKHCJ1R1rzy/iyFOLBD7cpBLbChxfY
         WPdvn70l6SHEQPrywpe1eZHHIy4RcNKlh5yEQuyCejxMCfVPkixMySQVmcOV2d2/kZOj
         50Z4hIrwE9WuJy6oTEHwz0JPH2SbPBWECJiwNEfciHfBK3+v/wDH1wGnevpEBX94+l2P
         dz/g==
X-Gm-Message-State: AOAM533iid+SSBWjEbexOQNRiduY8S6FOR8Hrxd2dXqjNXq54fX3ZvIp
        MTWGF3/vb/gnVuiPicueESyWTsO+ZFKIKs+1wbE=
X-Google-Smtp-Source: ABdhPJxsIAjPqPk9Sp6v4AwVB8tD+eTvHkyD8t4hVwHOVcuZooIZjbwrqRsGKT1xWeEpsHiTWT9aIRcFNFPY9CWFt7I=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr27849060otp.23.1629729303838;
 Mon, 23 Aug 2021 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210821082141.8608-1-liviu.cheru@gmail.com>
In-Reply-To: <20210821082141.8608-1-liviu.cheru@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 10:34:52 -0400
Message-ID: <CADnq5_PSKvmgfsO3DrNsyWqhgVnU312ijZ_BA92K3MDQU23JMA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: amdgpu: Fixed a few warnings
To:     Liviu Cheru <liviucheru@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, liviu.cheru@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 4:46 AM Liviu Cheru <liviucheru@gmail.com> wrote:
>
> Fixed warnings regarding SPDX license, using "unsigned" instead
> of "unsigned int", wrong function parameter name for the
> documentation and a space between the function name and "(".
>

In general, please split these up by the type of change.

> Signed-off-by: Liviu Cheru <liviu.cheru@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 795fa7445abe..af1abb281c6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

The license is MIT not GPL.  See the actual license on the file.

>  /*
>   * Copyright 2009 Jerome Glisse.
>   * All Rights Reserved.
> @@ -129,7 +130,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>         u32 c = 0;
>
>         if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> -               unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
> +               unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
>
>                 places[c].fpfn = 0;
>                 places[c].lpfn = 0;
> @@ -731,7 +732,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
>  /**
>   * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
>   *
> - * @bo: BO that will be inserted into the shadow list
> + * @vmbo: BO that will be inserted into the shadow list
>   *
>   * Insert a BO to the shadow list.
>   */

This code has already been fixed.

> @@ -957,7 +958,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>                 bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>         amdgpu_bo_placement_from_domain(bo, domain);
>         for (i = 0; i < bo->placement.num_placement; i++) {
> -               unsigned fpfn, lpfn;
> +               unsigned int fpfn, lpfn;
>
>                 fpfn = min_offset >> PAGE_SHIFT;
>                 lpfn = max_offset >> PAGE_SHIFT;
> @@ -1175,7 +1176,7 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>   * Returns:
>   * 0 for success or a negative error code on failure.
>   */
> -int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
> +int amdgpu_bo_set_metadata(struct amdgpu_bo *bo, void *metadata,
>                             uint32_t metadata_size, uint64_t flags)
>  {
>         struct amdgpu_bo_user *ubo;
> --
> 2.30.2
>
