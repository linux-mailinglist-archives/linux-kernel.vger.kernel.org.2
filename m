Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75F1342A20
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 04:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCTDEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 23:04:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTDDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 23:03:39 -0400
IronPort-SDR: NUHtZHatMMnCU2hqXvlC+ReS+EwNinh3lMZDpJ44SUpUXRZpNCZRcz+7SBvLnLTWbjy21qWR3J
 Wh5gam34fskA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186661559"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186661559"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 20:03:39 -0700
IronPort-SDR: EjE/3mmmQpmz4SFApQF+ZfoEHvw3Fa1b3Q+4o938Z/E/t6Eq1sbk7s9/1TwYI4Pu/mZP/VcHFM
 ZSijeZ1g024w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441520635"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 20:03:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/5] iommu/vt-d: Several misc fixes
Date:   Sat, 20 Mar 2021 10:54:10 +0800
Message-Id: <20210320025415.641201-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This series includes some misc fixes for the VT-d iommu driver. Please
help to review and merge.

Best regards,
baolu

Change log:
 v1->v2:
  - v1: https://lore.kernel.org/linux-iommu/20210225062654.2864322-1-baolu.lu@linux.intel.com/
  - [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level paging entries
     - Refine the commit message to make the intention clear.

Lu Baolu (5):
  iommu/vt-d: Report the right page fault address
  iommu/vt-d: Remove WO permissions on second-level paging entries
  iommu/vt-d: Invalidate PASID cache when root/context entry changed
  iommu/vt-d: Use user privilege for RID2PASID translation
  iommu/vt-d: Avoid unnecessary cache flush in pasid entry teardown

 drivers/iommu/intel/iommu.c | 28 ++++++++++++++++------------
 drivers/iommu/intel/pasid.c |  6 +++++-
 drivers/iommu/intel/svm.c   |  2 +-
 include/linux/intel-iommu.h |  1 +
 4 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.25.1

