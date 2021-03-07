Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331AF32FE87
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCGDOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCGDO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:14:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E6C061761
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 19:14:17 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q25so13536228lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QYIQSSMI82k7oQYcyVX3kx+rgpAtWYBUfAaleiiqPbw=;
        b=ztGsxjcDNLGPlCbukFiuOd5X/oQm/0Kr2NefJcYxFKpmYy6P7tr4/C2QKu/mF3PzvO
         plY6BalzXj647Re6bcQg1czkPH4sxKDWruTIC/wz8A0mKHWv90PJ8oruD5laKfhd1Ii+
         XvNx2A5tIHyLGlQyEu0fscSnK3sokRmkn41Il8fg5ggfjRoQBm2HALrWqBGRe3+Bcmco
         RbpO6IcZ8QmzKkCyio3yFMSE62ilc4QQnGMsDfBHJ5f8JXG+QlC7duxIaHU2nIn/bYiW
         GujhBJbiohfKmD0tt4IxAHibBYPhqrC0kJGHa0Iut40PyPl6x1cYXX5mv1e23cviSYDX
         YNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QYIQSSMI82k7oQYcyVX3kx+rgpAtWYBUfAaleiiqPbw=;
        b=cXjaqQM6t284tx+UU7gsgIEpt1wQp8Z6dEoF5gO7+VTSpO30IQW12S8oEYMGR7/qij
         wb2YtTLB0Aw0ySOxy9CXNcdL0KJsBRBjyV6gNVaX4uuUdwTssPh+Ck48ExR1xc4tLC2h
         MmNSqmmhcdzorH7fOvyWMBNo1VKndManpjBzEpy3InPB0lg22PYNrk6V9vwmDXoho0qi
         4JutST2/YAtPrW9Ddye9qxKaJ8dvgZZD20Ll3ZNzIXViM8RC9tAUKEdXFYb9n8XIP7+e
         ikRSvOsbY8uChAlm0Zsou2UDX05CHIwyB0iXdhbp8+OIH8SLEEvEmZJqJKfSLIo2B+Ws
         ohIw==
X-Gm-Message-State: AOAM530y39XeZDlLzDAD5Bduh8GXzspU0SDJahQQUoz+eF7gqtEYWw9B
        jyTVxm2p+8sc8l/WNS5aqXJfEg==
X-Google-Smtp-Source: ABdhPJwFcGU2v6B1JjERLd3D9iugpa+XPI0P9ax1jWCjUTU5dltfY4BwmO6hpeYXHwtYVHsn/Dq+5g==
X-Received: by 2002:ac2:5feb:: with SMTP id s11mr9886081lfg.558.1615086856052;
        Sat, 06 Mar 2021 19:14:16 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id u16sm847582lff.169.2021.03.06.19.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 19:14:15 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] net: allwinner: reset control support
Date:   Sun,  7 Mar 2021 06:13:51 +0300
Message-Id: <20210307031353.12643-2-boger@wirenboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307031353.12643-1-boger@wirenboard.com>
References: <20210307031353.12643-1-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
However, on R40 the EMAC is gated by default.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 5ed80d9a6b9f..c0ae06dd922c 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -28,6 +28,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/reset.h>
 #include <linux/soc/sunxi/sunxi_sram.h>
 
 #include "sun4i-emac.h"
@@ -85,6 +86,7 @@ struct emac_board_info {
 	unsigned int		link;
 	unsigned int		speed;
 	unsigned int		duplex;
+	struct reset_control *reset;
 
 	phy_interface_t		phy_interface;
 };
@@ -791,6 +793,7 @@ static int emac_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	int ret = 0;
 	const char *mac_addr;
+	struct reset_control *reset;
 
 	ndev = alloc_etherdev(sizeof(struct emac_board_info));
 	if (!ndev) {
@@ -852,6 +855,19 @@ static int emac_probe(struct platform_device *pdev)
 		goto out_release_sram;
 	}
 
+	reset = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(reset)) {
+		dev_err(&pdev->dev, "unable to request reset\n");
+		ret = -ENODEV;
+		goto out_release_sram;
+	}
+	db->reset = reset;
+	ret = reset_control_deassert(db->reset);
+	if (ret) {
+		dev_err(&pdev->dev, "could not deassert EMAC reset\n");
+		goto out_release_sram;
+	}
+
 	/* Read MAC-address from DT */
 	mac_addr = of_get_mac_address(np);
 	if (!IS_ERR(mac_addr))
@@ -881,7 +897,7 @@ static int emac_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Registering netdev failed!\n");
 		ret = -ENODEV;
-		goto out_release_sram;
+		goto out_assert_reset;
 	}
 
 	dev_info(&pdev->dev, "%s: at %p, IRQ %d MAC: %pM\n",
@@ -889,6 +905,8 @@ static int emac_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_assert_reset:
+	reset_control_assert(db->reset);
 out_release_sram:
 	sunxi_sram_release(&pdev->dev);
 out_clk_disable_unprepare:
@@ -913,6 +931,7 @@ static int emac_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	sunxi_sram_release(&pdev->dev);
 	clk_disable_unprepare(db->clk);
+	reset_control_assert(db->reset);
 	irq_dispose_mapping(ndev->irq);
 	iounmap(db->membase);
 	free_netdev(ndev);
-- 
2.17.1

