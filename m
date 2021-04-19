Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93DA3640D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhDSLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238740AbhDSLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lodamhupIClPRvQVAJcc8N1PrnJrjvEQCs2vDJeC4is=;
        b=MnF/lBntby0OCF9A9DjfAjH79Hw0IA8qcnqsftDGGpJf1UUuCq/rPbDWmsM7+kdP4EPwd/
        K9HJ06f4quAT376NM4WHbff5ewTAMRB+ebF4jeVAbUWv6y9Dm4nww3NemVA672ESNlX6Th
        AQdyHeun7nMpm1RRMLM7cqjX+PYPkaI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-cKyXoN8KNN293jkhDInGYg-1; Mon, 19 Apr 2021 07:47:06 -0400
X-MC-Unique: cKyXoN8KNN293jkhDInGYg-1
Received: by mail-wr1-f71.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so8935849wrl.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lodamhupIClPRvQVAJcc8N1PrnJrjvEQCs2vDJeC4is=;
        b=rtwOHyxNJrTpkPzmgKtXHs6qXiajur8flkC23x6yFCoNuMpQrNeK4UC8y1PaQxftKx
         jG4vCv4zqCHXarftFPbtOPFvxpLHZl1QgxSpcqcDDAtHMsfI5/lvmQxDR4aeibAe+PWS
         4VmPC6DOOIEgS/B7Nx8JShpIQToQg3wQuLcWL+E9r0uzGcXgaZvAKVtDoP0lls9BVTxq
         h42FzLeukUZMGrTqnRoUOVOwXiUrzmZzbzzg2BhxzQVe3hRrEmZZzgUP/sIuj/Da+L/t
         4DWKK9gCZiQgqRDw0NLaUyoAN+tKisjfgrTd+1HatUDLh8EZocbvui34xEb4QHdkWv/H
         NHAA==
X-Gm-Message-State: AOAM531fhMfYnAVUmkPHOZNPaw3/CiXtadxtFqoOo813S1jGPWNWksVF
        9muxgFZak+mDNE3B0LWc62b7HgsWGB9K1FKLS57SYZ/BzmTrYyC7U3E12wNHKw3gV778kdRorh4
        vpQit+mFMUFOAjbApMJwe5enmHr41Nzb3jttpYmuC
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr21149949wma.164.1618832825754;
        Mon, 19 Apr 2021 04:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz2DBi+eaf78G0k67QC0inXD2fGPAwhGBsJQeP4aS5Z+prjC2fisj6mCReZm8TlIb6JLrYH8C0u6hrguIqBF8=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr21149933wma.164.1618832825581;
 Mon, 19 Apr 2021 04:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-13-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-13-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:46:54 +0200
Message-ID: <CACO55ts=J1XGubumoTJMAj0w6F2KBJFUV601oq-2uVD08FrWuA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 12/40] drm/nouveau/nv50_display: Remove
 superfluous prototype for local static functions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
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
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

