Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0053340958
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCRPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhCRPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C3F564F2B;
        Thu, 18 Mar 2021 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082838;
        bh=vnHWsTImY4WVKdFD4iKMbkqENlHuov9x76e2FXq1Qhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyVTF3TnpwjD+6LfzbBMuE8qQDRvjovNDG/MfrZYI0L0Z6ikdazRj/Sr9Wj+yjKep
         vIeJHZxsA2NHpEBTjUe9brneCOOURI6oEoArTMgLgs+0A97f/FBVpZtkT9nYUVoiEg
         5mYo5YBd9F+jGWUG/J+nCa5fO046PvgXgw0SOfNrf68IPPEFvsrrXNKZ2l/O2MuR6D
         OrsOnsvYweNtMxSxPQLRQmomkXCTBrF02sHemGbZiLdWzlwjyL49qX0+iye4vB5nJh
         R2mWGe1KiGHty1JUZGgGnsT5tN3V3DGBe0bdbzWPCK+vBJ+HTBLqvCN3kIYD+wGTNd
         PECMyFqxdZ3tw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuyW-0005q5-Re; Thu, 18 Mar 2021 16:54:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] USB: core: rename usb_driver_claim_interface() data parameter
Date:   Thu, 18 Mar 2021 16:54:06 +0100
Message-Id: <20210318155406.22399-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155406.22399-1-johan@kernel.org>
References: <20210318155406.22399-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been almost twenty years since the interface "private data" pointer
was removed in favour of using the driver-data pointer of struct device.

Let's rename the driver-data parameter of usb_driver_claim_interface()
so that it better reflects how it's used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/driver.c | 6 +++---
 include/linux/usb.h       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index a1013d9da08d..072968c40ade 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -519,7 +519,7 @@ static int usb_unbind_interface(struct device *dev)
  * @driver: the driver to be bound
  * @iface: the interface to which it will be bound; must be in the
  *	usb device's active configuration
- * @priv: driver data associated with that interface
+ * @data: driver data associated with that interface
  *
  * This is used by usb device drivers that need to claim more than one
  * interface on a device when probing (audio and acm are current examples).
@@ -533,7 +533,7 @@ static int usb_unbind_interface(struct device *dev)
  * Return: 0 on success.
  */
 int usb_driver_claim_interface(struct usb_driver *driver,
-				struct usb_interface *iface, void *priv)
+				struct usb_interface *iface, void *data)
 {
 	struct device *dev;
 	int retval = 0;
@@ -550,7 +550,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		return -ENODEV;
 
 	dev->driver = &driver->drvwrap.driver;
-	usb_set_intfdata(iface, priv);
+	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
 
 	iface->condition = USB_INTERFACE_BOUND;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d6a41841b93e..08c672e7ece2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -841,7 +841,7 @@ extern int usb_free_streams(struct usb_interface *interface,
 
 /* used these for multi-interface device registration */
 extern int usb_driver_claim_interface(struct usb_driver *driver,
-			struct usb_interface *iface, void *priv);
+			struct usb_interface *iface, void *data);
 
 /**
  * usb_interface_claimed - returns true iff an interface is claimed
-- 
2.26.2

