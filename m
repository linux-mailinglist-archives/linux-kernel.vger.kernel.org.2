Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB83454CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCWBQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCWBPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:37 -0400
IronPort-SDR: oU/di2U/i45jLeh8Ao6kiFGHPOnueDb+60cMdbB/BfLg4XDfoE4tMtzh9ztYWcCCDYPXEdAAwx
 EohUR9SBYkUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455642"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:36 -0700
IronPort-SDR: Q8RsDOJ/JL6cw62Nw9uMR8/5n3JdeWVrk1I+zTuWv8wVJUm/aLSjfd+RYLBRTjFDiQoEPmZ6m8
 CSkRDn8o7tlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362413"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Several misc cleanups
Date:   Tue, 23 Mar 2021 09:05:55 +0800
Message-Id: <20210323010600.678627-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg et al,

This series includes several cleanups in the VT-d driver. Please help to
review.

Best regards,
baolu

Lu Baolu (5):
  iommu/vt-d: Remove unused dma map/unmap trace events
  iommu/vt-d: Remove svm_dev_ops
  iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
  iommu/vt-d: Remove unused function declarations
  iommu/vt-d: Make unnecessarily global functions static

 drivers/iommu/intel/pasid.c        |   4 +-
 drivers/iommu/intel/pasid.h        |   5 --
 drivers/iommu/intel/svm.c          |  55 +++++--------
 include/linux/intel-iommu.h        |   3 -
 include/linux/intel-svm.h          |  23 +-----
 include/trace/events/intel_iommu.h | 120 -----------------------------
 6 files changed, 24 insertions(+), 186 deletions(-)

-- 
2.25.1

