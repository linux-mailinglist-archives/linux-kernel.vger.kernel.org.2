Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78613640EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbhDSLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238759AbhDSLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nly+1DO6xtNI7xIJZQr0CwBL9odu8O2pnwWHw5PL2Fk=;
        b=IWbM7XCutl77mrKsg0+uKe3NGY5TOOuMIVvXC9gJ4O9rLyzr3P2MUEuOgCJaXWVE9pussH
        ZWF40qSqc9nK0Gei/G/rrmgO3/SvYfOZgc25HN3d6gbneh1J/i+BCca0Bir1ZdsZAUPeg/
        PzkVwZbjx/YDFdQQxyXQU+Ylxr5Bvx4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-3SCdgin4NU6veFiEJf6vgg-1; Mon, 19 Apr 2021 07:49:26 -0400
X-MC-Unique: 3SCdgin4NU6veFiEJf6vgg-1
Received: by mail-wm1-f69.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so4806898wmg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nly+1DO6xtNI7xIJZQr0CwBL9odu8O2pnwWHw5PL2Fk=;
        b=jdIHiHGxWNRqif9gzrrMpFJ8nA9JFral6kICXrBTmJU8x9RNx5Jd7wfDMpv5m3tqI0
         qnqCm/RH7FEIKwl2XXC+bNhrl9D+4Bqh09obGpD+OlC/zngfcrczjNBqkslgPvkCOcX/
         cDL0uUiZUOD5drKMluGNlaooP3iIftHjLSZiaYApZ49kRCPcceDskzKQTsSK2yr+erx0
         T8dFw2TeXGcL1yXjGYHnJeb6jCvsIBU4Mf5duoSEw2D2UfWNAgLcjlWZNZOBSTtFDNmd
         nHvz45/qagAVcm+MjH1C4bo2unFCZLR2zdiZ3mGkIDTHwfl27i0gTC1Kftdj29bawXBG
         +oBA==
X-Gm-Message-State: AOAM532aBu1zeqex3N4rNpHBak+u2u6RNGpcX00yIsV3lJNo/JEMgvwu
        YyFsFNWPBCx/kv+jDPm1FovbX+h+2wlUTRhbIdRmZMnDT7E2sZRrCDt0MM/RCAbWGQD5jKKtEvv
        FHW9UvyU4RN9OT4KYGPom3dmSGIRviZBcQXvc/AGa
X-Received: by 2002:a5d:524d:: with SMTP id k13mr14503024wrc.113.1618832965217;
        Mon, 19 Apr 2021 04:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo70JbUkSOXLnCMJ/q0c/kasxJbjovwmjfD+BmIDk5mqXW5hGpIhL7aPNl6r8rZpHGwg8WLg/vphWP4pcCf1U=
X-Received: by 2002:a5d:524d:: with SMTP id k13mr14503007wrc.113.1618832965102;
 Mon, 19 Apr 2021 04:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-17-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-17-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:49:14 +0200
Message-ID: <CACO55tsRq3dMrmw+msxnGf4e5=30m0R+XyAX4AMtgNrMNv284w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 16/40] drm/nouveau/nouveau_ioc32: Demote
 kernel-doc abuse to standard comment block
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> index 8ddf9b2325a42..2af3615c5205c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> @@ -38,7 +38,7 @@
>
>  #include "nouveau_ioctl.h"
>
> -/**
> +/*
>   * Called whenever a 32-bit process running under a 64-bit kernel
>   * performs an ioctl on /dev/dri/card<n>.
>   *
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

