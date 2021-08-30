Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C723FBA92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhH3REZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhH3RET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:04:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76159C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:03:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so427469pjz.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdA/bMO1TKjMxwaqSCpYrAC+Qrvx7KaeUrgZ61bH0AI=;
        b=NkaPHJhOhUnON4YzLbCMrmjcBGNE8Kx6Dx27g177KQF1+orcu4+bch4O3TkjXb+yeb
         BDjolpoeMriVKP2IRktfpkN5PeA8Lxw/OKfZYXgBK3gqKxhuGR7YlKNx2L+doM2pbuRK
         r4ayl67mqZRqreItUYw3isqIB90q+vqfI5tLRsWfCl4P2CMJs/bwCchZrb5VgluI9oDm
         A42es9ILdquC8fDumvjUVp4l1DGdAbTdwcTmVn2T4TKKMUo4tykL8yKNYYlAN8XcFmKe
         MN/RaEJzq4QEu204gjgGZs3NdgHIRoLSJA9KcOUg+/FiEKVl/iocNR2UhGL4i33Lrn32
         H3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdA/bMO1TKjMxwaqSCpYrAC+Qrvx7KaeUrgZ61bH0AI=;
        b=Jx4YwjkRFlhDmWPacn/EgUqkvX7y1CZf7uJRAtjxF/DJhRs+l3v+IIFbyrlDzvRgb4
         UHowvtuapeJFmbB5zN5EwCpxteyfkPVILQp1Az/4ipjMmTGytg6w0LMGz/eZfQz/TY6J
         AJ7pYL1DTah+CaB+oPJ95aSt8jDeOT+nu4jk8T/WL0jQQI2P4c6e9eewUzww9V0/z2h3
         z1YKoTEp2MHmf4nLbUnC+MAvPjpJhxzm0Z4VfdozGad6aWa7qODz4en11Qzf1+qZnLP+
         GjWiRneGvZ0DJBsdNkW6ARK3dCRt73+E+o0clEyEaCL12XZ/qHdX25eYGJXdZUyeE6xP
         Tybg==
X-Gm-Message-State: AOAM533YxYf9Rwpwe56GinPlrM8GC5rwrcmEsylM1Rv4mgiFMCk9MdoM
        GHfRUtTYefIjuCF4eKGjLlvd9sCPQl2mfVg524Ikyg==
X-Google-Smtp-Source: ABdhPJwILxnYbPA2sbKq3/p/rSKRJ32HoC74NyeaIzgS8HVajDYodqL/vxmPLBtO+c94XKeEqy7zKaMIB1IFUZUDDzg=
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr85790pjf.86.1630343004689;
 Mon, 30 Aug 2021 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210830045925.4163412-1-stevensd@google.com>
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 30 Aug 2021 10:02:48 -0700
Message-ID: <CACK8Z6G=O4cewAmNPfG9rpu2JTQ6T6ukE6QZ3BU0BTu7_KAqfA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Fixes for dma-iommu swiotlb bounce buffers
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering why I don't see v7 on these patches on patchwork (these
patches on https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=27643&state=&q=&archive=&delegate=)
?

On Sun, Aug 29, 2021 at 10:00 PM David Stevens <stevensd@chromium.org> wrote:
>
> This patch set includes various fixes for dma-iommu's swiotlb bounce
> buffers for untrusted devices.
>
> The min_align_mask issue was found when running fio on an untrusted nvme
> device with bs=512. The other issues were found via code inspection, so
> I don't have any specific use cases where things were not working, nor
> any concrete performance numbers.
>
> There are two issues related to min_align_mask that this patch series
> does not attempt to fix. First, it does not address the case where
> min_align_mask is larger than the IOVA granule. Doing so requires
> changes to IOVA allocation, and is not specific to when swiotlb bounce
> buffers are used. This is not a problem in practice today, since the
> only driver which uses min_align_mask is nvme, which sets it to 4096.
>
> The second issue this series does not address is the fact that extra
> swiotlb slots adjacent to a bounce buffer can be exposed to untrusted
> devices whose drivers use min_align_mask. Fixing this requires being
> able to allocate padding slots at the beginning of a swiotlb allocation.
> This is a rather significant change that I am not comfortable making.
> Without being able to handle this, there is also little point to
> clearing the padding at the start of such a buffer, since we can only
> clear based on (IO_TLB_SIZE - 1) instead of iova_mask.
>
> v6 -> v7:
>  - Remove unsafe attempt to clear padding at start of swiotlb buffer
>  - Rewrite commit message for min_align_mask commit to better explain
>    the problem it's fixing
>  - Rebase on iommu/core
>  - Acknowledge unsolved issues in cover letter
>
> v5 -> v6:
>  - Remove unnecessary line break
>  - Remove redundant config check
>
> v4 -> v5:
>  - Fix xen build error
>  - Move _swiotlb refactor into its own patch
>
> v3 -> v4:
>  - Fold _swiotlb functions into _page functions
>  - Add patch to align swiotlb buffer to iovad granule
>  - Combine if checks in iommu_dma_sync_sg_* functions
>
> v2 -> v3:
>  - Add new patch to address min_align_mask bug
>  - Set SKIP_CPU_SYNC flag after syncing in map/unmap
>  - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu
>
> v1 -> v2:
>  - Split fixes into dedicated patches
>  - Less invasive changes to fix arch_sync when mapping
>  - Leave dev_is_untrusted check for strict iommu
>
> David Stevens (7):
>   dma-iommu: fix sync_sg with swiotlb
>   dma-iommu: fix arch_sync_dma for map
>   dma-iommu: skip extra sync during unmap w/swiotlb
>   dma-iommu: fold _swiotlb helpers into callers
>   dma-iommu: Check CONFIG_SWIOTLB more broadly
>   swiotlb: support aligned swiotlb buffers
>   dma-iommu: account for min_align_mask w/swiotlb
>
>  drivers/iommu/dma-iommu.c | 188 +++++++++++++++++---------------------
>  drivers/xen/swiotlb-xen.c |   2 +-
>  include/linux/swiotlb.h   |   3 +-
>  kernel/dma/swiotlb.c      |  11 ++-
>  4 files changed, 93 insertions(+), 111 deletions(-)
>
> --
> 2.33.0.259.gc128427fd7-goog
>
