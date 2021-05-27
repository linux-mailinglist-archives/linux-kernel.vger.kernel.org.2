Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26139259A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhE0Dx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhE0Dx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:53:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:51:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso3134297otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObVfNwPVO2PC2rJ9mQ29zRLy3G1wFkbEiSVflWMxPk4=;
        b=bI4D1NOOpgtzq6luGnjJmHGV5j4sd9uC+nnz4zwFn2dCp2SPukZLmj+rS+Ra0LVncm
         kT+0/v11S2ccVthKIOH+C+b12P2XUqegYcFbGb2tM60SY1kfCxuhkjH36LnDNKarTmLe
         FlwSVyc7WBPgTFHmirMYMTQBiAxZv6mU4D6hIbDgZhtRbduzQphA2gwwMpTXgPzSMOjX
         8uY7xAnrhMsfsv+Efn51gD0Yk4EicB5y4rckTYSmlWy1rWoh9e+zPLuqSp9pW+vWbaSA
         nIAIH3JqV7zPtXopv8ahSj+4c9N5bN8YekfFmJTMhs7Kh/QZDs01vItMLmZqcX4ThW+g
         LeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObVfNwPVO2PC2rJ9mQ29zRLy3G1wFkbEiSVflWMxPk4=;
        b=uiJexuzqvG7XdzjPRaFkyJ9+suPBWQ5VXg63hymz/CJxqUOYWU0fhF3DK/Gw1bZF1Z
         6C+XakMV0oCQDoSz/jbLqcEkuMX5NPcalrnt+Qdj49vfH5EK4FwDgimGzZzJ/Xq5Fw7z
         RR6mgzgWfvM3aNOWcOxtKbZyof+rSEuyEucA+c4preOVaI8sGyP0IkZ7+VR2JmaJ/PKV
         HC9bKIQJS8IPNus2otw6qxwEV7rkC9pD0TFYbB6zlQSY7PBLl2Ki5By7Uw95y+JNxs23
         Vmt6tVoj0hrB/2LO1HUfv6EhS7OUwPckOadwxhfWsAGxe9X/8x7L5YO6f5En9rCsbz/2
         wDDQ==
X-Gm-Message-State: AOAM5315opOPH1goCAwbr/11eXQKsubRj3MHk5dsY9srSSf5vvkxzZwy
        UShvAV5qmwKRNhpRzELv6hRbxMXtxR4/AR2qCss=
X-Google-Smtp-Source: ABdhPJzoXaQbaKR/UK+3tvFkSVSQl0hgYg8KapNW/jKmqAowfs7VRGNg2OuJK2CjLoD3C/186iR8I/cCd0c4HRWXKmo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1201591oti.23.1622087513057;
 Wed, 26 May 2021 20:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-4-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-4-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:51:41 -0400
Message-ID: <CADnq5_MRrMWuCOrWx4iVrARkFs6HQzdQb8TMKMK4sm3bmNkv4Q@mail.gmail.com>
Subject: Re: [PATCH 03/34] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Provide
 function name for 'smu7_fan_ctrl_set_default_mode()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, May 26, 2021 at 4:47 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:132: war=
ning: This comment starts with '/**', but isn't a kernel-doc comment. Refer=
 Documentation/doc-guide/kernel-doc.rst
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index 0d38d4206848a..6cfe148ed45bb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -129,10 +129,10 @@ int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *=
hwmgr, uint32_t mode)
>  }
>
>  /**
> -* Reset Fan Speed Control to default mode.
> -* @hwmgr:  the address of the powerplay hardware manager.
> -* Exception: Should always succeed.
> -*/
> + * smu7_fan_ctrl_set_default_mode - Reset Fan Speed Control to default m=
ode.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Exception: Should always succeed.
> + */
>  int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
>  {
>         if (!hwmgr->fan_ctrl_is_in_default_mode) {
> --
> 2.31.1
>
