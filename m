Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88433E28A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbhHFKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245087AbhHFKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:35:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A9C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:34:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i10so6505737pla.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMrPPo91HyMQwIaJQSJYadUdAwVrHzNjmHLMXlRF+Bo=;
        b=POgz3HkCvc0xiYJXKRLuuquKaKr4AK4NaUc58zgE4tAwZMOnaWWWqWetaQQTA00s9V
         AbR+z+svqz0+NhG5LVEOZZtOLmSVigk5va0kmB5u/MdBK34ZYbyxXVHjTBEoyGGNfZEM
         K37dY/T1eTB7LUAyLEx5Ra2yBWZiP1+CuL3Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMrPPo91HyMQwIaJQSJYadUdAwVrHzNjmHLMXlRF+Bo=;
        b=buQaexD0kgNBi6wqz7LrgjUY+sVrt5S+NSzG7E015KnEhp7azOD1hOSU8lmwwU3YD4
         YeGaQzsxR/CkX9ELlgYEor7v4nKzyjjNHnn6drzIivsz4XrNOCySFVz+BI1gjX7GT3GQ
         rxdTmq0hvgbFeLQNBTbHb78eWy5WXH8FXt7X8Rml+mdCCgYW3kF68bQfSHlODli6OsRm
         kgVRxLgr/OrX5OIIztYvOC3t+p9mxY5XxEdrqH39bLdE+daYCIivvPPROkDYCbi+jNVe
         viI00p4uNaaHpulc+uRqYFuSD7oYmhBUun+hi3ACvvZ4mJHl1QlofAei7l5MQSXFf5kc
         QBBg==
X-Gm-Message-State: AOAM532oJrLBgzhxhYc0FqbNifEufdAL67qG32dwEVoWfuCUSXt4eZCJ
        zcl3kC0UTOZN1t7+nJdvJC0Vsg==
X-Google-Smtp-Source: ABdhPJy1+CeG1BgNQVLMHfOJrhbRkRnOHTwoQlo77pN2h7no05bbZjWu74Vlx51Wf6KiBfv/clhfxg==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr20501328pjg.75.1628246095479;
        Fri, 06 Aug 2021 03:34:55 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
        by smtp.gmail.com with UTF8SMTPSA id n35sm11457314pgb.90.2021.08.06.03.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:34:55 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 0/9] Add dynamic iommu backed bounce buffers
Date:   Fri,  6 Aug 2021 19:34:14 +0900
Message-Id: <20210806103423.3341285-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch series adds support for per-domain dynamic pools of iommu
bounce buffers to the dma-iommu API. This allows iommu mappings to be
reused while still maintaining strict iommu protection.

This bounce buffer support is used to add a new config option that, when
enabled, causes all non-direct streaming mappings below a configurable
size to go through the bounce buffers. This serves as an optimization on
systems where manipulating iommu mappings is very expensive. For
example, virtio-iommu operations in a guest on a linux host require a
vmexit, involvement the VMM, and a VFIO syscall. For relatively small
DMA operations, memcpy can be significantly faster.

As a performance comparison, on a device with an i5-10210U, I ran fio
with a VFIO passthrough NVMe drive and virtio-iommu with '--direct=1
--rw=read --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k,
and 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
by >99%, as bounce buffers don't require syncing here in the read case.
Running with multiple jobs doesn't serve as a useful performance
comparison because virtio-iommu and vfio_iommu_type1 both have big
locks that significantly limit mulithreaded DMA performance.

These pooled bounce buffers are also used for subgranule mappings with
untrusted devices, replacing the single use bounce buffers used
currently. The biggest difference here is that the new implementation
maps a whole sglist using a single bounce buffer. The new implementation
does not support using bounce buffers for only some segments of the
sglist, so it may require more copying. However, the current
implementation requires per-segment iommu map/unmap operations for all
untrusted sglist mappings (fully aligned sglists included). On a 
i5-10210U laptop with the internal NVMe drive made to appear untrusted,
fio --direct=1 --rw=read --ioengine=libaio --iodepth=64 --bs=64k showed
a statistically significant decrease in CPU load from 2.28% -> 2.17%
with the new iommu bounce buffer optimization enabled.

