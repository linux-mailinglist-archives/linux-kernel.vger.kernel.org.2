Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1B3790C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhEJO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:29:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:23254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238240AbhEJOZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:25:15 -0400
IronPort-SDR: R9ELT7O5pz5G4O6AuglaPnah2Dy1OWE9deqmt5A15J+0+p+UoWUsAx9vHqikDMHrHlNKSpDU4m
 Q1Gtz6INDPTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199274678"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199274678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:12:50 -0700
IronPort-SDR: nX0Z9zntYnqMQIoh0hAfqHayF6eU9Eb7aG6e1vkXAS2H+ltMejjO17KvBzwg3/EFR+PnTb1G/A
 CrL+wYOJDoUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="398892267"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2021 07:12:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 080E9142; Mon, 10 May 2021 17:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 1/1] pps: clients: parport: Switch to use module_parport_driver()
Date:   Mon, 10 May 2021 17:13:02 +0300
Message-Id: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 7a41fb7b0dec..42f93d4c6ee3 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -22,8 +22,6 @@
 #include <linux/parport.h>
 #include <linux/pps_kernel.h>
 
-#define DRVDESC "parallel port PPS client"
-
 /* module parameters */
 
 #define CLEAR_WAIT_MAX		100
@@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
 		.dev		= NULL
 	};
 
+	if (clear_wait > CLEAR_WAIT_MAX) {
+		pr_err("clear_wait value should be not greater then %d\n",
+		       CLEAR_WAIT_MAX);
+		return;
+	}
+
 	device = kzalloc(sizeof(struct pps_client_pp), GFP_KERNEL);
 	if (!device) {
 		pr_err("memory allocation failed, not attaching\n");
@@ -214,38 +218,8 @@ static struct parport_driver pps_parport_driver = {
 	.detach = parport_detach,
 	.devmodel = true,
 };
-
-/* module staff */
-
-static int __init pps_parport_init(void)
-{
-	int ret;
-
-	pr_info(DRVDESC "\n");
-
-	if (clear_wait > CLEAR_WAIT_MAX) {
-		pr_err("clear_wait value should be not greater"
-				" then %d\n", CLEAR_WAIT_MAX);
-		return -EINVAL;
-	}
-
-	ret = parport_register_driver(&pps_parport_driver);
-	if (ret) {
-		pr_err("unable to register with parport\n");
-		return ret;
-	}
-
-	return  0;
-}
-
-static void __exit pps_parport_exit(void)
-{
-	parport_unregister_driver(&pps_parport_driver);
-}
-
-module_init(pps_parport_init);
-module_exit(pps_parport_exit);
+module_parport_driver(pps_parport_driver);
 
 MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
-MODULE_DESCRIPTION(DRVDESC);
+MODULE_DESCRIPTION("parallel port PPS client");
 MODULE_LICENSE("GPL");
-- 
2.30.2

