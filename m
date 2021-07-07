Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C124E3BE403
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGGH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhGGH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:58:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FF4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:55:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fs7so1056765pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjKXBl1vkDCm5R1vUHFUBvPB60cGM9WwHmcZqOYFaT4=;
        b=OayDt65iTOThBSFcmD4oh4oPzMyU404O/oIJtWEBk2BRjGNINk4/xDEsCAFAZTe6JJ
         1II9FjTUeBHaGfRKcT5MKHRNfQrtmmyw+dcZhHo9t03MhaIKFlUSLvLuR88OeTzxnPZg
         j8I+hEoAqxDeJ11bruOBthi4wmvWdsdu1lo34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjKXBl1vkDCm5R1vUHFUBvPB60cGM9WwHmcZqOYFaT4=;
        b=SgzcStbzgM4ozCIEGS4RGtpcxCWJRYlJZWkwj+lbBuGmQGz1MoZPY7zIzPkR7Mv7tV
         p8fHoQWW7btgjnGME/rI1eH3h2EA/6cuthD0Eby0ZLZLvPggXINxvrpxikyiCXYyEvSb
         ykiBPwDSzMujQ6cLD9sowwmxVuA81o/MbkQQE8LED85T9g0ElTpcLo9+yLsUWG3l19T1
         9SqCYI190xRboE1Qadnsgaln8zL9frQzPKvJ+R5pGLnoypqT015L/2j1ijaVttt4wErl
         l2Sb8e6tc4qQXCW8iUnmueBCpKBVAWB/pmi7VR2jP7TeRybttaG7i5iM0zokzgZhRQvA
         /KTQ==
X-Gm-Message-State: AOAM532Y92WEN7Y1ldVaavszUV5ZtSeZJbEPh7uGQ5KKPmX34WPIeEQS
        RcFvYm7070UmJlYM6VJYLTpFBA==
X-Google-Smtp-Source: ABdhPJy3lVBNCERAeNgH2dhv8lEGILoM8Wd2ReiG54LDKIxUvl1Yjm1vVuRmJjpNHq8Lw0hE9S41MA==
X-Received: by 2002:a17:902:db0d:b029:127:98e9:c279 with SMTP id m13-20020a170902db0db029012798e9c279mr20295192plx.0.1625644526545;
        Wed, 07 Jul 2021 00:55:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
        by smtp.gmail.com with UTF8SMTPSA id t13sm2035196pjq.14.2021.07.07.00.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:55:25 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>
Subject: [PATCH 0/4] Add dynamic iommu backed bounce buffers
Date:   Wed,  7 Jul 2021 16:55:01 +0900
Message-Id: <20210707075505.2896824-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for per-domain dynamic pools of iommu bounce buffers to the 
dma-iommu API. This allows iommu mappings to be reused while still
maintaining strict iommu protection. Allocating buffers dynamically
instead of using swiotlb carveouts makes per-domain pools more amenable
on systems with large numbers of devices or where devices are unknown.

When enabled, all non-direct streaming mappings below a configurable
size will go through bounce buffers. Note that this means drivers which
don't properly use the DMA API (e.g. i915) cannot use an iommu when this
feature is enabled. However, all drivers which work with swiotlb=force
should work.

Bounce buffers serve as an optimization in situations where interactions
with the iommu are very costly. For example, virtio-iommu operations in
a guest on a linux host require a vmexit, involvement the VMM, and a
VFIO syscall. For relatively small DMA operations, memcpy can be
significantly faster.

As a performance comparison, on a device with an i5-10210U, I ran fio
with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
--ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
by >99%, as bounce buffers don't require syncing here in the read case.
Running with multiple jobs doesn't serve as a useful performance
comparison because virtio-iommu and vfio_iommu_type1 both have big
locks that significantly limit mulithreaded DMA performance.

This patch set is based on v5.13-rc7 plus the patches at [1].

David Stevens (4):
  dma-iommu: add kalloc gfp flag to alloc helper
  dma-iommu: replace device arguments
  dma-iommu: expose a few helper functions to module
  dma-iommu: Add iommu bounce buffers to dma-iommu api

 drivers/iommu/Kconfig          |  10 +
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/dma-iommu.c      | 119 ++++--
 drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
 drivers/iommu/io-buffer-pool.h |  91 +++++
 include/linux/dma-iommu.h      |  12 +
 6 files changed, 861 insertions(+), 28 deletions(-)
 create mode 100644 drivers/iommu/io-buffer-pool.c
 create mode 100644 drivers/iommu/io-buffer-pool.h

-- 
2.32.0.93.g670b81a890-goog

