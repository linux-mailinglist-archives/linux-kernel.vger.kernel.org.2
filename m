Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3181335C340
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbhDLKAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244819AbhDLJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 022E661367;
        Mon, 12 Apr 2021 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618221379;
        bh=quKD0m9fXHZbBoOyEC6sAtv2Nx7CdwbfN9wIuomHiHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kdnob56X0uGEG/Fi/aOv0sPtqc9rYi652HJz8wwyM2+9m2RR9BjbnigBEjZI6iIA5
         k5AYxmmvRv7v4fKqFC6bQ3pSl1Wi1v8fZTIEWIJ4COwvGLBDG5PuLyTqWKPVQDqso4
         1E2jJwoeCHUVTOkHaV5wl7yHQqXz+k8vbloBeiAjHfCnEtN4Y8612rCruXgOxnk9A7
         5e+413xfjqXPfsAzXSpbJAjwkLC6AKEbeLRJ8wpsXRbW5Cs7y2/ObXBsGW4lksmQ1M
         CpWpJl78eAfu+CBuzQbdd2FfwezDGbxyjp/rrRrC5Vls0Pf5q1PadDDmKtWc7LmmNa
         OwELyC4JEGcFw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVtIj-0000L6-HU; Mon, 12 Apr 2021 11:56:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 12/12] USB: cdc-acm: add more Maxlinear/Exar models to ignore list
Date:   Mon, 12 Apr 2021 11:55:57 +0200
Message-Id: <20210412095557.1213-13-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412095557.1213-1-johan@kernel.org>
References: <20210412095557.1213-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that the xr_serial got support for other models, add their USB IDs
as well.

The Maxlinear/Exar USB UARTs can be used in either ACM mode using the
cdc-acm driver or in "custom driver" mode in which further features such
as hardware and software flow control, GPIO control and in-band
line-status reporting are available.

In ACM mode the device always enables RTS/CTS flow control, something
which could prevent transmission in case the CTS input isn't wired up
correctly.

Ensure that cdc_acm will not bind to these devices if the custom
USB-serial driver is enabled.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Link: https://lore.kernel.org/r/5155887a764cbc11f8da0217fe08a24a77d120b4.1616571453.git.mchehab+huawei@kernel.org
[ johan: rewrite commit message, clean up entries ]
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 337ffced9c40..434539b13a70 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1903,9 +1903,17 @@ static const struct usb_device_id acm_ids[] = {
 #endif
 
 #if IS_ENABLED(CONFIG_USB_SERIAL_XR)
-	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
-	.driver_info = IGNORE_DEVICE,
-	},
+	{ USB_DEVICE(0x04e2, 0x1400), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1401), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1402), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1403), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1420), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1422), .driver_info = IGNORE_DEVICE },
+	{ USB_DEVICE(0x04e2, 0x1424), .driver_info = IGNORE_DEVICE },
 #endif
 
 	/*Samsung phone in firmware update mode */
-- 
2.26.3

