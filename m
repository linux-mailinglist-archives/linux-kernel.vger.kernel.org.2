Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A955379989
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhEJWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:02:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:48735 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEJWCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:02:33 -0400
IronPort-SDR: jkdw8oufwIDc6MOVnNfCIwFLPP1vNhXUy5tPMQA4Z2MHl+gmKyqFfLx7a9+kFrNR45GSgvBj1K
 aFKRlaaOoSAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="198974914"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="198974914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:01:26 -0700
IronPort-SDR: 34fe2CGszeCS3BAyVqDPJsQkBaf6yJsuPUza8a16YEQ4vZRKi6mhrivJmwyf9a65Iiat0PWD9S
 wz4Q/uIj3ICw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="470918936"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 15:00:52 -0700
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
Subject: [PATCH v4 0/2] Simplify and restrict IOMMU SVA APIs
Date:   Mon, 10 May 2021 06:25:06 -0700
Message-Id: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
V4	- fixed a cross-compile error
	- rebased to v5.13-rc1 resolved a conflict in intel-svm code

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
 include/linux/intel-svm.h                     | 12 ----------
 include/linux/iommu.h                         | 23 ++++++++++++++-----
 12 files changed, 54 insertions(+), 57 deletions(-)

-- 
2.25.1

