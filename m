Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF48E390ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEZD2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEZD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:28:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AA4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:26:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d21so180993oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2yP+ku7QrjLWJX/oew2T5TuLTAx5mCKhqruiqxpqcQ=;
        b=O3ljL1lRtGVQnjW8rsxilo9NnYYFVfvcU+/khpdunoVIfI4W84MTpwjJpkRuZbfsge
         3iRAMojK5fRFYnr8kf7Bnpgv3HdrtTrqKyui+mPtqtRCkxK+W3ULjS7ao6aDizRBrb1n
         ldhJJ/bd31Fjy/4L7em6LUoHtABC3P9AiHM2xocsyiCcWF+AcRdBDXGc4sque9YUFVx6
         3bR5etFDyuYjjlNQd6SGH4QGj5o8kS2QKh4rDugerss7iwrGzoxfdYpeq0DynpcFnxiJ
         URGMYAaPOXtt9HdNfEzwiOHrpiUP8UjG0ClNE7KwmJPxaU+7Q0QWbREmzQsd12xGANjo
         vmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2yP+ku7QrjLWJX/oew2T5TuLTAx5mCKhqruiqxpqcQ=;
        b=srs+xUidfkBwwcsxIU2YLC1fy/mZX25ptW6Viid4oI8N+KPIyjjK9rHL3J5pWDgWUz
         XUzZvB8dpSvMG+CY8GJCvrCZLjSlNNOgt1lxKmC4wP5o1iw9g+ERJ8mRAQ4U/VkN3DTW
         /il9zSgqHKCcoCozUS9ejPFFDW6De8qx3EGVDcDw0fpo/x88a3owWuyJ7ajIVyNN2ZTd
         BRhMwtuq38+ESPV4MdbZJvBBC+VJ2SDqKcxXTYicd9ZZbNPGF7A3gVj3EB1BV4pt+GL9
         nDDHmQhFPeh224sq/GIat5yyy48QG3arHgyOuIqT8KnLD6esCI1sACFLAG1G8G4ptDrS
         B7yw==
X-Gm-Message-State: AOAM531T27uJmi9scqlh6+uRB+D/KmdUxNDjPjJC83d9McAoVkUrDMAZ
        y2XqkEwWVMQQZIXFhR6hj2eoRensHDWAe1RnVhatflRUaSc=
X-Google-Smtp-Source: ABdhPJxEn4U0hetnvUphpr602aW+SAytDbAyj62ON2cN8CxvAmsHRKjnWPf8sPqYl5WXvOCS/SkUjrUOINKlFV1GAME=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr501125oiw.123.1621999590741;
 Tue, 25 May 2021 20:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <1621997748-127963-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1621997748-127963-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 May 2021 23:26:19 -0400
Message-ID: <CADnq5_PseP5LDdLY7=v6K7VZ-d_hZW_diuRh721S8gDHmaoYNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:56 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in sdma_v5_2.c kernel-doc comment
> to remove a warning found by clang_w1.
>
> drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:528: warning: expecting prototype
> for sdma_v_0_ctx_switch_enable(). Prototype was for
> sdma_v5_2_ctx_switch_enable() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Already fixed:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/ef6f76407cd7796bdeec31305c435162ab54c030

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 240596b..db79ee5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -512,7 +512,7 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>  }
>
>  /**
> - * sdma_v_0_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
>   *
>   * @adev: amdgpu_device pointer
>   * @enable: enable/disable the DMA MEs context switch.
> --
> 1.8.3.1
>
