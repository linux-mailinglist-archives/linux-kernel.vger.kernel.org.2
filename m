Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01C418864
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIZLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 07:50:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:50513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZLuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 07:50:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="224393315"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="224393315"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 04:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="475640098"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/3] iommu/t-d: Use SL for GPA->HPA translation
Date:   Sun, 26 Sep 2021 19:45:32 +0800
Message-Id: <20210926114535.923263-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
https://lore.kernel.org/linux-iommu/20210924022931.780963-1-baolu.lu@linux.intel.com/

Change log:
v1->v2:
 - Split the cleanup into a separated patch
 - Add a patch to check sanity of capabilities
 - Consider capabilities when determining FL or SL

Best regards,
Baolu

Lu Baolu (3):
  iommu/vt-d: Remove duplicate identity domain flag
  iommu/vt-d: Check FL and SL capability sanity in scalable mode
  iommu/vt-d: Use second level for GPA->HPA translation

 include/linux/intel-iommu.h     |  3 ---
 drivers/iommu/intel/cap_audit.h |  1 +
 drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
 drivers/iommu/intel/iommu.c     | 21 +++++++++++++--------
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.25.1

