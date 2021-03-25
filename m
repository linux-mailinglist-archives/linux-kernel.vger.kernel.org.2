Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BD349364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhCYNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:9881 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhCYNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:55:01 -0400
IronPort-SDR: ZQHz2Fi918DfeuHztW91+T1Els05eLgqqgGHIi/dUsZqRLxNRV1IVtNGJfnZi7Z5eKTEwrWgmj
 36VbHvFuYCCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188633461"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="188633461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:55:01 -0700
IronPort-SDR: cKKyGRrKt6IR+0gKux4wGRUsil8hhY24ZwoE2p4YEINFnUuQMID+uxHsV2QXNH3SfJreIm+qD0
 IVtBkcrBqTRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="414169289"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2021 06:54:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF0BA16A; Thu, 25 Mar 2021 15:55:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 2/4] usb: gadget: pch_udc: Remove CONFIG_PM_SLEEP ifdefery
Date:   Thu, 25 Mar 2021 15:55:06 +0200
Message-Id: <20210325135508.70350-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
References: <20210325135508.70350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __maybe_unused for the suspend()/resume() hooks and get rid of
the CONFIG_PM_SLEEP ifdefery to improve the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 6a96d4a3df2d..d5685d427158 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -3026,8 +3026,7 @@ static void pch_udc_remove(struct pci_dev *pdev)
 	pch_udc_exit(dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pch_udc_suspend(struct device *d)
+static int __maybe_unused pch_udc_suspend(struct device *d)
 {
 	struct pch_udc_dev *dev = dev_get_drvdata(d);
 
@@ -3037,16 +3036,12 @@ static int pch_udc_suspend(struct device *d)
 	return 0;
 }
 
-static int pch_udc_resume(struct device *d)
+static int __maybe_unused pch_udc_resume(struct device *d)
 {
 	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(pch_udc_pm, pch_udc_suspend, pch_udc_resume);
-#define PCH_UDC_PM_OPS		(&pch_udc_pm)
-#else
-#define PCH_UDC_PM_OPS		NULL
-#endif /* CONFIG_PM_SLEEP */
 
 static int pch_udc_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *id)
@@ -3156,7 +3151,7 @@ static struct pci_driver pch_udc_driver = {
 	.remove =	pch_udc_remove,
 	.shutdown =	pch_udc_shutdown,
 	.driver = {
-		.pm = PCH_UDC_PM_OPS,
+		.pm = &pch_udc_pm,
 	},
 };
 
-- 
2.30.2

