Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2034D392617
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhE0EYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:24:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79896C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:22:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y76so3867040oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9DG+xjWGZv67nZFsC1Ee5TRyVRy4OYoOSwlGHHWJ58U=;
        b=l5L+bJvVQJRe0kOb+T6Yq6UuOZ5NfHBWYe+QjQ7AgzNd+wN4b3ZnT/+xjry1OUKU5N
         b7coSP0dZSCIsI8RQl16xUD53gX/HGThF6Grwe7Xg7Z8usXdJN6sZgHHUv26XnVfrU1o
         +ppKtu8BbRLChINfqvdf588PZrqLhmbZZ87cZzANzPyy1ETBrw4ACHMJkzsY0v8oEpkw
         fGTT44+uA014dkuBUxX5/v2Tqix4JRPNgfuvu1rEgcXKRE1U7D8cWCFm4N7lUn+vFitX
         G0q2S549q0TCFxy4SWASelCCEgXGhqrI6/zri1K9lvZGnYohCU+ZRWelJHA5FUwXtTYW
         6sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DG+xjWGZv67nZFsC1Ee5TRyVRy4OYoOSwlGHHWJ58U=;
        b=jwFYJyJYYKtV5E+RbW3Q+PdQ8oWu/M2dGVOifG/06QpSn6UzeFfF0RdcfZvl6NyTla
         fmzMqDiBOYlbJO+5NQGYBsQmmQLWat/UhBi0xZYbVTF+8spZCUGnT3ZgeOZtN6sAwKAf
         wkDuPAw2AcK3uwfn8a2B+td54R2qduzesjK7xHNHYs7jXgXDJG7V0Si31Szf3iZWq9LB
         MY2yl7fOCw6mult/zkhFbm+6QgfivYwNoUv8ciM/i0sLOlupVqLy0nwzrspLOt+6w7p0
         vSoA41X+XVSPFD0r2GIcH91R2kgnaIwXnwydExMrzRjK9SChsoS9Vz09Lh5gJlfWunxj
         rk1w==
X-Gm-Message-State: AOAM531y2924eu06VJXIHX6+7dhKijETpoeMewrSdcEk6qCPVnO7y2iy
        1hWzrJahqAWqTJW4dVBrzF8+tdtBgGFevMf2EEA9HoE+
X-Google-Smtp-Source: ABdhPJz0CbLS9N2IE55TBBnETmt0sI7XDgqlj2lorRpi5OkRDYWOIcqZMgSfJ+Zx6228a69CfujHU7uG5Czu0vDD8Ms=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr4057313oie.5.1622089353925;
 Wed, 26 May 2021 21:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-21-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:22:22 -0400
Message-ID: <CADnq5_OHSFsckrZ4_Oy64fT+fDOf4QXudkhpGeaDqXvTc4JwXA@mail.gmail.com>
Subject: Re: [PATCH 20/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Fix kernel-doc
 formatting issue
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
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:608: warning=
: Function parameter or member 'interrupt_params' not described in 'dm_dcn_=
vertical_interrupt0_high_irq'
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
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ae0a95c5f1d8c..0b4841f377e41 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -605,7 +605,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>  /**
>   * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrup=
t0 for
>   * DCN generation ASICs
> - * @interrupt params - interrupt parameters
> + * @interrupt_params: interrupt parameters
>   *
>   * Used to set crc window/read out crc value at vertical line 0 position
>   */
> --
> 2.31.1
>
