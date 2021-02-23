Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DAA322FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhBWRsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhBWRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:47:16 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4AC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:46:35 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 18so18477890oiz.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qtbTXqXVuOZUhIlF4MKyuwiBZDXKc/e8EIy79NOn8I=;
        b=EhvqwC6fc0LXrtbfZcvMp82zCW+fmUD+W/RdQZzDPf5ii8MCce9Kg0h9jSdxiZ6TY2
         6Ede7G1Oe5TXUJ3UQdHVeaaTIRHhyHPrvQT1cI/9/UjvluArnBeFOfXOgwg3aiDd7oVo
         BPzLQC49p9d/NTqiWHbV12rcPk0tQAiysimtv65v0VFOrZZdWSeWyMnFkL4lMjy3yjGX
         tsqvfveHWiVeb6StipOF1KTmAVSuf8duOzmE+dKzDd8j+xBGy9MuS+olSE5+MDicjn9B
         QhBjTndDDkzbQdPV/YK79rwYS2pjZnAE9V8jlWHe0/law7EmsZwtFnmy0j3nsqN8kCk2
         l07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qtbTXqXVuOZUhIlF4MKyuwiBZDXKc/e8EIy79NOn8I=;
        b=qKGuNUWktLWPmhFDbTzhCC1YNCWVQXvy5vsMGBe6bhWSrpPMXnhuuMlkaNAeWPM0/V
         /KGSAMy3HBBh+gHo4sAcioZxgORLBtgry+RDmixBMoc3Zz+00SieMkMeddAmcJ5F4gKj
         83/MOHhkpZg0wb2QbHYycch2jqjnZzJWV09jowiEw18uJsqsaK16hjR4UMCbe9swetDA
         AwI/+FGKkqB7rIX0RFQN3bOhWSIxJfnx8Pf8pJGrqeSDDbMArZpTuye6Vnn6tkRcnner
         kujDKeOJei4UHpzn47eXUx3NGaVX9nX0MAvyFvLzlWoPwCmITTwQCP/hSGol8aN4fchn
         2Vqw==
X-Gm-Message-State: AOAM531UmFvuSE5Bcd7PuvLn/vV9Z/JL7OJkfF7BCILJcRgVol/9ApCS
        9lwEkHvBqsOf31jl0QPokbHWG1yxUOh01ys7cO0=
X-Google-Smtp-Source: ABdhPJxJtTCZXfTvedSSRvecwTcyGawl8EKQR0fPrCfuqwgApxHDv+38pdIua8+emj+ut1ZkhbTJ9xqi6YZvgmU+aGs=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7316628oih.120.1614102395279;
 Tue, 23 Feb 2021 09:46:35 -0800 (PST)
MIME-Version: 1.0
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Feb 2021 12:46:24 -0500
Message-ID: <CADnq5_PgZLo56d613xo=ofo9X=uq8bXKUu=khpUzVm0vTDVJqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 3:13 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> >> warning: variable 'i' is uninitialized when used here
> >> [-Wuninitialized]
>                            timing  = &edid->detailed_timings[i];
>                                                              ^
>    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> note: initialize the variable 'i' to silence this warning
>            int i;
>                 ^
>                  = 0
>    1 warning generated.
>
> Initialize the variable 'i'.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a22a53d..e96d3d9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>                                         struct edid *edid)
>  {
> -       int i;
> +       int i = 0;
>         struct detailed_timing *timing;
>         struct detailed_non_pixel *data;
>         struct detailed_data_monitor_range *range;
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
