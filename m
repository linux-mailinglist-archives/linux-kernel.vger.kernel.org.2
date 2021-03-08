Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD0331980
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCHVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCHVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:44:46 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:44:46 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d16so3334660oic.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnfgAUbDVZeNGV7YSOf7CHMyIPf11X/pivOxwIJfz2U=;
        b=TSSG5A/hAXDZ3Gg2dIHVcjUUsjRUNiVSvLBrL0SBFArOAAcGXLO1YUH+K5qfrCjk36
         CGDzpY4dRxotUuZwB6QdyN5hqlO4A9wHQxkA4kQP8QKhvAyVC5QO2tPcimXv4q83/vId
         3VRHjzYSaKAyavvUfGYdzKNryAhBRfV1saWL+z30j1QxQ90B9ZcS0dxeuEhYbPOxo11l
         fiC/u4qVHoDcCSvIPm2kQTdtIb6xyA+GubYCmcxij9gHAwur2VbMjVOyQVE60JBmkbQ8
         U6zA4HDzNx4/Ea8kIGPY1tvwM3N0503y57XABxebCbUiXns5Crxz2N5yDqYSXaZZtxuI
         2jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnfgAUbDVZeNGV7YSOf7CHMyIPf11X/pivOxwIJfz2U=;
        b=lmHvLKam+Yno74KpG0w4ZNLYaLlKUwJ+U/hyagOibcsn4Gy+aR5EjTZ7AOvoZsMH9/
         oygZTYRGjtlDoGOX04keqcSn8umrEd8Uly3Um+A8p+FK5uKcAXs8mu1FU7SdkgbZtwZT
         yL+9x7Ll0nPmiOuabENNw4iUe6NRckecej1D2r6mlsVlvJj89cZqqgL7slG7EtFokOkM
         VSVxZhwHchtK8d6/Dnw7pvY8GyxgpR7XEHbGdjpc3jpsTXUwA8oORk2Uj/zXXQtA3SOr
         WkH8k8346utIABphHOCVnXf5OIV6ooSyO96v0+JRL7nMau6YNQtNE3GsMfx+DeFOo3DX
         ixFg==
X-Gm-Message-State: AOAM533SEEiy/Pv+1UwZ8DIcea4DlbMC12KxAIZ/zCofe7fQby/Y89fI
        UCVtbKMoqewuH7JSMhG/ReTh6CxK4cnrxLPp9pk=
X-Google-Smtp-Source: ABdhPJzTV0MKG2bplLclx3EsQ/iIXSwzsj9SXfn6g3FatPK6uFrfqWxnwZ7Vw9XFr5SbhoPcMlN5X0RLizmg2dI9/Bw=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr673052oiw.123.1615239885798;
 Mon, 08 Mar 2021 13:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20210306104720.215738-1-zhang.yunkai@zte.com.cn>
In-Reply-To: <20210306104720.215738-1-zhang.yunkai@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Mar 2021 16:44:34 -0500
Message-ID: <CADnq5_OPcTeFb1Onr=Haz3BHroG==9TzmD3F65ENNebe-iW_=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate include in amdgpu_dm.c
To:     menglong8.dong@gmail.com
Cc:     "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        Dave Airlie <airlied@linux.ie>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Mar 6, 2021 at 5:48 AM <menglong8.dong@gmail.com> wrote:
>
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is duplicated.
> It is also included in the 79th line.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3e1fd1e7d09f..fee46fbcb0b7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -44,7 +44,6 @@
>  #include "amdgpu_dm.h"
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
>  #include "amdgpu_dm_hdcp.h"
> -#include <drm/drm_hdcp.h>
>  #endif
>  #include "amdgpu_pm.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
