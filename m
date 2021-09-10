Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519D406B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhIJMNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhIJMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:13:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4FB9611C8;
        Fri, 10 Sep 2021 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631275934;
        bh=FMoeBPCeVHQUwz+/csiaf0amqGtD7QOPcnxzuwU0WtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nz679UGiVMbIOpMcau/2U0nthGFmsj+ejhIu+PLqF3mrZNPsYQbdZwdgEeAu3zaw3
         FOm9/5mR/IAOgRchtzBrYWP1UJ2nu/Y3jsJ+GGaJJhBXMQgNfGbbrcScLaaUDgzQl7
         KLadb35F0hp3kZwSMNgeIlPFmMiH9/w20OHtSS/KkhTf1Zoxequ/C52AMgssgzGrop
         xQ9RRijduLYwaZ3ykeW0/XnvyB9PySCM1jOHbmyin6+4w12b3cxA1pMvbPggezh6rm
         dVo7sMn81QGnnfmg2u2YDMIQK+lrQsVEaeQfn0gp/wjSj8Pfis1kBcke0qv4zlDMHo
         yNfa/UoZVp5Uw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mOfO2-0004rz-6B; Fri, 10 Sep 2021 14:12:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: clean up core error labels
Date:   Fri, 10 Sep 2021 14:11:27 +0200
Message-Id: <20210910121128.18664-2-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910121128.18664-1-johan@kernel.org>
References: <20210910121128.18664-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the core error labels by consistently naming them after what
they do rather than after from where they are jumped to.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index eeb441c77207..abc657fec8c5 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -225,17 +225,17 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	serial = port->serial;
 	if (!try_module_get(serial->type->driver.owner))
-		goto error_module_get;
+		goto err_put_serial;
 
 	retval = usb_autopm_get_interface(serial->interface);
 	if (retval)
-		goto error_get_interface;
+		goto err_put_module;
 
 	init_termios = (driver->termios[idx] == NULL);
 
 	retval = tty_standard_install(driver, tty);
 	if (retval)
-		goto error_init_termios;
+		goto err_put_autopm;
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -247,11 +247,11 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
+err_put_autopm:
 	usb_autopm_put_interface(serial->interface);
- error_get_interface:
+err_put_module:
 	module_put(serial->type->driver.owner);
- error_module_get:
+err_put_serial:
 	usb_serial_put(serial);
 	mutex_unlock(&serial->disc_mutex);
 	return retval;
@@ -1327,7 +1327,7 @@ static int __init usb_serial_init(void)
 	result = bus_register(&usb_serial_bus_type);
 	if (result) {
 		pr_err("%s - registering bus driver failed\n", __func__);
-		goto exit_bus;
+		goto err_put_driver;
 	}
 
 	usb_serial_tty_driver->driver_name = "usbserial";
@@ -1347,25 +1347,23 @@ static int __init usb_serial_init(void)
 	result = tty_register_driver(usb_serial_tty_driver);
 	if (result) {
 		pr_err("%s - tty_register_driver failed\n", __func__);
-		goto exit_reg_driver;
+		goto err_unregister_bus;
 	}
 
 	/* register the generic driver, if we should */
 	result = usb_serial_generic_register();
 	if (result < 0) {
 		pr_err("%s - registering generic driver failed\n", __func__);
-		goto exit_generic;
+		goto err_unregister_driver;
 	}
 
 	return result;
 
-exit_generic:
+err_unregister_driver:
 	tty_unregister_driver(usb_serial_tty_driver);
-
-exit_reg_driver:
+err_unregister_bus:
 	bus_unregister(&usb_serial_bus_type);
-
-exit_bus:
+err_put_driver:
 	pr_err("%s - returning with error %d\n", __func__, result);
 	put_tty_driver(usb_serial_tty_driver);
 	return result;
@@ -1510,13 +1508,13 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
 	rc = usb_register(udriver);
 	if (rc)
-		goto failed_usb_register;
+		goto err_free_driver;
 
 	for (sd = serial_drivers; *sd; ++sd) {
 		(*sd)->usb_driver = udriver;
 		rc = usb_serial_register(*sd);
 		if (rc)
-			goto failed;
+			goto err_deregister_drivers;
 	}
 
 	/* Now set udriver's id_table and look for matches */
@@ -1524,11 +1522,11 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 	rc = driver_attach(&udriver->drvwrap.driver);
 	return 0;
 
- failed:
+err_deregister_drivers:
 	while (sd-- > serial_drivers)
 		usb_serial_deregister(*sd);
 	usb_deregister(udriver);
-failed_usb_register:
+err_free_driver:
 	kfree(udriver);
 	return rc;
 }
-- 
2.32.0

