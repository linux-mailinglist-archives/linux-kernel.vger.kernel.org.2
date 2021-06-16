Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4893A9D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhFPOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:22:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:10507 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233880AbhFPOWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:22:10 -0400
IronPort-SDR: gvph3pquI65AGsCLtfHNvMh7M6KWT9IDq+0XVI86G3f8GiAFAPhf3ix1p0hD1gpzFIJdUXsTin
 aKwNOg70V1kg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203161794"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="203161794"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:20:03 -0700
IronPort-SDR: Vv928JCoadp5sefmIVMrfjem4DUgAfJxPeCL9U6HGvE9cLqqLakWXwbPoiALuUfHCjYfxOaQ2s
 lx9YX7kzsl7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="442892894"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2021 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 663392AA; Wed, 16 Jun 2021 17:20:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] auxdisplay: panel: Switch to use module_parport_driver()
Date:   Wed, 16 Jun 2021 17:20:20 +0300
Message-Id: <20210616142020.45073-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/panel.c | 200 ++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 112 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index eba04c0de7eb..a1b5b5134242 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1520,106 +1520,9 @@ static void keypad_init(void)
 
 static void panel_attach(struct parport *port)
 {
+	int selected_keypad_type = NOT_SET;
 	struct pardev_cb panel_cb;
 
-	if (port->number != parport)
-		return;
-
-	if (pprt) {
-		pr_err("%s: port->number=%d parport=%d, already registered!\n",
-		       __func__, port->number, parport);
-		return;
-	}
-
-	memset(&panel_cb, 0, sizeof(panel_cb));
-	panel_cb.private = &pprt;
-	/* panel_cb.flags = 0 should be PARPORT_DEV_EXCL? */
-
-	pprt = parport_register_dev_model(port, "panel", &panel_cb, 0);
-	if (!pprt) {
-		pr_err("%s: port->number=%d parport=%d, parport_register_device() failed\n",
-		       __func__, port->number, parport);
-		return;
-	}
-
-	if (parport_claim(pprt)) {
-		pr_err("could not claim access to parport%d. Aborting.\n",
-		       parport);
-		goto err_unreg_device;
-	}
-
-	/* must init LCD first, just in case an IRQ from the keypad is
-	 * generated at keypad init
-	 */
-	if (lcd.enabled) {
-		lcd_init();
-		if (!lcd.charlcd || charlcd_register(lcd.charlcd))
-			goto err_unreg_device;
-	}
-
-	if (keypad.enabled) {
-		keypad_init();
-		if (misc_register(&keypad_dev))
-			goto err_lcd_unreg;
-	}
-	return;
-
-err_lcd_unreg:
-	if (scan_timer.function)
-		del_timer_sync(&scan_timer);
-	if (lcd.enabled)
-		charlcd_unregister(lcd.charlcd);
-err_unreg_device:
-	kfree(lcd.charlcd);
-	lcd.charlcd = NULL;
-	parport_unregister_device(pprt);
-	pprt = NULL;
-}
-
-static void panel_detach(struct parport *port)
-{
-	if (port->number != parport)
-		return;
-
-	if (!pprt) {
-		pr_err("%s: port->number=%d parport=%d, nothing to unregister.\n",
-		       __func__, port->number, parport);
-		return;
-	}
-	if (scan_timer.function)
-		del_timer_sync(&scan_timer);
-
-	if (keypad.enabled) {
-		misc_deregister(&keypad_dev);
-		keypad_initialized = 0;
-	}
-
-	if (lcd.enabled) {
-		charlcd_unregister(lcd.charlcd);
-		lcd.initialized = false;
-		kfree(lcd.charlcd->drvdata);
-		kfree(lcd.charlcd);
-		lcd.charlcd = NULL;
-	}
-
-	/* TODO: free all input signals */
-	parport_release(pprt);
-	parport_unregister_device(pprt);
-	pprt = NULL;
-}
-
-static struct parport_driver panel_driver = {
-	.name = "panel",
-	.match_port = panel_attach,
-	.detach = panel_detach,
-	.devmodel = true,
-};
-
-/* init function */
-static int __init panel_init_module(void)
-{
-	int selected_keypad_type = NOT_SET, err;
-
 	/* take care of an eventual profile */
 	switch (profile) {
 	case PANEL_PROFILE_CUSTOM:
@@ -1714,26 +1617,99 @@ static int __init panel_init_module(void)
 		return -ENODEV;
 	}
 
-	err = parport_register_driver(&panel_driver);
-	if (err) {
-		pr_err("could not register with parport. Aborting.\n");
-		return err;
+	if (port->number != parport)
+		return;
+
+	if (pprt) {
+		pr_err("%s: port->number=%d parport=%d, already registered!\n",
+		       __func__, port->number, parport);
+		return;
 	}
 
-	if (pprt)
-		pr_info("panel driver registered on parport%d (io=0x%lx).\n",
-			parport, pprt->port->base);
-	else
-		pr_info("panel driver not yet registered\n");
-	return 0;
+	memset(&panel_cb, 0, sizeof(panel_cb));
+	panel_cb.private = &pprt;
+	/* panel_cb.flags = 0 should be PARPORT_DEV_EXCL? */
+
+	pprt = parport_register_dev_model(port, "panel", &panel_cb, 0);
+	if (!pprt) {
+		pr_err("%s: port->number=%d parport=%d, parport_register_device() failed\n",
+		       __func__, port->number, parport);
+		return;
+	}
+
+	if (parport_claim(pprt)) {
+		pr_err("could not claim access to parport%d. Aborting.\n",
+		       parport);
+		goto err_unreg_device;
+	}
+
+	/* must init LCD first, just in case an IRQ from the keypad is
+	 * generated at keypad init
+	 */
+	if (lcd.enabled) {
+		lcd_init();
+		if (!lcd.charlcd || charlcd_register(lcd.charlcd))
+			goto err_unreg_device;
+	}
+
+	if (keypad.enabled) {
+		keypad_init();
+		if (misc_register(&keypad_dev))
+			goto err_lcd_unreg;
+	}
+	return;
+
+err_lcd_unreg:
+	if (scan_timer.function)
+		del_timer_sync(&scan_timer);
+	if (lcd.enabled)
+		charlcd_unregister(lcd.charlcd);
+err_unreg_device:
+	kfree(lcd.charlcd);
+	lcd.charlcd = NULL;
+	parport_unregister_device(pprt);
+	pprt = NULL;
 }
 
-static void __exit panel_cleanup_module(void)
+static void panel_detach(struct parport *port)
 {
-	parport_unregister_driver(&panel_driver);
+	if (port->number != parport)
+		return;
+
+	if (!pprt) {
+		pr_err("%s: port->number=%d parport=%d, nothing to unregister.\n",
+		       __func__, port->number, parport);
+		return;
+	}
+	if (scan_timer.function)
+		del_timer_sync(&scan_timer);
+
+	if (keypad.enabled) {
+		misc_deregister(&keypad_dev);
+		keypad_initialized = 0;
+	}
+
+	if (lcd.enabled) {
+		charlcd_unregister(lcd.charlcd);
+		lcd.initialized = false;
+		kfree(lcd.charlcd->drvdata);
+		kfree(lcd.charlcd);
+		lcd.charlcd = NULL;
+	}
+
+	/* TODO: free all input signals */
+	parport_release(pprt);
+	parport_unregister_device(pprt);
+	pprt = NULL;
 }
 
-module_init(panel_init_module);
-module_exit(panel_cleanup_module);
+static struct parport_driver panel_driver = {
+	.name = "panel",
+	.match_port = panel_attach,
+	.detach = panel_detach,
+	.devmodel = true,
+};
+module_parport_driver(panel_driver);
+
 MODULE_AUTHOR("Willy Tarreau");
 MODULE_LICENSE("GPL");
-- 
2.30.2

