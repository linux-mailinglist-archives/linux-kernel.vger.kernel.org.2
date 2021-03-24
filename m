Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49C3472DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhCXHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235650AbhCXHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48C1561A03;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=cYWYNcrB9C3keLoXcCiYON6nVkKe49hcwrxBhuh3z8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wyy1EyH+i7awz9gLrH7+Bh+vQ2cY0bEAMSm/E1LEWBtKLC7Gp9OsC0UA8H3B4jUqr
         SoMmKzaXmrOHKfybTtYzaVuApfFk3JjIum5fyxLVpv5AVlWgn9lUmwKcBF6R4fJisS
         R5dGUfSP68Nrtisb1TcQjHNGS0ZLY33i55UMt6kY3fhJh/jipjk6/qnQrU3AwfJnsV
         fobYbPVw/VFaA90jQ1M1G0lh2Hqh/H2WGerh4yOmpVYw24O3UFhGZXVYiY+IAbcyGm
         sm/ErPi2R6sXW70jAZjHFjLcM3biraS24jB06WyEHjX8EgP4dBRKul+ws1B5KpHm6e
         wZF9p6gsPBMQw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8h-000umZ-Ru; Wed, 24 Mar 2021 08:41:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 3/7] USB: serial: xr: add support for multi-port XR21V141X variants
Date:   Wed, 24 Mar 2021 08:41:07 +0100
Message-Id: <6ad220aa5ed6062005d44aeb3c02b5d576e12250.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XR21V1412 and XR21V1414 have exactly the same interface, but
they support multiple 2 and 4 ports, respectively.

On such devices, the "CDC Union" field shows how they're
grouped, as can be seen on those lsusb -v outputs:

	https://linux-usb.vger.kernel.narkive.com/YaTYwHkM/usb-uart-device-from-exar-co-not-working-with-cdc-acm-but-usbserial
	https://jquery.developreference.com/article/22043997/udev+rule+with+bInterfaceNumber+doesn't+work+%5bclosed%5d

So, for instance, on XR21V1414, (0x04e2:0x1414), the 3rd
port is:

	CDC Union:
		bMasterInterface 4
		bSlaveInterface 5

	CDC Call Management:
		bmCapabilities 0x01
			call management
				bDataInterface 5

In other words, the control interface is an even number,
and the data interface is the next odd number.

The logic to get the proper register for an specific channel
came from this patch:

	https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 518c4725431a..f161394d9b2d 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -145,6 +145,7 @@ static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
 
 struct xr_port_private {
 	enum xr_model model;
+	unsigned int channel;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
@@ -153,6 +154,14 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 	struct usb_serial *serial = port->serial;
 	int ret;
 
+	switch (port_priv->model) {
+	case XR21V141X:
+		if (port_priv->channel)
+			reg |= (port_priv->channel - 1) << 8;
+		break;
+	default:
+		return -EINVAL;
+	};
 	ret = usb_control_msg(serial->dev,
 			      usb_sndctrlpipe(serial->dev, 0),
 			      xr_hal_table[port_priv->model][REQ_SET],
@@ -178,6 +187,14 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 	if (!dmabuf)
 		return -ENOMEM;
 
+	switch (port_priv->model) {
+	case XR21V141X:
+		if (port_priv->channel)
+			reg |= (port_priv->channel - 1) << 8;
+		break;
+	default:
+		return -EINVAL;
+	};
 	ret = usb_control_msg(serial->dev,
 			      usb_rcvctrlpipe(serial->dev, 0),
 			      xr_hal_table[port_priv->model][REQ_GET],
@@ -601,17 +618,24 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
+	struct usb_interface *intf = serial->interface;
+	struct usb_endpoint_descriptor *data_ep;
 	struct xr_port_private *port_priv;
+	int ifnum;
 
-	/* Don't bind to control interface */
-	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
+	/* Attach only data interfaces */
+	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	if (!(ifnum % 2))
 		return -ENODEV;
 
 	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
 	if (!port_priv)
 		return -ENOMEM;
 
+	data_ep = &intf->cur_altsetting->endpoint[0].desc;
+
 	port_priv->model = id->driver_info;
+	port_priv->channel = data_ep->bEndpointAddress;
 
 	usb_set_serial_data(serial, port_priv);
 
@@ -628,6 +652,8 @@ static void xr_disconnect(struct usb_serial *serial)
 
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
+	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = XR21V141X},
+	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = XR21V141X},
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.30.2