Each domain's buffer pool is split into multiple power-of-2 size
classes. Each class allocates a fixed number of buffer slot metadata. A
large iova range is allocated, and each slot is assigned an iova from
the range. This allows the iova to be easily mapped back to the slot,
and allows the critical section of most pool operations to be constant
time. The one exception is finding a cached buffer to reuse. These are
only separated according to R/W permissions - the use of other
permissions such as IOMMU_PRIV may require a linear search through the
cache. However, these other permissions are rare and likely exhibit high
locality, so the should not be a bottleneck in practice.

Since untrusted devices may require bounce buffers, each domain has a
fallback rbtree to manage single use buffers. This may be necessary if a
very large number of DMA operations are simultaneously in-flight, or for
very large individual DMA operations.

This patch set does not use swiotlb. There are two primary ways in which
swiotlb isn't compatible with per-domain buffer pools. First, swiotlb
allocates buffers to be compatible with a single device, whereas
per-domain buffer pools don't handle that during buffer allocation as a
single buffer may end up being used by multiple devices. Second, swiotlb
allocation establishes the original to bounce buffer mapping, which
again doesn't work if buffers can be reused. Effectively the only code
that can be shared between the two use cases is allocating slots from
the swiotlb's memory. However, given that we're going to be allocating
memory for use with an iommu, allocating memory from a block of memory
explicitly set aside to deal with a lack of iommu seems kind of
contradictory. At best there might be a small performance improvement if 
wiotlb allocation is faster than regular page allocation, but buffer
allocation isn't on the hot path anyway.

Not using the swiotlb has the benefit that memory doesn't have to be
preallocated. Instead, bounce buffers consume memory only for in-flight
dma transactions (ignoring temporarily cached buffers), which is the
smallest amount possible. This makes it easier to use bounce buffers as
an optimization on systems with large numbers of devices or in
situations where devices are unknown, since it is not necessary to try
to tune how much memory needs to be set aside to achieve good
performance without costing too much memory.

Finally, this series adds a new DMA_ATTR_PERSISTENT_STREAMING flag. This
is meant to address devices which create long lived streaming mappings
but manage CPU cache coherency without using the dma_sync_* APIs.
Currently, these devices don't function properly with swiotlb=force. The
new flag is used to bypass bounce buffers so such devices will function
when the new bounce buffer optimization is enabled. The flag is added to
the i915 driver, which creates such mappings. It can also be added to
various dma-buf implementations as an optimization, although that is not
done here.

v1 -> v2:
 - Replace existing untrusted bounce buffers with new bounce
   buffer pools. This includes significant rework to account for
   untrusted bounce buffers being required instead of an
   optimization.
 - Add flag for persistent streaming mappings.

David Stevens (9):
  Revert "iommu: Allow the dma-iommu api to use bounce buffers"
  dma-iommu: expose a few helper functions to module
  dma-iommu: bounce buffers for untrusted devices
  dma-iommu: remove extra buffer search on unmap
  dma-iommu: clear only necessary bytes
  dma-iommu: add bounce buffer pools
  dma-iommu: support iommu bounce buffer optimization
  dma-mapping: add persistent streaming mapping flag
  drm/i915: use DMA_ATTR_PERSISTENT_STREAMING flag

 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |   4 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c        |   3 +-
 drivers/iommu/Kconfig                      |  11 +
 drivers/iommu/Makefile                     |   2 +-
 drivers/iommu/dma-iommu.c                  | 268 ++++-----
 drivers/iommu/io-bounce-buffers.c          | 533 +++++++++++++++++
 drivers/iommu/io-bounce-buffers.h          |  49 ++
 drivers/iommu/io-buffer-manager.c          | 633 +++++++++++++++++++++
 drivers/iommu/io-buffer-manager.h          |  94 +++
 include/linux/dma-iommu.h                  |  12 +
 include/linux/dma-mapping.h                |  11 +
 11 files changed, 1460 insertions(+), 160 deletions(-)
 create mode 100644 drivers/iommu/io-bounce-buffers.c
 create mode 100644 drivers/iommu/io-bounce-buffers.h
 create mode 100644 drivers/iommu/io-buffer-manager.c
 create mode 100644 drivers/iommu/io-buffer-manager.h

-- 
2.32.0.605.g8dce9f2422-goog

