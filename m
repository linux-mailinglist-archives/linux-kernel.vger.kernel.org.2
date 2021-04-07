Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6CA356A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbhDGKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351168AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B9FE613CF;
        Wed,  7 Apr 2021 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=rko33dhmJE5C8TBzYzW+l/pc/wZvDB0H/7SSHqLc+1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/Mkp++hJHVNqU4RM7LE8HVOOxa5t32jyCf/iC0zfuDaBpqZzYbX4E6lHJebwoS/p
         Eoz01ihiGtDB+5IOoTin6eNdvobBFuQ/NykgJVJukhL3g6zvAhKC0gSs7rcJdgOYtK
         54hzmy5kPnmRxdtfor5p52xxEPWCnmpMIkWzrg3AjoVaiRgIbon5dhpJ9DjIacY/Qp
         IUh8xe3T8qX/eY5jxjyturTfIYYc6yKATD9JB1LI1NsbT7KJIhEbPxLV7GqJ1KggZX
         N/Roulth1NOhIAir9g6bGLE9tR8pOoxKJVzX5EZdUcQLMD7PaloLGjBECGXND8vB8X
         GKxEupQfB22fg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b6-0000FU-0y; Wed, 07 Apr 2021 12:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] USB: serial: add generic support for TIOCSSERIAL
Date:   Wed,  7 Apr 2021 12:39:21 +0200
Message-Id: <20210407103925.829-21-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

The closing_wait parameter determines how long to wait for the transfer
buffers to drain during close and the default timeout of 30 seconds may
not be sufficient at low line speeds. In other cases, when for example
flow is stopped, the default timeout may instead be too long.

Add generic support for TIOCSSERIAL and TIOCGSERIAL with handling of the
three common parameters close_delay, closing_wait and line for the
benefit of all USB serial drivers while still allowing drivers to
implement further functionality through the existing callbacks.

This currently includes a few drivers that report their base baud clock
rate even if that is really only of interest when setting custom
divisors through the deprecated ASYNC_SPD_CUST interface; an interface
which only the FTDI driver actually implements.

Some drivers have also been reporting back a fake UART type, something
which should no longer be needed and will be dropped by a follow-on
patch.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ark3116.c          |  9 +----
 drivers/usb/serial/f81232.c           | 12 ++----
 drivers/usb/serial/f81534.c           |  8 +---
 drivers/usb/serial/ftdi_sio.c         | 11 +-----
 drivers/usb/serial/io_edgeport.c      | 12 +-----
 drivers/usb/serial/io_ti.c            | 17 +--------
 drivers/usb/serial/mos7720.c          | 12 +-----
 drivers/usb/serial/mos7840.c          | 10 +----
 drivers/usb/serial/opticon.c          | 12 +-----
 drivers/usb/serial/option.c           |  2 -
 drivers/usb/serial/pl2303.c           | 10 +----
 drivers/usb/serial/quatech2.c         | 13 -------
 drivers/usb/serial/ssu100.c           | 13 -------
 drivers/usb/serial/ti_usb_3410_5052.c | 42 +--------------------
 drivers/usb/serial/usb-serial.c       | 53 ++++++++++++++++++++++++---
 drivers/usb/serial/usb-wwan.h         |  4 --
 drivers/usb/serial/usb_wwan.c         | 42 ---------------------
 drivers/usb/serial/whiteheat.c        | 12 +-----
 include/linux/usb/serial.h            |  2 +-
 19 files changed, 70 insertions(+), 226 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 957cdd694b1f..c0cf60e9273d 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -385,17 +385,10 @@ static int ark3116_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return result;
 }
 
