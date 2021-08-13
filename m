Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D993EB1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhHMHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbhHMHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:43:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD0C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so19514014pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPsloz8dMJKQVghkZv9dWfHyOqdGc988vzlcGdOMiqs=;
        b=KLm6BU9Ld81zJP8v5wM43vhpaGeoR18x2sjWQKj6pS59bD+DnZpkv0NiHsY+D9t07C
         dRtIHNZpfka/ocJnIU9bqQwJ2/E+YoeQOgCavCt2eAZEu0MAmw6iKrCRqNxUU9v/iuem
         lWeRNYnqJz7xxC9TnA0OuTtDB+csJZF3sLQkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPsloz8dMJKQVghkZv9dWfHyOqdGc988vzlcGdOMiqs=;
        b=ELeQuNlUQB5VFV19k3tOI5RSAjKv6H6dbP2fdmPtJv4N1+BUjtl1O03VvduT1d26bF
         18d8M2jQ2eyx0FCMl6uGHgdeJE3M3qndyuFBGt1aOcLo0pymGtiFFj37SJlVnS3RRAp6
         3EPJxY/2v5hrRm8VET7vSHWYDJEHvJOg2HR7RMaiJx5hjTl9OKQSrWJ4OY7JPhZj10rU
         8+tBTw7A59IiiKeDrnX0hrbbd+t4mQxyllDsY1EoX9owZebJZXQqHRM9TrN2FyD9Fa+n
         yyFCK2I8I6x/xwCmPkgtGObldgDsCAM0gwrBqMHeKogwYbigI20ZLKR0HqEjc6HSydFy
         v7WQ==
X-Gm-Message-State: AOAM530DoDtRrkJJaA04G6H9t7bJ27yWpoiKmsX0ME4U5aieeB9ku6Ck
        tdFlImoJ4saXdgk4UQHvXSa51Q==
X-Google-Smtp-Source: ABdhPJzvmeADMrhG+LrPTQFy9EJDVmpdV2ijzdrQsWjP6jQVJIYcsouAqv40voGkNSNsJcOpsg9WZA==
X-Received: by 2002:aa7:973a:0:b029:3e0:9744:6460 with SMTP id k26-20020aa7973a0000b02903e097446460mr1168689pfg.63.1628840553663;
        Fri, 13 Aug 2021 00:42:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
        by smtp.gmail.com with UTF8SMTPSA id q29sm1183232pfl.142.2021.08.13.00.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:42:33 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 0/6] Fixes for dma-iommu swiotlb bounce buffers
Date:   Fri, 13 Aug 2021 16:38:33 +0900
Message-Id: <20210813073839.1562438-1-stevensd@google.com>
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

David Stevens (6):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: skip extra sync during unmap w/swiotlb
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  swiotlb: support aligned swiotlb buffers
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 193 +++++++++++++++++---------------------
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 3 files changed, 97 insertions(+), 110 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

