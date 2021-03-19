Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275743418F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCSJ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhCSJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysOGQ+JuPnyfkvsyXVUk/A0GgAxeDgtK3Jp6pwQPGCg=;
        b=Kdh5s9X3t+h7meJi+EJu21uDo/2+ETeiUUaa6s+QXuYs8mDFq34mO/ZhuW3G8V8n4+KDS0
        g5ULmVaZNeLGrUTcXFR9rZ1lNmLR6qRrzLyCozozoR3FyULamnm3kMlEwlCKR86ERDt1QV
        c9vtZ7iDd0vBx4hMGqNcsHbv4b1BBNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-x6fs_XrMOC2Xm5V4rmziZA-1; Fri, 19 Mar 2021 05:56:42 -0400
X-MC-Unique: x6fs_XrMOC2Xm5V4rmziZA-1
Received: by mail-wm1-f70.google.com with SMTP id s192so12695788wme.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ysOGQ+JuPnyfkvsyXVUk/A0GgAxeDgtK3Jp6pwQPGCg=;
        b=JmLxA4pmEAHp/KKj8hMVUxuxs76Iw3S96NmSPMdQrFRzeNxNA5Db6AwmG2TCdJW0z2
         1/CxBxCI7qyODK6P7sb64ECBTc4mGYTNrF8dJEg0bjRG6EcUWkjo8wYzz6l2EqLhqXQM
         H8ourm97EDpe1VZ62uchaCn3elhZVJ9y5e2dCWPTzMAXIF2r5O/EQGB8mKtzYAy4PrsC
         EtKa6Wg2YBodiZ3Bay2xt7u3zkgiBhiFfo8Upt9vSh7o+EYzE2oi7uJ3AYV92Ch57CDq
         Cfa+5aTTQHueEDyD3yUeKq5uhkxhgzQHBleHx49xCmHoMmItmFEZcRtVmabOBJKC8P25
         AlCQ==
X-Gm-Message-State: AOAM532ZvZvU9EgUEpwfk/fvuUG3Z+wTszCcMPJl2wpc7IXZCAUhz1lG
        OK9OyHwbLWG+noYe6J5MhQ8tW9fYhWKuNJvT22+hBs6Y2NgnBsb9I0QEUXjg8yO57AnG9RRxt6F
        tU9ABdbftzSoolA+ZNXi2ARBhTXx3gzsulAjvEGxj
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr3001416wmg.171.1616147800804;
        Fri, 19 Mar 2021 02:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3mEE6CSIZmWxiZ1XdIJ72ZTiVHg0YQRrSzZBZE3GwjnidS+39Es1MG0HcFFBZdOYiKYjsbTZEIXLbb0wk0kQ=
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr3001400wmg.171.1616147800686;
 Fri, 19 Mar 2021 02:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-16-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-16-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:56:29 +0100
Message-ID: <CACO55ttoFZdD6y_3sBr0aJseX=zZ=09E3bRXYyNy1djVSb2oew@mail.gmail.com>
Subject: Re: [PATCH 15/19] drm/nouveau/nv50_display: Remove superfluous
 prototype for local static functions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:25 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following build error:
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c:2530:1: error: conflicting types=
 for =E2=80=98nv50_display_fini=E2=80=99
>  In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
>  drivers/gpu/drm/nouveau/nv50_display.h:36:6: note: previous declaration =
of =E2=80=98nv50_display_fini=E2=80=99 was her
>  In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
>  drivers/gpu/drm/nouveau/nv50_display.h:35:6: note: previous declaration =
of =E2=80=98nv50_display_init=E2=80=99 was here
>  drivers/gpu/drm/nouveau/dispnv50/disp.c:2581:1: error: static declaratio=
n of =E2=80=98nv50_display_destroy=E2=80=99 follows non-static declaration
>  In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
>  drivers/gpu/drm/nouveau/nv50_display.h:34:6: note: previous declaration =
of =E2=80=98nv50_display_destroy=E2=80=99 was here
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nv50_display.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nou=
veau/nv50_display.h
> index fbd3b15583bc8..2421401d12636 100644
> --- a/drivers/gpu/drm/nouveau/nv50_display.h
> +++ b/drivers/gpu/drm/nouveau/nv50_display.h
> @@ -31,7 +31,4 @@
>  #include "nouveau_reg.h"
>
>  int  nv50_display_create(struct drm_device *);
> -void nv50_display_destroy(struct drm_device *);
> -int  nv50_display_init(struct drm_device *);
> -void nv50_display_fini(struct drm_device *);
>  #endif /* __NV50_DISPLAY_H__ */
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Karol Herbst <kherbst@redhat.com>

