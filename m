Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211F731E493
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBRDl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBRDlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:41:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB258C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:40:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so1107305ybh.20
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cJg53Dje1zJHUGVNSMHfeUh3OpPCOvr7+/hJB7zf2NU=;
        b=Xc55D4oyibYHJrF9xxK5ty4qZV5WPl/oyMOo1NIeaW4rzKh2l8T0flog4OHsGT9TkN
         a6BjFqUMJPcs9oUyXIyZkeFs+6ostr2RLzKjEmJG7P1VRkzC5+h+ZDLBGfAfEqZ3gH+F
         GNNcRAAC9X8K8uyk5EDzec+7gcNow32K96WyeJHK6yhnjNFAdjZOC6QlXOa2sxHwJOur
         ECKu1843Tuz2Lj0x+TIwopuBE5n3ZJSnWWokhXox2eZln4EXe2IGz+3nWE9iEfUrTqQQ
         dv3NwEDazI4LOFkJwSIbMVq7X7iomclZKiA3tbeVdYjK+8gLeXGEiDXdgiJ+JBb41NUF
         TBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cJg53Dje1zJHUGVNSMHfeUh3OpPCOvr7+/hJB7zf2NU=;
        b=hPP9o7/ml5GnP2qIJbYvsqdThKWVTE+qDXiaVPxq/W0fcqvLOwJfS9zih3tZRrb/5p
         mcKxTAc1DOLhN4yuqQgutFlYEH4ynXlgdF5nywStsq1j0v9XW7HJ2XU7xoY4rVyilFTG
         9Yar9iDGYiV2wXQ8q+tJntQS5aE8fNO3rbx78xggSSRSK6WVsrD8cf+hnliT9/5qvGdG
         tMR4NmDetRkGKxJXMg7ppsasfo81hlYtdW5QWmhD1yZ3ThOIBeMxEj/hIBcpk6AMhxTb
         K21uVINRPvXJW9YNxd3vNNvbnXodYCxGoS3BwYqI42cBTPDLkxBoTk8LAIxeb9Dj1oEk
         tRMw==
X-Gm-Message-State: AOAM5305NHW4/n8Rl4PbWGyLlQbof6Wm+IBA6MCzv7ugqAY39z539Yy0
        koo2rxzFSoictJb4NoxMwsr55bg=
X-Google-Smtp-Source: ABdhPJz2WMAVIxhWQ3CvQKch5WlfpnqivVZXx6DjkmgSGtYRxhSSFMhwOvuAimFRTqdovAb2+htK9vs=
Sender: "wak via sendgmr" <wak@wak-linux.svl.corp.google.com>
X-Received: from wak-linux.svl.corp.google.com ([2620:15c:2c5:3:b5f3:dab1:c8f5:62df])
 (user=wak job=sendgmr) by 2002:a25:23c6:: with SMTP id j189mr3854740ybj.211.1613619643954;
 Wed, 17 Feb 2021 19:40:43 -0800 (PST)
Date:   Wed, 17 Feb 2021 19:40:40 -0800
Message-Id: <20210218034040.296869-1-wak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] net: ftgmac100: Support phyless operation
From:   "William A. Kennington III" <wak@google.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have BMC to BMC connections that lack a PHY in between but don't
want to use the NC-SI state machinery of the kernel. Instead,
allow for an option to disable the phy detection and mdio logic.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 .../devicetree/bindings/net/ftgmac100.txt     |  2 ++
 drivers/net/ethernet/faraday/ftgmac100.c      | 30 +++++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt b/Documentation/devicetree/bindings/net/ftgmac100.txt
index 29234021f601..22c729c5fd3e 100644
--- a/Documentation/devicetree/bindings/net/ftgmac100.txt
+++ b/Documentation/devicetree/bindings/net/ftgmac100.txt
@@ -19,6 +19,8 @@ Optional properties:
 - phy-mode: See ethernet.txt file in the same directory. If the property is
   absent, "rgmii" is assumed. Supported values are "rgmii*" and "rmii" for
   aspeed parts. Other (unknown) parts will accept any value.
+- no-phy: Disable any MDIO or PHY connection logic and assume the interface
+  is always up.
 - use-ncsi: Use the NC-SI stack instead of an MDIO PHY. Currently assumes
   rmii (100bT) but kept as a separate property in case NC-SI grows support
   for a gigabit link.
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 88bfe2107938..f2cf190654c8 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1467,18 +1467,18 @@ static int ftgmac100_open(struct net_device *netdev)
 		return err;
 	}
 
-	/* When using NC-SI we force the speed to 100Mbit/s full duplex,
+	/* When PHYless we force the speed to 100Mbit/s full duplex,
 	 *
 	 * Otherwise we leave it set to 0 (no link), the link
 	 * message from the PHY layer will handle setting it up to
 	 * something else if needed.
 	 */
-	if (priv->use_ncsi) {
-		priv->cur_duplex = DUPLEX_FULL;
-		priv->cur_speed = SPEED_100;
-	} else {
+	if (netdev->phydev) {
 		priv->cur_duplex = 0;
 		priv->cur_speed = 0;
+	} else {
+		priv->cur_duplex = DUPLEX_FULL;
+		priv->cur_speed = SPEED_100;
 	}
 
 	/* Reset the hardware */
@@ -1506,14 +1506,16 @@ static int ftgmac100_open(struct net_device *netdev)
 	if (netdev->phydev) {
 		/* If we have a PHY, start polling */
 		phy_start(netdev->phydev);
-	} else if (priv->use_ncsi) {
-		/* If using NC-SI, set our carrier on and start the stack */
+	} else {
+		/* If PHYless, set our carrier on and start the stack */
 		netif_carrier_on(netdev);
 
-		/* Start the NCSI device */
-		err = ncsi_start_dev(priv->ndev);
-		if (err)
-			goto err_ncsi;
+		if (priv->use_ncsi) {
+			/* Start the NCSI device */
+			err = ncsi_start_dev(priv->ndev);
+			if (err)
+				goto err_ncsi;
+		}
 	}
 
 	return 0;
@@ -1725,8 +1727,8 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
 	 * is sufficient
 	 */
-	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
-			  FTGMAC_100MHZ);
+	rc = clk_set_rate(priv->clk, priv->netdev->phydev ? FTGMAC_100MHZ :
+			  FTGMAC_25MHZ);
 	if (rc)
 		goto cleanup_clk;
 
@@ -1837,6 +1839,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
 		if (!priv->ndev)
 			goto err_phy_connect;
+	} else if (np && of_get_property(np, "no-phy", NULL)) {
+		dev_info(&pdev->dev, "Using PHYless interface\n");
 	} else if (np && of_get_property(np, "phy-handle", NULL)) {
 		struct phy_device *phy;
 
-- 
2.30.0.478.g8a0d178c01-goog

