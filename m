Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82739E0AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFGPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:39:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:29556 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhFGPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:39:04 -0400
IronPort-SDR: LsLVH0phFaag3nyrxcZAo2q2PJkutsCWq07yFb41di9OIhJy40hs2XHUaCAVYGoSmkrsxHA907
 Te4r2I3fF2bQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265799411"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265799411"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:37:09 -0700
IronPort-SDR: fHqDdQG/bIdZ2/Gz7zIKVpNZZem0T7am94f1fASXTQ4oAhW9YEbM/VpCY16Qd+UrfElAOvLpPz
 7rKbWghkhbnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="469126684"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2021 08:37:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 056AFC5; Mon,  7 Jun 2021 18:37:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/1] pps: clients: parport: Switch to use module_parport_driver()
Date:   Mon,  7 Jun 2021 18:37:29 +0300
Message-Id: <20210607153729.58623-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
v2: added tag (Rodolfo)

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

