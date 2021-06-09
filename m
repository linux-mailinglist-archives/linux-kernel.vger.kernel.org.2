Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5E3A1EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFIVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:14:58 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46709 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:14:56 -0400
Received: by mail-ot1-f41.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso25327167otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VH3rwwEOTBktsGW6P22ZTU/VUmL/IO3btE6cu1C80Ps=;
        b=kkU8TwJT5Id3fmh2Sl2AH46PuradhB/XrIpeCemrg1wM3W3A/OtXodSG93fS3OjxLL
         kWEu50ukBGLnA5jjapnwcylXCBaRiQ4hB3jrrRVi7FLrp9yq0SEIzKxZKcqtsuC6uc4t
         jAvX2SJsPg5ZWvbkWPul+CguSHF2Jl9WVNdA1QoExuGRNT6me8n0T0xye3QdOyY+vMXI
         OgZI+pLZCT4YhnUtrS8uyMDWBy6sv1RXLpLwPSvG2GXaEz+LYM16LT9K6yUi7AFe809Z
         WoR/Wijb5vII9zLDf9Eqeu+QLCRA7uXv1kx5ewn46P5X1z5Dy4/OWLHujX1FrF7bfSif
         rPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VH3rwwEOTBktsGW6P22ZTU/VUmL/IO3btE6cu1C80Ps=;
        b=LtlUxWb/dHa7L5VIVhkOErJdu8IQ1Nw7TrAH/aOVBnMwB/Jm1u448z218MVSqgEeHn
         P4xZKLfyfUsxGAZJEuAsxzER7ASHBu5AA+IxRtb/OxgBZ0hcVtHvR3s72lmyiAgYVJ3y
         fdzVBth2G1v90TCy/9pxdAP+tLe4N1XksMeKWfGWayvLV0wPy2NtCF4sXRIuov9FXwGz
         KI53YYgQdaoxEj7uuXAONmZARRFWlPKFf0ut7auOAQE8HRyD/oFuQ1xT7LZeZR9PBO7P
         56v+Cw+1xK+/QKLCSsNW299SCB8V0lpgzFAwrOnNYkoDGZXB9M4b4Cw+EHLaO4B0Y1fu
         FggQ==
X-Gm-Message-State: AOAM532mpJOe7VuqFMEXLYzw9mWvkFgZaFH4a93mawwS2ouXEjLKnT3p
        bY1bq2ZaAuzDFtP6ddYvozC6fz7/L4F4H3PdiDYPaVns
X-Google-Smtp-Source: ABdhPJx4hEe6VVvmHzsO68zFInP3sXE1cld9nPHUn2tZYKdEegzAInUO59dC9UylbBKhZ5PheSO/1VpfZWGQJfhKTnc=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1146711otl.311.1623273105948;
 Wed, 09 Jun 2021 14:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <1623233121-97926-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1623233121-97926-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Jun 2021 17:11:34 -0400
Message-ID: <CADnq5_Pe0Vkr8geptXv-NW1h-q7UXGPsveZXudr9BX576-f0-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix duplicate included clk_mgr.h
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

On Wed, Jun 9, 2021 at 6:05 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean up the following includecheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c: clk_mgr.h is
> included more than once.
>
> No functional change.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index c0e544d..1007051 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -33,7 +33,6 @@
>  #include "clk_mgr.h"
>  #include "reg_helper.h"
>  #include "abm.h"
> -#include "clk_mgr.h"
>  #include "hubp.h"
>  #include "dchubbub.h"
>  #include "timing_generator.h"
> --
> 1.8.3.1
>
