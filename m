Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907331EFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBRT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBRSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:41:32 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B4C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:40:46 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id l23so2769293otn.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKc7ZspagPR2F1k2fhzcSExhZXGUtyluR76nOC+AMmU=;
        b=MPSrTvgmuhmGRFVaprGSkR/fjPIL6wO9YDZX+esMkvv2liwxxbRN6Y8/YEkXcdZPum
         OV28GaadKDtRe6SHfgFyIhW7GFuIcHbhkZSagqQqoB7btr6trc5ZfEWdnbxYFZkRwCtk
         pAmW4gyTYHbCAjisATpdmFDhXb2dSRrObP4iI2igsbTEOVQeCCvxRTs3gPtbYsbA5S9N
         Ecok0m41skRBDeKft6BCmZ8qsX+Npv0tx3wrNRYvT9pv/eD2U1R8WqI2l1lGiecNk9fT
         YNLfNMtSQFyIZk74HhYlQi4MHcj8T41dyy7vSeCodjSNXvIepHax72HsKRLGyCHEPoLV
         WXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKc7ZspagPR2F1k2fhzcSExhZXGUtyluR76nOC+AMmU=;
        b=ND/+KCT4zg0EfxUVQ9AqIwFYYCzqvzeFo8vKZh2m5N0RToldAbVT/0C1jA2PqxSKZT
         e9N2Opmzjx9cOc0V1Glz3OzERLMdGzvosNi8iQUm6ONGSB+g7ngKKNpBz0H7kDZwq6p3
         WtfVRKh2auIzed43dMoVl92OUWu4510pdOVuJPM/O/iLGWaEq5abTvx2XGpfq7vgFJ2V
         jdBhyHzd7aKqIQF8GF5nP7DH8ZorNaq9ici8G/1vbEiQlbBmlPEI8Lvq4WqCL+8jBS3v
         x3ER0Z381tC3Dnrfv6q0U2E6p1B+hvqwNcKINxoBR0REWIFtjBZyHiqD1pt3w7LoWQp4
         M1zA==
X-Gm-Message-State: AOAM530zykIElsj1pErqkTEVRCnTUCI2vFHvFpOHUlaVFhVxxPI4Rrxf
        zojIPmETlr9204ftc7YYaAAsA55umGjAMpH8Z1iTQveO
X-Google-Smtp-Source: ABdhPJyA35NN7DMVZeaKjW1bfa4oI1GShogpGaEoB30n2A6mojiKd25eT0cjrMQjlPUHAcKuaTiZYagn4wlV2Chlzis=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr3972185otl.23.1613673645475;
 Thu, 18 Feb 2021 10:40:45 -0800 (PST)
MIME-Version: 1.0
References: <1613633644-52961-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1613633644-52961-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Feb 2021 13:40:34 -0500
Message-ID: <CADnq5_Nva6t5RrDzLPr60jc+nA8KpQCudnm+AyaoosSEvZzh3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Feb 18, 2021 at 9:23 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8142:16-21: WARNING:
> conversion to bool not needed here
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 961abf1..f163e54 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8138,8 +8138,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         hdcp_update_display(
>                                 adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
>                                 new_con_state->hdcp_content_type,
> -                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED ? true
> -                                                                                                        : false);
> +                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
>         }
>  #endif
>
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
