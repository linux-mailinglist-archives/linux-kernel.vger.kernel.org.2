Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB73925AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhE0D52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhE0D51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:57:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1157C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:55:55 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x15so3792588oic.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6I1MN4NFWb6xeVQSlutSgWAcmQk4ybiIdBPc7EssI9A=;
        b=AcnIsP/9H7cKkmwG+Xb4aLO5wf9oNSioM80yUY5janIGjdZ/jrOxGOjL+Q459ygwmE
         hYaaatUpYrIYD19ql0dLEwobOc1LyazLx6QHcWc2mTN9lBtAuw9fG+tY9cY9ja3/3hGm
         TZGmuYn9qiQyW6EhOzwJMyYLd0mmDmQdFxfXDDAGoOZHYIIjP0NSQfeBWRC3mx4ymoQq
         wcmUoXszHs7h5JSo5vEjJnUrKWbrn8pWKCcAq2+E5aDbFh++LiHNrpl0OY1NkWsgf8tW
         aCE8CrDpqfvxDOT1yBDCViP1aWs3UqpcyAE7A8jHdNVVkwn9D7alnNieXb963Gs6I2bg
         cw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6I1MN4NFWb6xeVQSlutSgWAcmQk4ybiIdBPc7EssI9A=;
        b=QY15fqaP8k2KKikh7Mgqk97dKnGgCF0H5vwo7bXCjF1SImtpyKIvF2S7NxibmOQ9fi
         jDvFhNsvpbMwLM84ZP2WAgwkT08yloiQOxUsyKt/la2+BnMwC6sU8ByUlv9GeA8ABdDs
         7kJwuWBdO1QK8k5+ZeD7Ev7uRtZz/cDlv0+TuT7E+ayoXqpgd5cKejMqwD26SDZ9NOMn
         O1GDT4pIo7WgtJUr/hmsSqlSBfoyxO85PJDBbxbEfhhhq2sHD6C++4kB5sH4IrbmoxoK
         jeKFRXVXjVG7I/U9kPkkdNEjl6AG4aGKY1gm3EifR1PzueFY8IocJnOCAWCJDfm5G9Nd
         yErg==
X-Gm-Message-State: AOAM533xNrnSdgk/v3+9eDEcRQN+z56iSmSi4AJfwbNHTJmxKk82FfTy
        BrpBTGLgxdsddv7WjLFgfdlBeXcNUv1iTpH6O3M=
X-Google-Smtp-Source: ABdhPJyLCSQv/QKSuTRNjM9REWrV6LvELlWwO0q1KT5sPyqK1rH9VVCmNc0k3krS51ZcjSXmkdhBuwGUnFZY01qAZ2Q=
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr1023562oie.120.1622087755096;
 Wed, 26 May 2021 20:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-9-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:55:44 -0400
Message-ID: <CADnq5_PFBMaeD-sFQ-=5RzcZX42=4dwYZvnZhW+X3mQ62=182w@mail.gmail.com>
Subject: Re: [PATCH 08/34] drm/amd/display/dc/bios/command_table_helper: Fix
 function name for 'dal_cmd_table_helper_transmitter_bp_to_atom()'
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.c:127=
: warning: expecting prototype for translate_transmitter_bp_to_atom(). Prot=
otype was for dal_cmd_table_helper_transmitter_bp_to_atom() instead
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b=
/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> index 5b77251e05909..e317a36151477 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
> @@ -114,7 +114,7 @@ bool dal_cmd_table_helper_controller_id_to_atom(
>  }
>
>  /**
> - * translate_transmitter_bp_to_atom - Translate the Transmitter to the
> + * dal_cmd_table_helper_transmitter_bp_to_atom - Translate the Transmitt=
er to the
>   *                                    corresponding ATOM BIOS value
>   * @t: transmitter
>   * returns: output digitalTransmitter
> --
> 2.31.1
>
