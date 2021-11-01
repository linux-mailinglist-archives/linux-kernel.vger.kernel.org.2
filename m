Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D651B441D30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhKAPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:14:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:13981 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhKAPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:14:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="230988479"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="230988479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 08:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="496605896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2021 08:10:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8CC3C23E; Mon,  1 Nov 2021 17:10:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
Subject: [PATCH v1 1/1] mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()
Date:   Mon,  1 Nov 2021 17:10:36 +0200
Message-Id: <20211101151036.33598-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime PM callback may be called as soon as the runtime PM facility
is enabled and activated. It means that ->suspend() may be called before
we finish probing the device in the ACPI case. Hence, NULL pointer
dereference:

  intel-lpss INT34BA:00: IRQ index 0 not found
  BUG: kernel NULL pointer dereference, address: 0000000000000030
  ...
  Workqueue: pm pm_runtime_work
  RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]

To fix this, first try to register the device and only after that enable
runtime PM facility.

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
Reported-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 3f1d976eb67c..be81507afb5e 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -136,6 +136,7 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 {
 	struct intel_lpss_platform_info *info;
 	const struct acpi_device_id *id;
+	int ret;
 
 	id = acpi_match_device(intel_lpss_acpi_ids, &pdev->dev);
 	if (!id)
@@ -149,10 +150,14 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->irq = platform_get_irq(pdev, 0);
 
+	ret = intel_lpss_probe(&pdev->dev, info);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	return intel_lpss_probe(&pdev->dev, info);
+	return ret;
 }
 
 static int intel_lpss_acpi_remove(struct platform_device *pdev)
-- 
2.33.0

