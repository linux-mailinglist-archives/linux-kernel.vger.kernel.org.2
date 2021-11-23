Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C445A4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhKWOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:14:00 -0500
Received: from foss.arm.com ([217.140.110.172]:53482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237440AbhKWON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:13:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AEBC1042;
        Tue, 23 Nov 2021 06:10:49 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49B553F66F;
        Tue, 23 Nov 2021 06:10:48 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com
Subject: [PATCH 0/9] iommu: Refactor flush queues into iommu-dma
Date:   Tue, 23 Nov 2021 14:10:35 +0000
Message-Id: <cover.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As promised, this series cleans up the flush queue code and streamlines
it directly into iommu-dma. Since we no longer have per-driver DMA ops
implementations, a lot of the abstraction is now no longer necessary, so
there's a nice degree of simplification in the process. Un-abstracting
the queued page freeing mechanism is also the perfect opportunity to
revise which struct page fields we use so we can be better-behaved
from the MM point of view, thanks to Matthew.

These changes should also make it viable to start using the gather
freelist in io-pgtable-arm, and eliminate some more synchronous
invalidations from the normal flow there, but that is proving to need a
bit more careful thought than I have time for in this cycle, so I've
parked that again for now and will revisit it in the new year.

For convenience, branch at:
  https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/iova

I've build-tested for x86_64, and boot-tested arm64 to the point of
confirming that put_pages_list() gets passed a valid empty list when
flushing, while everything else still works.

Cheers,
Robin.


Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (7):
  gpu: host1x: Add missing DMA API include
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

 drivers/gpu/host1x/bus.c       |   1 +
 drivers/iommu/amd/io_pgtable.c | 116 ++++++--------
 drivers/iommu/dma-iommu.c      | 266 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 -------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 7 files changed, 295 insertions(+), 449 deletions(-)

-- 
2.28.0.dirty

