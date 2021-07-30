Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131BE3DB117
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhG3CV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhG3CV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:21:28 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5547C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:21:24 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so2079088oos.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rY+9G8Q38inHnp5VR3zTK8VfTTInfpSTIAY56RSB2NY=;
        b=DvbzTNXXSNYbMKdI3dvsvH9SUNxoimHMCUQQcizvfZ/SZG5YVPc4mBzWmkq9wGFuzj
         VqYpfCsIHwGx3QQ4QXNnpgiqAHMYDkLpVJkM7segHmfYcjD3py4M8sokFyLlNZp8PLI3
         z1mZBMOODUazqKAidCvDTmrx69qVlkyda9eOuKsBAJrwbwg9NvAbJKwyzLobEA//QtR3
         zbaAZDfZsr46b6yG/K/H5aIV0GhxGun1uEnU/HPiV1mJAngg34i1WRUvlg5pxjnl3ULf
         INbulmVpeMyXWWCl5ewAaXIBrkItzu6QrNhL1bp8kwoISjEv56dL+Jv0yM2mzuRdwpyG
         xC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rY+9G8Q38inHnp5VR3zTK8VfTTInfpSTIAY56RSB2NY=;
        b=hHAlADLuusQtvbWP5a1vs9ZIiQhfoQzxOzqVErXKDNcmKPsRgYRl5mCjA2aTwxE/JG
         jP5m8BaZnCN719oLhoXO+NED5GsHKU+qHXQFZxWn89FqTtYuuk7pnc7wUu9M0trdde4z
         xN7vN3RAzfh39Y2tfT8+zUkLEIKmX7v/2McRgHO+3IkkXQK0xrzFx4PoR74851n0LfxR
         gnrVSKDmheA1ifLpepSE3LXn27KVDlTAQ35eT1kbuF59WsHlweOfYBd1keFq0lBWZuD8
         oIZeVLrPLLjzNLhqyZy8P84YuoePsD/KUg5GDAAYQ5P5TipVVDGOLeigv0Dvtv969OWz
         f8/w==
X-Gm-Message-State: AOAM533jgr0znqseAjDJhG28TgCpeVK1Ytgz8jgP9jjgaRz+RXUVWnqt
        8mEe7jJKEE66G8K0wZfWNtGpAm8+OGBQCVuzMhk=
X-Google-Smtp-Source: ABdhPJxpCYa0oIfSEw5TIN/yj2T9wh41qaKwgVEfybU/mUG8Lz+r/DLlyFDM+ijLCh2Fx8Q40HSChM0k7R2NbU+Y1AM=
X-Received: by 2002:a4a:2242:: with SMTP id z2mr156897ooe.90.1627611684125;
 Thu, 29 Jul 2021 19:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210729135314.661858-1-standby24x7@gmail.com>
In-Reply-To: <20210729135314.661858-1-standby24x7@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Jul 2021 22:21:13 -0400
Message-ID: <CADnq5_N-T1-Tkf3JS28h_vKHpXhQLpRdWN4aLONLfCnGC7HR6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/smu10: Fix a typo in error message
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Jul 29, 2021 at 9:56 AM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fixes a spelling typo in error message.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 43c3f6e755e7..7dd92bdf7ffb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1580,7 +1580,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>                 }
>
>                 if (smu10_data->gfx_actual_soft_min_freq > smu10_data->gfx_actual_soft_max_freq) {
> -                       pr_err("The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
> +                       pr_err("The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
>                                         smu10_data->gfx_actual_soft_min_freq, smu10_data->gfx_actual_soft_max_freq);
>                         return -EINVAL;
>                 }
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
