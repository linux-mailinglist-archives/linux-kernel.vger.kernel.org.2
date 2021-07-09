Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701103C29F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGIUHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhGIUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:06:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E323C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 13:04:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bu12so18396903ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gNUEx8m5Ci3AhkJ9L85gRhMaE2ah4j4mk7binwFYxo4=;
        b=feaJUqYM5Sxctzs1DGVom2moLjXlXCOJnFk+tnjkuHgsCuUjXTEQgQcTFfvCsiQX2Q
         XYfm3MrC6umSCmuh/TMX+tzTTdAH1qS93xAxfXPmqFXkzd6baiXP5DT5mXkpTXG+uYJT
         Trmkbfpq7fSUjc+BjgJgVMyWCAISdfZrEy90SykR0fLFy3/t1YfvvMROiUlWTIRz6htn
         +srkHJHBdZfOKl7sn1dAJIO2P6BPYj6YUZBWWtYemOQkZJZmS6zEUoqG6ogjcocabXPd
         5HRIprqNz6A2ifw5YdOaBte1NU8PSjsM7dYsLtuncyOBUSl8XzUtShhX9injxNWDnB7K
         bi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gNUEx8m5Ci3AhkJ9L85gRhMaE2ah4j4mk7binwFYxo4=;
        b=CR6Fs459ZQY8jRL3/YtmsIVj5euOB4jhCuEEHC5WXQwOwK9011BzBoxO1QX8Cd22hq
         /fqnntmwtFtox9tRP84oe638RqLQHng3EwGu8RpLIqMEkTvazM17/kYwZTTzYA8q6BkC
         nFqdRuA6xMUVpR4ZN/S/ylnnfh1b/rBiI7vZCFoIwLuBidz+Yf8ydUnN7+LVSn8esAuX
         REcAtPlFuvv5WMj5jpsmMCjhc0PidQEurBcGRQ5nCUyUmG58GS/OBfV0GxbySmApnrPj
         5B9YJkcmb4CdhpPX9XC/wZwKY/E4EvVl5hD336XGULbDVPYo7cpiaB9XQRGSlYpu52zB
         jzyQ==
X-Gm-Message-State: AOAM533vrcob5Rc5X4lFEfWt0armltJM9XkrmIugT719dWv4LsMa0pNN
        s72mJTZ1w1FpG+kB0xZ04/YRq9fHP6Z4gqTzxEY=
X-Google-Smtp-Source: ABdhPJwabA+5JoiSPX7Y86UOc7pc7ms437M7LQTTS/JGSK0ldmB5G2pLr+Gco/VPKuylibl/OD/5HFw+lv7xKwphgrY=
X-Received: by 2002:a17:906:b051:: with SMTP id bj17mr34448190ejb.317.1625861052102;
 Fri, 09 Jul 2021 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210709180944.2533114-1-ztong0001@gmail.com>
In-Reply-To: <20210709180944.2533114-1-ztong0001@gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 10 Jul 2021 06:04:00 +1000
Message-ID: <CAPM=9twS2B-bY8_AxB0mEVtr_2N3y3AyWjL2SNvOHA8tSMRSMQ@mail.gmail.com>
Subject: Re: [PATCH v1] fix vmwgfx compilation error due to a missing include
To:     Tong Zhang <ztong0001@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing Christian to fix this I assume it was ttm refactor?

>
> This patch fixes vmwgfx driver compilation error due to a missing include
>
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function =E2=80=98vmw_vram_manage=
r_init=E2=80=99:
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:678:8: error: implicit declaration of=
 function =E2=80=98ttm_range_man_init=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>   678 |  ret =3D ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
>       |        ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function =E2=80=98vmw_vram_manage=
r_fini=E2=80=99:
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:690:2: error: implicit declaration of=
 function =E2=80=98ttm_range_man_fini=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>   690 |  ttm_range_man_fini(&dev_priv->bdev, TTM_PL_VRAM);
>       |  ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 6f5ea00973e0..6eb93aa2f311 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -37,6 +37,7 @@
>  #include <drm/drm_sysfs.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_placement.h>
> +#include <drm/ttm/ttm_range_manager.h>
>  #include <generated/utsrelease.h>
>
>  #include "ttm_object.h"
> --
> 2.25.1
>
