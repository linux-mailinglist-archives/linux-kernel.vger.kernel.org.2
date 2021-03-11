Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66533337807
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhCKPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhCKPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:39:10 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EAC061574;
        Thu, 11 Mar 2021 07:39:10 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r24so1824162otp.12;
        Thu, 11 Mar 2021 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8nU3otkqKDGoLnXZ+AyQvf2Qyce9hWCQRz5CGYNTV8=;
        b=YcOESLcl6A0DxELmb4Q3UlWuPIwjY/Gi64vBCZUBHVthOHA1c7hZbJ5ZyFx1ShfPX+
         UDBXkbf0bBJ69IdKKvHxGPdrz94adaGRFXEZvmClR/gYFpmJUxiTPatMLAMUwl0Kr2ew
         YImXGZF2QV8Kc0Sdr7//IBmcxMeUp74q1MOdPi4NRzbJnpMT9jd9k2yrBRmOk7Kj3rLI
         VGaEkR4caadslizFgAO2MX86IwC42yJjj6TD53EJBd1ndKHqxOsbQCJY0HagwDv6NK/V
         o29f/1sAPK23OLr1chPlFfl7NN6ki+6ZutXKq9c+JDqMqxex2FEAucpqibpFp1RX3FPO
         1S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8nU3otkqKDGoLnXZ+AyQvf2Qyce9hWCQRz5CGYNTV8=;
        b=mLVK+0P7/XMQ9McEt/+0ucLEzq+zsS10FwwTRzTD1AZvZvGx0HJdXBk3I5zI4xFeaL
         ZkInNlYJR0vXL32mV01N7sNcCplwdXvvTa/ksWmd1jSebjBlD7hbQ2334lV/DsnG69Id
         1XnBWuzri/sdQqcoGpxMYpizXSpaG6XkSPYeGrd4uXVv+UW7XjygfRZryk2k/bhVEKuY
         u86s3u4uHPw1IFINvQ7AWMW77k6JNku+nRreWCrA63MxhKWECGnC/ZWNFdTI/C46VAE6
         dRdWup3fPnJT3BeLiAxFHblVlJUkJW0U80vbscMTSrCmM6+vTBtTqDJLqdDzUsN8JPdJ
         AdtQ==
X-Gm-Message-State: AOAM530iVeCr9X+uL/o7qqdgfXyIkBg7zwSc6dFTUUQTN9wGAdKxhEhF
        1MfTiflA3tBnZL3ZDCd8yMoF5fAzhox6W0c57u+mWSzx
X-Google-Smtp-Source: ABdhPJxOjP/JafiPMC5iAxWgHzxV7klk0G1enHWcpJxnjDmEpaJAZVjHHfOQIxpKPQnRhz+jSKit4DzGCNRjuClDMsk=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr7279798ota.311.1615477149643;
 Thu, 11 Mar 2021 07:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20210311092830.5106-1-colin.king@canonical.com>
In-Reply-To: <20210311092830.5106-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 11 Mar 2021 10:38:58 -0500
Message-ID: <CADnq5_PNgWJPjV-kny7pfRZZ7pS8FhpHxWYPBKbyGd7kVqW2Fg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix spelling mistake "disabed" -> "disabled"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

On Thu, Mar 11, 2021 at 4:28 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a drm debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 617e62e1eff9..dcbae9237cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3464,7 +3464,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>                                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> -                                       DRM_DEBUG("IP %s disabed for hw_init.\n",
> +                                       DRM_DEBUG("IP %s disabled for hw_init.\n",
>                                                 adev->ip_blocks[i].version->funcs->name);
>                                         adev->ip_blocks[i].status.hw = true;
>                                 }
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
