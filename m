Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B541F054
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354795AbhJAPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:06:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:49686 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354706AbhJAPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:06:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205614103"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="205614103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="521138546"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2021 08:03:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C79E29D; Fri,  1 Oct 2021 18:03:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Subject: [PATCH v2 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
Date:   Fri,  1 Oct 2021 18:03:16 +0300
Message-Id: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: remove useless message (Greg), Cc to the original (hopefully) author
 drivers/pps/generators/pps_gen_parport.c | 42 ++++--------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index 6a1af7664f3b..fba6c490977c 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -20,8 +20,6 @@
 #include <linux/hrtimer.h>
 #include <linux/parport.h>
 
-#define DRVDESC "parallel port PPS signal generator"
-
 #define SIGNAL		0
 #define NO_SIGNAL	PARPORT_CONTROL_STROBE
 
@@ -180,6 +178,11 @@ static void parport_attach(struct parport *port)
 {
 	struct pardev_cb pps_cb;
 
+	if (send_delay > SEND_DELAY_MAX) {
+		pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
+		return -EINVAL;
+	}
+
 	if (attached) {
 		/* we already have a port */
 		return;
@@ -231,39 +234,8 @@ static struct parport_driver pps_gen_parport_driver = {
 	.detach = parport_detach,
 	.devmodel = true,
 };
-
-/* module staff */
-
-static int __init pps_gen_parport_init(void)
-{
-	int ret;
-
-	pr_info(DRVDESC "\n");
-
-	if (send_delay > SEND_DELAY_MAX) {
-		pr_err("delay value should be not greater"
-				" then %d\n", SEND_DELAY_MAX);
-		return -EINVAL;
-	}
-
-	ret = parport_register_driver(&pps_gen_parport_driver);
-	if (ret) {
-		pr_err("unable to register with parport\n");
-		return ret;
-	}
-
-	return  0;
-}
-
-static void __exit pps_gen_parport_exit(void)
-{
-	parport_unregister_driver(&pps_gen_parport_driver);
-	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
-}
-
-module_init(pps_gen_parport_init);
-module_exit(pps_gen_parport_exit);
+module_parport_driver(pps_gen_parport_driver);
 
 MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
-MODULE_DESCRIPTION(DRVDESC);
+MODULE_DESCRIPTION("parallel port PPS signal generator");
 MODULE_LICENSE("GPL");
-- 
2.33.0

