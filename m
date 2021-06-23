Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE53B1D91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFWPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624461819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqNfBw+DZy7VZXBvahJMXyxmm59IKQhUiq2dn1235vw=;
        b=al5+qDE98xCfMMjJOInGnGtQG/Jre0q0BjMjH+tHe1KQOOnoinpuHXdsDj7FR/N7MOkyNg
        +GBDV1Ve5dxbXhv4wvoZZ5tbPnItUFmvNiFxzEDHFlezcjFCRmZ/ydxSUjDTrs1Rup70gB
        FrAw49aPIt/ocgz9LR8xDJ6xnjRxCjA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Jev1xyjVMNKxq--7GemLzw-1; Wed, 23 Jun 2021 11:23:37 -0400
X-MC-Unique: Jev1xyjVMNKxq--7GemLzw-1
Received: by mail-wr1-f71.google.com with SMTP id f9-20020a5d64c90000b029011a3c2a0337so1217674wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqNfBw+DZy7VZXBvahJMXyxmm59IKQhUiq2dn1235vw=;
        b=ru8pvWCZUMpWKvQJWvvCvyShy5n110BWud/gFo7pgKbMHnrRqqdWwZQNuX3fI38HVE
         BcSG8ZUvwQungWfix2xDVFT9cgK30KfjkVu96s53VicMvKQO0rrBsGR1dGpb2JQORIsh
         yUY3wIbmRNPL1+F4F6DtnqgbNoXzMUBzLfAS8T2+fMWiaBj+EWFqAIp/iyOYEp/eHzAk
         9tHRf1Olt5uIngdBnJ2uNcYfvBrThJNpqNWL9dsxFzH919zqcC4RBmjC1xXKmqp7twgZ
         Ta+Ci/E8qcbeVMpymsFBRDVNUJe+PcKmyEsEiDljn0faAbRZtFqN6J1fEzDItYxASXaw
         r80Q==
X-Gm-Message-State: AOAM5338IHKO9wymmwTnJLQT7OUPDL+7XY3oZgOAG6i5Hvd6J2O++MoW
        1yZ6szSWHDsl3c09SYtsdiTGvTP5vwqoQfxzyutceJDfS5uOjh6PwoQBFuHd7RPj4TIyBwkxkeK
        GFMVK0xFEcfRNChWnuJLFdIgWfaOvQ/df0dCrsTY1
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr4087031wmd.139.1624461816650;
        Wed, 23 Jun 2021 08:23:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkwprwBs+4+m2cINYxKCit9IeKr9Iv1V9yb/mYUuehMDtRmPDtVVvRYTjDw7TLfVWQ+DO40JMT0djrFoge9kc=
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr4087017wmd.139.1624461816527;
 Wed, 23 Jun 2021 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210622125803.640-1-caihuoqing@baidu.com>
In-Reply-To: <20210622125803.640-1-caihuoqing@baidu.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 23 Jun 2021 17:23:25 +0200
Message-ID: <CACO55ttH-BbGzT+2ZXPiONdmtv5s-4qCCLWAx+sxQ9kyJoKtfQ@mail.gmail.com>
Subject: Re: [PATCH] remove unused varialble "struct device *dev"
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 5:14 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> fix the warning- variable 'dev' set but not used
>

the patch title needs a prefix to indicate which subsystem it belongs
to. Check git log for examples.

With that fixed: Reviewed-by: Karol Herbst <kherbst@redhat.com>

> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 984721b..cb3ff4a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -1242,7 +1242,6 @@ vm_fault_t nouveau_ttm_fault_reserve_notify(struct ttm_buffer_object *bo)
>  {
>         struct ttm_tt *ttm_dma = (void *)ttm;
>         struct nouveau_drm *drm;
> -       struct device *dev;
>         bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
>
>         if (ttm_tt_is_populated(ttm))
> @@ -1255,7 +1254,6 @@ vm_fault_t nouveau_ttm_fault_reserve_notify(struct ttm_buffer_object *bo)
>         }
>
>         drm = nouveau_bdev(bdev);
> -       dev = drm->dev->dev;
>
>         return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
>  }
> @@ -1265,14 +1263,12 @@ vm_fault_t nouveau_ttm_fault_reserve_notify(struct ttm_buffer_object *bo)
>                           struct ttm_tt *ttm)
>  {
>         struct nouveau_drm *drm;
> -       struct device *dev;
>         bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
>
>         if (slave)
>                 return;
>
>         drm = nouveau_bdev(bdev);
> -       dev = drm->dev->dev;
>
>         return ttm_pool_free(&drm->ttm.bdev.pool, ttm);
>  }
> --
> 1.8.3.1
>

