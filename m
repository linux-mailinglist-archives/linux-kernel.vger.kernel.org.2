Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C18326363
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZNba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhBZNaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:30:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5056664F14;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=pDZRiHRCbWfi2gnpuv/OSYPozj5G9SfSIdoHNgW532A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGc0qpwirSZN4O53Aa8g3CkW1xBeKYW9hpcqpXuJORpwQ4BIZL6vKRuWOMzB93Ea6
         WveUY2CV1JC8/wDOswoZ218M+rRE+5kgWxnClIGehMbZ4Nd7/6ZfUfxs/3XEvEp9t4
         zGhLqZsS3vbXeYTszUkv5+cqhi647p6kcErRv/HxoOd+iMBkRdvDABlyHKzHDWPVJk
         OtZewgNMAxQ/FCsYCkgd5BY3M+jPCVYhiVan9W/jdUVTxTsVOfbn1NcGprcDx+2DvG
         CxdDhXo2zX2nNKmN3EegBZhydgqUN6jNle6VIaq5ZPmNHLfPR23bDBC02obhJVO05A
         l99zH5LcZcE9Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nc3-Nt; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 7/7] USB: cdc-acm: add other non-standard xr_serial models to ignore list
Date:   Fri, 26 Feb 2021 14:28:33 +0100
Message-Id: <922b6686be927fd1e176852d9cebdd8fca7f42dd.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614345081.git.mchehab+huawei@kernel.org>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
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
index 37f824b59daa..bb7e30e9104d 100644
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
2.29.2

