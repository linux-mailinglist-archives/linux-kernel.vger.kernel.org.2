Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C015406B36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhIJMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232952AbhIJMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:13:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D062D611C7;
        Fri, 10 Sep 2021 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631275934;
        bh=OGpeKe8qlKrKG2MWCkAbVaugcCWxiuy7ISiHVSw/oOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyAKLVfE0WPaM/hiFJaves446nQfPAhOHKZ16jHFcadokK40JHGWDQMxOm97sSx97
         R+9yQUDk721dloiz72HxcwPVui90q1xUM/xy2RjumvzeXr7uIU9Pww6wDj+zLQPMGj
         wedM0eGNh1VhjnCxmBJFscNtSn53joXGgp6r4f/ks4YFUkpa9SloagnVbEvUrIwcEu
         9iiU6oZhEgOOafGrsgLnKaGAU6hyskjKgBRFCzu2vxoIC4k96nEXUkSehSdr+0Wmw0
         FXVlDstzABo3OypSM9sdE+ALRDjHMkMvmq11ihLgxrL3Svf53/W7gt2baE8E4ll06p
         Me+WWWvwYuFWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mOfO2-0004s1-8h; Fri, 10 Sep 2021 14:12:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: allow hung up ports to be suspended
Date:   Fri, 10 Sep 2021 14:11:28 +0200
Message-Id: <20210910121128.18664-3-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910121128.18664-1-johan@kernel.org>
References: <20210910121128.18664-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space can keep a tty open indefinitely and that should not prevent
a hung up port and its USB device from being runtime suspended.

Fix this by incrementing the PM usage counter when the port it activated
and decrementing the counter when the port is shutdown rather than when
the tty is installed and the last reference is dropped, respectively.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index abc657fec8c5..b357361d5d1e 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -208,8 +208,8 @@ void usb_serial_put(struct usb_serial *serial)
  *
  * This is the first place a new tty gets used.  Hence this is where we
  * acquire references to the usb_serial structure and the driver module,
- * where we store a pointer to the port, and where we do an autoresume.
- * All these actions are reversed in serial_cleanup().
+ * where we store a pointer to the port.  All these actions are reversed
+ * in serial_cleanup().
  */
 static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 {
@@ -227,15 +227,11 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (!try_module_get(serial->type->driver.owner))
 		goto err_put_serial;
 
-	retval = usb_autopm_get_interface(serial->interface);
-	if (retval)
-		goto err_put_module;
-
 	init_termios = (driver->termios[idx] == NULL);
 
 	retval = tty_standard_install(driver, tty);
 	if (retval)
-		goto err_put_autopm;
+		goto err_put_module;
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -247,8 +243,6 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
-err_put_autopm:
-	usb_autopm_put_interface(serial->interface);
 err_put_module:
 	module_put(serial->type->driver.owner);
 err_put_serial:
@@ -265,10 +259,19 @@ static int serial_port_activate(struct tty_port *tport, struct tty_struct *tty)
 	int retval;
 
 	mutex_lock(&serial->disc_mutex);
-	if (serial->disconnected)
+	if (serial->disconnected) {
 		retval = -ENODEV;
-	else
-		retval = port->serial->type->open(tty, port);
+		goto out_unlock;
+	}
+
+	retval = usb_autopm_get_interface(serial->interface);
+	if (retval)
+		goto out_unlock;
+
+	retval = port->serial->type->open(tty, port);
+	if (retval)
+		usb_autopm_put_interface(serial->interface);
+out_unlock:
 	mutex_unlock(&serial->disc_mutex);
 
 	if (retval < 0)
@@ -304,6 +307,8 @@ static void serial_port_shutdown(struct tty_port *tport)
 
 	if (drv->close)
 		drv->close(port);
+
+	usb_autopm_put_interface(port->serial->interface);
 }
 
 static void serial_hangup(struct tty_struct *tty)
@@ -352,8 +357,6 @@ static void serial_cleanup(struct tty_struct *tty)
 	serial = port->serial;
 	owner = serial->type->driver.owner;
 
-	usb_autopm_put_interface(serial->interface);
-
 	usb_serial_put(serial);
 	module_put(owner);
 }
-- 
2.32.0

