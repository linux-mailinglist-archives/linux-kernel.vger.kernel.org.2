Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00D322E46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhBWQD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhBWQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:03:19 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:02:37 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w69so8365217oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nFz5QhW8arftbgT3SWdBqbURvYJyjSvDbhJ1gX4x0g=;
        b=sz6ezuyCXhfV/E1P7Z3gnV1MOYt49cCtFkxa3maFn7AL5HNGvbjxsfadhRHEmk8JYm
         D0gw1Xrya+1uKg8Jy6aXEbl2j56hAuQRnZlDGYB2yIcSyIqdkcmut7iLapSn9Mq70/cn
         uuzyPXlRUW7St3AmQLFS8udta7spyQGw4Ddqu1Rgj8B9ZYZEhCvLmkGHEWwqvqrzD+AY
         R8L14GujAQKJRmWaYPxu6xShaRS79JONObXiPSrYi0VFUSx2wvSJhWUnCBgmlyRhbm3u
         ko74yCKzxSTkfjjDpQcZ1eiWH9C7gGJo+BAwWU7WYLIRY5b0klifDu9M5voefGhCGJbP
         ZzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nFz5QhW8arftbgT3SWdBqbURvYJyjSvDbhJ1gX4x0g=;
        b=m4fGS6dcw0aFAgNq9GU0D/KOu7nJuasYdmkNyHA+R3YtsRYISCiJ+S5nro8VZhrgq1
         RBy1cchR+Y00IMJRS92Jol9SdGXx64qne5bZGX9iGHfff+5Kcju8rZwFxD5ih7LuqZq+
         ATxtyLiDRmmWIAQSx4W+0XMkXAFFKynzP+Xi0XPgAOmoxP0eoTzM7Et2LIz4ZIUVbbyg
         DuEVGXEsCE40MXTebSrx4qNhRcXYmNnKUDBJQQGyutPsS5MtnZXCrZkRJwS6sTuXgdEK
         3owD9f6fzy/3K9pw+lwm7teaH9ixeZyVy7U2acYjx6Ygiq0QmMjT96ducsiBQN5QNfQA
         C5Kg==
X-Gm-Message-State: AOAM533G2VOkPt9D0feoqIPbzSNE7m25aDgL6HxrnSwKQiWbwYeOVtWH
        x6tms4zeU/c8aLQopQjQC1iKOu44Fh5jl0HXqcc=
X-Google-Smtp-Source: ABdhPJxmRs41X61fR0MbTZ0+qV+vk94HD/0G9VbbyJscORKHNJlkHtV/VBwBeaoaIb+Fll1VtcrRc/Ph2wjvDoJOj0g=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7051770oih.120.1614096157412;
 Tue, 23 Feb 2021 08:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1614060797-124965-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614060797-124965-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Feb 2021 11:02:26 -0500
Message-ID: <CADnq5_O24kGLYBLN6Zzv-n_NNUhXkGs-vkWEnW2FYH3-GT9=Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was already fixed by a patch from Yang Li <yang.lee@linux.alibaba.com>.

Alex

On Tue, Feb 23, 2021 at 1:13 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8260:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 94cd5dd..323473d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8253,8 +8253,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
