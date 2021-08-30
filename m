Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9706C3FB0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhH3FBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhH3FBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDAC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s29so6395851pfw.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5yp+iEsNoKP4WGqkNPHHksJ0ymICBTMw/Qbzp/3nIQ=;
        b=dtgCN1gMrCH1MM5IFYsxPex7XkoqcAkCNgbuhjJ8CXOkg5ZoUVoCt10oIS8Sq7+gu4
         5UBMaON9sRCC3NISL1ZbdbC8NfhrhL/be56VTemR9VthyPx1OI1SCSuTSpGO9tWiCvN8
         WMTC/coebK+x3gDB4Cs9ngJA6FHLbv30Zvi5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5yp+iEsNoKP4WGqkNPHHksJ0ymICBTMw/Qbzp/3nIQ=;
        b=YBc9FF5MZFt89k07dNHGDwWXhCgC6wS5ZzWmApNBURTL0G4MJ5upndglGX7JJarGki
         unbLV+1RtCBln1UEM5MHufNaIigLxFD89cCzaTcMev5MyVjQbSN5Xr93NAPgrSSipTx6
         OsoCuhU+P0xttkVGxiyU1cyu3OwcVbLYcO07u0v+1jPLTPysbpXoU1B+k3MtF35Y3NCA
         lZ2IT/WWDqcgX52439orB2zdi+HzL6Bdkw5lILUTztPDlJMMLAD/GIh0ryQCNgOOlJb2
         JuiZjaRhdCTE3SZzl/gRBQbwGxBvhicxUb4PhqtRrJ8tnzoSpk5GzSWBr9T5Yfc9dsAb
         DyUg==
X-Gm-Message-State: AOAM533uzzeNzazNUk1H1I98HsjzYCbBS5SI8WXvAlbk22Qe3HEWEmyw
        3BVQO1cTzX7KhijflXMQCDLzovQ4/4TQIQ==
X-Google-Smtp-Source: ABdhPJyrbVmHeKY73nJb+cpXt0NyxJ9t9575dqYGO8C91QNfxde7wOce/4GCWNwPKyNvfVhN2ikv/w==
X-Received: by 2002:a63:e756:: with SMTP id j22mr19773617pgk.362.1630299610786;
        Sun, 29 Aug 2021 22:00:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id t15sm15410999pgi.80.2021.08.29.22.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:10 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>
Subject: [PATCH v7 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date:   Mon, 30 Aug 2021 13:59:18 +0900
Message-Id: <20210830045925.4163412-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 kernel/dma/swiotlb.c      |  11 ++-
 4 files changed, 93 insertions(+), 111 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

