Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD84324A99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhBYGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:37:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:22393 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBYGhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:37:40 -0500
IronPort-SDR: huMkIJoGDQ6dDajfhrTxijE+vOLScGGTesMPMH0TB007PImmrSY+42nO/L3D/DkeejRJagFhq8
 uZzbJvEoU/eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246838617"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="246838617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:35:54 -0800
IronPort-SDR: 1GwWinQ2jjPBuNPzJpkyQmJkkQ3fVDQv9Wh/e/GnXeiZu9TMEtpEXsiRLxom07nLA6+rg+VZsb
 zInIE2O1zrwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="499965235"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:35:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Several misc fixes
Date:   Thu, 25 Feb 2021 14:26:49 +0800
Message-Id: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
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

