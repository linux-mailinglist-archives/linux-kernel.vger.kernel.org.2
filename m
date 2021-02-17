Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65131D444
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhBQDb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBQDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:31:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:30:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v5so19239573lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O1SlRD9mHyYcgKEptGwWMdlwwiEOHkySooRbJcp0FA=;
        b=rKjhnV/rKjMzs4NVFzvqTIn1IvEel/XKRv2CRTelQ9l6AmdnlXFx3Bq7V2QK0TB6IH
         RP8YriO8Bu7FI1tvhK16Tveb1BhGHb7ONYkrxHbl0SByByvd9l7PQh2gnxvthWGBVRtj
         bXB1nyzKQYJ7EN8BVX8fOCVK6GzHAasVhWRO5JgvYeVBLiEbZaRBldLJA1VhY2bSm6Il
         MX4tL+wwAQuNwnBxJCLPbiWVtLIORNNel+aUMW2Z5Yr5JCcDzYKWX2bmaO4684IyiCdT
         C0hTEGyOCmdNNeWPC75RJr3anp+S1ucatzlY4N9Wfy8WUbwCe+Rs2eR+9LRyHzF/eJ2c
         daaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O1SlRD9mHyYcgKEptGwWMdlwwiEOHkySooRbJcp0FA=;
        b=hTeAXarg5kiFgLrcBAwtrDDT32tl/FXJPQGH4KDwZx2gK5/lKC6B+6IrFh0uABPphk
         x4YEGdino1ZvV+2fnKhHv7Mmlxx+Lyte+ct3tEAcEzJunIq+hi7WWEgtfdD5rTkoum2v
         EqTrVT3rFayO/T4JFWtBgwghgHRz6CDnDdJCyqtKtzTSvThnhhikwyHmaTXZvefSBk03
         MWWQi6Q1NYZ5LVo2K7thNmxXcyGBkmqeJMpQeR+qZ0gIj1D3XZhCvNCRGmb5LXqzqOrt
         HlwxWAuAH72JzWCx9iip5RTIEe4v7ioxQWyVwrQdbyuv6xbcBwNktiu5Yjh9NlcJNfu5
         lpMQ==
X-Gm-Message-State: AOAM531AggytHc21xLSt+ifEOvD1AfJU1u9MCHwBDWSPsISVwGvORoM9
        XbTXxNEA8o4XkK5rHm7xKmnu4GCZVJ7ZusoF4zYgoOT4568=
X-Google-Smtp-Source: ABdhPJw5LFP81VELsUJIh9KxmEzjlv1swQbIZPYaaa7C6xhkNziyUEhOnBsHYExdN6qSsBLznPBBWbSnzjIIeBUMxDo=
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr12812355lfu.577.1613532641983;
 Tue, 16 Feb 2021 19:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20210216161924.1687-1-diego.viola@gmail.com>
In-Reply-To: <20210216161924.1687-1-diego.viola@gmail.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Wed, 17 Feb 2021 12:30:30 +0900
Message-ID: <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/pmu: fix timeout on GP108
To:     Diego Viola <diego.viola@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@spliet.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 1:20 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> This code times out on GP108, probably because the BIOS puts it into a
> bad state.
>
> Since we reset the PMU on driver load anyway, we are at no risk from
> missing a response from it since we are not waiting for one to begin
> with.

This looks safe to me, provided indeed that the PMU's reset is not
called outside of initialization (which for GP108 is shouldn't be
IIRC?).

>
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> index a0fe607c9c07..5c802f2d00cb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> @@ -102,12 +102,8 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
>         if (!pmu->func->enabled(pmu))
>                 return 0;
>
> -       /* Inhibit interrupts, and wait for idle. */
> +       /* Inhibit interrupts. */
>         nvkm_wr32(device, 0x10a014, 0x0000ffff);
> -       nvkm_msec(device, 2000,
> -               if (!nvkm_rd32(device, 0x10a04c))
> -                       break;
> -       );
>
>         /* Reset. */
>         if (pmu->func->reset)
> --
> 2.30.1
>
