Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5750E3699E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbhDWSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbhDWSkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:40:53 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A035C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:40:15 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r186so22287374oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3rbej15nTxekMSQ1d2nQzyOkeUYbiZHxrH9ny0O8Oc=;
        b=aA2xwfEgakU/kmGZNNzcdMQc6wSaL2tS0j/txBQzgMEyVhyWmJmvS2j3S0BZ+7Zx5r
         j8Y/Ir8Ly78Ms2ruYnd6eOU66Dozyanfsy20HpdyeVef0rVRYTucIdfa0IhOLNbnf97O
         0USgHsNSno9Gav/tZs8CSz86aUX7LEGB5Bg0hifGMHXh9lJ9trIVQgQ/MgisiHmeAkv2
         JBVrjaKpYOa0LodQjT+0i2ME6xCW2kSgUBlAYmcJu1X6JlYyuibnUBLRD1EjEg73naxl
         0dM2Ma48nKOsyI95tclJqyyMVfjtu9gEHOdC2zexjM2R5o7B/BLAUf1NhrgSJgrqnKb+
         wc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3rbej15nTxekMSQ1d2nQzyOkeUYbiZHxrH9ny0O8Oc=;
        b=c49zKI+Al5gAnBMrsAqwZ82Engq1HzpZBqMSLMKLotgy+0Kwn4dDdAQWzgCQTjxbYU
         FYfGGrT/QPi8Ic4yVLpMLJTA3Y/FA+cWYVclLgMyTZLjVIu5iwcmsmINpoY2yWcLyj+i
         Xih3yfhfNYbTg/MJN0VuPRiz3eJJEyI4sqcVZ0ZMTtvkny7Nr4QG9dQbCqWYG0FSqEKl
         O7vB5UInFjObQsn2NTW3djR0tXB5bAEQRosqSkBAGJ8KSQWexHm2ljnBs2OzFyUuuc02
         tpncqiCETnaVGiIkW9xhEFZR0RHihiKpvkO2jI09xvLDhP3a6GH9UHQRtAQHT3KHAQrA
         ckxA==
X-Gm-Message-State: AOAM531RI5UMGWWJiqPnZlZEoAkmlhetFgsYuMdg+z1RPLCCXg+iMeGM
        nddfzQitZ5LTovqKuDYBwD3G60/KkyDNTCPzgRw=
X-Google-Smtp-Source: ABdhPJy2XuueP4dPExRWZi8ws1g5uJwd7d1b7YaYrcT24czjaGaQrPADg9hlwDPvVQDxiB1aranscBUKR3TwqAVYnHI=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr4813114oif.5.1619203214988;
 Fri, 23 Apr 2021 11:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1617929840-13269-1-git-send-email-wangyingjie55@126.com>
In-Reply-To: <1617929840-13269-1-git-send-email-wangyingjie55@126.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Apr 2021 14:40:04 -0400
Message-ID: <CADnq5_P6=ztTEJ3uC6gnLCcPXUJFJDHLatswcGFD6_iy_rOM+g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/dc: Fix a missing check bug in dm_dp_mst_detect()
To:     wangyingjie55@126.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lipski, Mikita" <mikita.lipski@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Apr 8, 2021 at 9:01 PM <wangyingjie55@126.com> wrote:
>
> From: Yingjie Wang <wangyingjie55@126.com>
>
> In dm_dp_mst_detect(), We should check whether or not @connector
> has been unregistered from userspace. If the connector is unregistered,
> we should return disconnected status.
>
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 8ab0b9060d2b..103dfd0e9b65 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -271,6 +271,9 @@ dm_dp_mst_detect(struct drm_connector *connector,
>         struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>         struct amdgpu_dm_connector *master = aconnector->mst_port;
>
> +       if (drm_connector_is_unregistered(connector))
> +               return connector_status_disconnected;
> +
>         return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
>                                       aconnector->port);
>  }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
