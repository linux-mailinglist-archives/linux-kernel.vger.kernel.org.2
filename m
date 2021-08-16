Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95743ECCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhHPC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhHPC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:59:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6CC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d17so19157116plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJmx8LsBVfoygzSD05ZwIHQxzCJmHnV38QWqOATHelQ=;
        b=UVjsELPlAK1AHNHzU1tOH9RD3UEOCFs/XiDEkQu85qGgQhihCL+7Kps3O0thUqfL/e
         GfiZ/sOyOJ+LVL7/YjWVL5z0LA90PO98DPklo9HOXVhQmM+KYLqWBUgsdC0DIGPg+7Gp
         mMnYwGbGRGTS9BR5Dhey8TkCOg3NmlAaGliRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJmx8LsBVfoygzSD05ZwIHQxzCJmHnV38QWqOATHelQ=;
        b=Zm/dyN0Va8PhAW4AIBybcy4itmMmDKUVKjgSgkvLEiQGa7rRQCWnTsbZF1ovZZXt6L
         yuaQ9A1dUFqpt5xsTlKgyLnS5FjQ52Ksc5XYE8fUb+akdGBZi3T7mj4fq9xIM5NYNBX0
         w4RD+rmZgZmAwohVtP37UVsMZp6On472ic9dpG59vdYIhdQjxkn/clBhwklQK9yPGrIN
         sMhnGDhlgf5T3J2xDqAwL1bP6EupTQKROF9w+b0Lh7V66ghJZJb/bBYRuvlmCOJXs3js
         /wOAuK9bIgk+rEmCMQtQ2nIzWgsfk2donuUSc8jt4WWFZhPdNWzx/D8VLJqgpC/sQjTy
         Ktsw==
X-Gm-Message-State: AOAM5323NItHN3hYVZ2GrLsFIXhxYJsctSU6Q7/zrLWOVizj+taEGczd
        Z0rVIdyOOjy3aUnhoEoEFb4inA==
X-Google-Smtp-Source: ABdhPJwUVs9a4JAM6gHL66U95qsAW2lmlophZEsPwfhMxRcipFC7Q/ovkUqDwjuu70xU9CEV2z6zzg==
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id 189-20020a6205c60000b0290341e0b1a72cmr13967618pff.71.1629082762342;
        Sun, 15 Aug 2021 19:59:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
        by smtp.gmail.com with UTF8SMTPSA id 21sm9195739pfh.103.2021.08.15.19.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 19:59:21 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date:   Mon, 16 Aug 2021 11:57:48 +0900
Message-Id: <20210816025755.2906695-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch set includes various fixes for dma-iommu's swiotlb bounce
buffers for untrusted devices. There are four fixes for correctness
issues, one for a performance issue, and one for general cleanup.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

v4 -> v5:
 - Fix xen build error
 - Move _swiotlb refactor into its own patch

v3 -> v4:
 - Fold _swiotlb functions into _page functions
 - Add patch to align swiotlb buffer to iovad granule
 - Combine if checks in iommu_dma_sync_sg_* functions

v2 -> v3:
 - Add new patch to address min_align_mask bug
 - Set SKIP_CPU_SYNC flag after syncing in map/unmap
 - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (7):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: skip extra sync during unmap w/swiotlb
  dma-iommu: fold _swiotlb helpers into callers
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  swiotlb: support aligned swiotlb buffers
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 193 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 4 files changed, 98 insertions(+), 111 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

