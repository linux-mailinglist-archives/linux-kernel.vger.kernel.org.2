Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C383DF8F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhHDAdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:33:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:55954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234792AbhHDAc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:32:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213799588"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="213799588"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 17:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="667604504"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2021 17:32:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 93F7C58093B;
        Tue,  3 Aug 2021 17:32:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_pmc_core: Prevent possibile overflow
Date:   Tue,  3 Aug 2021 17:30:39 -0700
Message-Id: <20210804003039.359138-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <facd47b64a5efa4e0e70cd29586173e44a8929c2.camel@linux.intel.com>
References: <facd47b64a5efa4e0e70cd29586173e44a8929c2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Low Power Mode (LPM) priority is encoded in 4 bits. Yet, this value is used
as an index to an array whose element size was less than 16, leading to the
possibility of overflow should we read a larger than expected priority. Set
the array size to 16 to prevent this.

Reported-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 drivers/platform/x86/intel_pmc_core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index b0e486a6bdfb..2a761fe98277 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1451,7 +1451,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
 
 static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 {
-	u8 lpm_priority[LPM_MAX_NUM_MODES];
+	u8 lpm_priority[LPM_MAX_PRI];
 	u32 lpm_en;
 	int mode, i, p;
 
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index e8dae9c6c45f..b98c2b44c938 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -190,6 +190,7 @@ enum ppfear_regs {
 #define LPM_MAX_NUM_MODES			8
 #define GET_X2_COUNTER(v)			((v) >> 1)
 #define LPM_STS_LATCH_MODE			BIT(31)
+#define LPM_MAX_PRI				16	/* size of 4 bits */
 
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
 #define TGL_PMC_LTR_THC0			0x1C04
-- 
2.25.1

