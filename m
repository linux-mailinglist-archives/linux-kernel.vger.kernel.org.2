Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAF313587
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhBHOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhBHOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:32:39 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B21C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:31:59 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5017AAF3D91; Mon,  8 Feb 2021 15:31:57 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] USB: serial: Make remove callback return void
Date:   Mon,  8 Feb 2021 15:31:49 +0100
Message-Id: <20210208143149.963644-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208143149.963644-1-uwe@kleine-koenig.org>
References: <20210208143149.963644-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usb_serial drivers return 0 in their remove callback and
the driver core ignores the value returned by
usb_serial_device_remove(). So change the remove callback to return
void and return 0 unconditionally in usb_serial_device_remove().

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/usb/serial/ark3116.c          | 4 +---
 drivers/usb/serial/belkin_sa.c        | 6 ++----
 drivers/usb/serial/bus.c              | 5 ++---
 drivers/usb/serial/ch341.c            | 4 +---
 drivers/usb/serial/cp210x.c           | 6 ++----
 drivers/usb/serial/cyberjack.c        | 6 ++----
 drivers/usb/serial/cypress_m8.c       | 6 ++----
 drivers/usb/serial/digi_acceleport.c  | 6 ++----
 drivers/usb/serial/f81534.c           | 3 +--
 drivers/usb/serial/ftdi_sio.c         | 6 ++----
 drivers/usb/serial/garmin_gps.c       | 3 +--
 drivers/usb/serial/io_edgeport.c      | 6 ++----
 drivers/usb/serial/io_ti.c            | 4 +---
 drivers/usb/serial/iuu_phoenix.c      | 4 +---
 drivers/usb/serial/keyspan.c          | 6 ++----
 drivers/usb/serial/keyspan_pda.c      | 4 +---
 drivers/usb/serial/kl5kusb105.c       | 6 ++----
 drivers/usb/serial/kobil_sct.c        | 6 ++----
 drivers/usb/serial/mct_u232.c         | 6 ++----
 drivers/usb/serial/metro-usb.c        | 4 +---
 drivers/usb/serial/mos7720.c          | 4 +---
 drivers/usb/serial/mos7840.c          | 4 +---
 drivers/usb/serial/omninet.c          | 6 ++----
 drivers/usb/serial/opticon.c          | 4 +---
 drivers/usb/serial/oti6858.c          | 6 ++----
 drivers/usb/serial/pl2303.c           | 4 +---
 drivers/usb/serial/quatech2.c         | 4 +---
 drivers/usb/serial/sierra.c           | 4 +---
 drivers/usb/serial/spcp8x5.c          | 4 +---
 drivers/usb/serial/ssu100.c           | 4 +---
 drivers/usb/serial/symbolserial.c     | 4 +---
 drivers/usb/serial/ti_usb_3410_5052.c | 6 ++----
 drivers/usb/serial/upd78f0730.c       | 4 +---
 drivers/usb/serial/usb-wwan.h         | 2 +-
 drivers/usb/serial/usb_wwan.c         | 4 +---
 drivers/usb/serial/whiteheat.c        | 6 ++----
 include/linux/usb/serial.h            | 2 +-
 37 files changed, 53 insertions(+), 120 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 71a9206ea1e2..f0ac7bb07ac1 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -178,15 +178,13 @@ static int ark3116_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int ark3116_port_remove(struct usb_serial_port *port)
