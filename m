Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E553A1EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFIVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:15:40 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36632 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:15:39 -0400
Received: by mail-ot1-f44.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so25387662otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+vTwOmzwLF/GmiUHSZdVNz6KHeSQoupkzPT9DlPZJE=;
        b=UXdMRlhsFFSxm/2Mk/c3mHNqpjn4ns2S31aVCngPlEAlxhlPqMJeo2LAHOKakytmzB
         Wm0FplBGGEnaeJ4svs6nd4fp65TxM2SKVMcrS6Ywn8NaPXs7xSLOvmhCmmcTiL5FTCM3
         /qgxdqIBTYAVRqjOKiZfbDKgCEpUjd0KkgmeDWsDGN2XtaoiaZ/RYfkdyVhhdpkM3GIn
         SnGoxWlPdVfOq9P81ZMRiAiy+b+OCkA82+RFmAIPMFy85yi6PGuXzSwFkZd8GYW188MT
         93bZSz8GyuYPMbEjwxAq8hn9ky0h5jxM/9hshAEqQEITHGp0z/1x4sXsl5MNrqNRp5IW
         Ro3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+vTwOmzwLF/GmiUHSZdVNz6KHeSQoupkzPT9DlPZJE=;
        b=eSX213EIfj1o1xxYj8PmTTzWVqKyOY0+QpwFETWK7Hr/ymJL6ij4LDkjIY1i6DhVDd
         KJQT26w++O7I6TRyr5BHK9BcR1OjeIqocqrzvGD5DUkNpQxHQkLwv7cIygAjPeZUxPav
         cDtXLpWCCphlD7IxnnMsTrIwklDmmjXJOfJv/a9f2BjovekO0aHICsk/GC3dte84yYso
         eJmTbIeqbW0sPnrZLLiA9rR9zWcvoFppkIwfWiz56RJeTV2yRyhXfIVe5AaT/qOPak1o
         LCidAv2Qx2OktkWZ9nLYERJYMc4hFmwwTCL/3Tfq0TKYT920PIXp2Lg0Ere7qfKZYHkn
         HYfQ==
X-Gm-Message-State: AOAM531JDf4x8nY+oDd6MdTRIO9pprZ4YAqYat+UeTTS8E8OCX0Jfoxn
        NjLxObH6Bk88sgLQDJCisUkff2YyWx0JWviFjuI=
X-Google-Smtp-Source: ABdhPJy5gjHIlujtByvS9IHsso8aiM/8W+YZHouRkqXFR2/zW0it21pwmOAG+IooOSApA2+nBXEpbk7ROb81/QPfn6w=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr1212482otk.132.1623273148945;
 Wed, 09 Jun 2021 14:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <1623233366-100202-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1623233366-100202-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Jun 2021 17:12:18 -0400
Message-ID: <CADnq5_Ms6Hv=PpSWXEabE1C0oQ=B37Mz1HYfxjn+vF9e8kK9SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use ARRAY_SIZE for base60_refresh_rates
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
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

Applied.  Thanks!

On Wed, Jun 9, 2021 at 6:09 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
> element.
>
> Clean up the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/core/dc_resource.c:448:47-48: WARNING:
> Use ARRAY_SIZE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 57afe71..3f00989 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -445,7 +445,7 @@ bool resource_are_vblanks_synchronizable(
>  {
>         uint32_t base60_refresh_rates[] = {10, 20, 5};
>         uint8_t i;
> -       uint8_t rr_count = sizeof(base60_refresh_rates)/sizeof(base60_refresh_rates[0]);
> +       uint8_t rr_count = ARRAY_SIZE(base60_refresh_rates);
>         uint64_t frame_time_diff;
>
>         if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
> --
> 1.8.3.1
>
