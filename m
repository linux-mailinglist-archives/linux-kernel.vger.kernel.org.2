Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A53E4C41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhHISiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhHISiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:38:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99938C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:38:00 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so19086184oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hF3J2nitrZIyoEjWGUnb52bS6szzJmi/8nrZtEgocBU=;
        b=nG+VNsdWX0azIvITBY1SWd1dBDzHOWEdGeeHzzUQlULUMr+ac+/LKqK8jMNvlawmWK
         m4P4bhIIcQMmI+1JUUuuWykgySO49NH6/HbEkPQ8wP15Xr7MRcgjQnFAif5yeBdShHqx
         C9VqPpebmHRgzmp895zZfWaKxkUEjR5r320OFNGBrhnFtT5g5ZbXbwgDia8em/GMnZVi
         Ly1NPZeLw6KvJVTjKMWk9Lfox2+pVeKPAIvMAm6rh/v5lzpAkmB46c82okHEC5+ssVa8
         5Uv0npO0b9orvvYX/wuX0cpqjJqebj+jfSvvs5rVleoEIooUJZ6rIoBeT6l88RtwE3ng
         n36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hF3J2nitrZIyoEjWGUnb52bS6szzJmi/8nrZtEgocBU=;
        b=RZaJda7YwIl4BoKhT9mwM5zwzJYz/AO/A6N7LeYeZ5oRGlOpH8bagsDiCKFenLHYj+
         UVdBHPDQxvCGdFZqgmXDh4xUqgUTUXTOwWkRcxQNgtJY7wqzZGjRpCrkQEtl9Ovi19gI
         10epC5eSM+QOjKyyaSq7H8TSZgP/yEWdpkfxPutNAMhTg/MKunHRMMH+yaWkd/4+48w1
         yBdLuo0gRCg4a25+RLuO3Jqw+mK8deybb4S+yvaVT8Ce/X0OFKBKCr93hTkhJN4/I9Sx
         Ne5/Ebyt9nZ2MXx3QuhqhtXbTIGQtBhBY6ObGeHkC+kSYdvtkzyfWyylPuNlLpGMEAFy
         ZcLw==
X-Gm-Message-State: AOAM533sPVQyuOflP965SXtqkLkt3FskSuS8W2pVs32POZIu0N9TlH4y
        1IAnRFPg5aYQNBGtbDHVRQw/wqfqtAnF8Z4Gc8w=
X-Google-Smtp-Source: ABdhPJzUNyO2F6LNmKtN4pThy7CkMaQ+/UixJOOSIsBEA4eAMFcUvyU32t6qyIqEXOzGOTYAEjsF5aA+euDrIko27Xc=
X-Received: by 2002:a05:6830:1e78:: with SMTP id m24mr12195440otr.23.1628534280053;
 Mon, 09 Aug 2021 11:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210809120050.679048-1-sergio@lony.xyz>
In-Reply-To: <20210809120050.679048-1-sergio@lony.xyz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Aug 2021 14:37:48 -0400
Message-ID: <CADnq5_NuDDMaKzAm0pRo1dQ-PQ+niibM7u3_1vcAvC4DnP4Ufw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Removed unnecessary if statement
To:     =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <lonyelon@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Sergio_Migu=C3=A9ns_Iglesias?= <sergio@lony.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:59 AM Sergio Migu=C3=A9ns Iglesias
<lonyelon@gmail.com> wrote:
>
> There was an "if" statement that did nothing so it was removed.
>
> Signed-off-by: Sergio Migu=C3=A9ns Iglesias <sergio@lony.xyz>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_fb.c
> index 09b048647523..5eb3869d029e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -273,9 +273,6 @@ static int amdgpufb_create(struct drm_fb_helper *help=
er,
>         return 0;
>
>  out:
> -       if (abo) {
> -
> -       }
>         if (fb && ret) {
>                 drm_gem_object_put(gobj);
>                 drm_framebuffer_unregister_private(fb);
> --
> 2.32.0
>