+static void ark3116_port_remove(struct usb_serial_port *port)
 {
 	struct ark3116_private *priv = usb_get_serial_port_data(port);
 
 	/* device is closed, so URBs and DMA should be down */
 	mutex_destroy(&priv->hw_lock);
 	kfree(priv);
-
-	return 0;
 }
 
 static void ark3116_set_termios(struct tty_struct *tty,
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 9bb123ab9bc9..ed9193f3bb1a 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -37,7 +37,7 @@
 
 /* function prototypes for a Belkin USB Serial Adapter F5U103 */
 static int belkin_sa_port_probe(struct usb_serial_port *port);
-static int belkin_sa_port_remove(struct usb_serial_port *port);
+static void belkin_sa_port_remove(struct usb_serial_port *port);
 static int  belkin_sa_open(struct tty_struct *tty,
 			struct usb_serial_port *port);
 static void belkin_sa_close(struct usb_serial_port *port);
@@ -134,14 +134,12 @@ static int belkin_sa_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int belkin_sa_port_remove(struct usb_serial_port *port)
+static void belkin_sa_port_remove(struct usb_serial_port *port)
 {
 	struct belkin_sa_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int belkin_sa_open(struct tty_struct *tty,
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index d862ed656414..09b2c1717c1e 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -88,7 +88,6 @@ static int usb_serial_device_remove(struct device *dev)
 {
 	struct usb_serial_driver *driver;
 	struct usb_serial_port *port = to_usb_serial_port(dev);
-	int retval = 0;
 	int minor;
 	int autopm_err;
 
@@ -105,7 +104,7 @@ static int usb_serial_device_remove(struct device *dev)
 
 	driver = port->serial->type;
 	if (driver->port_remove)
-		retval = driver->port_remove(port);
+		driver->port_remove(port);
 
 	dev_info(dev, "%s converter now disconnected from ttyUSB%d\n",
 		 driver->description, minor);
@@ -113,7 +112,7 @@ static int usb_serial_device_remove(struct device *dev)
 	if (!autopm_err)
 		usb_autopm_put_interface(port->serial->interface);
 
-	return retval;
+	return 0;
 }
 
 static ssize_t new_id_store(struct device_driver *driver,
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 28deaaec581f..8d997b71056f 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -419,14 +419,12 @@ error:	kfree(priv);
 	return r;
 }
 
-static int ch341_port_remove(struct usb_serial_port *port)
+static void ch341_port_remove(struct usb_serial_port *port)
 {
 	struct ch341_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int ch341_carrier_raised(struct usb_serial_port *port)
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..5b17a00c442e 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -45,7 +45,7 @@ static int cp210x_attach(struct usb_serial *);
 static void cp210x_disconnect(struct usb_serial *);
 static void cp210x_release(struct usb_serial *);
 static int cp210x_port_probe(struct usb_serial_port *);
-static int cp210x_port_remove(struct usb_serial_port *);
+static void cp210x_port_remove(struct usb_serial_port *);
 static void cp210x_dtr_rts(struct usb_serial_port *port, int on);
 static void cp210x_process_read_urb(struct urb *urb);
 static void cp210x_enable_event_mode(struct usb_serial_port *port);
@@ -1714,14 +1714,12 @@ static int cp210x_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int cp210x_port_remove(struct usb_serial_port *port)
+static void cp210x_port_remove(struct usb_serial_port *port)
 {
 	struct cp210x_port_private *port_priv;
 
 	port_priv = usb_get_serial_port_data(port);
 	kfree(port_priv);
-
-	return 0;
 }
 
 static void cp210x_init_max_speed(struct usb_serial *serial)
diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index 2e40908963da..cf389224d528 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -47,7 +47,7 @@
 
 /* Function prototypes */
 static int cyberjack_port_probe(struct usb_serial_port *port);
-static int cyberjack_port_remove(struct usb_serial_port *port);
+static void cyberjack_port_remove(struct usb_serial_port *port);
 static int  cyberjack_open(struct tty_struct *tty,
 	struct usb_serial_port *port);
 static void cyberjack_close(struct usb_serial_port *port);
@@ -120,7 +120,7 @@ static int cyberjack_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int cyberjack_port_remove(struct usb_serial_port *port)
+static void cyberjack_port_remove(struct usb_serial_port *port)
 {
 	struct cyberjack_private *priv;
 
@@ -128,8 +128,6 @@ static int cyberjack_port_remove(struct usb_serial_port *port)
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int  cyberjack_open(struct tty_struct *tty,
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index cc028601c388..166ee2286fda 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -115,7 +115,7 @@ struct cypress_private {
 static int  cypress_earthmate_port_probe(struct usb_serial_port *port);
 static int  cypress_hidcom_port_probe(struct usb_serial_port *port);
 static int  cypress_ca42v2_port_probe(struct usb_serial_port *port);
-static int  cypress_port_remove(struct usb_serial_port *port);
+static void cypress_port_remove(struct usb_serial_port *port);
 static int  cypress_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void cypress_close(struct usb_serial_port *port);
 static void cypress_dtr_rts(struct usb_serial_port *port, int on);
@@ -564,7 +564,7 @@ static int cypress_ca42v2_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int cypress_port_remove(struct usb_serial_port *port)
+static void cypress_port_remove(struct usb_serial_port *port)
 {
 	struct cypress_private *priv;
 
@@ -572,8 +572,6 @@ static int cypress_port_remove(struct usb_serial_port *port)
 
 	kfifo_free(&priv->write_fifo);
 	kfree(priv);
-
-	return 0;
 }
 
 static int cypress_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 0ecd5316d85f..8b2f06539f2c 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -233,7 +233,7 @@ static int digi_startup(struct usb_serial *serial);
 static void digi_disconnect(struct usb_serial *serial);
 static void digi_release(struct usb_serial *serial);
 static int digi_port_probe(struct usb_serial_port *port);
-static int digi_port_remove(struct usb_serial_port *port);
+static void digi_port_remove(struct usb_serial_port *port);
 static void digi_read_bulk_callback(struct urb *urb);
 static int digi_read_inb_callback(struct urb *urb);
 static int digi_read_oob_callback(struct urb *urb);
@@ -1281,14 +1281,12 @@ static int digi_port_probe(struct usb_serial_port *port)
 	return digi_port_init(port, port->port_number);
 }
 
-static int digi_port_remove(struct usb_serial_port *port)
+static void digi_port_remove(struct usb_serial_port *port)
 {
 	struct digi_port *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static void digi_read_bulk_callback(struct urb *urb)
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 5661fd03e545..48231f9d4a05 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1432,12 +1432,11 @@ static int f81534_port_probe(struct usb_serial_port *port)
 	return f81534_set_port_output_pin(port);
 }
 
-static int f81534_port_remove(struct usb_serial_port *port)
+static void f81534_port_remove(struct usb_serial_port *port)
 {
 	struct f81534_port_private *port_priv = usb_get_serial_port_data(port);
 
 	flush_work(&port_priv->lsr_work);
-	return 0;
 }
 
 static int f81534_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 94398f89e600..9ab216a7a567 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1069,7 +1069,7 @@ static const char *ftdi_chip_name[] = {
 static int  ftdi_sio_probe(struct usb_serial *serial,
 					const struct usb_device_id *id);
 static int  ftdi_sio_port_probe(struct usb_serial_port *port);
-static int  ftdi_sio_port_remove(struct usb_serial_port *port);
+static void ftdi_sio_port_remove(struct usb_serial_port *port);
 static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void ftdi_dtr_rts(struct usb_serial_port *port, int on);
 static void ftdi_process_read_urb(struct urb *urb);
@@ -2399,7 +2399,7 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	return 0;
 }
 
-static int ftdi_sio_port_remove(struct usb_serial_port *port)
+static void ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
@@ -2408,8 +2408,6 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
 	remove_sysfs_attrs(port);
 
 	kfree(priv);
-
-	return 0;
 }
 
 static int ftdi_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index c02c19bb1183..50e8bdc77e71 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1401,7 +1401,7 @@ static int garmin_port_probe(struct usb_serial_port *port)
 }
 
 
-static int garmin_port_remove(struct usb_serial_port *port)
+static void garmin_port_remove(struct usb_serial_port *port)
 {
 	struct garmin_data *garmin_data_p = usb_get_serial_port_data(port);
 
@@ -1409,7 +1409,6 @@ static int garmin_port_remove(struct usb_serial_port *port)
 	usb_kill_urb(port->interrupt_in_urb);
 	del_timer_sync(&garmin_data_p->timer);
 	kfree(garmin_data_p);
-	return 0;
 }
 
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index ba5d8df69518..a493670c06e6 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -293,7 +293,7 @@ static int  edge_startup(struct usb_serial *serial);
 static void edge_disconnect(struct usb_serial *serial);
 static void edge_release(struct usb_serial *serial);
 static int edge_port_probe(struct usb_serial_port *port);
-static int edge_port_remove(struct usb_serial_port *port);
+static void edge_port_remove(struct usb_serial_port *port);
 
 /* function prototypes for all of our local functions */
 
@@ -3078,14 +3078,12 @@ static int edge_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int edge_port_remove(struct usb_serial_port *port)
+static void edge_port_remove(struct usb_serial_port *port)
 {
 	struct edgeport_port *edge_port;
 
 	edge_port = usb_get_serial_port_data(port);
 	kfree(edge_port);
-
-	return 0;
 }
 
 static struct usb_serial_driver edgeport_2port_device = {
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index c327d4cf7928..1ba128bd0ae7 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2629,15 +2629,13 @@ static int edge_port_probe(struct usb_serial_port *port)
 	return ret;
 }
 
-static int edge_port_remove(struct usb_serial_port *port)
+static void edge_port_remove(struct usb_serial_port *port)
 {
 	struct edgeport_port *edge_port;
 
 	edge_port = usb_get_serial_port_data(port);
 	edge_remove_sysfs_attrs(port);
 	kfree(edge_port);
-
-	return 0;
 }
 
 /* Sysfs Attributes */
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index f1201d4de297..fa0c87c2e732 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -100,7 +100,7 @@ static int iuu_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int iuu_port_remove(struct usb_serial_port *port)
+static void iuu_port_remove(struct usb_serial_port *port)
 {
 	struct iuu_private *priv = usb_get_serial_port_data(port);
 
@@ -108,8 +108,6 @@ static int iuu_port_remove(struct usb_serial_port *port)
 	kfree(priv->writebuf);
 	kfree(priv->buf);
 	kfree(priv);
-
-	return 0;
 }
 
 static int iuu_tiocmset(struct tty_struct *tty,
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index aa3dbce22cfb..622077dcc344 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -49,7 +49,7 @@ static int keyspan_startup(struct usb_serial *serial);
 static void keyspan_disconnect(struct usb_serial *serial);
 static void keyspan_release(struct usb_serial *serial);
 static int keyspan_port_probe(struct usb_serial_port *port);
-static int keyspan_port_remove(struct usb_serial_port *port);
+static void keyspan_port_remove(struct usb_serial_port *port);
 static int keyspan_write_room(struct tty_struct *tty);
 static int keyspan_write(struct tty_struct *tty, struct usb_serial_port *port,
 			 const unsigned char *buf, int count);
@@ -2985,7 +2985,7 @@ static int keyspan_port_probe(struct usb_serial_port *port)
 	return -ENOMEM;
 }
 
-static int keyspan_port_remove(struct usb_serial_port *port)
+static void keyspan_port_remove(struct usb_serial_port *port)
 {
 	struct keyspan_port_private *p_priv;
 	int i;
@@ -3014,8 +3014,6 @@ static int keyspan_port_remove(struct usb_serial_port *port)
 		kfree(p_priv->in_buffer[i]);
 
 	kfree(p_priv);
-
-	return 0;
 }
 
 /* Structs for the devices, pre and post renumeration. */
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index e6f933e8d25f..39b0f5f344c2 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -672,14 +672,12 @@ static int keyspan_pda_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int keyspan_pda_port_remove(struct usb_serial_port *port)
+static void keyspan_pda_port_remove(struct usb_serial_port *port)
 {
 	struct keyspan_pda_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static struct usb_serial_driver keyspan_pda_fake_device = {
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 5f6b82ebccc5..f1e9628a9907 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -52,7 +52,7 @@
  * Function prototypes
  */
 static int klsi_105_port_probe(struct usb_serial_port *port);
-static int klsi_105_port_remove(struct usb_serial_port *port);
+static void klsi_105_port_remove(struct usb_serial_port *port);
 static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void klsi_105_close(struct usb_serial_port *port);
 static void klsi_105_set_termios(struct tty_struct *tty,
@@ -231,14 +231,12 @@ static int klsi_105_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int klsi_105_port_remove(struct usb_serial_port *port)
+static void klsi_105_port_remove(struct usb_serial_port *port)
 {
 	struct klsi_105_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 49aacb0a327c..a9bc546626ab 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -48,7 +48,7 @@
 
 /* Function prototypes */
 static int kobil_port_probe(struct usb_serial_port *probe);
-static int kobil_port_remove(struct usb_serial_port *probe);
+static void kobil_port_remove(struct usb_serial_port *probe);
 static int  kobil_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void kobil_close(struct usb_serial_port *port);
 static int  kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
@@ -143,14 +143,12 @@ static int kobil_port_probe(struct usb_serial_port *port)
 }
 
 
-static int kobil_port_remove(struct usb_serial_port *port)
+static void kobil_port_remove(struct usb_serial_port *port)
 {
 	struct kobil_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static void kobil_init_termios(struct tty_struct *tty)
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 7887c312d9a9..ecd5b921e374 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -39,7 +39,7 @@
  * Function prototypes
  */
 static int  mct_u232_port_probe(struct usb_serial_port *port);
-static int  mct_u232_port_remove(struct usb_serial_port *remove);
+static void mct_u232_port_remove(struct usb_serial_port *remove);
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void mct_u232_close(struct usb_serial_port *port);
 static void mct_u232_dtr_rts(struct usb_serial_port *port, int on);
@@ -400,14 +400,12 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int mct_u232_port_remove(struct usb_serial_port *port)
+static void mct_u232_port_remove(struct usb_serial_port *port)
 {
 	struct mct_u232_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index e63cea02cfd8..0bfe4459c37f 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -256,14 +256,12 @@ static int metrousb_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int metrousb_port_remove(struct usb_serial_port *port)
+static void metrousb_port_remove(struct usb_serial_port *port)
 {
 	struct metrousb_private *metro_priv;
 
 	metro_priv = usb_get_serial_port_data(port);
 	kfree(metro_priv);
-
-	return 0;
 }
 
 static void metrousb_throttle(struct tty_struct *tty)
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 41ee2984a0df..a7835d7d999c 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1756,14 +1756,12 @@ static int mos7720_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int mos7720_port_remove(struct usb_serial_port *port)
+static void mos7720_port_remove(struct usb_serial_port *port)
 {
 	struct moschip_port *mos7720_port;
 
 	mos7720_port = usb_get_serial_port_data(port);
 	kfree(mos7720_port);
-
-	return 0;
 }
 
 static struct usb_serial_driver moschip7720_2port_driver = {
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 23f91d658cb4..c5fd48e3a9d5 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1743,7 +1743,7 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 	return status;
 }
 
-static int mos7840_port_remove(struct usb_serial_port *port)
+static void mos7840_port_remove(struct usb_serial_port *port)
 {
 	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
 
@@ -1760,8 +1760,6 @@ static int mos7840_port_remove(struct usb_serial_port *port)
 	}
 
 	kfree(mos7840_port);
-
-	return 0;
 }
 
 static struct usb_serial_driver moschip7840_4port_device = {
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 5b6e982a9376..83c62f920c50 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -36,7 +36,7 @@ static int omninet_prepare_write_buffer(struct usb_serial_port *port,
 static int omninet_calc_num_ports(struct usb_serial *serial,
 				struct usb_serial_endpoints *epds);
 static int omninet_port_probe(struct usb_serial_port *port);
-static int omninet_port_remove(struct usb_serial_port *port);
+static void omninet_port_remove(struct usb_serial_port *port);
 
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNINET_ID) },
@@ -121,14 +121,12 @@ static int omninet_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int omninet_port_remove(struct usb_serial_port *port)
+static void omninet_port_remove(struct usb_serial_port *port)
 {
 	struct omninet_data *od;
 
 	od = usb_get_serial_port_data(port);
 	kfree(od);
-
-	return 0;
 }
 
 #define OMNINET_HEADERLEN	4
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index 0af76800bd78..eecb72aef83e 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -385,13 +385,11 @@ static int opticon_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int opticon_port_remove(struct usb_serial_port *port)
+static void opticon_port_remove(struct usb_serial_port *port)
 {
 	struct opticon_private *priv = usb_get_serial_port_data(port);
 
 	kfree(priv);
-
-	return 0;
 }
 
 static struct usb_serial_driver opticon_device = {
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 8151dd7a45e8..65cd0341fa78 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -132,7 +132,7 @@ static int oti6858_tiocmget(struct tty_struct *tty);
 static int oti6858_tiocmset(struct tty_struct *tty,
 				unsigned int set, unsigned int clear);
 static int oti6858_port_probe(struct usb_serial_port *port);
-static int oti6858_port_remove(struct usb_serial_port *port);
+static void oti6858_port_remove(struct usb_serial_port *port);
 
 /* device info */
 static struct usb_serial_driver oti6858_device = {
@@ -344,14 +344,12 @@ static int oti6858_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int oti6858_port_remove(struct usb_serial_port *port)
+static void oti6858_port_remove(struct usb_serial_port *port)
 {
 	struct oti6858_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int oti6858_write(struct tty_struct *tty, struct usb_serial_port *port,
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index be8067017eaa..d3a462f5175c 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -448,13 +448,11 @@ static int pl2303_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int pl2303_port_remove(struct usb_serial_port *port)
+static void pl2303_port_remove(struct usb_serial_port *port)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
 
 	kfree(priv);
-
-	return 0;
 }
 
 static int pl2303_set_control_lines(struct usb_serial_port *port, u8 value)
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 872d1bc86ab4..599dcb2e374d 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -727,7 +727,7 @@ static int qt2_port_probe(struct usb_serial_port *port)
 	return -ENOMEM;
 }
 
-static int qt2_port_remove(struct usb_serial_port *port)
+static void qt2_port_remove(struct usb_serial_port *port)
 {
 	struct qt2_port_private *port_priv;
 
@@ -735,8 +735,6 @@ static int qt2_port_remove(struct usb_serial_port *port)
 	usb_free_urb(port_priv->write_urb);
 	kfree(port_priv->write_buffer);
 	kfree(port_priv);
-
-	return 0;
 }
 
 static int qt2_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 57fc3c31712e..54e16ffc30a0 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -901,15 +901,13 @@ static int sierra_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int sierra_port_remove(struct usb_serial_port *port)
+static void sierra_port_remove(struct usb_serial_port *port)
 {
 	struct sierra_port_private *portdata;
 
 	portdata = usb_get_serial_port_data(port);
 	usb_set_serial_port_data(port, NULL);
 	kfree(portdata);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 3bac55bd9bd9..7039dc918827 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -169,14 +169,12 @@ static int spcp8x5_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int spcp8x5_port_remove(struct usb_serial_port *port)
+static void spcp8x5_port_remove(struct usb_serial_port *port)
 {
 	struct spcp8x5_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int spcp8x5_set_ctrl_line(struct usb_serial_port *port, u8 mcr)
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 7d39d35e52a1..89fdc5c19285 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -366,14 +366,12 @@ static int ssu100_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int ssu100_port_remove(struct usb_serial_port *port)
+static void ssu100_port_remove(struct usb_serial_port *port)
 {
 	struct ssu100_port_private *priv;
 
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
-
-	return 0;
 }
 
 static int ssu100_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/symbolserial.c b/drivers/usb/serial/symbolserial.c
index 6ca24e86f686..d7f73ad6e778 100644
--- a/drivers/usb/serial/symbolserial.c
+++ b/drivers/usb/serial/symbolserial.c
@@ -160,13 +160,11 @@ static int symbol_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int symbol_port_remove(struct usb_serial_port *port)
+static void symbol_port_remove(struct usb_serial_port *port)
 {
 	struct symbol_private *priv = usb_get_serial_port_data(port);
 
 	kfree(priv);
-
-	return 0;
 }
 
 static struct usb_serial_driver symbol_device = {
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 73075b9351c5..7252b0ce75a6 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -303,7 +303,7 @@ struct ti_device {
 static int ti_startup(struct usb_serial *serial);
 static void ti_release(struct usb_serial *serial);
 static int ti_port_probe(struct usb_serial_port *port);
-static int ti_port_remove(struct usb_serial_port *port);
+static void ti_port_remove(struct usb_serial_port *port);
 static int ti_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void ti_close(struct usb_serial_port *port);
 static int ti_write(struct tty_struct *tty, struct usb_serial_port *port,
@@ -629,14 +629,12 @@ static int ti_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int ti_port_remove(struct usb_serial_port *port)
+static void ti_port_remove(struct usb_serial_port *port)
 {
 	struct ti_port *tport;
 
 	tport = usb_get_serial_port_data(port);
 	kfree(tport);
-
-	return 0;
 }
 
 static int ti_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 0a2268c479af..0d642d4b48bd 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -174,15 +174,13 @@ static int upd78f0730_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int upd78f0730_port_remove(struct usb_serial_port *port)
+static void upd78f0730_port_remove(struct usb_serial_port *port)
 {
 	struct upd78f0730_port_private *private;
 
 	private = usb_get_serial_port_data(port);
 	mutex_destroy(&private->lock);
 	kfree(private);
-
-	return 0;
 }
 
 static int upd78f0730_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index 934e9361cf6b..79dafd98e0a1 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -10,7 +10,7 @@ extern void usb_wwan_dtr_rts(struct usb_serial_port *port, int on);
 extern int usb_wwan_open(struct tty_struct *tty, struct usb_serial_port *port);
 extern void usb_wwan_close(struct usb_serial_port *port);
 extern int usb_wwan_port_probe(struct usb_serial_port *port);
-extern int usb_wwan_port_remove(struct usb_serial_port *port);
+extern void usb_wwan_port_remove(struct usb_serial_port *port);
 extern int usb_wwan_write_room(struct tty_struct *tty);
 extern int usb_wwan_tiocmget(struct tty_struct *tty);
 extern int usb_wwan_tiocmset(struct tty_struct *tty,
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 4b9845807bee..46d46a4f99c9 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -544,7 +544,7 @@ int usb_wwan_port_probe(struct usb_serial_port *port)
 }
 EXPORT_SYMBOL_GPL(usb_wwan_port_probe);
 
-int usb_wwan_port_remove(struct usb_serial_port *port)
+void usb_wwan_port_remove(struct usb_serial_port *port)
 {
 	int i;
 	struct usb_wwan_port_private *portdata;
@@ -562,8 +562,6 @@ int usb_wwan_port_remove(struct usb_serial_port *port)
 	}
 
 	kfree(portdata);
-
-	return 0;
 }
 EXPORT_SYMBOL(usb_wwan_port_remove);
 
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index ca3bd58f2025..ccfd5ed652cd 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -79,7 +79,7 @@ static int  whiteheat_firmware_attach(struct usb_serial *serial);
 static int  whiteheat_attach(struct usb_serial *serial);
 static void whiteheat_release(struct usb_serial *serial);
 static int  whiteheat_port_probe(struct usb_serial_port *port);
-static int  whiteheat_port_remove(struct usb_serial_port *port);
+static void whiteheat_port_remove(struct usb_serial_port *port);
 static int  whiteheat_open(struct tty_struct *tty,
 			struct usb_serial_port *port);
 static void whiteheat_close(struct usb_serial_port *port);
@@ -345,14 +345,12 @@ static int whiteheat_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int whiteheat_port_remove(struct usb_serial_port *port)
+static void whiteheat_port_remove(struct usb_serial_port *port)
 {
 	struct whiteheat_private *info;
 
 	info = usb_get_serial_port_data(port);
 	kfree(info);
-
-	return 0;
 }
 
 static int whiteheat_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1c09b922f8b0..952272002e48 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -260,7 +260,7 @@ struct usb_serial_driver {
 	void (*release)(struct usb_serial *serial);
 
 	int (*port_probe)(struct usb_serial_port *port);
-	int (*port_remove)(struct usb_serial_port *port);
+	void (*port_remove)(struct usb_serial_port *port);
 
 	int (*suspend)(struct usb_serial *serial, pm_message_t message);
 	int (*resume)(struct usb_serial *serial);
-- 
2.29.2

