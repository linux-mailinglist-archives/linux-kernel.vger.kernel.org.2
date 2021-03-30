Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC634EA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhC3Oi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhC3OiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E692C619D3;
        Tue, 30 Mar 2021 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115086;
        bh=kr6okVgaxdFe672zZFhMyvVfCQNT17c0uIl2nrqJeuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVxoCj4YN0EJJSEAKShzYGhSUXFKrolPA9ICwsowIS03Uo1tRARbdY98ExeTwvEgV
         3k2hXL1NXq/zlnLNJiZyJLLUZXdNzRNxnOH/Cr+HDeN62T3VCevC91q+5tpjoATBWo
         qcUK35beQHK9CqKuXTGtjv9gYpDkkUIuQyE0Z+TX+KdR8CAEHaT/CAKMQhYFt0h3RG
         /P3knAZivTvnHANgGLYRtFsGEE+4YweuBQuigtd8SOcqIpEPl0cbJNx5Z/zIVooq0P
         iVINcNAsfyIDOy4g84OleKGTXoeeUb2evwBNrCTXHxEPbJc/0m6YdgxOxrjtcxP3cC
         xo+kROYtDVT8w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFVj-0002Np-Hy; Tue, 30 Mar 2021 16:38:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] USB: serial: add support for multi-interface functions
Date:   Tue, 30 Mar 2021 16:38:19 +0200
Message-Id: <20210330143820.9103-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143820.9103-1-johan@kernel.org>
References: <20210330143820.9103-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single USB function can be implemented using a group of interfaces and
this is for example commonly used for Communication Class devices.

Add support for multi-interface functions to USB serial core and export
an interface that allows drivers to claim a second sibling interface.
The interface could easily be extended to allow claiming further
interfaces if ever needed.

When a driver claims a sibling interface in probe(), core allocates
resources for any bulk in, bulk out, interrupt in and interrupt out
endpoints found also on the sibling interface.

Disconnect is implemented so that unbinding either interface will
release the other interface while disconnect() is called precisely once.

Similarly, suspend() is called when the first sibling interface is
suspended and resume() is called when the last sibling interface is
resumed by USB core.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 84 ++++++++++++++++++++++++++++-----
 include/linux/usb/serial.h      |  7 +++
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index d981809c4ed3..aaae71a0bbff 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -121,6 +121,44 @@ static void release_minors(struct usb_serial *serial)
 	serial->minors_reserved = 0;
 }
 
