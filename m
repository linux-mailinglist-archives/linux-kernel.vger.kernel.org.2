Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CAC38B783
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhETT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhETT1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:27:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:25:44 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y76so8177088oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jP7V9on14Wbn9cVMjkYpwwbeii1k8feXDpcOLaFr/ZA=;
        b=qcjvQOaL6FVCN/qtvhskOg/KM52KS0jZicEMg+rFrj0xPFxkUMDJVwoj5hq4EP5rAY
         dwx7/Bye5cm40OO0t3CjjT6Ui8XjuolUyPYtrL25XM1RdoSIiDQ32rsQfoPUn10G8+fR
         cuL7rmfMeb8Lb6qeMd/5A9MQpUfzCUZN6Kmp45SnlrXi+qTrpLPeX5lzMMJsQIsapP4k
         w2xW+vB/SAUul57FbZ4+Nnk5JGdn8BckMe91jfo1aNwIoHqIldJMG+DXa05EznVv6RH4
         Q6wSlVI74UuV4Q0+rT0l94VsScXDRL7xh0RtOm3N/bNbYYg1uYMWbWCo5McxmK3Px/af
         Phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jP7V9on14Wbn9cVMjkYpwwbeii1k8feXDpcOLaFr/ZA=;
        b=LqpS6gdSfjUf3z7SkRtwctvoPgVhAGPHEMg+4lL8+SHMsWRo/66TErZ6w/Ix3bX4x+
         rf9zFL0l6G1IsaH+9ehzB+x8p1EZSSu6ccMgWwzW6CP087N1h0q48NDDoS8EGuzrivD4
         Yg9TnG0O9NS0IS3svH0FUqP2A2qYrhaioPlgM0+T9sWq9U0kpnI2mhqAyI9UAa/BIBr4
         0zxmA5LZ1ZBUcDKEpTs6k+iqvHFtd6NapnanS1JVchPt9Q+Mo6EqmCPjNL7uTyzJ7oc1
         ocd280fMY7YwE2olkl8mCJjPZxIBnSYMDhehZym426J+FQOymbTSO2WKlJsqFkV78f/P
         RJew==
X-Gm-Message-State: AOAM531X8vUmRi4+hOnms3KH7XgrqxvQEsRpfTkO/id+tOufyIuK3B06
        GlbEjNTD/juK/CPXJjDy9chwTIJ8POO3SrNd1Xc=
X-Google-Smtp-Source: ABdhPJw/IRLYslkqMnEsahf4i98spgdQTKKRx48jW+eoP6/J47a/swlS5KwPFjt0AO1JUByC+7OoBBEUxd/D4/T5iBw=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr2496065oiw.123.1621538743810;
 Thu, 20 May 2021 12:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-37-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:25:32 -0400
Message-ID: <CADnq5_OpCwYAJOX1wDSpkYFg8wt9VroU0PmPstcgSe=h7cw60A@mail.gmail.com>
Subject: Re: [PATCH 36/38] drm/amd/amdgpu/vcn_v1_0: Fix some function naming disparity
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:775: warning: expecting prototype =
for vcn_v1_0_start(). Prototype was for vcn_v1_0_start_spg_mode() instead
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1111: warning: expecting prototype=
 for vcn_v1_0_stop(). Prototype was for vcn_v1_0_stop_spg_mode() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 0c1beefa3e498..2c9af18683feb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -765,7 +765,7 @@ static void vcn_1_0_enable_static_power_gating(struct=
 amdgpu_device *adev)
>  }
>
>  /**
> - * vcn_v1_0_start - start VCN block
> + * vcn_v1_0_start_spg_mode - start VCN block
>   *
>   * @adev: amdgpu_device pointer
>   *
> @@ -1101,7 +1101,7 @@ static int vcn_v1_0_start(struct amdgpu_device *ade=
v)
>  }
>
>  /**
> - * vcn_v1_0_stop - stop VCN block
> + * vcn_v1_0_stop_spg_mode - stop VCN block
>   *
>   * @adev: amdgpu_device pointer
>   *
> --
> 2.31.1
>
