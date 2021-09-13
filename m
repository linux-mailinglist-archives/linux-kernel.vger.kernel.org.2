Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF6408676
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhIMI2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:28:12 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59031 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhIMI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:28:10 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 995021BF206;
        Mon, 13 Sep 2021 08:26:53 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH] clk: at91: check pmc node status before registering syscore ops
Date:   Mon, 13 Sep 2021 10:26:33 +0200
Message-Id: <20210913082633.110168-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, at91 pmc driver always register the syscore_ops whatever
the status of the pmc node that has been found. When set as secure
and disabled, the pmc should not be accessed or this will generate
abort exceptions.
To avoid this, add a check on node availability before registering
the syscore operations.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/clk/at91/pmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 20ee9dccee78..b40035b011d0 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -267,6 +267,11 @@ static int __init pmc_register_ops(void)
 	if (!np)
 		return -ENODEV;
 
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
 	pmcreg = device_node_to_regmap(np);
 	of_node_put(np);
 	if (IS_ERR(pmcreg))
-- 
2.33.0

