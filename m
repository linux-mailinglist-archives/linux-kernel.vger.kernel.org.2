Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C633F3EE3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhHQBjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhHQBjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:39:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A3C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w14so29337385pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaeVCqVLYGePRZHRPgpZyDyc+9DsWOQG8K5wim8K06M=;
        b=az8HGc8lPGq1zGtlBUJkUyNQT27hlrF90LkVRdo0UIiQJgLiJ6Ny1/2Y8nVoP/1QaN
         LEWf8yGDarQC0dgQJbiekX805OjNYM8A32yK535SnlBVNuRgDXBPo0k9mW9e1q2evHtM
         dFLG/Mxh0ee/DFG3rVBkLdMHTKykJwgvtXaL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaeVCqVLYGePRZHRPgpZyDyc+9DsWOQG8K5wim8K06M=;
        b=Z6fjyAF/d2eeZP2pzJxr2IO7nhOhsodAW06LJTSKAv/kxWfmddNfeurKyrdT3Oz4O6
         61E4OmlxFSTXITzvjsHr+pQrgGy4+23aBR/sZORaXN5oXlxddGZRT1KhIwfVCbp1INug
         9f4bE7yH+gRSDlegNOHllIyutplMSu6eUOY9LrAC7YaKZLjYU4VWxHRzM40Vgv3ymw0L
         RM7i3AacXUjAfXMQsxZRo2OE01WS7fcK9gn7rS/FV6sK6OgIwXQXmbJ0L6SiCFLnKsGF
         BRSBoy6bnTKxrFK/hFc/6mSPLbJPm7/TMNgwQ+cQOP+lMnYDgI8Z7UC+Yvd7SXwqFvPC
         KD9w==
X-Gm-Message-State: AOAM5338f8oQAgpNNGngOeMwH0OZ0Us5yS/I+D/NGXJ43+uCNm+F4o95
        Ts77I/qzfW/Ihyhq9H/PyJV7mw==
X-Google-Smtp-Source: ABdhPJx3pzb8ovk9BInxryDeR1SaMMI6lCp8NNmr4FVx6wgLcXHHX7VG/9xlN4KDklvXGSusqc+EOQ==
X-Received: by 2002:a17:90a:c57:: with SMTP id u23mr908312pje.186.1629164354448;
        Mon, 16 Aug 2021 18:39:14 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id k9sm393131pfu.109.2021.08.16.18.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:13 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date:   Tue, 17 Aug 2021 10:38:45 +0900
Message-Id: <20210817013852.3222824-1-stevensd@google.com>
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
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 191 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 4 files changed, 96 insertions(+), 111 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

