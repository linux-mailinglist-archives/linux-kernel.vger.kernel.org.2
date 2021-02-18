Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9A31F4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBSGFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:05:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:39731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhBSGFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:05:40 -0500
IronPort-SDR: /Q6ZtINnRJH+DR7eFJs9ckqN8l5g5Wlcp5mHLU+taIp1CV0kzBXEIiYijS0krcRqfMnMGGV+mP
 Ev+1JMrHjC4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="171424151"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171424151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:02:29 -0800
IronPort-SDR: wVmcecK3h7qBCj4zzziKZys3Iw1DkVS7eSN/rsaWKImrHK0ShrNBbNlX/WFq1NR52Zg0TbyUcT
 I38LJLHfev0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="362829341"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2021 22:02:29 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/4] Misc vSVA fixes for VT-d
Date:   Thu, 18 Feb 2021 13:31:14 -0800
Message-Id: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu et al,

This is a collection of SVA-related fixes.

Thanks,
Jacob


Jacob Pan (4):
  iommu/vt-d: Enable write protect for supervisor SVM
  iommu/vt-d: Enable write protect propagation from guest
  iommu/vt-d: Reject unsupported page request modes
  iommu/vt-d: Calculate and set flags for handle_mm_fault

 drivers/iommu/intel/pasid.c | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c   | 21 +++++++++++++++++----
 include/uapi/linux/iommu.h  |  3 ++-
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.25.1

