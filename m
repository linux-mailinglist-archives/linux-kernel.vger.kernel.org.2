Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951332AD62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837489AbhCBVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:46:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:46626 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378589AbhCBSxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:53:44 -0500
IronPort-SDR: AFL2YwPe6f8/7hiipzdYLuWkUvEVfOXk5yhJyzklz7HVO135XPJsqZKfhmag9E6xLPwX4FZmIe
 QfR+hYDJh/DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186272511"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="186272511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 10:45:45 -0800
IronPort-SDR: aCYvvGs7aPQeqpMHnIVnr1zjKEwaG2KBWxEjra5ru6lWdgOgGhqZvSCx1lVamLb7y5F9GYO2KQ
 eWP8BJyB+VhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="406158799"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:45 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/4] Misc vSVA fixes for VT-d
Date:   Tue,  2 Mar 2021 02:13:56 -0800
Message-Id: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu et al,

This is a collection of SVA-related fixes.

ChangeLog:

v2:
	- For guest SVA, call pasid_set_wpe directly w/o checking host CR0.wp
	  (Review comments by Kevin T.)
	- Added fixes tag

Thanks,

Jacob

Jacob Pan (4):
  iommu/vt-d: Enable write protect for supervisor SVM
  iommu/vt-d: Enable write protect propagation from guest
  iommu/vt-d: Reject unsupported page request modes
  iommu/vt-d: Calculate and set flags for handle_mm_fault

 drivers/iommu/intel/pasid.c | 29 +++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c   | 21 +++++++++++++++++----
 include/uapi/linux/iommu.h  |  3 ++-
 3 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.25.1

