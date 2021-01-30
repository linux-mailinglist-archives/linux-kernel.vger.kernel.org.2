Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAC3096A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhA3QWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:22:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:1989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232153AbhA3Phz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:37:55 -0500
IronPort-SDR: vn8JtLratsi8YPs3L7DwkQeeTQ2oJp73w2PVI4AEY8100pGun5U+mhWSo7iAAlNpnIY2wyMPPo
 E5Toebi5MWUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="265368927"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="265368927"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 07:27:32 -0800
IronPort-SDR: 0Fdaod5SS/O4p5u2mRo7WEr3CE5ATOhPuMbQemLHOhjpL6GaqNiSsXJ216wJ2gemxMc6D0KRnY
 DUBGSW/l7tFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="404853077"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2021 07:27:31 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix compile error [-Werror=implicit-function-declaration]
Date:   Sat, 30 Jan 2021 23:19:07 +0800
Message-Id: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_qi_submit() could be used when interrupt remapping is supported,
but DMA remapping is not. In this case, the following compile error
occurs.

../drivers/iommu/intel/dmar.c: In function 'qi_submit_sync':
../drivers/iommu/intel/dmar.c:1311:3: error: implicit declaration of function 'trace_qi_submit';
  did you mean 'ftrace_nmi_exit'? [-Werror=implicit-function-declaration]
   trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
   ^~~~~~~~~~~~~~~
   ftrace_nmi_exit

Fixes: f2dd871799ba5 ("iommu/vt-d: Add qi_submit trace event")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Makefile       | 2 +-
 drivers/iommu/intel/iommu.c        | 1 -
 include/trace/events/intel_iommu.h | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fb8e1e8c8029..ae570810a35e 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += trace.o
+obj-$(CONFIG_DMAR_TABLE) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7fecc109947..37da4caa67c9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -44,7 +44,6 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "pasid.h"
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index aad2ff0c1e2e..e801f4910522 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -6,7 +6,6 @@
  *
  * Author: Lu Baolu <baolu.lu@linux.intel.com>
  */
-#ifdef CONFIG_INTEL_IOMMU
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM intel_iommu
 
@@ -176,4 +175,3 @@ TRACE_EVENT(qi_submit,
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-#endif /* CONFIG_INTEL_IOMMU */
-- 
2.25.1

