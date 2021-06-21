Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042F93AF20A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhFURdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhFURdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:33:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD1C0617AD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a16so4821698ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJlskXXqPukoUIiMaWjgnuEmfc7b1Qye4aSSYHDeJ90=;
        b=YC+v2VFSlEj714Fipr+X5uKqGdyPOi0fZRjQqg66R6KKAg8Uo5T40tWRGiB2MRbsLJ
         YhWQdupK4lXKB+ixP2oNXdfPhwOqLLgRyr7EJs9xXpxDYkeUzROoI/VXf/5tbYjuDQM4
         0/g++YC3yKdJbNwDJROq5/H8+tf1OyHf0ZER2ZrR9OE9iA06CWnM8c0gKLPQfMHOp8Ys
         Y2AHTUWnw3dKAfqfFADjQD8oyTg0vl+aKDETGNvjxRlbt1C24aPPE53KUhmYARbZEIo5
         me1h5U+cZOc2HFPgwhMQm/7fRjRM4J6BNJF8GdRW35MYUpmEnerbG5w49OKaz5WMy7T1
         UcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJlskXXqPukoUIiMaWjgnuEmfc7b1Qye4aSSYHDeJ90=;
        b=cX7JWmXTX6t9kEeWhqx9uspiNOul8pEhY0W+lvyUMPcaWuU79kVagOj+FjkH/bw+y8
         bhBo8LmPgWB+5lCggKtlaQxoSNMCqSFLaoEMqm7MIE5QdQMIgBTMmsQ7+LpDa4y6OTwF
         /FjR+EGoAA6/KpkZd2kUAtStFPwIchClShmljXhkPW74WYawR6wW+gURBRjoawLZR4aC
         tW1uD684oUpp3U0mCy02AZuurx/sxhyQrM3cWjwsajTMhsEtTM9p/DSD2zbH9inS11LR
         W/JqM+R7bvazjI8IUdTFHWr1gCfgj+akT9BPprc0WffFltFIK++3D45wAGnBg3pyGCvO
         ObFQ==
X-Gm-Message-State: AOAM532TWBBjcKYpkCNuOQL0dddh6Zyh4sgJ4Ji1gHsGc9aTDZLyQyZp
        1fbiWm92RfTcuYgNtSDCTedmYQts72zd2A==
X-Google-Smtp-Source: ABdhPJwh/jpROltqTQn9Q+zie8Ck/NJNxGVWm47H6XdT5P2r+bkSKZ6WmxdaMC1PibH6CfqUQq5BJA==
X-Received: by 2002:a2e:87d6:: with SMTP id v22mr23205134ljj.50.1624296676473;
        Mon, 21 Jun 2021 10:31:16 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u11sm1926380lfs.257.2021.06.21.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:31:15 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v3 5/6] net: mvpp2: enable using phylink with ACPI
Date:   Mon, 21 Jun 2021 19:30:27 +0200
Message-Id: <20210621173028.3541424-6-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621173028.3541424-1-mw@semihalf.com>
References: <20210621173028.3541424-1-mw@semihalf.com>
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
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 22 +++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9bca8c8f9f8d..a66ed3194015 100644
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
@@ -6921,8 +6933,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
 	dev->dev.of_node = port_node;
 
-	/* Phylink isn't used w/ ACPI as of now */
-	if (port_node) {
+	if (!mvpp2_use_acpi_compat_mode(port_fwnode)) {
 		port->phylink_config.dev = &dev->dev;
 		port->phylink_config.type = PHYLINK_NETDEV;
 
@@ -6934,6 +6945,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		}
 		port->phylink = phylink;
 	} else {
+		dev_warn(&pdev->dev, "Use link irqs for port#%d. FW update required\n", port->id);
 		port->phylink = NULL;
 	}
 
-- 
2.29.0

