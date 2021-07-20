Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3213CF196
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbhGTBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:03:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:17234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240289AbhGTBAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211219346"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="211219346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 18:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453887537"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:16 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Several minor adjustments
Date:   Tue, 20 Jul 2021 09:38:51 +0800
Message-Id: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes some adjustments for Intel IOMMU which I have
been suggested. Please help to review.

- Enable Intel IOMMU scalable mode by default
- Preset A/D bits for user space DMA usage
- Disallow SVA if devices don't support 64-bit address
- Allow devices to have more than 32 outstanding PRs

Best regards,
baolu

Lu Baolu (5):
  iommu/vt-d: Refactor Kconfig a bit
  iommu/vt-d: Enable Intel IOMMU scalable mode by default
  iommu/vt-d: Preset A/D bits for user space DMA usage
  iommu/vt-d: Disallow SVA if devices don't support 64-bit address
  iommu/vt-d: Allow devices to have more than 32 outstanding PRs

 .../admin-guide/kernel-parameters.txt         | 11 +++---
 include/linux/intel-svm.h                     |  5 +++
 drivers/iommu/intel/iommu.c                   | 34 ++++++++-----------
 drivers/iommu/intel/svm.c                     |  4 ---
 drivers/iommu/intel/Kconfig                   | 19 ++++++-----
 5 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.25.1