+int usb_serial_claim_interface(struct usb_serial *serial, struct usb_interface *intf)
+{
+	struct usb_driver *driver = serial->type->usb_driver;
+	int ret;
+
+	if (serial->sibling)
+		return -EBUSY;
+
+	ret = usb_driver_claim_interface(driver, intf, serial);
+	if (ret) {
+		dev_err(&serial->interface->dev,
+				"failed to claim sibling interface: %d\n", ret);
+		return ret;
+	}
+
+	serial->sibling = intf;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_serial_claim_interface);
+
+static void release_sibling(struct usb_serial *serial, struct usb_interface *intf)
+{
+	struct usb_driver *driver = serial->type->usb_driver;
+	struct usb_interface *sibling;
+
+	if (!serial->sibling)
+		return;
+
+	if (intf == serial->sibling)
+		sibling = serial->interface;
+	else
+		sibling = serial->sibling;
+
+	usb_set_intfdata(sibling, NULL);
+	usb_driver_release_interface(driver, sibling);
+}
+
 static void destroy_serial(struct kref *kref)
 {
 	struct usb_serial *serial;
@@ -742,13 +780,14 @@ static void store_endpoint(struct usb_serial *serial,
 }
 
 static void find_endpoints(struct usb_serial *serial,
-					struct usb_serial_endpoints *epds)
+					struct usb_serial_endpoints *epds,
+					struct usb_interface *intf)
 {
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *epd;
 	unsigned int i;
 
-	iface_desc = serial->interface->cur_altsetting;
+	iface_desc = intf->cur_altsetting;
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		epd = &iface_desc->endpoint[i].desc;
 		store_endpoint(serial, epds, epd);
@@ -917,7 +956,7 @@ static int usb_serial_probe(struct usb_interface *interface,
 
 		if (retval) {
 			dev_dbg(ddev, "sub driver rejected device\n");
-			goto err_put_serial;
+			goto err_release_sibling;
 		}
 	}
 
@@ -925,10 +964,12 @@ static int usb_serial_probe(struct usb_interface *interface,
 	epds = kzalloc(sizeof(*epds), GFP_KERNEL);
 	if (!epds) {
 		retval = -ENOMEM;
-		goto err_put_serial;
+		goto err_release_sibling;
 	}
 
-	find_endpoints(serial, epds);
+	find_endpoints(serial, epds, interface);
+	if (serial->sibling)
+		find_endpoints(serial, epds, serial->sibling);
 
 	if (epds->num_bulk_in < type->num_bulk_in ||
 			epds->num_bulk_out < type->num_bulk_out ||
@@ -1076,7 +1117,8 @@ static int usb_serial_probe(struct usb_interface *interface,
 
 err_free_epds:
 	kfree(epds);
-err_put_serial:
+err_release_sibling:
+	release_sibling(serial, interface);
 	usb_serial_put(serial);
 err_put_module:
 	module_put(type->driver.owner);
@@ -1092,6 +1134,10 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 	struct usb_serial_port *port;
 	struct tty_struct *tty;
 
+	/* sibling interface is cleaning up */
+	if (!serial)
+		return;
+
 	usb_serial_console_disconnect(serial);
 
 	mutex_lock(&serial->disc_mutex);
@@ -1115,6 +1161,8 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 	if (serial->type->disconnect)
 		serial->type->disconnect(serial);
 
+	release_sibling(serial, interface);
+
 	/* let the last holder of this object cause it to be cleaned up */
 	usb_serial_put(serial);
 	dev_info(dev, "device disconnected\n");
@@ -1123,7 +1171,11 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usb_serial *serial = usb_get_intfdata(intf);
-	int i, r = 0;
+	int i, r;
+
+	/* suspend when called for first sibling interface */
+	if (serial->suspend_count++)
+		return 0;
 
 	/*
 	 * serial->type->suspend() MUST return 0 in system sleep context,
@@ -1132,14 +1184,16 @@ int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
 	 */
 	if (serial->type->suspend) {
 		r = serial->type->suspend(serial, message);
-		if (r < 0)
-			goto err_out;
+		if (r < 0) {
+			serial->suspend_count--;
+			return r;
+		}
 	}
 
 	for (i = 0; i < serial->num_ports; ++i)
 		usb_serial_port_poison_urbs(serial->port[i]);
-err_out:
-	return r;
+
+	return 0;
 }
 EXPORT_SYMBOL(usb_serial_suspend);
 
@@ -1156,6 +1210,10 @@ int usb_serial_resume(struct usb_interface *intf)
 	struct usb_serial *serial = usb_get_intfdata(intf);
 	int rv;
 
+	/* resume when called for last sibling interface */
+	if (--serial->suspend_count)
+		return 0;
+
 	usb_serial_unpoison_port_urbs(serial);
 
 	if (serial->type->resume)
@@ -1172,6 +1230,10 @@ static int usb_serial_reset_resume(struct usb_interface *intf)
 	struct usb_serial *serial = usb_get_intfdata(intf);
 	int rv;
 
+	/* resume when called for last sibling interface */
+	if (--serial->suspend_count)
+		return 0;
+
 	usb_serial_unpoison_port_urbs(serial);
 
 	if (serial->type->reset_resume) {
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 7efba6caaadc..e9b90577f50b 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -130,6 +130,8 @@ static inline void usb_set_serial_port_data(struct usb_serial_port *port,
  * @dev: pointer to the struct usb_device for this device
  * @type: pointer to the struct usb_serial_driver for this device
  * @interface: pointer to the struct usb_interface for this device
+ * @sibling: pointer to the struct usb_interface of any sibling interface
+ * @suspend_count: number of suspended (sibling) interfaces
  * @num_ports: the number of ports this device has
  * @num_interrupt_in: number of interrupt in endpoints we have
  * @num_interrupt_out: number of interrupt out endpoints we have
@@ -145,6 +147,8 @@ struct usb_serial {
 	struct usb_device		*dev;
 	struct usb_serial_driver	*type;
 	struct usb_interface		*interface;
+	struct usb_interface		*sibling;
+	unsigned int			suspend_count;
 	unsigned char			disconnected:1;
 	unsigned char			attached:1;
 	unsigned char			minors_reserved:1;
@@ -334,6 +338,9 @@ static inline void usb_serial_console_disconnect(struct usb_serial *serial) {}
 /* Functions needed by other parts of the usbserial core */
 struct usb_serial_port *usb_serial_port_get_by_minor(unsigned int minor);
 void usb_serial_put(struct usb_serial *serial);
+
+int usb_serial_claim_interface(struct usb_serial *serial, struct usb_interface *intf);
+
 int usb_serial_generic_open(struct tty_struct *tty, struct usb_serial_port *port);
 int usb_serial_generic_write_start(struct usb_serial_port *port, gfp_t mem_flags);
 int usb_serial_generic_write(struct tty_struct *tty, struct usb_serial_port *port,
-- 
2.26.3

