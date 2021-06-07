Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CED39D73E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFGI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhFGI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:29:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A9C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:27:34 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lqAba-0004dX-JK; Mon, 07 Jun 2021 10:27:30 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lqAba-0006nQ-AB; Mon, 07 Jun 2021 10:27:30 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/8] net: usb: asix: ax88772_bind: use devm_kzalloc() instead of kzalloc()
Date:   Mon,  7 Jun 2021 10:27:20 +0200
Message-Id: <20210607082727.26045-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210607082727.26045-1-o.rempel@pengutronix.de>
References: <20210607082727.26045-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make resource management easier, use devm_kzalloc().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/asix_devices.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 19a8fafb8f04..5f767a33264e 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -746,11 +746,11 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev->rx_urb_size = 2048;
 	}
 
-	dev->driver_priv = kzalloc(sizeof(struct asix_common_private), GFP_KERNEL);
-	if (!dev->driver_priv)
+	priv = devm_kzalloc(&dev->udev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	priv = dev->driver_priv;
+	dev->driver_priv = priv;
 
 	priv->presvd_phy_bmcr = 0;
 	priv->presvd_phy_advertise = 0;
@@ -768,7 +768,6 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
 	asix_rx_fixup_common_free(dev->driver_priv);
-	kfree(dev->driver_priv);
 }
 
 static const struct ethtool_ops ax88178_ethtool_ops = {
-- 
2.29.2

