Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68E3388A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbhESJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344951AbhESJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CAF461363;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=RLQFovnxGyeCq9RZvMxT7WIIXWK0rhVwwaRKTMU2wq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my/MOYNSNUbXGQHUBcDBlygvsNmZf6u/6/Vo0R4NjN3KVvSBC9epNWaxhjlZvKgco
         S5aqG4Ve6L2cwy/rDGLVHQ3ZijkW8yU/lyio4gjvHFjXeqluG5F3cIwrdxRV07hATy
         lZVL5x8oQyXyBDBApYzf262fZhg2BS6Fvx5bfxF3OrhD3IJuISmHdSu2gFGRyYxiNy
         Q42/4/vHfuaQHEa9JiUfhvbker5vgez1tA0qloK/EZFt7kBL2h6rKUbXkKtSkxGmAA
         Sq0U0JA0hT4x8NhsMm2i1oQWfSYR5kA+klxsCeTmk+6ivp5jsWwQAjnz4q99gQbndw
         oqcn863zLRPwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002Yn-Vp; Wed, 19 May 2021 11:20:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] USB: serial: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:20:06 +0200
Message-Id: <20210519092006.9775-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to initialise irq-flags variables before saving the
interrupt state.

Drop the redundant initialisations from the three drivers that got this
wrong.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 13 ++++++-------
 drivers/usb/serial/metro-usb.c       | 12 ++++++------
 drivers/usb/serial/quatech2.c        |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 754c66ff0fc1..af65eb863d70 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -372,7 +372,7 @@ static int digi_write_oob_command(struct usb_serial_port *port,
 	int len;
 	struct usb_serial_port *oob_port = (struct usb_serial_port *)((struct digi_serial *)(usb_get_serial_data(port->serial)))->ds_oob_port;
 	struct digi_port *oob_priv = usb_get_serial_port_data(oob_port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(&port->dev,
 		"digi_write_oob_command: TOP: port=%d, count=%d\n",
@@ -430,7 +430,7 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 	int len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(&port->dev, "digi_write_inb_command: TOP: port=%d, count=%d\n",
 		priv->dp_port_num, count);
@@ -511,8 +511,7 @@ static int digi_set_modem_signals(struct usb_serial_port *port,
 	struct usb_serial_port *oob_port = (struct usb_serial_port *) ((struct digi_serial *)(usb_get_serial_data(port->serial)))->ds_oob_port;
 	struct digi_port *oob_priv = usb_get_serial_port_data(oob_port);
 	unsigned char *data = oob_port->write_urb->transfer_buffer;
-	unsigned long flags = 0;
-
+	unsigned long flags;
 
 	dev_dbg(&port->dev,
 		"digi_set_modem_signals: TOP: port=%d, modem_signals=0x%x\n",
@@ -577,7 +576,7 @@ static int digi_transmit_idle(struct usb_serial_port *port,
 	int ret;
 	unsigned char buf[2];
 	struct digi_port *priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
 	priv->dp_transmit_idle = 0;
@@ -887,7 +886,7 @@ static int digi_write(struct tty_struct *tty, struct usb_serial_port *port,
 	int ret, data_len, new_len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(&port->dev, "digi_write: TOP: port=%d, count=%d\n",
 		priv->dp_port_num, count);
@@ -1024,8 +1023,8 @@ static unsigned int digi_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct digi_port *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	unsigned int room;
-	unsigned long flags = 0;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
 
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index f9ce9e7b9b80..30ab565e0738 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -109,9 +109,9 @@ static void metrousb_read_int_callback(struct urb *urb)
 	struct usb_serial_port *port = urb->context;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
+	unsigned long flags;
 	int throttled = 0;
 	int result = 0;
-	unsigned long flags = 0;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
@@ -171,7 +171,7 @@ static int metrousb_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	int result = 0;
 
 	/* Set the private data information for the port. */
@@ -268,7 +268,7 @@ static void metrousb_throttle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	/* Set the private information for the port to stop reading data. */
 	spin_lock_irqsave(&metro_priv->lock, flags);
@@ -281,7 +281,7 @@ static int metrousb_tiocmget(struct tty_struct *tty)
 	unsigned long control_state = 0;
 	struct usb_serial_port *port = tty->driver_data;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	spin_lock_irqsave(&metro_priv->lock, flags);
 	control_state = metro_priv->control_state;
@@ -296,7 +296,7 @@ static int metrousb_tiocmset(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned long control_state = 0;
 
 	dev_dbg(&port->dev, "%s - set=%d, clear=%d\n", __func__, set, clear);
@@ -323,7 +323,7 @@ static void metrousb_unthrottle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct metrousb_private *metro_priv = usb_get_serial_port_data(port);
-	unsigned long flags = 0;
+	unsigned long flags;
 	int result = 0;
 
 	/* Set the private information for the port to resume reading data. */
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 3b5f2032ecdb..d3377f3b5a23 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -874,7 +874,7 @@ static unsigned int qt2_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct qt2_port_private *port_priv;
-	unsigned long flags = 0;
+	unsigned long flags;
 	unsigned int r;
 
 	port_priv = usb_get_serial_port_data(port);
-- 
2.26.3

