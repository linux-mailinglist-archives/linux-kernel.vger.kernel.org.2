Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32078341905
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhCSJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14N7YiIxyiIUD8jIqz1YlQ1wNnYD6BJh9pT3hmKB6gU=;
        b=XZx3DJ9wrdpqzS2TjVCGvRz9TA6ujeXXbjYGDA8mmPqb57rMS/An0kwnYJZLE6IjeYC2na
        7kwI0RPC76MzwCSlmpAT0jfUix4wPh2fpQKoDqFRQvm8ERaVBOt4RrOqIN7G0kdSOgx0MX
        z9yChzSO8boY2RcI7LzHQlt/05W8h00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-0grsKkUzPu2-ztTNKDOG_g-1; Fri, 19 Mar 2021 05:58:24 -0400
X-MC-Unique: 0grsKkUzPu2-ztTNKDOG_g-1
Received: by mail-wm1-f70.google.com with SMTP id n2so12703269wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14N7YiIxyiIUD8jIqz1YlQ1wNnYD6BJh9pT3hmKB6gU=;
        b=UD7vfd2gQRPU9DqV5lT6Na9fXqgnLfi8lkzv1anp+uJYlYiu/XXqAFqoMCN60XjLts
         CyA7H0Y6elxhGcOEyiz9ciDAckOR79BPrkYyZHSbFhdx8jB/bJiOIjLllZWsUMWnRK8/
         jzIT4qMFU8p/a42QhMNqr7z50zAJNPMZ3e7fIWaad/6Z3aXAlnQkdqALB3uwscK7G5HE
         z2AWHy5iUS9n4jj8u5eOYnB/YtM6/AmeyoC2NzAh2jbqXJmRlHfOs2fWPZy3BXtl7Ep5
         BREevNQdwGr3jrcnpRtkYlPU6vea7hzk265PRyyBX4iry4bB6fS853kMTO/ItR7cwAio
         enJQ==
X-Gm-Message-State: AOAM533WXU9rI8crbfU2DBlC9ZXjG4BDCQLMTiDp7kDStT2At/BV+Qtu
        oLF3r4fIbJdt/mlP9z2BU2984X4qwxQ6xL4mvb+HUS1Galt0s+HBarH5bW3V0g7j7oHsV6jiGc9
        CmNnGrNORiZv9a/caLh/MIRj9KDg2eKB0sUcZSIDO
X-Received: by 2002:a5d:560e:: with SMTP id l14mr3643924wrv.10.1616147903078;
        Fri, 19 Mar 2021 02:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeORHso+wJAMW5iE+h4wMikaT3nxP8XYKaAeRR1AoFZSCKv6xsGOxkyaAWdZVyocVW2UEWX29YgKydp9i6sUE=
X-Received: by 2002:a5d:560e:: with SMTP id l14mr3643914wrv.10.1616147902914;
 Fri, 19 Mar 2021 02:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-15-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-15-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:58:12 +0100
Message-ID: <CACO55ts4nBY1DptpqcUGKgfkUzuQy61o+ZZ5voRfr4hSsqQcRQ@mail.gmail.com>
Subject: Re: [PATCH 14/19] drm/nouveau/dispnv50/headc57d: Make local function
 'headc57d_olut' static
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
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous =
prototype for =E2=80=98headc57d_olut=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc57d.c
> index fd51527b56b83..bdcfd240d61c8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> @@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size=
, void __iomem *mem)
>         writew(readw(mem - 4), mem + 4);
>  }
>
> -bool
> +static bool
>  headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int s=
ize)
>  {
>         if (size !=3D 0 && size !=3D 256 && size !=3D 1024)
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Karol Herbst <kherbst@redhat.com>

