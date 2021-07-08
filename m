Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9DB3BF3E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGHCNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:13:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:61851 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhGHCNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:13:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="209246227"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="209246227"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 19:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="449770535"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2021 19:10:42 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH v2 5/5] platform/x86/intel: intel_pmc_core: Add GBE Package C10 fix for Alder Lake PCH
Date:   Wed,  7 Jul 2021 19:07:25 -0700
Message-Id: <cea5cf09ddecface98712e5db877a70e8c41d581.1625709047.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1625709047.git.gayatri.kammela@intel.com>
References: <cover.1625709047.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

Alder PCH uses the same Gigabit Ethernet (GBE) device as Tiger Lake PCH
which cannot achieve PC10 without ignoring the PMC GBE LTR. Add this
work around for Alder Lake PCH as well.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/intel_pmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/intel_pmc_core.c
index 27346ff5a924..84b58b557a49 100644
--- a/drivers/platform/x86/intel/pmc/intel_pmc_core.c
+++ b/drivers/platform/x86/intel/pmc/intel_pmc_core.c
@@ -1983,10 +1983,10 @@ static int pmc_core_probe(struct platform_device *pdev)
 		pmc_core_get_tgl_lpm_reqs(pdev);
 
 	/*
-	 * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
-	 * a cable is attached. Tell the PMC to ignore it.
+	 * On TGL and ADL, due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
-	if (pmcdev->map == &tgl_reg_map) {
+	if (pmcdev->map == &tgl_reg_map || pmcdev->map == &adl_reg_map) {
 		dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
 		pmc_core_send_ltr_ignore(pmcdev, 3);
 	}
-- 
2.25.1

