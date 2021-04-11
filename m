Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210835B202
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhDKGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:33:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:47112 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKGdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:33:17 -0400
IronPort-SDR: LTvYZkX+gUqF6Hup6TNaPJ3CAgIYCTTxGClEVE5E/g8JAyDogUYDeeRRsvzZIKzmmmjTGBGLLY
 Uk1I7GYEAk+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="181124353"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="181124353"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 23:33:01 -0700
IronPort-SDR: i9OKvhbG4YO9IHwkD1Vg/oxLhZrn8lM6ghMUnTffFHgUnjw6+NpDr5OQPyGZGAbmppqGSAX8Tk
 8AtzBRifn4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="442678699"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2021 23:32:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix build error of pasid_enable_wpe() with !X86
Date:   Sun, 11 Apr 2021 14:23:12 +0800
Message-Id: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor
SVM") added pasid_enable_wpe() which hit below compile error with !X86.

../drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
../drivers/iommu/intel/pasid.c:554:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
  554 |  unsigned long cr0 = read_cr0();
      |                      ^~~~~~~~
In file included from ../include/linux/build_bug.h:5,
                 from ../include/linux/bits.h:22,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/iommu/intel/pasid.c:12:
../drivers/iommu/intel/pasid.c:557:23: error: 'X86_CR0_WP' undeclared (first use in this function)
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |                                          ^
../drivers/iommu/intel/pasid.c:557:23: note: each undeclared identifier is reported only once for each function it appears in
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |

Add the missing dependency.

Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor SVM")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 477b2e1d303c..72646bafc52f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -551,6 +551,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 static inline int pasid_enable_wpe(struct pasid_entry *pte)
 {
+#ifdef CONFIG_X86
 	unsigned long cr0 = read_cr0();
 
 	/* CR0.WP is normally set but just to be sure */
@@ -558,6 +559,7 @@ static inline int pasid_enable_wpe(struct pasid_entry *pte)
 		pr_err_ratelimited("No CPU write protect!\n");
 		return -EINVAL;
 	}
+#endif
 	pasid_set_wpe(pte);
 
 	return 0;
-- 
2.25.1

