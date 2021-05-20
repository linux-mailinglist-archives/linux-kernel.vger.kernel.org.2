Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5603038B6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhETTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhETTMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:12:19 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:10:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id t22-20020a4ad0b60000b029020fe239e804so1222827oor.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7aUG2dXh+6klmDA6WXd8OSdzl7pjQCCb87TCo0Exy6E=;
        b=mfIXPPC10SzTZqxuepC3SiwJi6etRAelD5Y7D4Mj+i2F+ZX9euxkSxgtSlreNy8Wq+
         0DzQ5Fd/Bw3uP+VaNdRXPkP2PdIWaZ71qzYVFPKDoW52A062H8ShnqfUFuuFM4LzZtWl
         e8x0dG0ZRmSreIPjrRnRP7NnexrVLaFbZdIxfa1jpRB1WST3Yvsd68yNsfJOAS3fC47c
         4kNHVUPhVOzqcafK3dXXLyJlbQaaNdlVcwZw5AfC31+Kfmb2wBS2ZwpUnpyzKqDx6WUa
         g2hqC+xjp6E1Mrt6so4bseLcZtNeIKTR7YHBcjOsOzgyYq4d8ccxnVvpnl1o+a+akq27
         /6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7aUG2dXh+6klmDA6WXd8OSdzl7pjQCCb87TCo0Exy6E=;
        b=CEXhUmC0TxWe6kHhiKunIfB0XsojC9vB/5fA1aBH5vdtEmTFzhU6tRFkfQbpJpQPl9
         sEeLyieSFCrayrRG/1SuU5Fw3CybnqOzB+dAUdCFcggia0slUoL8mScsDskmcI/74vmt
         ueSO/YREKTlUIdG2VWMtW+Yz6HShnd0mV6OE1AcQErE9V9ggpO6JPk4q6q9hJLdlKxBA
         dUOZeBRjV1CbrnLdO77EVJ9P9zxqaSAQ0+aoM84OmzIZFnBlOsodDxNPtEGK6XK/ANC5
         02iPZ8O82/27f4WXqAgln/Sbfdtrg2Pc3SCXKaU0mXk9EQp0pJmGXcyMHouQJ0ZPivBN
         t0SQ==
X-Gm-Message-State: AOAM531z/e3h23mzV7K61auTYR6j9pZp98nfTKDg50+K8+tKE8Up0tZK
        5a4d8WG5eDbysvf+tuVHh6ZDYbembgc2JEY1ZN4=
X-Google-Smtp-Source: ABdhPJyxmJJMnSHgvijXuC3+a1N5VY1r34o/FRKeOu5rQXlWBh5wzcOKYm9e4IMiB8c2W8XXE3R4pH7R9VEoycNN7Uo=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr4948998oor.61.1621537857547;
 Thu, 20 May 2021 12:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-13-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:10:46 -0400
Message-ID: <CADnq5_PCSixr_j3+zxhS4Z3WG83L_vYQuboo9NOOML0n_r9j0Q@mail.gmail.com>
Subject: Re: [PATCH 12/38] drm/amd/amdgpu/amdgpu_gmc: Fix a little naming
 related doc-rot
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

Alex

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:487: warning: expecting prototyp=
e for amdgpu_tmz_set(). Prototype was for amdgpu_gmc_tmz_set() instead
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:533: warning: expecting prototyp=
e for amdgpu_noretry_set(). Prototype was for amdgpu_gmc_noretry_set() inst=
ead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index a129ecc738693..58feb0a422c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -528,7 +528,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_devi=
ce *adev)
>  }
>
>  /**
> - * amdgpu_tmz_set -- check and set if a device supports TMZ
> + * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>   * @adev: amdgpu_device pointer
>   *
>   * Check and set if an the device @adev supports Trusted Memory
> @@ -574,7 +574,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>  }
>
>  /**
> - * amdgpu_noretry_set -- set per asic noretry defaults
> + * amdgpu_gmc_noretry_set -- set per asic noretry defaults
>   * @adev: amdgpu_device pointer
>   *
>   * Set a per asic default for the no-retry parameter.
> --
> 2.31.1
>