-static int ark3116_get_serial_info(struct tty_struct *tty,
+static void ark3116_get_serial_info(struct tty_struct *tty,
 			struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
 	ss->type = PORT_16654;
-	ss->line = port->minor;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 static int ark3116_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index af0fe2a82eb2..5e34b364d94d 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -820,19 +820,13 @@ static int f81232_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static int f81232_get_serial_info(struct tty_struct *tty,
-		struct serial_struct *ss)
+static void f81232_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct f81232_private *priv = usb_get_serial_port_data(port);
 
 	ss->type = PORT_16550A;
-	ss->line = port->minor;
 	ss->baud_base = priv->baud_base;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 static void  f81232_interrupt_work(struct work_struct *work)
@@ -1023,7 +1017,7 @@ static struct usb_serial_driver f81232_device = {
 	.close =		f81232_close,
 	.dtr_rts =		f81232_dtr_rts,
 	.carrier_raised =	f81232_carrier_raised,
-	.get_serial =		f81232_get_serial_info,
+	.get_serial =		f81232_get_serial,
 	.break_ctl =		f81232_break_ctl,
 	.set_termios =		f81232_set_termios,
 	.tiocmget =		f81232_tiocmget,
@@ -1048,7 +1042,7 @@ static struct usb_serial_driver f81534a_device = {
 	.close =		f81232_close,
 	.dtr_rts =		f81232_dtr_rts,
 	.carrier_raised =	f81232_carrier_raised,
-	.get_serial =		f81232_get_serial_info,
+	.get_serial =		f81232_get_serial,
 	.break_ctl =		f81232_break_ctl,
 	.set_termios =		f81232_set_termios,
 	.tiocmget =		f81232_tiocmget,
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index c9f90d437e3a..633de52feaad 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1140,8 +1140,7 @@ static void f81534_close(struct usb_serial_port *port)
 	mutex_unlock(&serial_priv->urb_mutex);
 }
 
-static int f81534_get_serial_info(struct tty_struct *tty,
-				  struct serial_struct *ss)
+static void f81534_get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct f81534_port_private *port_priv;
@@ -1149,12 +1148,7 @@ static int f81534_get_serial_info(struct tty_struct *tty,
 	port_priv = usb_get_serial_port_data(port);
 
 	ss->type = PORT_16550A;
-	ss->line = port->minor;
 	ss->baud_base = port_priv->baud_base;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 static void f81534_process_per_serial_block(struct usb_serial_port *port,
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f8a0911f90ea..16d3e50487e6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1082,8 +1082,7 @@ static int  ftdi_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
 static int  ftdi_ioctl(struct tty_struct *tty,
 			unsigned int cmd, unsigned long arg);
-static int get_serial_info(struct tty_struct *tty,
-				struct serial_struct *ss);
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss);
 static int set_serial_info(struct tty_struct *tty,
 				struct serial_struct *ss);
 static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
@@ -1477,20 +1476,14 @@ static int read_latency_timer(struct usb_serial_port *port)
 	return 0;
 }
 
-static int get_serial_info(struct tty_struct *tty,
-				struct serial_struct *ss)
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
-	ss->line = port->minor;
 	ss->flags = priv->flags;
 	ss->baud_base = priv->baud_base;
 	ss->custom_divisor = priv->custom_divisor;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 static int set_serial_info(struct tty_struct *tty,
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 471a1a04c9c3..f669b065dc42 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1637,17 +1637,9 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static int get_serial_info(struct tty_struct *tty,
-				struct serial_struct *ss)
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
-	ss->type		= PORT_16550A;
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= 3000;
-
-	return 0;
+	ss->type = PORT_16550A;
 }
 
 
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index f5aab570fd05..dce994c29afe 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2433,22 +2433,9 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static int get_serial_info(struct tty_struct *tty,
-				struct serial_struct *ss)
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-	unsigned cwait;
-
-	cwait = port->port.closing_wait;
-	if (cwait != ASYNC_CLOSING_WAIT_NONE)
-		cwait = jiffies_to_msecs(cwait) / 10;
-
-	ss->type		= PORT_16550A;
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= cwait;
-
-	return 0;
+	ss->type = PORT_16550A;
 }
 
 static void edge_break(struct tty_struct *tty, int break_state)
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index db90ce560d42..ccb1291c94a2 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1634,17 +1634,9 @@ static int mos7720_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
-	ss->type		= PORT_16550A;
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= 3000;
-
-	return 0;
+	ss->type = PORT_16550A;
 }
 
 static int mos7720_ioctl(struct tty_struct *tty,
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 77cbe18a1629..d20fb0a678dc 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1388,17 +1388,9 @@ static int mos7840_get_lsr_info(struct tty_struct *tty,
  *      function to get information about serial port
  *****************************************************************************/
 
-static int mos7840_get_serial_info(struct tty_struct *tty,
-				   struct serial_struct *ss)
+static void mos7840_get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
 	ss->type = PORT_16550A;
-	ss->line = port->minor;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 /*****************************************************************************
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index 1c7e5dc2c272..db84afcf7f1a 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -352,18 +352,10 @@ static int opticon_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
+static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
 	/* fake emulate a 16550 uart to make userspace code happy */
-	ss->type		= PORT_16550A;
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= 3000;
-
-	return 0;
+	ss->type = PORT_16550A;
 }
 
 static int opticon_port_probe(struct usb_serial_port *port)
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c6969ca72839..3e79a543d3e7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2095,8 +2095,6 @@ static struct usb_serial_driver option_1port_device = {
 	.chars_in_buffer   = usb_wwan_chars_in_buffer,
 	.tiocmget          = usb_wwan_tiocmget,
 	.tiocmset          = usb_wwan_tiocmset,
-	.get_serial        = usb_wwan_get_serial_info,
-	.set_serial        = usb_wwan_set_serial_info,
 	.attach            = option_attach,
 	.release           = option_release,
 	.port_probe        = usb_wwan_port_probe,
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 0455add8593a..67d598b1a0f7 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -939,17 +939,9 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static int pl2303_get_serial(struct tty_struct *tty,
-			struct serial_struct *ss)
+static void pl2303_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
 	ss->type = PORT_16654;
-	ss->line = port->minor;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 static void pl2303_set_break(struct usb_serial_port *port, bool enable)
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 0d23e565e0d2..5f2e7f668e68 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -453,18 +453,6 @@ static void qt2_disconnect(struct usb_serial *serial)
 	usb_kill_urb(serial_priv->read_urb);
 }
 
-static int get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
-{
-	struct usb_serial_port *port = tty->driver_data;
-
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= 3000;
-
-	return 0;
-}
-
 static void qt2_process_status(struct usb_serial_port *port, unsigned char *ch)
 {
 	switch (*ch) {
@@ -975,7 +963,6 @@ static struct usb_serial_driver qt2_device = {
 	.tiocmset            = qt2_tiocmset,
 	.tiocmiwait          = usb_serial_generic_tiocmiwait,
 	.get_icount	     = usb_serial_generic_get_icount,
-	.get_serial          = get_serial_info,
 	.set_termios         = qt2_set_termios,
 };
 
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index c4616c37f33f..3baf7c0f5a98 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -331,18 +331,6 @@ static int ssu100_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return usb_serial_generic_open(tty, port);
 }
 
-static int get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
-{
-	struct usb_serial_port *port = tty->driver_data;
-
-	ss->line		= port->minor;
-	ss->close_delay		= 50;
-	ss->closing_wait	= 3000;
-
-	return 0;
-}
-
 static int ssu100_attach(struct usb_serial *serial)
 {
 	return ssu100_initdevice(serial->dev);
@@ -542,7 +530,6 @@ static struct usb_serial_driver ssu100_device = {
 	.tiocmset            = ssu100_tiocmset,
 	.tiocmiwait          = usb_serial_generic_tiocmiwait,
 	.get_icount	     = usb_serial_generic_get_icount,
-	.get_serial          = get_serial_info,
 	.set_termios         = ssu100_set_termios,
 };
 
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index bb50098a0ce6..6df316bdb40f 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -328,10 +328,7 @@ static void ti_recv(struct usb_serial_port *port, unsigned char *data,
 static void ti_send(struct ti_port *tport);
 static int ti_set_mcr(struct ti_port *tport, unsigned int mcr);
 static int ti_get_lsr(struct ti_port *tport, u8 *lsr);
-static int ti_get_serial_info(struct tty_struct *tty,
-	struct serial_struct *ss);
-static int ti_set_serial_info(struct tty_struct *tty,
-	struct serial_struct *ss);
+static void ti_get_serial_info(struct tty_struct *tty, struct serial_struct *ss);
 static void ti_handle_new_msr(struct ti_port *tport, u8 msr);
 
 static void ti_stop_read(struct ti_port *tport, struct tty_struct *tty);
@@ -435,7 +432,6 @@ static struct usb_serial_driver ti_1port_device = {
 	.throttle		= ti_throttle,
 	.unthrottle		= ti_unthrottle,
 	.get_serial		= ti_get_serial_info,
-	.set_serial		= ti_set_serial_info,
 	.set_termios		= ti_set_termios,
 	.tiocmget		= ti_tiocmget,
 	.tiocmset		= ti_tiocmset,
@@ -469,7 +465,6 @@ static struct usb_serial_driver ti_2port_device = {
 	.throttle		= ti_throttle,
 	.unthrottle		= ti_unthrottle,
 	.get_serial		= ti_get_serial_info,
-	.set_serial		= ti_set_serial_info,
 	.set_termios		= ti_set_termios,
 	.tiocmget		= ti_tiocmget,
 	.tiocmset		= ti_tiocmset,
@@ -1393,46 +1388,13 @@ static int ti_get_lsr(struct ti_port *tport, u8 *lsr)
 }
 
 
-static int ti_get_serial_info(struct tty_struct *tty,
-	struct serial_struct *ss)
+static void ti_get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ti_port *tport = usb_get_serial_port_data(port);
-	unsigned cwait;
-
-	cwait = port->port.closing_wait;
-	if (cwait != ASYNC_CLOSING_WAIT_NONE)
-		cwait = jiffies_to_msecs(cwait) / 10;
 
 	ss->type = PORT_16550A;
-	ss->line = port->minor;
 	ss->baud_base = tport->tp_tdev->td_is_3410 ? 921600 : 460800;
-	ss->close_delay = 50;
-	ss->closing_wait = cwait;
-
-	return 0;
-}
-
-
-static int ti_set_serial_info(struct tty_struct *tty,
-	struct serial_struct *ss)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct tty_port *tport = &port->port;
-	unsigned cwait;
-
-	cwait = ss->closing_wait;
-	if (cwait != ASYNC_CLOSING_WAIT_NONE)
-		cwait = msecs_to_jiffies(10 * ss->closing_wait);
-
-	if (!capable(CAP_SYS_ADMIN)) {
-		if (cwait != tport->closing_wait)
-			return -EPERM;
-	}
-
-	tport->closing_wait = cwait;
-
-	return 0;
 }
 
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index c311cc4fabee..78396fe409a0 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -399,19 +399,62 @@ static void serial_unthrottle(struct tty_struct *tty)
 static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	unsigned int close_delay, closing_wait;
+
+	mutex_lock(&tport->mutex);
+
+	close_delay = jiffies_to_msecs(tport->close_delay) / 10;
+	closing_wait = tport->closing_wait;
+	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		closing_wait = jiffies_to_msecs(closing_wait) / 10;
+
+	ss->line = port->minor;
+	ss->close_delay = close_delay;
+	ss->closing_wait = closing_wait;
 
 	if (port->serial->type->get_serial)
-		return port->serial->type->get_serial(tty, ss);
-	return -ENOTTY;
+		port->serial->type->get_serial(tty, ss);
+
+	mutex_unlock(&tport->mutex);
+
+	return 0;
 }
 
 static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	unsigned int close_delay, closing_wait;
+	int ret = 0;
+
+	close_delay = msecs_to_jiffies(ss->close_delay * 10);
+	closing_wait = ss->closing_wait;
+	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		closing_wait = msecs_to_jiffies(closing_wait * 10);
+
+	mutex_lock(&tport->mutex);
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		if (close_delay != tport->close_delay ||
+				closing_wait != tport->closing_wait) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+	}
 
-	if (port->serial->type->set_serial)
-		return port->serial->type->set_serial(tty, ss);
-	return -ENOTTY;
+	if (port->serial->type->set_serial) {
+		ret = port->serial->type->set_serial(tty, ss);
+		if (ret)
+			goto out_unlock;
+	}
+
+	tport->close_delay = close_delay;
+	tport->closing_wait = closing_wait;
+out_unlock:
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_ioctl(struct tty_struct *tty,
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index 79dafd98e0a1..b5331d03092f 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -15,10 +15,6 @@ extern int usb_wwan_write_room(struct tty_struct *tty);
 extern int usb_wwan_tiocmget(struct tty_struct *tty);
 extern int usb_wwan_tiocmset(struct tty_struct *tty,
 			     unsigned int set, unsigned int clear);
-extern int usb_wwan_get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss);
-extern int usb_wwan_set_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss);
 extern int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 			  const unsigned char *buf, int count);
 extern int usb_wwan_chars_in_buffer(struct tty_struct *tty);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 4ea315e5e69b..3eb72c59ede6 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -132,48 +132,6 @@ int usb_wwan_tiocmset(struct tty_struct *tty,
 }
 EXPORT_SYMBOL(usb_wwan_tiocmset);
 
