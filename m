Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8EB34EAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhC3OkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhC3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6889619DF;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=Qx3uIICjxsR/7ZgFZaHsruYnYuOO5JAwUyW0HFtbjGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvqYXfHmL+cnqwh+yG9rxRCMDOPIETf3ns6+DnVEswld/YK5FKQt5bmweltNgyTRN
         Lo2xj9hYLud6pGZ0N/P+m7SvJ6r7KlYISVnbCFkkx2q49lDVgIrsK4POBuiZt25Bq0
         6Q3jZYNl33+9jLvB/OMyexqBYaJuRuU0VFz1hnszHYAt2TNDHE7NJco49gGFf47Bup
         sJoKLW3QvqOYbtg3HriJS7iHztN33+x01Mu6IosuOsFoHNMNP9L3hKT13iazi2BfxI
         gk+cDqIGIF7z6u+uEBDXRD8RtgVKVMoXHi8+0XzLMIL0JLlZDDsGbmCqnnTL0qp4/W
         s1QoE/Jv93zqg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002Pd-PN; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] USB: serial: xr: add support for XR22801, XR22802, XR22804
Date:   Tue, 30 Mar 2021 16:39:34 +0200
Message-Id: <20210330143934.9197-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XR22801, XR22802 and XR22804 are compound devices with an embedded
hub and up to seven downstream USB devices including one, two or four
UARTs respectively.

The UART function is similar to XR21B142X but most registers are offset
by 0x40, the register requests are different and are directed at the
device rather than interface, and 5 and 6-bit words are not supported.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 46e5e1b2f3c0..14dbda13ab4d 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -134,6 +134,7 @@ enum xr_type_id {
 	XR21V141X,
 	XR21B142X,
 	XR21B1411,
+	XR2280X,
 	XR_TYPE_COUNT,
 };
 
@@ -198,6 +199,24 @@ static const struct xr_type xr_types[] = {
 		.gpio_status	= 0xc10,
 		.custom_driver	= 0x20d,
 	},
+	[XR2280X] = {
+		.reg_width	= 16,
+		.reg_recipient	= USB_RECIP_DEVICE,
+		.set_reg	= 0x05,
+		.get_reg	= 0x05,
+
+		.uart_enable	= 0x40,
+		.flow_control	= 0x46,
+		.xon_char	= 0x47,
+		.xoff_char	= 0x48,
+		.tx_break	= 0x4a,
+		.gpio_mode	= 0x4c,
+		.gpio_direction	= 0x4d,
+		.gpio_set	= 0x4e,
+		.gpio_clear	= 0x4f,
+		.gpio_status	= 0x50,
+		.custom_driver	= 0x81,
+	},
 };
 
 struct xr_data {
@@ -906,6 +925,10 @@ static void xr_port_remove(struct usb_serial_port *port)
 	.driver_info = (type)
 
 static const struct usb_device_id id_table[] = {
+	{ XR_DEVICE(0x04e2, 0x1400, XR2280X) },
+	{ XR_DEVICE(0x04e2, 0x1401, XR2280X) },
+	{ XR_DEVICE(0x04e2, 0x1402, XR2280X) },
+	{ XR_DEVICE(0x04e2, 0x1403, XR2280X) },
 	{ XR_DEVICE(0x04e2, 0x1410, XR21V141X) },
 	{ XR_DEVICE(0x04e2, 0x1411, XR21B1411) },
 	{ XR_DEVICE(0x04e2, 0x1412, XR21V141X) },
-- 
2.26.3

