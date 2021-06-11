Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B43A433A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFKNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhFKNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:48:51 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Jun 2021 06:46:52 PDT
Received: from mail-out-2.itc.rwth-aachen.de (mail-out-2.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD5C061574;
        Fri, 11 Jun 2021 06:46:51 -0700 (PDT)
IronPort-SDR: w+r7Ecj97RnT52MOBEpzp4jh4NUfT2dr6jjKENWhqd1BM4TKm7c5y3I37YF7LyqMwDCBpWRvCP
 aJno3mvLWsRA==
X-IPAS-Result: =?us-ascii?q?A2BKBQBmaMNg/5wagoZaHgEBCxIMQIVRaguEPa1bgWgLA?=
 =?us-ascii?q?QEBAQEBAQEBCAE/AgQBAYRQgmoCJTgTAgQBAQEBAwIDAQEBAQUBAQYBAQEBA?=
 =?us-ascii?q?QEFBIEEhS9Ghm8PAUY1AiYCXwENBYJxgwgEqgeBMoEBiGOBJgkBgQYqhwmBc?=
 =?us-ascii?q?XaEIYIpgRWCdIRzg1WCZASDIAcHNlG/DQeBeoElnV1ElHWQbgGVUqAfhBECB?=
 =?us-ascii?q?AIEBQIWgWuBfXGDOFAXAg6cb0AxOAIGAQkBAQMJTwwhh1sBgRABAQ?=
IronPort-HdrOrdr: A9a23:mSDSzKl63BF5yWh6XicPjA+PFlfpDfKz3DAbv31ZSRFFG/Fwwf
 re58jztCWE+Qr5N0tPpTntAsi9qV21z+8Q3WA6B8bGYOCeghrTEGgA1/qd/9SDIVycygcH79
 YYT0EWMrSZZmSS6/yb3ODSKbodKay8gdyVbJDlvgpQpG9RBp2J321CYDpzO3cGPDVuNN4SEo
 aG/MYChzfIQwVxUu2LQlMCQ/PYq5ntnJbrCCR2YSLPkDP+7w+A2frfFR6U2xtbdShOz7ck+X
 XElAK83K+5s+inoyWsqFM6Ofxt9+fc9g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,265,1616454000"; 
   d="scan'208";a="148317777"
Received: from rwthex-w1-a.rwth-ad.de ([134.130.26.156])
  by mail-in-2.itc.rwth-aachen.de with ESMTP; 11 Jun 2021 15:45:44 +0200
Received: from pebbles.fritz.box (78.48.70.208) by rwthex-w1-a.rwth-ad.de
 (2a00:8a60:1:e500::26:156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12; Fri, 11 Jun
 2021 15:45:25 +0200
From:   =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add support for SDX55 based Sierra Wireless 5G modules
Date:   Fri, 11 Jun 2021 15:45:07 +0200
Message-ID: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [78.48.70.208]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices exposes two different interface compositions:
- QDL mode, single interface
- MBIM mode, MBIM class compliant plus AT/DM(/ADB)

Current firmware versions (up to 01.07.19) do not expose an NMEA port.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/usb/serial/qcserial.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 83da8236e3c8..4ff325a14c98 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -26,12 +26,15 @@ enum qcserial_layouts {
 	QCSERIAL_G1K = 1,	/* Gobi 1000 */
 	QCSERIAL_SWI = 2,	/* Sierra Wireless */
 	QCSERIAL_HWI = 3,	/* Huawei */
+	QCSERIAL_SWI2 = 4,	/* Sierra Wireless */
 };
 
 #define DEVICE_G1K(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_G1K
 #define DEVICE_SWI(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI
+#define DEVICE_SWI2(v, p) \
+	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI2
 #define DEVICE_HWI(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_HWI
 
@@ -181,6 +184,10 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
 	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
 
+	/* SDX55 based Sierra Wireless devices */
+	{DEVICE_SWI2(0x1199, 0x90d2)},	/* Sierra Wireless EM919x QDL */
+	{DEVICE_SWI2(0x1199, 0x90d3)},	/* Sierra Wireless EM919x */
+
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
 
@@ -359,6 +366,28 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 			break;
 		}
 		break;
+	case QCSERIAL_SWI2:
+		/*
+		 * Sierra Wireless SDX55 in MBIM mode:
+		 * 0/1: MBIM Control/Data
+		 * 3: AT-capable modem port
+		 * 4: DM/DIAG (use libqcdm from ModemManager for communication)
+		 * 5: ADB
+		 */
+		switch (ifnum) {
+		case 3:
+			dev_dbg(dev, "Modem port found\n");
+			sendsetup = true;
+			break;
+		case 4:
+			dev_dbg(dev, "DM/DIAG interface found\n");
+			break;
+		default:
+			/* don't claim any unsupported interface */
+			altsetting = -1;
+			break;
+		}
+		break;
 	case QCSERIAL_HWI:
 		/*
 		 * Huawei devices map functions by subclass + protocol
-- 
2.31.1

