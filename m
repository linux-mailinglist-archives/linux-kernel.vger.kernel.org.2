Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34160356A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhDGKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351167AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C55C613D8;
        Wed,  7 Apr 2021 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=hIEWDIMXdN7Zepr7RP2ktRujbppp4xhaYUonwGsO2XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8xogpQKkiZodtBZ/0y7Orz+lxHUjx1BamnrIN8W77I0BpdHtn7gpxk4PwdHKso5w
         6OOWyhUzGSS62appx8H40ZnHjQPJudsUlfr3uGdIeeqR6w0nekpVCvcwPCsS2HIV5w
         Kp4+WX7sqRojJt/vQMHd+PWP/AhzBjdfI5qDBlHT6vTovH/a35QlLQrz3cl2JyXJ0i
         SMMpkhechC3DKPSGvUvoon/rfhnq/CRnXhIadlNcJmukwUh5xZpvzxvByEmQQ2CCiZ
         QyBgjlfoer6q0LeTtRV1UL64B00fx/ejdObPYg2jwbtn+sWrFhpa7+kELuhO5nYkDA
         f/YBc/O/eAsgg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b6-0000FX-4V; Wed, 07 Apr 2021 12:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] USB: serial: stop reporting legacy UART types
Date:   Wed,  7 Apr 2021 12:39:22 +0200
Message-Id: <20210407103925.829-22-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIOCGSERIAL ioctl can be used to set and retrieve the UART type for
legacy UARTs, but some USB serial drivers have been reporting back
random types in order to "make user-space happy".

Some applications have historically expected TIOCGSERIAL to be
implemented, but judging from the Debian sources, the port type not
being PORT_UNKNOWN is only used to check for the existence of legacy
serial ports (ttySn).

Drivers like ftdi_sio have been using PORT_UNKNOWN for twenty years (and
option for 10 years) without anyone complaining so let's stop reporting
back anything else.

In the unlikely event that this do cause problems, this should be fixed
tree-wide anyway (e.g. for all USB serial drivers and also CDC-ACM).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ark3116.c          |  7 -------
 drivers/usb/serial/f81232.c           |  1 -
 drivers/usb/serial/f81534.c           |  1 -
 drivers/usb/serial/io_edgeport.c      | 10 ----------
 drivers/usb/serial/io_ti.c            |  7 -------
 drivers/usb/serial/mos7720.c          |  6 ------
 drivers/usb/serial/mos7840.c          | 11 -----------
 drivers/usb/serial/opticon.c          |  7 -------
 drivers/usb/serial/pl2303.c           |  6 ------
 drivers/usb/serial/ti_usb_3410_5052.c |  1 -
 drivers/usb/serial/whiteheat.c        |  1 -
 11 files changed, 58 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index c0cf60e9273d..5dd710e9fe7d 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -385,12 +385,6 @@ static int ark3116_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return result;
 }
 
