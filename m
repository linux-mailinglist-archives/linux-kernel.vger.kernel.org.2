Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C134A3CA1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbhGOQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhGOQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:20 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC367C06175F;
        Thu, 15 Jul 2021 09:04:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so6714465ott.1;
        Thu, 15 Jul 2021 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDgo4aZEEERbVkoaBcaAe2QHHX9WVxAXJi1OtCjtkTM=;
        b=YqCnUt7Dm2F4+/3Rb71Adj77P9AGyQtomoFeo1/XCi/Fm5LB6jzB/pYpJUaAHoPxes
         jcDgGYADmp4xBu2KQGrQlNslohr/NFj1U3q+KruDrAfGGOjtF+XJKR0NdT+hDS0yjMxO
         ePw3zpXowf/yp63GDp2P3AYAJXfXCqP5lkpuytglp/wMRKEdjpeSkgb46tDhwwY1MgcF
         HSLzU3TdpuO7ANbm9fiNbBsJv5dVIzVx5a7a70P5sd0J0DMOdF7Y6n7Vzb1TUKBt/iFh
         nN1AM2F3Ljd8sfIQCYJEDNK0hoK07iaREQEDYRl/4Vr5jJa9bAP6vHb0qCwBp9gJ/0f/
         Ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDgo4aZEEERbVkoaBcaAe2QHHX9WVxAXJi1OtCjtkTM=;
        b=Z0foJqlPRuj8r0aT1z6XgqNeO8fjZxA6EYtvoKe2eQm4FoWvYIXoSkYazv7FxIgHA+
         aG0WeSPK34f4CX9S9GVvJCj92DlMr6enSGtfXxeU4si+mGy+6AkMBGGbBppxZD0jc8TU
         1efoTiNRNu/pO6E42+0j9dExrg7Ms2gDMgzDA8BgzZIbvI7ULjKByCBrYsWQFEGWmMfR
         gEOuwE/C5ed6w/o8nMji6McgTCnwqTuFsikn1SwRjw88OVh0lpBCWwX0mcfIqeM9HZwS
         ob1DiOOGLxoO5swvTL55eNbO0k2rVDARLoQoS3U2a43uqaws1f7v7gGGv592aYUJw9Uo
         Qc2w==
X-Gm-Message-State: AOAM530r7mmPNBPhTm6MfTTDgV68OUJ7qeXARaxFH3MH+4rLfD6iB3zh
        DoFMro3aNdz0M0mPN/WT/s4Jp0lMKOHSNvHYGIo=
X-Google-Smtp-Source: ABdhPJytpHPsR7Psh+/kvUqKqvdOAb+qm1HyOVCZ8FzhnBWZ9JWAfapoFgqqNcWF62mrNZTJ0whN3cjvEj8Au3UfNSQ=
X-Received: by 2002:a05:6830:14cd:: with SMTP id t13mr4401878otq.23.1626365066132;
 Thu, 15 Jul 2021 09:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210715143740.28403-1-colin.king@canonical.com>
In-Reply-To: <20210715143740.28403-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Jul 2021 12:04:14 -0400
Message-ID: <CADnq5_NHEksy0hfBaFWEPO8Dz3gMJgojqk5R8sSN_+7aVSht7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: make a const array common_rates
 static, makes object smaller
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
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

On Thu, Jul 15, 2021 at 10:37 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const array common_rates on the stack but instead it
> static. Makes the object code smaller by 80 bytes:
>
> Before:
>    text    data     bss     dec     hex filename
>  268019   98322     256  366597   59805 ../display/amdgpu_dm/amdgpu_dm.o
>
> After:
>    text    data     bss     dec     hex filename
>  267843   98418     256  366517   597b5 ../display/amdgpu_dm/amdgpu_dm.o
>
> Reduction of 80 bytes
>
> (gcc version 10.3.0)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2d48bb09645f..b196bb6eafc0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7580,8 +7580,10 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
>          * 60       - Commonly used
>          * 48,72,96 - Multiples of 24
>          */
> -       const uint32_t common_rates[] = { 23976, 24000, 25000, 29970, 30000,
> -                                        48000, 50000, 60000, 72000, 96000 };
> +       static const uint32_t common_rates[] = {
> +               23976, 24000, 25000, 29970, 30000,
> +               48000, 50000, 60000, 72000, 96000
> +       };
>
>         /*
>          * Find mode with highest refresh rate with the same resolution
> --
> 2.31.1
>
