Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175C45F2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhKZRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:33:21 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38729 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbhKZRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:31:07 -0500
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 07AE0240008;
        Fri, 26 Nov 2021 17:27:51 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Denis Kirjanov <dkirjanov@suse.de>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next v3 2/4] net: ocelot: add support to get port mac from device-tree
Date:   Fri, 26 Nov 2021 18:27:37 +0100
Message-Id: <20211126172739.329098-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211126172739.329098-1-clement.leger@bootlin.com>
References: <20211126172739.329098-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get mac from device-tree using of_get_mac_address.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index eaeba60b1bba..b589ae95e29b 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1704,7 +1704,10 @@ int ocelot_probe_port(struct ocelot *ocelot, int port, struct regmap *target,
 		NETIF_F_HW_TC;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
 
-	eth_hw_addr_gen(dev, ocelot->base_mac, port);
+	err = of_get_ethdev_address(portnp, dev);
+	if (err)
+		eth_hw_addr_gen(dev, ocelot->base_mac, port);
+
 	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr,
 			  OCELOT_VLAN_UNAWARE_PVID, ENTRYTYPE_LOCKED);
 
-- 
2.33.1

