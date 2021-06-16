Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C43AA3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhFPTKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhFPTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:10:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949EC0613A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp38so6133012lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJlskXXqPukoUIiMaWjgnuEmfc7b1Qye4aSSYHDeJ90=;
        b=j6UvX9zq/sPizWvzFQ1T0u4GCMD2XjPHC82VcPSaJaKiBAcneookTY3Ed1d02CaGrd
         7dIFeO4QpfuK14mdUlK5ACdVgDNO9Tads/4fiOTUp46WubLTThwTtqyJBpaTw2ozwf98
         kVFXdNqARq0/KzDDbnsPyhO0Q7kFR4z1uUouFCjO81jhMnN4JHGkltf4iYJKs91ZKtOU
         hlTKE9Zsm8ug4xTDHHQ4nfSgj+8RoDlwMSJe8nYjgWDGqHLoWKka/mazzDVT82VfNJrM
         Dl8fVLHuAA6racPJi0+YyHoW9cZDPQJ9s1juS5QqLvoLpul8e1h35NX0FvuZHqTV23UX
         KVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJlskXXqPukoUIiMaWjgnuEmfc7b1Qye4aSSYHDeJ90=;
        b=Sfhz/BdXR7kOzZfMcu6k7VtvA1bo9iBVK3hSql7TBqz4DX6gvoQRAmu54+G/jW3x8E
         TKW4Hr8UK9civZjfQrvH14vghzTp598TDamw9xfGmsOt2mZPx7UbRlLt6UyDb19rN948
         zY+MIT05Zq8XiuMbaDQKW6XC5xTf01rQFoPkaRVOAwSGCfvC1b0DGrsdOXbTdQsC44Cj
         UIk/et52h0B98A2Aq+uelAv74gRICcaWewOGRI1h3+WG4m/Izt+fOhJs9rpV3IN4jbmo
         kpD+gMToLFPUt7pw1CwGNbzFSdklNGARIU4zfNJe4TO3OpQmfHgYXUBjlV9zgiOyGiK9
         epJg==
X-Gm-Message-State: AOAM533ujrVITZ4smCSBGgLrUw8D8Bpz+8pXPMTDlorK4cGaDwGfLQ5n
        8gb4MfFKoNbwka/GXNXYmbH6l0o79t7rlg==
X-Google-Smtp-Source: ABdhPJwdwrSxllmvf4YfPOQkJpoCeiA8FUGeCt7NkwLbEr7swjLDXq2ri/thhPsM39fORUQAZYi3dw==
X-Received: by 2002:ac2:51b3:: with SMTP id f19mr937764lfk.218.1623870507506;
        Wed, 16 Jun 2021 12:08:27 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id h22sm406939ljl.126.2021.06.16.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:08:26 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v2 6/7] net: mvpp2: enable using phylink with ACPI
Date:   Wed, 16 Jun 2021 21:07:58 +0200
Message-Id: <20210616190759.2832033-7-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210616190759.2832033-1-mw@semihalf.com>
References: <20210616190759.2832033-1-mw@semihalf.com>
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

