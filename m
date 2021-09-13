Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1021440865C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhIMIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhIMIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:23:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:22:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y16so18822799ybm.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA5SjJKuJahGLX31luP7D8mzJxDC+SO2vk0Mq3zJOdo=;
        b=AoG98t+mNqkfbrBywtW3MJma5qtkX/dgD6g7VOb+c5S1n0FjUnL6yOa9luwzbDC0MB
         NnE4WQDAKNb7Je59De5Z5Z9iZwATFiDUbv4xqPOuTLfNgLnIZEiJWmT2uFI8AESauw1f
         PMZNUSu1450/2jJTr/yR85ZtWx7ev71h29DEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA5SjJKuJahGLX31luP7D8mzJxDC+SO2vk0Mq3zJOdo=;
        b=hwDThg5v09ik6JlsvwSAJQOvhFS7lkUK7D1h4JTws8ikV3NLXFxO/FZfS1vcTIsXVS
         e8ESTY8YOIK3kIqgXLgQEdJreq9Iun+PpABdNN8so5Pkw0x4MyzFFpRPbkdCf9q7Noe/
         5XYVh2zqzWSuhaBn6khR+vksmkp/3Iolq3RENDc8B5Ot0l76A40jwCUxgB97YLAWlVcI
         nF+ffVC6cEmamu6F6pqs/J7hwHLn0XpH89xlykqgF2NUKoT5oUyqV67VAqIADo1aWDj5
         le0+UqRkPKFFs7Jf+OYSvB/PAikTc6HDdgA6om3szG8pIBrlPCwgNnyQlRjF2Xtu/hHb
         0MtQ==
X-Gm-Message-State: AOAM532srWrBydWQLl+qY82xcEJaGWJrV7Gpv+hns5xE3FpyDsLqIkaG
        ZlL1YRov9T/uzVXiGc3Jm6sp5CAMOHRs8DYEn0JP1rLfiUw=
X-Google-Smtp-Source: ABdhPJyoIJv0HVf8WwdAxbVU4oGBg51HU76Y7j3Y3KgW0hMXTKS5AxkYn5ltcrEHX348TDlPO+2cPincRl0pRPxOhOo=
X-Received: by 2002:a25:a522:: with SMTP id h31mr14948997ybi.355.1631521320765;
 Mon, 13 Sep 2021 01:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210830045925.4163412-1-stevensd@google.com>
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 13 Sep 2021 17:21:49 +0900
Message-ID: <CAD=HUj5xXci8YX90H8zqY-aY5u_EJ8c8ZMoiMT2QXHz52oMy=w@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Fixes for dma-iommu swiotlb bounce buffers
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there further feedback on these patches? Only patch 7 is still
pending review.

-David

On Mon, Aug 30, 2021 at 2:00 PM David Stevens <stevensd@chromium.org> wrote:
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
