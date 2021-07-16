Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896093CBBFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhGPSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:44:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:56665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232214AbhGPSop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:44:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="191144883"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="191144883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="460843499"
Received: from otcpl-manager.jf.intel.com (HELO localhost.localdomain) ([10.54.39.234])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2021 11:41:49 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, hdegoede@redhat.com,
        irenic.rajneesh@gmail.com, andriy.shevchenko@linux.intel.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com,
        "David E. Box" <david.e.box@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 5/5] platform/x86/intel: pmc/core: Add GBE Package C10 fix for Alder Lake PCH
Date:   Fri, 16 Jul 2021 11:38:37 -0700
Message-Id: <a03f97c108811c1ad966df78778832c19a6d2a17.1626459866.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626459866.git.gayatri.kammela@intel.com>
References: <cover.1626459866.git.gayatri.kammela@intel.com>
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
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e645ede591d8..7c4bf7d22fd5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
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

