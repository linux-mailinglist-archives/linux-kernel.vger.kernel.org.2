Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC88428504
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhJKCJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231578AbhJKCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633918023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
        b=C/2IW8LLS+sXyKCV+RSDxigaQqHO8wFvXb9Da9YNTXfXiO9khvDjcS9+aC1JNxS+pygMNJ
        rLM2mbmbTV+gqopNKagvJ3fp+bnB4R9PIdxbUfoZUn58b4NCOuarTQAUrzNO1HQ+P5xCpz
        Qg72mgUA6XfihXvetWBDoGBjgAt1lv0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-an92fliPOymvOD3rOsfE4Q-1; Sun, 10 Oct 2021 22:07:01 -0400
X-MC-Unique: an92fliPOymvOD3rOsfE4Q-1
Received: by mail-lf1-f69.google.com with SMTP id i40-20020a0565123e2800b003f53da59009so11447106lfv.16
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 19:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
        b=zpOlsAK66EGL4db6uJoNaBvpVCU7buQpN3RFg2nofp6toZIOJkHqUQTKkWH+Obme0h
         Vnv96K62g2JvWLgXKBK+qcVDcN+t/tEtPtL+YlMKqiRfS6VrJX+WGE0PKogUGHXGwn7N
         bwaAjegeU8NPZuYTYZE3rX+6lvT7ySYe2rR7zJQx8WlOReU2S5bXGmPTj//lnwcuE6s8
         xQxyCAxe9YRT8Db/XeUT5hTbfKeVb7N0dc8jg8lQN5D4ecdObTMys44SsjHSGnPEP4c2
         jLSKe5A0LQA5KNISq7uSWVGAtXKK8DqsPYXEuoMSs1XjJfHmtAvJ57arojY1gMm0XJka
         IIXw==
X-Gm-Message-State: AOAM533Laq9grTsPdOKujUVPGcWlHKj0iCkf5+tnAS+1SBjms/oO0Hp7
        7FBiLqjnR+Zkd3EA91q2cunek5c3exbf3TKl0+J2+c/P0GaXtcoESfCK7mS6oN6hwiqOO9WdutI
        EqK9UP8LF0w6g4BPdM9CsY8ompiKb1+3bek9EJ+k5
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr12508864lfv.481.1633918019931;
        Sun, 10 Oct 2021 19:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz14BTo20ifNpNLBzaLU+yNKHq7V7P/zv03+clH5xHZcu/iFJWoObufgdo9Yiy21rVk+IBUQO3NHQ409rBQPsA=
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr12508845lfv.481.1633918019761;
 Sun, 10 Oct 2021 19:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com> <1632477717-5254-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Oct 2021 10:06:48 +0800
Message-ID: <CACGkMEt8FcoJ4zMXFZzmrFjm=ynWfr5yLfvSHCckawpa3FvhkA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into alloc_iova_fast()
To:     John Garry <john.garry@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        mst <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c            | 8 --------
>  drivers/iommu/iova.c                 | 9 +++++++++
>  drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..a99b3445fef8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -444,14 +444,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>
>         shift = iova_shift(iovad);
>         iova_len = size >> shift;
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>
>         dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>         unsigned long iova_pfn;
>         struct iova *new_iova;
>
> +       /*
> +        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +        * will come back to bite us badly, so we have to waste a bit of space
> +        * rounding up anything cacheable to make sure that can't happen. The
> +        * order of the unadjusted size will still match upon freeing.
> +        */
> +       if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +               size = roundup_pow_of_two(size);
> +
>         iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>         if (iova_pfn)
>                 return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>         unsigned long iova_len = iova_align(iovad, size) >> shift;
>         unsigned long iova_pfn;
>
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>         iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>
>         return iova_pfn << shift;
> --
> 2.26.2
>