-int usb_wwan_get_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
-{
-	struct usb_serial_port *port = tty->driver_data;
-
-	ss->line            = port->minor;
-	ss->close_delay	    = jiffies_to_msecs(port->port.close_delay) / 10;
-	ss->closing_wait    = port->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-				 ASYNC_CLOSING_WAIT_NONE :
-				 jiffies_to_msecs(port->port.closing_wait) / 10;
-	return 0;
-}
-EXPORT_SYMBOL(usb_wwan_get_serial_info);
-
-int usb_wwan_set_serial_info(struct tty_struct *tty,
-			   struct serial_struct *ss)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	unsigned int closing_wait, close_delay;
-	int retval = 0;
-
-	close_delay = msecs_to_jiffies(ss->close_delay * 10);
-	closing_wait = ss->closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-			ASYNC_CLOSING_WAIT_NONE :
-			msecs_to_jiffies(ss->closing_wait * 10);
-
-	mutex_lock(&port->port.mutex);
-
-	if (!capable(CAP_SYS_ADMIN)) {
-		if ((close_delay != port->port.close_delay) ||
-		    (closing_wait != port->port.closing_wait))
-			retval = -EPERM;
-	} else {
-		port->port.close_delay  = close_delay;
-		port->port.closing_wait = closing_wait;
-	}
-
-	mutex_unlock(&port->port.mutex);
-	return retval;
-}
-EXPORT_SYMBOL(usb_wwan_set_serial_info);
-
 int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 		   const unsigned char *buf, int count)
 {
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index c8b10faa2ff8..6a95c5a0056f 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -83,7 +83,7 @@ static void whiteheat_port_remove(struct usb_serial_port *port);
 static int  whiteheat_open(struct tty_struct *tty,
 			struct usb_serial_port *port);
 static void whiteheat_close(struct usb_serial_port *port);
-static int  whiteheat_get_serial(struct tty_struct *tty,
+static void whiteheat_get_serial(struct tty_struct *tty,
 			struct serial_struct *ss);
 static void whiteheat_set_termios(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
@@ -439,18 +439,10 @@ static int whiteheat_tiocmset(struct tty_struct *tty,
 }
 
 
-static int whiteheat_get_serial(struct tty_struct *tty,
-				struct serial_struct *ss)
+static void whiteheat_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tty->driver_data;
-
 	ss->type = PORT_16654;
-	ss->line = port->minor;
 	ss->baud_base = 460800;
-	ss->close_delay = 50;
-	ss->closing_wait = 3000;
-
-	return 0;
 }
 
 
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 952272002e48..6a6ac06fe1e6 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -276,7 +276,7 @@ struct usb_serial_driver {
 	int  (*write_room)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty,
 		      unsigned int cmd, unsigned long arg);
-	int  (*get_serial)(struct tty_struct *tty, struct serial_struct *ss);
+	void (*get_serial)(struct tty_struct *tty, struct serial_struct *ss);
 	int  (*set_serial)(struct tty_struct *tty, struct serial_struct *ss);
 	void (*set_termios)(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
-- 
2.26.3

