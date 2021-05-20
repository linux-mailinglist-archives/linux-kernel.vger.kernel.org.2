Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6377638B703
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhETTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbhETTQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:16:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6007C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:15:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c196so9227842oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Zg4vmizJSIriLR9LU2790YKiK+logM7QIyA/FHoq5U=;
        b=uKVjxMBMCiPlK1ONgqo7qgd7w5MARG286PrWgvUYmmIWJRX5w9IIYfdT/a6nJUUCCJ
         nQ61aY30RNUXahoz/Ut+6v2/8E2SP7kyMac5joyCEamIXwySlQHhwRvCt9kCR4+lSxJ+
         ezgdsDRdr8aRU6/KXw+4ck5d72i7h5vj1Gttkzdrg4PNOAULjNd3CWHRdkJj3JwQ2SK1
         rBopRBZ2qG9Z1vlyB2/380L59fQKLJNrQ9LqTYsIIm4ZuOofhwK1wfb1NXz8MQxfRULf
         XvWh3ddH4yGRtwaceVe7IpU5bMuxu2YQUA5xoCudl8hZkemEUUejAVKO6rN26EQ1i9YX
         GFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Zg4vmizJSIriLR9LU2790YKiK+logM7QIyA/FHoq5U=;
        b=ogVJafI+9NDqM7AmfOpBE+l/etkzOfOebu8q28HgzjeCjSjc86dHdESMpZbid+LoAu
         VPu7jdVJuGC/SRfHXmdB7ad4HJ6bPsFyBB8bi0JpaOTMUKg36jC8+lv+8bYOZF43GkLr
         QJn7CvqNB80aKcIRsY7MCmRfU4ODCVK2GX2ZJzU7OGU7nY3p3UsOYOgmup6ncipYmErX
         sSerzF6TP1d02k3ZHLl2T5E2f+aFDIxO5POots6mxrRtNFoOjU2cFLvi/2jpERyyYkqQ
         9LgfQPEyOGqGmCx3C8njwjEFdYhhsav+OFaO2r1lnebCWliGuV/wygEFKfZrVlXSEGEZ
         jmhQ==
X-Gm-Message-State: AOAM5310ODVT0qvSKKz1RyjEMg6PgGlWaRbMB+Wo/Ms3YuTrpIu/pysh
        eaRvqCuqSdJUiZuvluWGiWbWnecckGl3ZrAMgPE=
X-Google-Smtp-Source: ABdhPJzFakh2ykhbWYSIfMClrsTCDR/RlVV7AtZW4ucMxT7ws+DcoO2qHEzPA0somMKUOaKocha3T0eLNyGNR+hyxb8=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr4188439oie.5.1621538127240;
 Thu, 20 May 2021 12:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-18-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:15:16 -0400
Message-ID: <CADnq5_MXcOO_a56RzN-qoTrZ2kCH3u1W-vq1hzxnN7eY29VMzA@mail.gmail.com>
Subject: Re: [PATCH 17/38] drm/amd/amdgpu/dce_v6_0: Repair function name of 'si_get_number_of_dram_channels()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
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

Alex

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:468: warning: expecting prototype =
for cik_get_number_of_dram_channels(). Prototype was for si_get_number_of_d=
ram_channels() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index dbcb09cf83e63..c7803dc2b2d53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -456,7 +456,7 @@ static void dce_v6_0_program_fmt(struct drm_encoder *=
encoder)
>  }
>
>  /**
> - * cik_get_number_of_dram_channels - get the number of dram channels
> + * si_get_number_of_dram_channels - get the number of dram channels
>   *
>   * @adev: amdgpu_device pointer
>   *
> --
> 2.31.1
>
