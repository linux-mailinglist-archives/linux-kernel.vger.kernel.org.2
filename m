Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31A3FD8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbhIALdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhIALdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:33:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46892C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xETUREejxUvl6a5dRIWIEFCqvkaaKABc39aXkgvr63Y=; b=vH2+/GPZVX8/y6zvjy1vfT0Qsy
        YX6og6+N2IaYDZu9VDj6T0IrRyQlhlZA95q/RukfN61MZQt4PnjkceBpr0kp5JLiqZiutI3eBaNzu
        sBlqrZPTwixSJOHB/6Yl89ySc95fqbCyNmaWkwKvgOEq53RexF3IiZZKtgKp/6TkM8qsfBr5xeInS
        o23ig7kSE1Xkrvy7wvHoQyCPO/o4u3Z+VntxIIv8NfqZa6vJRxLwapkIaQbEfsLhGtvbumg3IoUmp
        ZTglGsu9O4Iysh3Z76zNx9aVXKJhwJ9KamQLkiBc/JZLePzDa3Is8b+vBrVDrRR4GYFlM+rv3zuut
        e7DEksvw==;
Received: from [2001:4bb8:180:a30:2deb:705a:5588:bf7d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLOSp-002Eq0-9Q; Wed, 01 Sep 2021 11:31:48 +0000
Date:   Wed, 1 Sep 2021 13:31:30 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.15
Message-ID: <YS9kkqNhU0TPA9Fr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note that there is a conflict with changes from the swiotlb tree due
 dma_direct_{alloc,free}.  The solution is to basically take the changes
 from both trees and apply them manually.]

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15

for you to fetch changes up to c1dec343d7abdf8e71aab2a289ab45ce8b1afb7e:

  hexagon: use the generic global coherent pool (2021-08-19 09:02:40 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.15

 - fix debugfs initialization order (Anthony Iliopoulos)
 - use memory_intersects() directly (Kefeng Wang)
 - allow to return specific errors from ->map_sg
   (Logan Gunthorpe, Martin Oliveira)
 - turn the dma_map_sg return value into an unsigned int (me)
 - provide a common global coherent pool іmplementation (me)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      dma-debug: fix debugfs initialization order

Christoph Hellwig (8):
      dma-mapping: return an unsigned int from dma_map_sg{,_attrs}
      dma-direct: add support for dma_coherent_default_memory
      ARM/nommu: use the generic dma-direct code for non-coherent devices
      dma-mapping: allow using the global coherent pool for !ARM
      dma-mapping: simplify dma_init_coherent_memory
      dma-mapping: add a dma_init_global_coherent helper
      dma-mapping: make the global coherent pool conditional
      hexagon: use the generic global coherent pool

Kefeng Wang (1):
      dma-debug: use memory_intersects() directly

Logan Gunthorpe (10):
      dma-mapping: allow map_sg() ops to return negative error codes
      dma-direct: return appropriate error code from dma_direct_map_sg()
      iommu: return full error code from iommu_map_sg[_atomic]()
      iommu/dma: return error code from iommu_dma_map_sg()
      ARM/dma-mapping: don't set failed sg dma_address to DMA_MAPPING_ERROR
      powerpc/iommu: don't set failed sg dma_address to DMA_MAPPING_ERROR
      s390/pci: don't set failed sg dma_address to DMA_MAPPING_ERROR
      sparc/iommu: don't set failed sg dma_address to DMA_MAPPING_ERROR
      x86/amd_gart: don't set failed sg dma_address to DMA_MAPPING_ERROR
      dma-mapping: disallow .map_sg operations from returning zero on error

Martin Oliveira (11):
      alpha: return error code from alpha_pci_map_sg()
      ARM/dma-mapping: return error code from .map_sg() ops
      ia64/sba_iommu: return error code from sba_map_sg_attrs()
      MIPS/jazzdma: return error code from jazz_dma_map_sg()
      powerpc/iommu: return error code from .map_sg() ops
      s390/pci: return error code from s390_dma_map_sg()
      sparc/iommu: return error codes from .map_sg() ops
      parisc: return error code from .map_sg() ops
      xen: swiotlb: return error code from xen_swiotlb_map_sg()
      x86/amd_gart: return error code from gart_map_sg()
      dma-mapping: return error code from dma_dummy_map_sg()

 arch/alpha/kernel/pci_iommu.c           |  10 +-
 arch/arm/Kconfig                        |   5 +-
 arch/arm/mm/dma-mapping-nommu.c         | 173 ++------------------------------
 arch/arm/mm/dma-mapping.c               |  26 +++--
 arch/hexagon/Kconfig                    |   1 +
 arch/hexagon/kernel/dma.c               |  57 ++---------
 arch/ia64/hp/common/sba_iommu.c         |   4 +-
 arch/mips/jazz/jazzdma.c                |   2 +-
 arch/powerpc/kernel/iommu.c             |   6 +-
 arch/powerpc/platforms/ps3/system-bus.c |   2 +-
 arch/powerpc/platforms/pseries/vio.c    |   5 +-
 arch/s390/pci/pci_dma.c                 |  13 +--
 arch/sparc/kernel/iommu.c               |   6 +-
 arch/sparc/kernel/pci_sun4v.c           |   6 +-
 arch/sparc/mm/iommu.c                   |   2 +-
 arch/x86/kernel/amd_gart_64.c           |  18 ++--
 drivers/iommu/dma-iommu.c               |  22 ++--
 drivers/iommu/iommu.c                   |  15 ++-
 drivers/parisc/ccio-dma.c               |   2 +-
 drivers/parisc/sba_iommu.c              |   2 +-
 drivers/xen/swiotlb-xen.c               |   2 +-
 include/linux/dma-map-ops.h             |  23 +++--
 include/linux/dma-mapping.h             |  44 +++-----
 include/linux/iommu.h                   |  22 ++--
 kernel/dma/Kconfig                      |   4 +
 kernel/dma/coherent.c                   | 161 ++++++++++++++---------------
 kernel/dma/debug.c                      |  21 ++--
 kernel/dma/direct.c                     |  17 +++-
 kernel/dma/dummy.c                      |   2 +-
 kernel/dma/mapping.c                    |  80 +++++++++++++--
 30 files changed, 310 insertions(+), 443 deletions(-)
