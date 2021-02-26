Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DC326362
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBZNay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhBZN33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:29:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5302164E4B;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=Pg3E5k5m+ARqGfXGqBRXxYZr5F2MSDKqzC+TkVPCxJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKsU0M9H5Q3qz1+WfzNXDAdw0Oa3Pf5LsJA3kgKgpV3SVAdftjDFCziGFeFrGJeG0
         CWRdpJ3/loui8Zwu+Yv6r9orvsEKh05GmC+hCbfktr5A/Mvrdx4v3vg8s4TcUlW+wP
         eu9x1uu3w/VGCCEOzHsFOOtLKlwfIwidUnRHFnIqBiPJGP+Qflt62mKzV/IoMwd5DG
         5Kyhrk5I+GEmawJflUo0nk+NUN2dn+aSVeP3bd51ccQihsCDkgjCA0X/Fs336bmf8t
         IeC1oSgBsnucvvHawpFAIG+VD7xIq6k+2y0H/A3oEi+Vkt3ONWp61sY9Nue95MORBq
         eKmaB8RQVXxjw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nbu-KM; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 3/7] USB: serial: xr: add support for multi-port XR21V141X variants
Date:   Fri, 26 Feb 2021 14:28:29 +0100
Message-Id: <1552a1f9d20d5e8241aea4cfa247b0e549cd66d7.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614345081.git.mchehab+huawei@kernel.org>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
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
index 10f7fb40d9ae..1d4d67e64a21 100644
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
2.29.2

