Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66E3A5A09
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhFMSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhFMSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 14:37:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C4AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:35:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp38so17290236lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rd9LRe77V7pHhuoyeJvDmCm7mX//E10O3Cp6VzupEbc=;
        b=X3h0v8rWhxwM83OXFg2rjx0eapxrhbv2wKjjRumRzFjbVe27c2iIcnVX3HdWbzf0Ga
         yFvNhv6AgLdxzgqmU/jLdG603LfFOahrzt2FkIbARG+tiJZJmP78NADp00Zfk6cJGDcK
         2/wnAuZztRmR/aexs/QqR4qyoez2Lq29oYFXL4x6/P1Rm/nMkuS7oRPCqSnbbl1ZJsvB
         XNploNxjgjD/1sy6ZRkWxvm0y1LVK6mCyHu0zoHSMwH+3T/HDzomaG/mK/FNE+WAgadj
         msjGgoYPpE7/SX6g2BCKNV0I3Lqeiky9YLfSGJttDT7jkMU4kFM+lldBzfFBro42D6FJ
         Ar5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rd9LRe77V7pHhuoyeJvDmCm7mX//E10O3Cp6VzupEbc=;
        b=lPxghsXwiBEMag7uE17fAk+yXLC0DEexxqztKxtdAS3vW7NfxrXkKumgxH1N+qvHzO
         6ZYhEYmx1hD/jBRzVXLNZniJ5uvuhKGNFziDHTARGaaNWb27pNemoPr4qF8jnpr9Ho9Y
         6f2ypzxU29kyJe+qKCkxwTVqkdGvH+CSarWbw3Q1dT7ZELi6M7lRHLt0io5zWM42tXBm
         O2yZDZWpYjD0EhtZ/XFEahmgp0+YqRQrC/b4V9wEiAH9LrNM9T+CC5MkJajubkJHZWoc
         yE1/tnEdE2F59StVdJgZXQYTp9MroME48W2AAYMOhjvaZCNXV5tqOQhffEJON+LKGbIL
         bxow==
X-Gm-Message-State: AOAM532rMNpe7sTBDfHcytVWeu7rCux7a9hWr745QCs8mE4rsF3DN9A1
        wTFuX6mIJ2Q1umTa/ufbkj/JxGrzuYl6tUjP
X-Google-Smtp-Source: ABdhPJwUjHaqlJOTtdodjN7olzOnovJzLlzWpp9qtubDDey3kRktZPFby3LOt1+6+xlLqrJNc3BJUQ==
X-Received: by 2002:a19:e00f:: with SMTP id x15mr9356463lfg.222.1623609339102;
        Sun, 13 Jun 2021 11:35:39 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e12sm904984lfs.157.2021.06.13.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 11:35:38 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH 2/3] net: mvpp2: enable using phylink with ACPI
Date:   Sun, 13 Jun 2021 20:35:19 +0200
Message-Id: <20210613183520.2247415-3-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210613183520.2247415-1-mw@semihalf.com>
References: <20210613183520.2247415-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MDIO and phylink are supported in the ACPI
world, enable to use them in the mvpp2 driver. Ensure a backward
compatibility with the firmware whose ACPI description does
not contain the necessary elements for the proper phy handling
and fall back to relying on the link interrupts instead.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 21 ++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9bca8c8f9f8d..ca1f0464e746 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4793,9 +4793,8 @@ static int mvpp2_open(struct net_device *dev)
 		goto err_cleanup_txqs;
 	}
 
-	/* Phylink isn't supported yet in ACPI mode */
-	if (port->of_node) {
-		err = phylink_of_phy_connect(port->phylink, port->of_node, 0);
+	if (port->phylink) {
+		err = phylink_fwnode_phy_connect(port->phylink, port->fwnode, 0);
 		if (err) {
 			netdev_err(port->dev, "could not attach PHY (%d)\n",
 				   err);
@@ -6703,6 +6702,19 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
 			  SPEED_UNKNOWN, DUPLEX_UNKNOWN, false, false);
 }
 
+/* In order to ensure backward compatibility for ACPI, check if the port
+ * firmware node comprises the necessary description allowing to use phylink.
+ */
+static bool mvpp2_use_acpi_compat_mode(struct fwnode_handle *port_fwnode)
+{
+	if (!is_acpi_node(port_fwnode))
+		return false;
+
+	return (!fwnode_property_present(port_fwnode, "phy-handle") &&
+		!fwnode_property_present(port_fwnode, "managed") &&
+		!fwnode_get_named_child_node(port_fwnode, "fixed-link"));
+}
+
 /* Ports initialization */
 static int mvpp2_port_probe(struct platform_device *pdev,
 			    struct fwnode_handle *port_fwnode,
@@ -6922,7 +6934,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->dev.of_node = port_node;
 
 	/* Phylink isn't used w/ ACPI as of now */
-	if (port_node) {
+	if (!mvpp2_use_acpi_compat_mode(port_fwnode)) {
 		port->phylink_config.dev = &dev->dev;
 		port->phylink_config.type = PHYLINK_NETDEV;
 
@@ -6934,6 +6946,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		}
 		port->phylink = phylink;
 	} else {
+		dev_warn(&pdev->dev, "Use link irqs for port#%d. FW update required\n", port->id);
 		port->phylink = NULL;
 	}
 
-- 
2.29.0

