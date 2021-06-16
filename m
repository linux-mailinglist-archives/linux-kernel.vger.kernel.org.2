Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1961A3A9C36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhFPNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:42:05 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233341AbhFPNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623850767; x=1655386767;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WVAH0YkNKVeMmNqcBBXc3DJnfF/QS6kEngfFH1hdQs8=;
  b=MdgntlK9PgI3K/s4ZNMc0a67epmwM6QgnuPMGhmBIdaSf5lu/ToMaCGn
   BHk7eA9bA9n7FB/lRIhsDzI+4GffK+pWn1iU5yp75YmbfaoTVANO8FGqk
   A1adeQUg/Eq5bIO+FGXQi7OQJMEbvd9du3YKTHTFTZFMKbGiTAeyy6kTI
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2021 06:39:16 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 06:39:07 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:06 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
Date:   Wed, 16 Jun 2021 06:38:41 -0700
Message-ID: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
the buffer at a granule of the largest page size that is supported by
the IOMMU hardware and fits within the buffer. For every block that
is unmapped, the IOMMU framework will call into the IOMMU driver, and
then the io-pgtable framework to walk the page tables to find the entry
that corresponds to the IOVA, and then unmaps the entry.

This can be suboptimal in scenarios where a buffer or a piece of a
buffer can be split into several contiguous page blocks of the same size.
For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
unmapped at IOVA 0. The current call-flow will result in 4 indirect calls,
and 2 page table walks, to unmap 2 entries that are next to each other in
the page-tables, when both entries could have been unmapped in one shot
by clearing both page table entries in the same call.

The same optimization is applicable to mapping buffers as well, so
these patches implement a set of callbacks called unmap_pages and
map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
an IOVA range that consists of a number of pages of the same
page size that is supported by the IOMMU hardware, and allows for
manipulating multiple page table entries in the same set of indirect
calls. The reason for introducing these callbacks is to give other IOMMU
drivers/io-pgtable formats time to change to using the new callbacks, so
that the transition to using this approach can be done piecemeal.

Changes since V6:
(https://lore.kernel.org/r/1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com/)

* Fix compiler warning (patch 08/15)
* Free underlying page tables for large mappings (patch 10/15)
    Consider the case where a 2N--where N > 1--MB buffer is composed
    entirely of 4 KB pages. This means that at the second to last level,
    the buffer will have N non-leaf entries that point to page tables
    with 4 KB mappings.

    When the buffer is unmapped, all N entries will be cleared at the
    second to last level. However, the existing logic only checks if
    it needs to free the underlying page tables for the first non-leaf
    entry. Therefore, the page table memory for the other entries N-1
    entries will be leaked.

    Fix this memory leak by ensuring that we apply the same check to
    all N entries that are being unmapped.

    When unmapping multiple entries, __arm_lpae_unmap() should unmap
    one entry at a time and perform TLB maintenance as required for that
    entry.

Changes since V5: 
(https://lore.kernel.org/r/20210408171402.12607-1-isaacm@codeaurora.org/)

* Rebased on next-20210515.
* Fixed minor checkpatch warnings - indentation, extra blank lines.
* Use the correct function argument in __arm_lpae_map(). (chenxiang)

Changes since V4:

* Fixed type for addr_merge from phys_addr_t to unsigned long so
  that GENMASK() can be used.
* Hooked up arm_v7s_[unmap/map]_pages to the io-pgtable ops.
* Introduced a macro for calculating the number of page table entries
  for the ARM LPAE io-pgtable format.

Changes since V3:

* Removed usage of ULL variants of bitops from Will's patches, as
  they were not needed.
* Instead of unmapping/mapping pgcount pages, unmap_pages() and
  map_pages() will at most unmap and map pgcount pages, allowing
  for part of the pages in pgcount to be mapped and unmapped. This
  was done to simplify the handling in the io-pgtable layer.
* Extended the existing PTE manipulation methods in io-pgtable-arm
  to handle multiple entries, per Robin's suggestion, eliminating
  the need to add functions to clear multiple PTEs.
* Implemented a naive form of [map/unmap]_pages() for ARM v7s io-pgtable
  format.
* arm_[v7s/lpae]_[map/unmap] will call
  arm_[v7s/lpae]_[map_pages/unmap_pages] with an argument of 1 page.
* The arm_smmu_[map/unmap] functions have been removed, since they
  have been replaced by arm_smmu_[map/unmap]_pages.

Changes since V2:

* Added a check in __iommu_map() to check for the existence
  of either the map or map_pages callback as per Lu's suggestion.

Changes since V1:

* Implemented the map_pages() callbacks
* Integrated Will's patches into this series which
  address several concerns about how iommu_pgsize() partitioned a
  buffer (I made a minor change to the patch which changes
  iommu_pgsize() to use bitmaps by using the ULL variants of
  the bitops)

Isaac J. Manjarres (12):
  iommu/io-pgtable: Introduce unmap_pages() as a page table op
  iommu: Add an unmap_pages() op for IOMMU drivers
  iommu/io-pgtable: Introduce map_pages() as a page table op
  iommu: Add a map_pages() op for IOMMU drivers
  iommu: Add support for the map_pages() callback
  iommu/io-pgtable-arm: Prepare PTE methods for handling multiple
    entries
  iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
  iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
  iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
  iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
  iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
  iommu/arm-smmu: Implement the map_pages() IOMMU driver callback

Will Deacon (3):
  iommu: Use bitmap to calculate page size in iommu_pgsize()
  iommu: Split 'addr_merge' argument to iommu_pgsize() into separate
    parts
  iommu: Hook up '->unmap_pages' driver callback

 drivers/iommu/arm/arm-smmu/arm-smmu.c |  18 +--
 drivers/iommu/io-pgtable-arm-v7s.c    |  50 ++++++--
 drivers/iommu/io-pgtable-arm.c        | 223 +++++++++++++++++++++-------------
 drivers/iommu/iommu.c                 | 129 +++++++++++++++-----
 include/linux/io-pgtable.h            |   8 ++
 include/linux/iommu.h                 |   9 ++
 6 files changed, 307 insertions(+), 130 deletions(-)

