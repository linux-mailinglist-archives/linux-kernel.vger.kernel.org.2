Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28523A9D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhFPOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:33:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:9731 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233208AbhFPOdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:33:07 -0400
IronPort-SDR: ERHjl+zN6PoI5/q3zIl16UX2GwmHmzVUTk3RcFOw5cMJTFIsrvfiCWhWvr54sbWyQP41uNZ+8B
 MhJ0FjZ2MJng==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204356436"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="204356436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:31:01 -0700
IronPort-SDR: 7ZyKCQaT1jdkElj93gSvPXBJ9/SpjQUlX35ATgnKLrRiyhMdNvuoCfP9/4Slv+D0nL/7Im2xRz
 BRwiWdpF3/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="442896117"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2021 07:31:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 733122AA; Wed, 16 Jun 2021 17:31:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
Date:   Wed, 16 Jun 2021 17:31:21 +0300
Message-Id: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/generators/pps_gen_parport.c | 44 +++++-------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index 6a1af7664f3b..565f99782402 100644
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
@@ -223,6 +226,8 @@ static void parport_detach(struct parport *port)
 	hrtimer_cancel(&device.timer);
 	parport_release(device.pardev);
 	parport_unregister_device(device.pardev);
+
+	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
 }
 
 static struct parport_driver pps_gen_parport_driver = {
@@ -231,39 +236,8 @@ static struct parport_driver pps_gen_parport_driver = {
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
2.30.2

