Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE0367BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhDVH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhDVH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:59:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:58:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lZUEf-00062I-8O; Thu, 22 Apr 2021 09:58:53 +0200
Received: from [2a0a:edc0:0:900:2e4d:54ff:fe67:bfa5] (helo=ginster)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lZUEe-0000K0-JG; Thu, 22 Apr 2021 09:58:52 +0200
Received: from jbe by ginster with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lZUEe-0002RY-IT; Thu, 22 Apr 2021 09:58:52 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] USB: serial: ftdi_sio: add IDs for IDS GmbH Products
Date:   Thu, 22 Apr 2021 09:58:52 +0200
Message-Id: <20210422075852.9351-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Andreas Schorpp <dominik.a.schorpp@ids.de>

Add the IDS GmbH Vendor ID and the Product IDs for SI31A (2xRS232)
and CM31A (LoRaWAN Modem).

Signed-off-by: Dominik Andreas Schorpp <dominik.a.schorpp@ids.de>
Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/usb/serial/ftdi_sio.c     | 3 +++
 drivers/usb/serial/ftdi_sio_ids.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c867592..5a725ff 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1034,6 +1034,9 @@ static const struct usb_device_id id_table_combined[] = {
 	/* Sienna devices */
 	{ USB_DEVICE(FTDI_VID, FTDI_SIENNA_PID) },
 	{ USB_DEVICE(ECHELON_VID, ECHELON_U20_PID) },
+	/* IDS GmbH devices */
+	{ USB_DEVICE(IDS_VID, IDS_SI31A_PID) },
+	{ USB_DEVICE(IDS_VID, IDS_CM31A_PID) },
 	/* U-Blox devices */
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ZED_PID) },
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 3d47c6d..d854e04 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1567,6 +1567,13 @@
 #define UNJO_VID			0x22B7
 #define UNJO_ISODEBUG_V1_PID		0x150D
 
+/*
+ * IDS GmbH
+ */
+#define IDS_VID				0x2CAF
+#define IDS_SI31A_PID			0x13A2
+#define IDS_CM31A_PID			0x13A3
+
 /*
  * U-Blox products (http://www.u-blox.com).
  */
-- 
2.20.1

