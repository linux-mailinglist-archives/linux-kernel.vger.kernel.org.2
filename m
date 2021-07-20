Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F13CF1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbhGTBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:32:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:12590 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240543AbhGTB17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:27:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190749817"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="190749817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 19:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453891940"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:27 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, robin.murphy@arm.com,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Implement [map/unmap]_pages callbacks
Date:   Tue, 20 Jul 2021 10:06:12 +0800
Message-Id: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The "Optimizing iommu_[map/unmap] performance" series posted here,

https://lore.kernel.org/linux-iommu/1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com/

improves the iommu_[map/unmap] performce by reducing the number of
calls to the vendor-specific map/unmap callbacks. This series
introduces the implementation of those new callbacks in Intel IOMMU
implementation.

Note: This series depends on above series. It can only be taken after
      above series get merged.

Best regards,
baolu

Lu Baolu (3):
  iommu/vt-d: Report real pgsize bitmap to iommu core
  iommu/vt-d: Implement map/unmap_pages() iommu_ops callback
  iommu/vt-d: Move clflush'es from iotlb_sync_map() to map_pages()

 drivers/iommu/intel/iommu.c | 123 ++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 62 deletions(-)

-- 
2.25.1

