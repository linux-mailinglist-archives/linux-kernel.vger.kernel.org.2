Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2234EA85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhC3OiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhC3OiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1431619C8;
        Tue, 30 Mar 2021 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115086;
        bh=+6W/Yl//h0yVqmxmy3+UJygrHKmPkBC8VX4z4yi1Wl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRfESmEcCc7LtpOzIpOWSNP/JolMBZ/QgPUeZnKc7FLJYJ+qQUzEplQjYc89FNDaw
         rQyJsAB+3SlhiXawCdvwgKbheu0ac/hj95UCnKEEd2ndjfLKY0OnQsdiaSGeeWpnhZ
         mkL4kZ4rOT7A3pzl3ksKwCcRvw9+fo9hYKoL4QrLEshZn+dwmazz23Z7TvGeCoLSxD
         OhFqLwHxOxFQ8TRW5jdhXyKWH/FExBSofJTTMC+VFhCdZtuMkCXbVUxElqYpnPbrua
         VioJwEhNBRmMTdsawUurWRmR/DaV7jPfohl1iA5ADFEFNpwDo7SwlgYMoQFC5Du7Ap
         91Z3aD9AGn2vQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFVj-0002Nt-LB; Tue, 30 Mar 2021 16:38:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] USB: serial: xr: claim both interfaces
Date:   Tue, 30 Mar 2021 16:38:20 +0200
Message-Id: <20210330143820.9103-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143820.9103-1-johan@kernel.org>
References: <20210330143820.9103-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new multi-interface support in USB serial core to properly claim
also the control interface during probe. This prevents having another
driver claim the control interface and makes core allocate resources
also for the interrupt endpoint (currently unused).

Switch to probing only Communication Class interfaces and use the Union
functional descriptor to determine the corresponding data interface.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index c59c8b47a120..88c73f88cb26 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/usb.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
 
 struct xr_txrx_clk_mask {
@@ -550,15 +551,34 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
-	/* Don't bind to control interface */
-	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
+	struct usb_interface *control = serial->interface;
+	struct usb_host_interface *alt = control->cur_altsetting;
+	struct usb_cdc_parsed_header hdrs;
+	struct usb_cdc_union_desc *desc;
+	struct usb_interface *data;
+	int ret;
+
+	ret = cdc_parse_cdc_header(&hdrs, control, alt->extra, alt->extralen);
+	if (ret < 0)
 		return -ENODEV;
 
+	desc = hdrs.usb_cdc_union_desc;
+	if (!desc)
+		return -ENODEV;
+
+	data = usb_ifnum_to_if(serial->dev, desc->bSlaveInterface0);
+	if (!data)
+		return -ENODEV;
+
+	ret = usb_serial_claim_interface(serial, data);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
+	{ USB_DEVICE_INTERFACE_CLASS(0x04e2, 0x1410, USB_CLASS_COMM) }, /* XR21V141X */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.26.3

