Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6232F3A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCETOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCETOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:14:14 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C938C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:14:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y131so774722oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYJESrZoGMMpt93wyizWTgxvC6R+AKuRSC08jpC+CMk=;
        b=MAWB+SghDRYrejm0VlOu78ulG5W+KnucHMRxvhboJY0NrT62+hsxlDTfkLXD5oCj7y
         3f14Yn35dH1b8FF3A96mBM45mepaIFo/m2hcb9YWh82HPSS3VAjmeCZVnj3fh2WJxwuq
         HJ58AMb9MLnF/V+f/MxU0Pp6Qq+e0DKr0foQXOlIaxRuXGv8/949no/Ejjk82w0yTNqW
         BuO+qEdKT+JJnrCpR8Fv6hF2D7z0FIW3TLyyiO/WzwCfXU2N6jrz5RiWqWVNz7AD6YgS
         WomxAEpHm3O170IanB/lSo8LsP+4IRoDHDv9FGXAsfJsFfsc2zuP42JB4TzUFHHXpKYK
         bkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYJESrZoGMMpt93wyizWTgxvC6R+AKuRSC08jpC+CMk=;
        b=MhzBZhcJ2IsAdGZUwpxat8KYGZ4aFGAMpmk8+M49W0YoKKlCAOiK+SOJC9Rsgm4oz6
         5siME3kL8Mcs/ZpRto/R3D+SRZO1psS5yyOpNuzhnPdAvJRHqjmD2zLf1WsNZmWBLW7q
         ndjwLaLvLTNTLzugByoD7E4thjKd1/LY8JG9wgrtRKX036qHcdlvL9qjXMBnqHdRaqGd
         ZCFvE8nId1fNMHT4ycPL/uhhEHnvlVw9JThw74ZGEau1U6wqIEvumrbL00lVpge82ApJ
         dx72reEpQGCLt9uPFYULS12sDyeucH/Xd3eyPtllBWPI9YQrXSAqitBS0oeyg7Ld6VXi
         j+Kw==
X-Gm-Message-State: AOAM531G6cWCBYsP90KF4vZTxwMOC03RF92N05pUHEw3STfD7RMJaADO
        bjN5MXbMNoOkm5QQ0qVvYtwpGZDOVHctWHZsJrA=
X-Google-Smtp-Source: ABdhPJwohfI775nymjsDoAp+q59a9uUqDcZHasxQewDfv1hHKqiuwWkMXqmBKpTnPcEPZqkGWDuNQW1uDFoZJR9bUZE=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr8054191oiw.123.1614971653655;
 Fri, 05 Mar 2021 11:14:13 -0800 (PST)
MIME-Version: 1.0
References: <1614926449-68399-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614926449-68399-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Mar 2021 14:14:02 -0500
Message-ID: <CADnq5_P1wgjQbkWkQfWXADBr+Q_-yhqXv+m1SS7AQ+GDp-N6uw@mail.gmail.com>
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

The same patch was already applied a while ago.

Thanks,

Alex

On Fri, Mar 5, 2021 at 1:41 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8257:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3e1fd1e..10de6c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8307,8 +8307,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
