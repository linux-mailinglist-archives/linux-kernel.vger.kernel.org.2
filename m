Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417241BCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhI2Cev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhI2Ceu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:34:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so3133182pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4D2m3+ZWSpbOoxTyd7Cgfd8aoV6x9f5QnXTQ4XHoJU=;
        b=mjb1HkkFEo/4kXpzKswwKo7ybpmTiqaMC1SZPvRXfskBLUGEYTTfVY8P/C3LAuJHi+
         ffXrSo/WgWYrdjlAf7i8QaoHE3qh6iNB2SfXImYtOOJDvRp+6XoErY67hPQWnn8erK+K
         QBUWG0efPgEgJhtXYBUzHZwwNfjKky5oP4Lis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4D2m3+ZWSpbOoxTyd7Cgfd8aoV6x9f5QnXTQ4XHoJU=;
        b=GisOSk1OYDVpDC1Kmia5Bl1DibeS1LkoycTFrpg6SRQCXP9vSkkV7IxcPCtSzg5VPU
         nI9nXOVaR1bH8zkPKLICaJq/boEWkNB/aY0UG30duRpfS91Txu3IszHqXseR4uFKbDQR
         3KWbc4hxv+YV/FIMdvxEcozY6ll+HjxLYd0bCcIoxczPFe1r8WKj1DxRpwgPNciagpWA
         7bN6WCpYpsPZYmwzkjtjB5gGLr5gbIvTFqn8xEU0PaZ0mlETSH1DCzAaA+iah3XqAeqB
         szyYpJ39zIRP++8wmLkIz2sVUXZrPtrF7AuCRGvZwDqIWHnW898sKKDuPfRoKhg4FKDY
         8JOw==
X-Gm-Message-State: AOAM53332g+7Wd8WhLe+Sjm3cZiLeR9bON6rRFIBJPQL9MvTJ5CvUWrY
        6T4CTe52SaXsD1ziCp1JwP2zvA==
X-Google-Smtp-Source: ABdhPJy/Xl7WpMkqbfI/8pobwf4sSQzGXJOOhZ9x/QA095lKKz/1QLB7sdtXt7FXoTcHkHNu+Vqwjg==
X-Received: by 2002:a17:90a:1b67:: with SMTP id q94mr3664963pjq.246.1632882790135;
        Tue, 28 Sep 2021 19:33:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id w142sm407779pfc.47.2021.09.28.19.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:09 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date:   Wed, 29 Sep 2021 11:32:53 +0900
Message-Id: <20210929023300.335969-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch set includes various fixes for dma-iommu's swiotlb bounce
buffers for untrusted devices.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

There are two issues related to min_align_mask that this patch series
does not attempt to fix. First, it does not address the case where
min_align_mask is larger than the IOVA granule. Doing so requires
changes to IOVA allocation, and is not specific to when swiotlb bounce
buffers are used. This is not a problem in practice today, since the
only driver which uses min_align_mask is nvme, which sets it to 4096.

The second issue this series does not address is the fact that extra
swiotlb slots adjacent to a bounce buffer can be exposed to untrusted
devices whose drivers use min_align_mask. Fixing this requires being
able to allocate padding slots at the beginning of a swiotlb allocation.
This is a rather significant change that I am not comfortable making.
Without being able to handle this, there is also little point to
clearing the padding at the start of such a buffer, since we can only
clear based on (IO_TLB_SIZE - 1) instead of iova_mask.

v7 -> v8:
 - Rebase on v5.15-rc3 and resolve conflicts with restricted dma

v6 -> v7:
 - Remove unsafe attempt to clear padding at start of swiotlb buffer
 - Rewrite commit message for min_align_mask commit to better explain
   the problem it's fixing
 - Rebase on iommu/core
 - Acknowledge unsolved issues in cover letter

v5 -> v6:
 - Remove unnecessary line break
 - Remove redundant config check

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
  dma-iommu: account for min_align_mask w/swiotlb

 drivers/iommu/dma-iommu.c | 188 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  13 ++-
 4 files changed, 94 insertions(+), 112 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

