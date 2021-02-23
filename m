Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD373322FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhBWRtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhBWRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:48:55 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:48:15 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id x23so4063487oop.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffSuOizC5vkUXK1gRj/KWG3leLFcWqMQLhXqk6jtjF8=;
        b=vbgy9CARhYqdjN8Ho0PbyEzF2w+6y+n6HQqUZYHQI722nTtteSgOdfhyF4xLx6RjQf
         ZHF4NoXNSe/9YN19Tv1e5e3DFmQ9WRH8KfVHVdesDO6q1vl/dd7TDMGfp6+n2AR74lOL
         5Y0rSya1bpC7gEAMn42hTASouVT2h2Vx+nOdfRKSV7BBhkwCU+apO1umKsk1HTqQScTQ
         0NgeXSzLPhe7htdcc+NOI1ffXxgekrCB5+jpr691zE916wqJfptwgHrgViVOy26aUw/B
         urPcPfsnnoWL/eydzwiUAG+iubpxx/UquDpjx+pzRzRCXbk4lEVZMQ+4sDgiw6Nz66qR
         FsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffSuOizC5vkUXK1gRj/KWG3leLFcWqMQLhXqk6jtjF8=;
        b=rJHuQdQf4b6ClW2uO1RI5xvvwMn+b5e309pO0xouOEOAITUqnKTvFEW3oF9lPxbk8g
         cFq0WZSiYMPQCeKwAlCYCADQ+qkF/e6VgMEuq99PuxcmgqgKbCoIL2SJjFIy05pkdAK+
         HwL+hVYDGtuNgSrd1wlFMi+5v7c+wwtA1ZZlWZm0a1efzS/lyxcJkFvQ7jfO7XP+2VBC
         QXz26AT/qCVyWQBxuq+KUDSzn1JFKx6sguGTnq81CsrrXBIHv0kLpN3TBQDWECLAp/HC
         SPFm74fkbUFYc3YLnRuzw7frxKqBZR97xg6JMxusF9WrJngb4rGUhaehMnyu/4rD4QdY
         TlCw==
X-Gm-Message-State: AOAM531CJdlu7ZVf9d9tzMhLnqmwVZl+0uhY3AqyQCqaZIlBkexNf/uX
        9iIasbGEmMUEDvRpMRDFAuT1MCCy+K4IYnTloxA=
X-Google-Smtp-Source: ABdhPJzxvdElhLv4Olbxje+vfunp4TxzAJH8llMrhEMdjEvnxVubx328z9Es28kfa/xGAYsyYOsVKAW93HWSYchf8zc=
X-Received: by 2002:a4a:4581:: with SMTP id y123mr20841890ooa.61.1614102494816;
 Tue, 23 Feb 2021 09:48:14 -0800 (PST)
MIME-Version: 1.0
References: <1614051813-51451-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614051813-51451-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Feb 2021 12:48:03 -0500
Message-ID: <CADnq5_O3dQvBk5rG+XgQHzguByjMs-Yds71vzj4MG+AMhmyvhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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

On Mon, Feb 22, 2021 at 10:44 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/amdgpu/athub_v2_1.c:79:40-45: WARNING: conversion
> to bool not needed here.
>
> ./drivers/gpu/drm/amd/amdgpu/athub_v2_1.c:81:40-45: WARNING: conversion
> to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> index 7b1b183..2ac4988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> @@ -74,10 +74,8 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
>         case CHIP_SIENNA_CICHLID:
>         case CHIP_NAVY_FLOUNDER:
>         case CHIP_DIMGREY_CAVEFISH:
> -               athub_v2_1_update_medium_grain_clock_gating(adev,
> -                               state == AMD_CG_STATE_GATE ? true : false);
> -               athub_v2_1_update_medium_grain_light_sleep(adev,
> -                               state == AMD_CG_STATE_GATE ? true : false);
> +               athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
> +               athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
>                 break;
>         default:
>                 break;
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
