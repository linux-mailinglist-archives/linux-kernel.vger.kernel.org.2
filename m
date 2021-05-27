Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD53925DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhE0EJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhE0EJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:09:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA52C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:07:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so3191359otc.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=biRP26rVUcCDUxlQKzqIiq6xaK3uwBrV/Qk9YlWx7iU=;
        b=Lvc/0ad2S41Y2inaGB+y3ko0vNk5/5PGoyTFgSAHppOljYZ8gdf8OttN1r7sGmXs4n
         GaZwmgTrDi97eVBMTi5c0TaQniyI2gX8fwXLfagTgEq3YVYBAvz8byoKJxWU25L30hDw
         bpclaMU2tQNt5tFOZhHNq2DihxDLxbO+ebX9+fF35alvl9+l4aRM0ZOSnfff/+UyFvrL
         n/gvNTbEQad8hEoUixsGpaGDtcA5EnIipLBfeXQ95JFIXar1GNZ/np9EqpprnXycsIM6
         +1H02NoCXcxx0xv30QR4AzlW02rVsSgmIwz7073qZ1axPAYh7RqJYWnztUUcsYAgh5YE
         uywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=biRP26rVUcCDUxlQKzqIiq6xaK3uwBrV/Qk9YlWx7iU=;
        b=NgCZgK7S0fq7Y1YP8ClkHbO6RRhAHW+eVQu3R6wtxFV1MyVhSdIkWECOK5UXWBjUu5
         NZKmxW3+n11ag100Q51rn90496jfSGXJmnIjQJJyorJWWmKPjH/R8QKERbQex6lG5dK3
         FkRSFYhyxxyoeHYBp+fAVJ2G+RPRbH3BMgdTJOifNXzMadA6DMRRWdVcEJOyuq7+Z5gv
         iL6KNkmlAwzLuDeCDnv0csPAFoLvbr9wwYiumXoA3Cq2d4vML0YcQW560PpMX8TzUXw2
         NBkOekjsL5XwpUASn7Soz/PJUuLp5dWa6DWhOxkmumH7F5WgPWFbeUll963fCsccUIyL
         8dxQ==
X-Gm-Message-State: AOAM530dRy0njEm2xslFax1Jb0ahGAyti8t6c/TrtRnMk4nFn3MKkHb6
        jIv2TGfvMzY6BE4c4y5i5NbSoUi/7qXHkSjuhLXu9rFT
X-Google-Smtp-Source: ABdhPJzEfSXRivAnJdi6SeTD/+1xR9TKlmVtvSYaYLngnkYXEQ1fhBNMVCyLnuQnerV4Vl0wz/a7inrtQalD/snllf0=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1241846oti.23.1622088446582;
 Wed, 26 May 2021 21:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-16-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:07:15 -0400
Message-ID: <CADnq5_PjO_KWOU1y8kXDV77Pm56vzhGxaWow7-GFGSxqGsMr9g@mail.gmail.com>
Subject: Re: [PATCH 15/34] drm/amd/display/dc/dce110/dce110_hw_sequencer:
 Include our own header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
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

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:92=
7:6: warning: no previous prototype for =E2=80=98dce110_edp_wait_for_T12=E2=
=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 5ddeee96bf235..9219db79f32b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -63,6 +63,8 @@
>
>  #include "atomfirmware.h"
>
> +#include "dce110_hw_sequencer.h"
> +
>  #define GAMMA_HW_POINTS_NUM 256
>
>  /*
> --
> 2.31.1
>
