Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBF44F53E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhKMUY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhKMUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636834921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2F/RqjtwTDKHqbmFyTCtAaLezofMM+3SAjDwL4WYfjk=;
        b=Il8Gj9OfVXN0dSVKu4KJa5QBcb0mPO0P3XdrvskzQK5ZN2e81HyIi7h/ZIuzYVn0JmCbOO
        j4sLXZzjC1fOALLaXJdxUNtsvQrRVFEzmjNCs91lxQOl+Bz66oxDr2xXvsVjgRHWLGIbE+
        uI4oWiu9x6T4jmG8EcUFMCi3kURQM3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-BKhO4GU4P2WXrBt7l5tzxQ-1; Sat, 13 Nov 2021 15:21:59 -0500
X-MC-Unique: BKhO4GU4P2WXrBt7l5tzxQ-1
Received: by mail-wm1-f72.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso5020421wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F/RqjtwTDKHqbmFyTCtAaLezofMM+3SAjDwL4WYfjk=;
        b=ygiOsvlQIKxWpge8ol0CpoZluhjcoZ5MS/c+uRKXdIgmp7ZlSxhLK+0KOUNM86w1wR
         Pacah3EOe7TzgPrei1OIW7uV67VZrKsDK/oJ6yj/U9MsEE+ETNY+0sCLCZxQdideu0/9
         i5oNEPnNbbbju53ZkwAbn5m+3il1Nn3j/iQ64uc16R/yxUAktoLZMMu3OWXLQfT2nvkA
         NFTOmg0rLODffFLHFOjOKrgDICQWGJvPEOFbpgJ2e/vNUfZXE4gNL5S+CuK7PqvWQQMY
         lyuZ7ZYHLdBF3EXy/eR+SxB4ntuByvT5qhz84+iAdu19oBOqoTVlYlyASGLzA5kMykUb
         dDyg==
X-Gm-Message-State: AOAM53322NGeMvWZ8iepYMOjyifOVf7rtR+nt11H1mRzFIZI14AtoKdA
        rKvScXNIBEoJi47/DGymzPliZtTbvZ4RAwwrII/S26iw1184UEsvNHz6ll0/ptmJuxifw7B8FTM
        PEKmhMMhOEwZMBPXMstNUtR3M/PKX0YiYR1BwtGLK
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr31811215wrr.11.1636834918441;
        Sat, 13 Nov 2021 12:21:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvqhfKWTCnwIY4T3+XKKRpmPT2+dOSNYismuaVwHbxo7aKrTV7NWW08xEzDGvONPamHxoBM3Hbj1P73gNHmAk=
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr31811191wrr.11.1636834918255;
 Sat, 13 Nov 2021 12:21:58 -0800 (PST)
MIME-Version: 1.0
References: <CABvMjLTVZaU8vMW__2BDo6FnjFa_bsh2S-kEmg=KV4KTsFiUzA@mail.gmail.com>
In-Reply-To: <CABvMjLTVZaU8vMW__2BDo6FnjFa_bsh2S-kEmg=KV4KTsFiUzA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 13 Nov 2021 21:21:47 +0100
Message-ID: <CACO55tuDQ9UC2rr=_Hsowvujk49oNK1zWfHj3jMnhEqsTAnh0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/core: fix the uninitialized use in nvkm_ioctl_map()
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

something seems to have messed with the patch so it doesn't apply correctly.

On Thu, Jun 17, 2021 at 9:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> In function nvkm_ioctl_map(), the variable "type" could be
> uninitialized if "nvkm_object_map()" returns error code,
> however, it does not check the return value and directly
> use the "type" in the if statement, which is potentially
> unsafe.
>
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> index d777df5a64e6..7f2e8482f167 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> @@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
>                 ret = nvkm_object_map(object, data, size, &type,
>                                       &args->v0.handle,
>                                       &args->v0.length);
> +               if (ret)
> +                       return ret;
>                 if (type == NVKM_OBJECT_MAP_IO)
>                         args->v0.type = NVIF_IOCTL_MAP_V0_IO;
>                 else
> --
> 2.17.1
>

