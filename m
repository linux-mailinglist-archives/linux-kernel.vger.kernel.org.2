Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4035492C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhDEXOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbhDEXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:14:16 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F06C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 16:14:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x11so13122434qkp.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKjyGrTQkdJ77KfeD8uvsU4WKwWh4qlFSNUL5dPdjfU=;
        b=cbUAcKuM2AX0RK/QokGq5zjGJ589ipdJgkyKtdvW7AZq5ncy0bLg5qVMurq6tSIIWu
         X2TUiRHAU9pvFPsCTJwYhVs/PnISmjY+3FdvvjDxsYeke/V3xLHMx4I5pfUmHSkZWaoR
         oLbj7LVRhaqq5Py/bKrrP//uvvB8LYTHGA2m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKjyGrTQkdJ77KfeD8uvsU4WKwWh4qlFSNUL5dPdjfU=;
        b=NY3ugLAd/mU7QHLpOLMaNVN5IPAH3toji144O14XxGOXdM25/TD4b7H89/praRfJ7J
         BXsDmnRWjriBFCOldyrdO6p8zSyRxTvPhtT7iraO9mTElberC+9wHrMh1gdYt8h9dRRD
         wI6FBFX8XTUxu/6eqsh/VSSyOA0RvCVKgY3hUOiSdvZYUWwk45BpBIg6QyWIwY0S3GSw
         u7Y75dpr4LstEcCV1Q+6QBOghfexvwbZcBGG3Sn1A22qs62rVh3YaPDFOORAtHoPIpof
         CcJlS4Pe5BCGyPXRwKx3P0ClfaPmeY+8ykyqJjfUZaG9UpSBVa9S8A0Mcoqlx8azpGVj
         m5hw==
X-Gm-Message-State: AOAM532e9IfBHAFmpbsJzWPrFXeAO/9wDgl98vWOdCTB+wqYhhVcDRCF
        QyIziWBSimq0//RpfwB1xMsvzw==
X-Google-Smtp-Source: ABdhPJyvxP5MoeFaRhekp4KLM5wH25hHSvp4AVFBk3YUVIegcoKtXzrFbVlavibETPUj3F6v8nl+dg==
X-Received: by 2002:a37:6888:: with SMTP id d130mr26110802qkc.368.1617664447096;
        Mon, 05 Apr 2021 16:14:07 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id b17sm13151650qtp.73.2021.04.05.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:14:06 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Roland Dreier <roland@kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH net-next v4 2/4] usbnet: add method for reporting speed without MII
Date:   Mon,  5 Apr 2021 16:13:42 -0700
Message-Id: <20210405231344.1403025-3-grundler@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210405231344.1403025-1-grundler@chromium.org>
References: <20210405231344.1403025-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

The old method for reporting link speed assumed a driver uses the
generic phy (mii) MDIO read/write functions. CDC devices don't
expose the phy.

Add a primitive internal version reporting back directly what
the CDC notification/status operations recorded.

v2: rebased on upstream
v3: changed names and made clear which units are used
v4: moved hunks to correct patch; rewrote commmit messages

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Tested-by: Roland Dreier <roland@kernel.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Tested-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/usbnet.c   | 23 +++++++++++++++++++++++
 include/linux/usb/usbnet.h |  7 +++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 5b4629c80b4b..ecf62849f4c1 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -961,6 +961,27 @@ int usbnet_get_link_ksettings_mii(struct net_device *net,
 }
 EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings_mii);
 
+int usbnet_get_link_ksettings_internal(struct net_device *net,
+					struct ethtool_link_ksettings *cmd)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	/* the assumption that speed is equal on tx and rx
+	 * is deeply engrained into the networking layer.
+	 * For wireless stuff it is not true.
+	 * We assume that rx_speed matters more.
+	 */
+	if (dev->rx_speed != SPEED_UNSET)
+		cmd->base.speed = dev->rx_speed / 1000000;
+	else if (dev->tx_speed != SPEED_UNSET)
+		cmd->base.speed = dev->tx_speed / 1000000;
+	else
+		cmd->base.speed = SPEED_UNKNOWN;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings_internal);
+
 int usbnet_set_link_ksettings_mii(struct net_device *net,
 			      const struct ethtool_link_ksettings *cmd)
 {
@@ -1664,6 +1685,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	dev->intf = udev;
 	dev->driver_info = info;
 	dev->driver_name = name;
+	dev->rx_speed = SPEED_UNSET;
+	dev->tx_speed = SPEED_UNSET;
 
 	net->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!net->tstats)
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index a89e1452107d..8336e86ce606 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -53,6 +53,9 @@ struct usbnet {
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
 	struct mii_if_info	mii;
+	long			rx_speed;	/* If MII not used */
+	long			tx_speed;	/* If MII not used */
+#		define SPEED_UNSET	-1
 
 	/* various kinds of pending driver work */
 	struct sk_buff_head	rxq;
@@ -81,8 +84,6 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
-	u32			rx_speed;	/* in bps - NOT Mbps */
-	u32			tx_speed;	/* in bps - NOT Mbps */
 };
 
 static inline struct usb_driver *driver_of(struct usb_interface *intf)
@@ -271,6 +272,8 @@ extern int usbnet_get_link_ksettings_mii(struct net_device *net,
 				     struct ethtool_link_ksettings *cmd);
 extern int usbnet_set_link_ksettings_mii(struct net_device *net,
 				     const struct ethtool_link_ksettings *cmd);
+extern int usbnet_get_link_ksettings_internal(struct net_device *net,
+				     struct ethtool_link_ksettings *cmd);
 extern u32 usbnet_get_link(struct net_device *net);
 extern u32 usbnet_get_msglevel(struct net_device *);
 extern void usbnet_set_msglevel(struct net_device *, u32);
-- 
2.30.1

