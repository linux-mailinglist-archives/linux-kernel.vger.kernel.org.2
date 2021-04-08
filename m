Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2D3587E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhDHPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhDHPJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C676610F9;
        Thu,  8 Apr 2021 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617894567;
        bh=Q1tb7NsUPYnKrwr/XvbzX2fwGPuRF4h+16uhX9RhtsM=;
        h=From:To:Cc:Subject:Date:From;
        b=AiOiWukeoQy1QPe9ohrxnpP8WVxClmjNuvVddbsGgp/dlFIMLD85C3r9gkbkPrrRT
         KpicuGzzZAXT3xOtCFHBP4w4kreKt8k9L5iigFSMF188t1qdEovrBGQbvCJTSnG39J
         Ic9RjfhoMM6mZbZ61FQXWoZHZHzkojHSDEC9oKNbH8O8+Vd4Dvrakh5BrzKKM19UO+
         SPR0jBXkHqsY6b6nbyAlj1geq0HPNGIYsYvAOaDqiX6pxh0HmZn2xTw8qZoYRyjQMN
         REVT/gHc6LEf28Reg63Vm1Kywir68QkU5GikmuQhQwZNj9/XteI0mlwvYMlapL51rP
         jX9Ux9DoNefRg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUWHb-0004Oq-6e; Thu, 08 Apr 2021 17:09:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: do not use tty class device for debugging
Date:   Thu,  8 Apr 2021 17:08:59 +0200
Message-Id: <20210408150859.16868-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the port struct device rather than tty class device for debugging.

Note that while USB serial doesn't support serdev yet (due to serdev not
handling hotplugging), serdev ttys do not have a corresponding class
device and would have been logged using a "(NULL device *):" prefix.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/metro-usb.c  |  4 ++--
 drivers/usb/serial/upd78f0730.c |  7 +++----
 drivers/usb/serial/usb-serial.c | 32 ++++++++++++++++----------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index 0bfe4459c37f..f9ce9e7b9b80 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -299,7 +299,7 @@ static int metrousb_tiocmset(struct tty_struct *tty,
 	unsigned long flags = 0;
 	unsigned long control_state = 0;
 
-	dev_dbg(tty->dev, "%s - set=%d, clear=%d\n", __func__, set, clear);
+	dev_dbg(&port->dev, "%s - set=%d, clear=%d\n", __func__, set, clear);
 
 	spin_lock_irqsave(&metro_priv->lock, flags);
 	control_state = metro_priv->control_state;
@@ -334,7 +334,7 @@ static void metrousb_unthrottle(struct tty_struct *tty)
 	/* Submit the urb to read from the port. */
 	result = usb_submit_urb(port->interrupt_in_urb, GFP_ATOMIC);
 	if (result)
-		dev_err(tty->dev,
+		dev_err(&port->dev,
 			"failed submitting interrupt in urb error code=%d\n",
 			result);
 }
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 26d7b003b7e3..63d4a784ae45 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -182,7 +182,6 @@ static void upd78f0730_port_remove(struct usb_serial_port *port)
 
 static int upd78f0730_tiocmget(struct tty_struct *tty)
 {
-	struct device *dev = tty->dev;
 	struct upd78f0730_port_private *private;
 	struct usb_serial_port *port = tty->driver_data;
 	int signals;
@@ -197,7 +196,7 @@ static int upd78f0730_tiocmget(struct tty_struct *tty)
 	res = ((signals & UPD78F0730_DTR) ? TIOCM_DTR : 0) |
 		((signals & UPD78F0730_RTS) ? TIOCM_RTS : 0);
 
-	dev_dbg(dev, "%s - res = %x\n", __func__, res);
+	dev_dbg(&port->dev, "%s - res = %x\n", __func__, res);
 
 	return res;
 }
@@ -205,10 +204,10 @@ static int upd78f0730_tiocmget(struct tty_struct *tty)
 static int upd78f0730_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear)
 {
-	struct device *dev = tty->dev;
 	struct usb_serial_port *port = tty->driver_data;
 	struct upd78f0730_port_private *private;
 	struct upd78f0730_set_dtr_rts request;
+	struct device *dev = &port->dev;
 	int res;
 
 	private = usb_get_serial_port_data(port);
@@ -241,10 +240,10 @@ static int upd78f0730_tiocmset(struct tty_struct *tty,
 
 static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
-	struct device *dev = tty->dev;
 	struct upd78f0730_port_private *private;
 	struct usb_serial_port *port = tty->driver_data;
 	struct upd78f0730_set_dtr_rts request;
+	struct device *dev = &port->dev;
 
 	private = usb_get_serial_port_data(port);
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 255f562ef1a0..98b33b1b5357 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -281,7 +281,7 @@ static int serial_open(struct tty_struct *tty, struct file *filp)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	return tty_port_open(&port->port, tty, filp);
 }
@@ -310,7 +310,7 @@ static void serial_hangup(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	tty_port_hangup(&port->port);
 }
@@ -319,7 +319,7 @@ static void serial_close(struct tty_struct *tty, struct file *filp)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	tty_port_close(&port->port, tty, filp);
 }
@@ -339,7 +339,7 @@ static void serial_cleanup(struct tty_struct *tty)
 	struct usb_serial *serial;
 	struct module *owner;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	/* The console is magical.  Do not hang up the console hardware
 	 * or there will be tears.
@@ -367,7 +367,7 @@ static int serial_write(struct tty_struct *tty, const unsigned char *buf,
 	if (port->serial->dev->state == USB_STATE_NOTATTACHED)
 		goto exit;
 
-	dev_dbg(tty->dev, "%s - %d byte(s)\n", __func__, count);
+	dev_dbg(&port->dev, "%s - %d byte(s)\n", __func__, count);
 
 	retval = port->serial->type->write(tty, port, buf, count);
 	if (retval < 0)
@@ -380,7 +380,7 @@ static int serial_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	return port->serial->type->write_room(tty);
 }
@@ -390,7 +390,7 @@ static int serial_chars_in_buffer(struct tty_struct *tty)
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (serial->disconnected)
 		return 0;
@@ -403,7 +403,7 @@ static void serial_wait_until_sent(struct tty_struct *tty, int timeout)
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (!port->serial->type->wait_until_sent)
 		return;
@@ -418,7 +418,7 @@ static void serial_throttle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->throttle)
 		port->serial->type->throttle(tty);
@@ -428,7 +428,7 @@ static void serial_unthrottle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->unthrottle)
 		port->serial->type->unthrottle(tty);
@@ -501,7 +501,7 @@ static int serial_ioctl(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -ENOIOCTLCMD;
 
-	dev_dbg(tty->dev, "%s - cmd 0x%04x\n", __func__, cmd);
+	dev_dbg(&port->dev, "%s - cmd 0x%04x\n", __func__, cmd);
 
 	switch (cmd) {
 	case TIOCMIWAIT:
@@ -520,7 +520,7 @@ static void serial_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->set_termios)
 		port->serial->type->set_termios(tty, port, old);
@@ -532,7 +532,7 @@ static int serial_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->break_ctl)
 		port->serial->type->break_ctl(tty, break_state);
@@ -579,7 +579,7 @@ static int serial_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->tiocmget)
 		return port->serial->type->tiocmget(tty);
@@ -591,7 +591,7 @@ static int serial_tiocmset(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->tiocmset)
 		return port->serial->type->tiocmset(tty, set, clear);
@@ -603,7 +603,7 @@ static int serial_get_icount(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	dev_dbg(tty->dev, "%s\n", __func__);
+	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->get_icount)
 		return port->serial->type->get_icount(tty, icount);
-- 
2.26.3

