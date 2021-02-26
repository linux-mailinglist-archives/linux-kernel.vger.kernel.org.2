Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4008326105
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBZKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230466AbhBZKJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:09:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 999A964EED;
        Fri, 26 Feb 2021 10:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614334110;
        bh=+vSapguqVi3xqBZItpVDSazJWi5j4QeV+Jglua/0Ul8=;
        h=From:To:Cc:Subject:Date:From;
        b=p2dVoMxmr0REiGruLYydcIFsMId1dYK2ZpW0uA5jRZYlAuqwPSUYWFNPdcLDRptlE
         OFzF2WzQ4IY1FY1uGQqoWgCTwppg3EVA/Mf0VaE7+UE5detHV1MORv+SUZ1CDQHXeS
         rFeC/9J5bIea84mdhvn4CU44cw1xYJGg8p7om4JJ1kZq0Gwg3H37UfveRyRe9xJMbO
         xvVH5jZ/iLk89HfNjIa66Zy9OrwSm7R/o66FcBj3JdBQmvsha9e/Brn96QvTAw8zbl
         res01ueFB+AslXJ4JAhcSj5Pfr5ye4LyS5pvsD2QRmye/6lIRlGwZuGzqxocyJrtb0
         dgBUdozDBGWRQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lFa3G-0004wz-S7; Fri, 26 Feb 2021 11:08:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] USB: serial: xr: fix NULL-deref on disconnect
Date:   Fri, 26 Feb 2021 11:08:26 +0100
Message-Id: <20210226100826.18987-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claiming the sibling control interface is a bit more involved and
specifically requires adding support to USB-serial core for managing
either interface being unbound first, something which could otherwise
lead to a NULL-pointer dereference.

Similarly, additional infrastructure is also needed to handle suspend
properly.

Since the driver currently isn't actually using the control interface,
we can defer this for now by simply not claiming the control interface.

Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 483d07dee19d..0ca04906da4b 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -545,37 +545,13 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
-	struct usb_driver *driver = serial->type->usb_driver;
-	struct usb_interface *control_interface;
-	int ret;
-
 	/* Don't bind to control interface */
 	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
 		return -ENODEV;
 
-	/* But claim the control interface during data interface probe */
-	control_interface = usb_ifnum_to_if(serial->dev, 0);
-	if (!control_interface)
-		return -ENODEV;
-
-	ret = usb_driver_claim_interface(driver, control_interface, NULL);
-	if (ret) {
-		dev_err(&serial->interface->dev, "Failed to claim control interface\n");
-		return ret;
-	}
-
 	return 0;
 }
 
-static void xr_disconnect(struct usb_serial *serial)
-{
-	struct usb_driver *driver = serial->type->usb_driver;
-	struct usb_interface *control_interface;
-
-	control_interface = usb_ifnum_to_if(serial->dev, 0);
-	usb_driver_release_interface(driver, control_interface);
-}
-
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
 	{ }
@@ -590,7 +566,6 @@ static struct usb_serial_driver xr_device = {
 	.id_table		= id_table,
 	.num_ports		= 1,
 	.probe			= xr_probe,
-	.disconnect		= xr_disconnect,
 	.open			= xr_open,
 	.close			= xr_close,
 	.break_ctl		= xr_break_ctl,
-- 
2.26.2