-static void ark3116_get_serial_info(struct tty_struct *tty,
-			struct serial_struct *ss)
-{
-	ss->type = PORT_16654;
-}
-
 static int ark3116_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -627,7 +621,6 @@ static struct usb_serial_driver ark3116_device = {
 	.port_probe =		ark3116_port_probe,
 	.port_remove =		ark3116_port_remove,
 	.set_termios =		ark3116_set_termios,
-	.get_serial =		ark3116_get_serial_info,
 	.tiocmget =		ark3116_tiocmget,
 	.tiocmset =		ark3116_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 5e34b364d94d..b4b847dce4bc 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -825,7 +825,6 @@ static void f81232_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct f81232_private *priv = usb_get_serial_port_data(port);
 
-	ss->type = PORT_16550A;
 	ss->baud_base = priv->baud_base;
 }
 
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 633de52feaad..c0bca52ef92a 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1147,7 +1147,6 @@ static void f81534_get_serial_info(struct tty_struct *tty, struct serial_struct
 
 	port_priv = usb_get_serial_port_data(port);
 
-	ss->type = PORT_16550A;
 	ss->baud_base = port_priv->baud_base;
 }
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index f669b065dc42..4f9fb1d96380 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1637,12 +1637,6 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-{
-	ss->type = PORT_16550A;
-}
-
-
 /*****************************************************************************
  * SerialIoctl
  *	this function handles any ioctl calls to the driver
@@ -3104,7 +3098,6 @@ static struct usb_serial_driver edgeport_2port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
-	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3140,7 +3133,6 @@ static struct usb_serial_driver edgeport_4port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
-	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3176,7 +3168,6 @@ static struct usb_serial_driver edgeport_8port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
-	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3212,7 +3203,6 @@ static struct usb_serial_driver epic_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
-	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index dce994c29afe..f548cdbf0a51 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2433,11 +2433,6 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-{
-	ss->type = PORT_16550A;
-}
-
 static void edge_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -2696,7 +2691,6 @@ static struct usb_serial_driver edgeport_1port_device = {
 	.release		= edge_release,
 	.port_probe		= edge_port_probe,
 	.port_remove		= edge_port_remove,
-	.get_serial		= get_serial_info,
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
@@ -2735,7 +2729,6 @@ static struct usb_serial_driver edgeport_2port_device = {
 	.release		= edge_release,
 	.port_probe		= edge_port_probe,
 	.port_remove		= edge_port_remove,
-	.get_serial		= get_serial_info,
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index ccb1291c94a2..6ee83886e2c9 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1634,11 +1634,6 @@ static int mos7720_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-{
-	ss->type = PORT_16550A;
-}
-
 static int mos7720_ioctl(struct tty_struct *tty,
 			 unsigned int cmd, unsigned long arg)
 {
@@ -1778,7 +1773,6 @@ static struct usb_serial_driver moschip7720_2port_driver = {
 	.ioctl			= mos7720_ioctl,
 	.tiocmget		= mos7720_tiocmget,
 	.tiocmset		= mos7720_tiocmset,
-	.get_serial		= get_serial_info,
 	.set_termios		= mos7720_set_termios,
 	.write			= mos7720_write,
 	.write_room		= mos7720_write_room,
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index d20fb0a678dc..28e4093794e0 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1383,16 +1383,6 @@ static int mos7840_get_lsr_info(struct tty_struct *tty,
 	return 0;
 }
 
-/*****************************************************************************
- * mos7840_get_serial_info
- *      function to get information about serial port
- *****************************************************************************/
-
-static void mos7840_get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-{
-	ss->type = PORT_16550A;
-}
-
 /*****************************************************************************
  * SerialIoctl
  *	this function handles any ioctl calls to the driver
@@ -1771,7 +1761,6 @@ static struct usb_serial_driver moschip7840_4port_device = {
 	.probe = mos7840_probe,
 	.attach = mos7840_attach,
 	.ioctl = mos7840_ioctl,
-	.get_serial = mos7840_get_serial_info,
 	.set_termios = mos7840_set_termios,
 	.break_ctl = mos7840_break,
 	.tiocmget = mos7840_tiocmget,
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index db84afcf7f1a..40c713fae0c3 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -352,12 +352,6 @@ static int opticon_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-{
-	/* fake emulate a 16550 uart to make userspace code happy */
-	ss->type = PORT_16550A;
-}
-
 static int opticon_port_probe(struct usb_serial_port *port)
 {
 	struct opticon_private *priv;
@@ -399,7 +393,6 @@ static struct usb_serial_driver opticon_device = {
 	.chars_in_buffer =	opticon_chars_in_buffer,
 	.throttle =		usb_serial_generic_throttle,
 	.unthrottle =		usb_serial_generic_unthrottle,
-	.get_serial =		get_serial_info,
 	.tiocmget =		opticon_tiocmget,
 	.tiocmset =		opticon_tiocmset,
 	.process_read_urb =	opticon_process_read_urb,
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 67d598b1a0f7..10f92a60f5fb 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -939,11 +939,6 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static void pl2303_get_serial(struct tty_struct *tty, struct serial_struct *ss)
-{
-	ss->type = PORT_16654;
-}
-
 static void pl2303_set_break(struct usb_serial_port *port, bool enable)
 {
 	struct usb_serial *serial = port->serial;
@@ -1127,7 +1122,6 @@ static struct usb_serial_driver pl2303_device = {
 	.close =		pl2303_close,
 	.dtr_rts =		pl2303_dtr_rts,
 	.carrier_raised =	pl2303_carrier_raised,
-	.get_serial =		pl2303_get_serial,
 	.break_ctl =		pl2303_break_ctl,
 	.set_termios =		pl2303_set_termios,
 	.tiocmget =		pl2303_tiocmget,
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 6df316bdb40f..c312d0cce5fb 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -1393,7 +1393,6 @@ static void ti_get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct ti_port *tport = usb_get_serial_port_data(port);
 
-	ss->type = PORT_16550A;
 	ss->baud_base = tport->tp_tdev->td_is_3410 ? 921600 : 460800;
 }
 
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 6a95c5a0056f..5116ed9db3eb 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -441,7 +441,6 @@ static int whiteheat_tiocmset(struct tty_struct *tty,
 
 static void whiteheat_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
-	ss->type = PORT_16654;
 	ss->baud_base = 460800;
 }
 
-- 
2.26.3

