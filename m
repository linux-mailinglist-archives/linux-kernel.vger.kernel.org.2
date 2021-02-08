Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D474313D51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhBHSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232159AbhBHPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:48:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD09464E60;
        Mon,  8 Feb 2021 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612799281;
        bh=PItUJHlIhnMJGEXKGysuzUkGG/a3tdRmx1rjVzOOgPY=;
        h=From:To:Cc:Subject:Date:From;
        b=UffVNtKu6GgAHOxqgXXxlkscrglVfRMDORXpafN1W+CVZ0JwEAlrQQJ9vfjM+XOxZ
         QHv/EihI25tpRpywMngSqaDuS0Q3QjIfu8TT1cAunk+8MqbiTEwXkPmfLHfVdv71n3
         RvYgIYdOd0sLfvP6RlThy7wNMtgYZ4hmaZ56ATjonf6DOUcOQYNAXylGdskZWKQH8M
         7rjLEdaS14mOMdJrt8yK5FhQz/gYNEaAP3V5iGOD1eC9V0iO2A1e/LWRYzO4NEIV/5
         nhQfm2bolyJMxSYvCHAV/RiT58yAHFtptTgpbL7c8lOkYpTRFgEKkwC63v0/Y3/UcK
         IS7WB9z1HbiBQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l98lt-0005R4-U1; Mon, 08 Feb 2021 16:48:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] USB: serial: drop bogus to_usb_serial_port() checks
Date:   Mon,  8 Feb 2021 16:48:06 +0100
Message-Id: <20210208154806.20853-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The to_usb_serial_port() macro is implemented using container_of() so
there's no need to check for NULL.

Note that neither bus match() or probe() is ever called with a NULL
struct device pointer so the checks weren't just misplaced.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/bus.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 1a8c7821d00a..7133818a58b9 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -16,19 +16,13 @@
 static int usb_serial_device_match(struct device *dev,
 						struct device_driver *drv)
 {
-	struct usb_serial_driver *driver;
-	const struct usb_serial_port *port;
+	const struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct usb_serial_driver *driver = to_usb_serial_driver(drv);
 
 	/*
 	 * drivers are already assigned to ports in serial_probe so it's
 	 * a simple check here.
 	 */
-	port = to_usb_serial_port(dev);
-	if (!port)
-		return 0;
-
-	driver = to_usb_serial_driver(drv);
-
 	if (driver == port->serial->type)
 		return 1;
 
@@ -37,16 +31,12 @@ static int usb_serial_device_match(struct device *dev,
 
 static int usb_serial_device_probe(struct device *dev)
 {
+	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct usb_serial_driver *driver;
-	struct usb_serial_port *port;
 	struct device *tty_dev;
 	int retval = 0;
 	int minor;
 
-	port = to_usb_serial_port(dev);
-	if (!port)
-		return -ENODEV;
-
 	/* make sure suspend/resume doesn't race against port_probe */
 	retval = usb_autopm_get_interface(port->serial->interface);
 	if (retval)
-- 
2.26.2

