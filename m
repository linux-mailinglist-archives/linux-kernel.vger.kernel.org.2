Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBD397EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFBCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhFBCRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:17:15 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 19:15:31 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso1138643otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8W7mQck0zs774kTbT+4Y+xlf8nCc+MK9JC+2lYg3zE=;
        b=qHJOGBXsNCjbuu1M9YqCpqq1RfvnCzeoKXJHOi7f50s8kzMuGq/2TH1aeim4YfVPWE
         WuGlRuf+7W5KDX9ImbTKpto3udXjuRr1brQa2rEoWKqe4fpX5Cl47XFstY+mlkgZdS4s
         bh6toS4Yhu18tWEFxLZp1RvD93zT8ur7rz/CeN7MxoX2S7GBkEGf/hANVq+9XCbFzuNI
         W8FEDkf2LU3OaVDXOVQdNIM38qWX6blvgojVE3chWCwP/Y7nHpcCzJnE5/XWbpJmuPq6
         wOF6rQUXREd+WaJAoF7YNCtzdVSTZtoMkyJDcZ4/othzCAmBg8g5HRw4SuOSUYAaNg3X
         aQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8W7mQck0zs774kTbT+4Y+xlf8nCc+MK9JC+2lYg3zE=;
        b=O/qmnjxKIqX5RMnBVH3rzDiNG9zyINF3Fk6fIZCgWN1OqxMMNsvPe4t8cJxHyiK09p
         +zEkUHtb3NA8uzdFEAAqzuDo3j/6EeRsUN8Rsfjf28IYodASjHlL6CX6bTOw4vVP5U8L
         nnBXQcQ+bWGshPCjV/I6dAeXCG+H1l4YhiSadovQ/WlSBcazgrnTT0S0f9PvcVB3zawA
         /JU/55ESgSOaMt2x9uyKR2nZRHhl2tOiNQPB6lJ+ktPVQclx+kFwbwxANF26Ewq+hrvf
         pHxhmwT4INVBu1Wh0mElswb4MEkHJPXIisUdw31fTiTGo0ib0C9ZJOisbriRwacZkNpN
         7+FA==
X-Gm-Message-State: AOAM532/0CdFM8dj+IcaUi8+qRMHfBGPGWWdwMkI5PByZwCLuojGD0r5
        H8s5YtHT16nDzOod/Dv6zdnP+GlQRlBZVxv0+3E=
X-Google-Smtp-Source: ABdhPJzYlfRlP9uhCedE+PX9MiStThS6tMzO/MIxFMIq/6cuN1r9zaxs1LVhr62SBosE9437BvCp3d9x1Sn39n1ihp4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24935473otl.132.1622600130512;
 Tue, 01 Jun 2021 19:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210601142055.4132163-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210601142055.4132163-1-zhengyongjun3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Jun 2021 22:15:19 -0400
Message-ID: <CADnq5_PoERXyB7f08X9uxZ-jQj6jw2_PpXxj2YFGJM=Z+iBFPQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Remove unneeded semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Jun 1, 2021 at 10:07 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Remove unneeded semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 65b1dca4b02e..148f6c3343ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -227,7 +227,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>                         break;
>                 default:
>                         break;
> -               };
> +               }
>         }
>
>         /* Reinit NBIF block */
> --
> 2.25.1
>
