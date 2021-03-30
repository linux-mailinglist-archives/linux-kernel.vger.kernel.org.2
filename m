Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59934EA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhC3OiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhC3OiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:38:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74436619BD;
        Tue, 30 Mar 2021 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115085;
        bh=wAtTiuqbcs4zl44Wh5dNxP5kXHHuGZ0n/flc0iW7p0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg/MvTdkZjHr3BdHDmUlwbmD0th8nUhgXR8SUnotfcTWkLgeiOMDJgVxDVKIRahQw
         EUO0z6p8RD4wTpJ5mrDpw9eCu7VjOlaLZhFcp4OTJNmOMMJkHrNn1TxO/oUgs4J1d6
         uS06uQkOcpCIQjkNoJLlgNoGcgFMhHn0s01rHm6iblqnDBmni6OqW29muZw0QWCJfB
         95ptrrgpFbm5deCOAnid7qIbMoVXZuKfIawRQPIMDrYDfZ3ZmVQSV2WYDUUY6vwyMp
         6hPZYU0a1K71eIdKssmvcp/owTLGX975HLNhdgv8q0bUfHWimSDdqn0nSNRu85WuAS
         gK3oUlvqRPxYw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFVj-0002Nm-F2; Tue, 30 Mar 2021 16:38:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] USB: serial: refactor endpoint classification
Date:   Tue, 30 Mar 2021 16:38:18 +0200
Message-Id: <20210330143820.9103-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143820.9103-1-johan@kernel.org>
References: <20210330143820.9103-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor endpoint classification and replace the build-time
endpoint-array sanity checks with runtime checks in preparation for
handling endpoints from a sibling interface.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 51 ++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 2a38810a3979..d981809c4ed3 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -711,36 +711,47 @@ static const struct tty_port_operations serial_port_ops = {
 	.shutdown		= serial_port_shutdown,
 };
 
+static void store_endpoint(struct usb_serial *serial,
+					struct usb_serial_endpoints *epds,
+					struct usb_endpoint_descriptor *epd)
+{
+	struct device *dev = &serial->interface->dev;
+	u8 addr = epd->bEndpointAddress;
+
+	if (usb_endpoint_is_bulk_in(epd)) {
+		if (epds->num_bulk_in == ARRAY_SIZE(epds->bulk_in))
+			return;
+		dev_dbg(dev, "found bulk in endpoint %02x\n", addr);
+		epds->bulk_in[epds->num_bulk_in++] = epd;
+	} else if (usb_endpoint_is_bulk_out(epd)) {
+		if (epds->num_bulk_out == ARRAY_SIZE(epds->bulk_out))
+			return;
+		dev_dbg(dev, "found bulk out endpoint %02x\n", addr);
+		epds->bulk_out[epds->num_bulk_out++] = epd;
+	} else if (usb_endpoint_is_int_in(epd)) {
+		if (epds->num_interrupt_in == ARRAY_SIZE(epds->interrupt_in))
+			return;
+		dev_dbg(dev, "found interrupt in endpoint %02x\n", addr);
+		epds->interrupt_in[epds->num_interrupt_in++] = epd;
+	} else if (usb_endpoint_is_int_out(epd)) {
+		if (epds->num_interrupt_out == ARRAY_SIZE(epds->interrupt_out))
+			return;
+		dev_dbg(dev, "found interrupt out endpoint %02x\n", addr);
+		epds->interrupt_out[epds->num_interrupt_out++] = epd;
+	}
+}
+
 static void find_endpoints(struct usb_serial *serial,
 					struct usb_serial_endpoints *epds)
 {
-	struct device *dev = &serial->interface->dev;
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *epd;
 	unsigned int i;
 
-	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_in) < USB_MAXENDPOINTS / 2);
-	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < USB_MAXENDPOINTS / 2);
-	BUILD_BUG_ON(ARRAY_SIZE(epds->interrupt_in) < USB_MAXENDPOINTS / 2);
-	BUILD_BUG_ON(ARRAY_SIZE(epds->interrupt_out) < USB_MAXENDPOINTS / 2);
-
 	iface_desc = serial->interface->cur_altsetting;
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		epd = &iface_desc->endpoint[i].desc;
-
-		if (usb_endpoint_is_bulk_in(epd)) {
-			dev_dbg(dev, "found bulk in on endpoint %u\n", i);
-			epds->bulk_in[epds->num_bulk_in++] = epd;
-		} else if (usb_endpoint_is_bulk_out(epd)) {
-			dev_dbg(dev, "found bulk out on endpoint %u\n", i);
-			epds->bulk_out[epds->num_bulk_out++] = epd;
-		} else if (usb_endpoint_is_int_in(epd)) {
-			dev_dbg(dev, "found interrupt in on endpoint %u\n", i);
-			epds->interrupt_in[epds->num_interrupt_in++] = epd;
-		} else if (usb_endpoint_is_int_out(epd)) {
-			dev_dbg(dev, "found interrupt out on endpoint %u\n", i);
-			epds->interrupt_out[epds->num_interrupt_out++] = epd;
-		}
+		store_endpoint(serial, epds, epd);
 	}
 }
 
-- 
2.26.3

