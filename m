Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D33472D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhCXHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhCXHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ED67619FA;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=h9+yg+LKCptBrIFFjhsjQQ4j1e01DH+GCFCab0dYLJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOXHzMPllBsdO7gKwWq2Irwgzm4lQ28XFJL2j98J9j6+stcfr2FB+oFfalDuF7wWd
         fxijM+SNFfgi/pxtEfitL1jOeJF2AIKzWlBSsWddeQEUMIJGqR/MPpmcyRqGJNM/qz
         Mna/EVX0bGV1sWIBFLclOSuSj1xgK2JNEay65xm0240E3AXNZ8nRQ/fu4rMvHCnGH2
         LnnLU9aAELB3Hvl+JBoM1d10mNx8cHL4PTvbAFczBpR74JewkJH5V1WsXDiWsdF9Q1
         GyFLz26/73D6TclhGbGDCbTHyDn1NtK1myl8VVfXeMgBxJHDroPQQuyU1eVqDpZSes
         CGlcgNAn/EoVQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8i-000umk-09; Wed, 24 Mar 2021 08:41:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 7/7] USB: cdc-acm: add other non-standard xr_serial models to ignore list
Date:   Wed, 24 Mar 2021 08:41:11 +0100
Message-Id: <5155887a764cbc11f8da0217fe08a24a77d120b4.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the xr_serial got support for other models, add their
USB IDs as well, as those devices won't work with the standard
CDC driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 39ddb5585ded..839b80093478 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1902,9 +1902,20 @@ static const struct usb_device_id acm_ids[] = {
 #endif
 
 #if IS_ENABLED(CONFIG_USB_SERIAL_XR)
-	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
-	.driver_info = IGNORE_DEVICE,
-	},
+	/* Ignore MaxLinear/Exar USB UARTs and USB UART bridges */
+	{ USB_DEVICE(0x04e2, 0x1400), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1401), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1402), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1403), .driver_info = IGNORE_DEVICE,},
+
+	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = IGNORE_DEVICE,},
+
+	{ USB_DEVICE(0x04e2, 0x1420), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1422), .driver_info = IGNORE_DEVICE,},
+	{ USB_DEVICE(0x04e2, 0x1424), .driver_info = IGNORE_DEVICE,},
 #endif
 
 	/*Samsung phone in firmware update mode */
-- 
2.30.2

