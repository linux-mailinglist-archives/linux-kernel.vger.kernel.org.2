Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D365354930
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhDEXO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbhDEXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:14:18 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD8DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 16:14:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j17so6227226qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/PJIlYMvtvOjmWKMvD86+isUEsA4SFh08VG5H5krSE=;
        b=AtUtSyilVCumg3/2d6qBmx4TlBGwzZFJS3Q617LXCDmHu5oLh1kGA+L5ts+JvS1eY4
         H/V2H6nYyxLmPTJuMHGAhoi9Q1M9FrG1Je23/C0LjLZsr+3mHCMd1Dz5phPPnP54JPCU
         nH7SghuJPwL6STx+334CH8HRxOQqmTNDd/Muw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/PJIlYMvtvOjmWKMvD86+isUEsA4SFh08VG5H5krSE=;
        b=lb2spHxr+2sWP0WemP9/+zQFKjbcecRIb4JuYkBOIdfTAJSrNC9QRRHofgPCtKY/8y
         AB69tKIJ2vb29YTh6xuyQtTLlK+1JItGqdlgDpbt5vCQSSdZpFmUDlg1Kc2B1GScZb13
         EiM38JuOWxJ03OfQcwKYFWxp6sRQv0lI/1l6ZaBOQzpwkMsdOwwVP7MucD+Hee0plkxk
         rU7M7oNnjwSmGInkTSAI22JhdjgG51MZvCmIoiEqncUxV3HiJPnipYyGv0Dl2/i4gYK4
         t7GkoXd+OBmuhRRhGnSrwRvoM8MvmvJYGyUksOq7hUtw7VPLVp67rQBGMHpdnTz1jmne
         ZQ5g==
X-Gm-Message-State: AOAM530uomdce5q3ZNgyWNq1Q3MQVqWuMBIlymommzgEs4nmBBtq2P4Q
        ztplhVepb8tYtg5YbD+/49U8JQ==
X-Google-Smtp-Source: ABdhPJzuCJF7g+T0vM/FKWm5gCCOAnSR+OpyF3oNPUIgHg+vhgf6Hmj7l03tEpZD5t4iwyEpUleIfg==
X-Received: by 2002:a0c:b294:: with SMTP id r20mr25283932qve.16.1617664450042;
        Mon, 05 Apr 2021 16:14:10 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id b17sm13151650qtp.73.2021.04.05.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:14:09 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Roland Dreier <roland@kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH net-next v4 4/4] net: cdc_ether: record speed in status method
Date:   Mon,  5 Apr 2021 16:13:44 -0700
Message-Id: <20210405231344.1403025-5-grundler@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210405231344.1403025-1-grundler@chromium.org>
References: <20210405231344.1403025-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until very recently, the usbnet framework only had support functions
for devices which reported the link speed by explicitly querying the
PHY over a MDIO interface. However, the cdc_ether devices send
notifications when the link state or link speeds change and do not
expose the PHY (or modem) directly.

Support funtions (e.g. usbnet_get_link_ksettings_internal()) to directly
query state recorded by the cdc_ether driver were added in a previous patch.

Instead of cdc_ether spewing the link speed into the dmesg buffer,
record the link speed encoded in these notifications and tell the
usbnet framework to use the new functions to get link speed/state.

User space can now get the most recent link speed/state using ethtool.

v4: added to series since cdc_ether uses same notifications
    as cdc_ncm driver.

Signed-off-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/cdc_ether.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a9b551028659..7eb0109e9baa 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -92,6 +92,18 @@ void usbnet_cdc_update_filter(struct usbnet *dev)
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_update_filter);
 
+/* We need to override usbnet_*_link_ksettings in bind() */
+static const struct ethtool_ops cdc_ether_ethtool_ops = {
+	.get_link		= usbnet_get_link,
+	.nway_reset		= usbnet_nway_reset,
+	.get_drvinfo		= usbnet_get_drvinfo,
+	.get_msglevel		= usbnet_get_msglevel,
+	.set_msglevel		= usbnet_set_msglevel,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_link_ksettings	= usbnet_get_link_ksettings_internal,
+	.set_link_ksettings	= NULL,
+};
+
 /* probes control interface, claims data interface, collects the bulk
  * endpoints, activates data interface (if needed), maybe sets MTU.
  * all pure cdc, except for certain firmware workarounds, and knowing
@@ -310,6 +322,9 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 		return -ENODEV;
 	}
 
+	/* override ethtool_ops */
+	dev->net->ethtool_ops = &cdc_ether_ethtool_ops;
+
 	return 0;
 
 bad_desc:
@@ -379,12 +394,10 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
  * (by Brad Hards) talked with, with more functionality.
  */
 
-static void dumpspeed(struct usbnet *dev, __le32 *speeds)
+static void speed_change(struct usbnet *dev, __le32 *speeds)
 {
-	netif_info(dev, timer, dev->net,
-		   "link speeds: %u kbps up, %u kbps down\n",
-		   __le32_to_cpu(speeds[0]) / 1000,
-		   __le32_to_cpu(speeds[1]) / 1000);
+	dev->tx_speed = __le32_to_cpu(speeds[0]);
+	dev->rx_speed = __le32_to_cpu(speeds[1]);
 }
 
 void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
@@ -396,7 +409,7 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 
 	/* SPEED_CHANGE can get split into two 8-byte packets */
 	if (test_and_clear_bit(EVENT_STS_SPLIT, &dev->flags)) {
-		dumpspeed(dev, (__le32 *) urb->transfer_buffer);
+		speed_change(dev, (__le32 *) urb->transfer_buffer);
 		return;
 	}
 
@@ -413,7 +426,7 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 		if (urb->actual_length != (sizeof(*event) + 8))
 			set_bit(EVENT_STS_SPLIT, &dev->flags);
 		else
-			dumpspeed(dev, (__le32 *) &event[1]);
+			speed_change(dev, (__le32 *) &event[1]);
 		break;
 	/* USB_CDC_NOTIFY_RESPONSE_AVAILABLE can happen too (e.g. RNDIS),
 	 * but there are no standard formats for the response data.
-- 
2.30.1

