Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3876A362A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbhDPVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:22:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:46596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344186AbhDPVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:47 -0400
IronPort-SDR: HkC5zTqdCNDMUYG1AzxXZeI76em2LDjKgbEkdiJus0NCg3/XuofY6E8++bOEbq4sEHTG99T7Wk
 vqqbwIi/13JQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256427945"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256427945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 14:19:34 -0700
IronPort-SDR: 3vfggyqGry/nrWnHH+RyO74dDk6XQPSCR1gyRWlQfj+zUkev56L0d89TQ/9Fa8JB9F+8VTCDsy
 fes5B32D8e6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="522825399"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2021 14:19:34 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 0/2] Simplify and restrict IOMMU SVA APIs
Date:   Fri, 16 Apr 2021 05:45:12 -0700
Message-Id: <1618577114-30156-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small changes to simplify and restrict SVA APIs. The motivation
is to make PASID allocation palatable for cgroup consumptions. Misc cgroup
is merged for v5.13, it can be extended for IOASID as another scalar
resource.

I have not tested on ARM platforms due to availability. Would appreciate
if someone could help with the testing on uacce based SVA usages.

Thanks,

Jacob

ChangeLog:
V3	- stop passing mm to sva_bind IOMMU ops, no need to take mm refcount
	in the common SVA code.
	- deleted flag variable in idxd driver

V2
	- retained mm argument in iommu_sva_alloc_pasid()
	- keep generic supervisor flag separated from vt-d's SRE
	- move flag declaration out of CONFIG_IOMMU_API



Jacob Pan (2):
  iommu/sva: Tighten SVA bind API with explicit flags
  iommu/sva: Remove mm parameter from SVA bind API

 drivers/dma/idxd/cdev.c                       |  2 +-
 drivers/dma/idxd/init.c                       |  7 ++----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++--
 drivers/iommu/intel/svm.c                     | 19 ++++++++-------
 drivers/iommu/iommu-sva-lib.c                 | 11 +++++----
 drivers/iommu/iommu-sva-lib.h                 |  2 +-
 drivers/iommu/iommu.c                         | 13 +++++------
 drivers/misc/uacce/uacce.c                    |  2 +-
 include/linux/intel-iommu.h                   |  3 +--
 include/linux/intel-svm.h                     | 17 ++------------
 include/linux/iommu.h                         | 23 ++++++++++++++-----
 12 files changed, 56 insertions(+), 60 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.25.1

