Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0534854B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhCXX3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCXX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:29:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401BCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:29:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i144so398352ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szMyrlVIzLgkuWOdfnjXqAD83OmSXPmtaUZglnnq0Iw=;
        b=U1Wb1zOKrEBdqaW8up8hYUOKhLJOii3QLZEBREfU6wiLpwHRSg721PdIN2QEmhKpSu
         Q4iZAyLmtlSjLIXvfyGhaN9kwjgF7OdcrWkv8CRNB26WCWcFbvU9eheYY783bUNX8MWj
         cnkO8eJmaR5S1ETumlGVDkbnZSuclmpqcjaESJxyDeMQYsFwunkoUXYKjEw2Yduqrnyx
         l/k6UCfTC2gpx5oEtC8B17v2DjYSzIWDokLeVqgoCo+DhYDvJQsGeMvysMKu8Fhf7IRB
         5DwfdlWd8Qav2VZafgi9CtexdsYullmmY0XNi2Ng6W5o35dW++W8lJrDlOB9Sm3TfNAw
         +z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szMyrlVIzLgkuWOdfnjXqAD83OmSXPmtaUZglnnq0Iw=;
        b=QxBHGRMWzAx50Eyxg6sZPb/MVAYgTWjJhAedPhPb0tK0RpB+tAqDIu7ACAZ+HpuT3E
         VVpV/FpYzOYJMGu9p5AHs7QI342HvOeZw1a3SdnQONFnML9m5vf98lg9poHA7KWBBzag
         B/jtuCUvrp6AQpXVEw8tn2v95VwSih5CZurVCoxib9zcJNTHwHAJpOmNzqLAOn/NOe9U
         eghPElogXh1SkTwFTc7+ywVP452WOSM1DeRGGZXhNJBm7c5FF93rnYKLdCc3TYtsm+11
         1oBpcHoOqkUBYq/QUXsccrYQMwCrdVLGZ8PT5TmgYZoKXYIptb597e8ue80aD5nn31DJ
         yxsw==
X-Gm-Message-State: AOAM532q6dFVP1OzgqxUmLTV62g+g7yxYZVaWHeFYWQfWyiMJU/Me2j3
        U/W5Y2wDv1pG+xJqixKf+K6fQ3F11LIq7nm+Dl8=
X-Google-Smtp-Source: ABdhPJyOs9xaGa+QOKUSOuI31tkhHjwgr5dxjeryBWUSHHVi7wTeTF4Stk2Ysp67G6woc0dQ0qgfpRTJ0VGQLHnGRPA=
X-Received: by 2002:a5b:591:: with SMTP id l17mr8407393ybp.60.1616628543635;
 Wed, 24 Mar 2021 16:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210317093545.354-1-tangchunyou@163.com>
In-Reply-To: <20210317093545.354-1-tangchunyou@163.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 25 Mar 2021 09:28:52 +1000
Message-ID: <CACAvsv6ixo422jtf+KRQj9P1bs3LCqMB3JhSnVhQ0wyQrUa84g@mail.gmail.com>
Subject: Re: [PATCH] nouveau/nvkm/subdev/devinit/mcp89.c:Unneeded variable
To:     ChunyouTang <tangchunyou@163.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        tangchunyou@yulong.com, LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 19:51, ChunyouTang <tangchunyou@163.com> wrote:
>
> From: tangchunyou <tangchunyou@yulong.com>
>
> disable,delete disable and return 0
>
> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
Thanks!

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> index fb90d47..a9cdf24 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> @@ -32,7 +32,6 @@
>         struct nvkm_device *device = init->subdev.device;
>         u32 r001540 = nvkm_rd32(device, 0x001540);
>         u32 r00154c = nvkm_rd32(device, 0x00154c);
> -       u64 disable = 0;
>
>         if (!(r001540 & 0x40000000)) {
>                 nvkm_subdev_disable(device, NVKM_ENGINE_MSPDEC, 0);
> @@ -48,7 +47,7 @@
>         if (!(r00154c & 0x00000200))
>                 nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
>
> -       return disable;
> +       return 0;
>  }
>
>  static const struct nvkm_devinit_func
> --
> 1.9.1
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
