Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA538B749
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhETTVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhETTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:20:59 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62881C06138A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:19:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso15812117otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aOvxK05c6d3wLnFR8rUhQpFTkZU71eE9Pa/GUWPK6jA=;
        b=owH4E/XC406vIhUhSMWKPP8GyzYF1Mz7lVEo7LkRN7q76QG2sgiTXc/BMDNCWHxBV4
         5eIsWYI7Y06NM/nbZzTqTwVgMR6e8YFBUz8XTPxQBPhyv3tFmpVR3RADDLFn/rle8h4F
         cgPWUwXLPvFpOIo1cn5flHD7ieUjHUAv6/HsOUwVVqpU86IpKOeB18jJnXudzBMq47UQ
         VPs5Yt225e/0F5nRXeHuJE4+W5aRuoeIjCpuhmlNqTumAygglz9UidSgkiAqqtjWNv/0
         hSyBN5GXNzwhnfyOAUTEDHzsRiqdagH47HqhiF/mc6JMZlohcD9b9BkPYTAz4T7J96Gl
         QLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aOvxK05c6d3wLnFR8rUhQpFTkZU71eE9Pa/GUWPK6jA=;
        b=S5OVYnmPtd1CIW0dJsnPgbsFEMOaIzpPK5Pvy3Dxy6EdFZ6DWl40hohnr9n5Uh1jrv
         7D6rlc4FTPcYdhv3RumRQ09Mgg4BMQNRlpFc3PtvIR1CcOq8hdvRFB6etprxx7pohVWl
         Dmf63eV6IbuWL2+xF7Hb9PgKH89/6zvBCihPm2O3deKLgf/9d0+tXsGLgB79EFnWrAoz
         0mGqvBrvSxYMiuXoAvBgh8FTeUNI9f0lx895+Yz+iFcxyECUfYeUejEz8mDO891j/y/q
         4K7RQX7x00t75P1Rhgbe++jCcVtPgAsgIlOeE1aEcRUml4F9kwEmh/GmbApEE54Lmc+G
         7m3g==
X-Gm-Message-State: AOAM5317DW+aIwZNTOwi2GmPOSs+wWOxQ1ohhyyOuI+y2oNVy1Ippj5/
        adQXOB/0d968vbH+3k37HqkxfupTUdZiowCKTok=
X-Google-Smtp-Source: ABdhPJyH4iCQKcDPVu6k2YTOnGw2ittRAY+dS0HMOZ25P+LVhK/V3vl3eDM4n+HZ6KmurXcebwFwKqKfjYKus3pdk1U=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5144353otl.132.1621538371730;
 Thu, 20 May 2021 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-25-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:19:20 -0400
Message-ID: <CADnq5_OtCr6KeYBOr-chNZRKuUOEE96B5WZN_mu2A2H_JutjeA@mail.gmail.com>
Subject: Re: [PATCH 24/38] drm/amd/amdgpu/mmhub_v9_4: Fix naming disparity
 with 'mmhub_v9_4_set_fault_enable_default()'
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

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c:446: warning: expecting prototyp=
e for mmhub_v1_0_set_fault_enable_default(). Prototype was for mmhub_v9_4_s=
et_fault_enable_default() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v9_4.c
> index 47c8dd9d1c78e..c4ef822bbe8c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -436,7 +436,7 @@ static void mmhub_v9_4_gart_disable(struct amdgpu_dev=
ice *adev)
>  }
>
>  /**
> - * mmhub_v1_0_set_fault_enable_default - update GART/VM fault handling
> + * mmhub_v9_4_set_fault_enable_default - update GART/VM fault handling
>   *
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
> --
> 2.31.1
>
