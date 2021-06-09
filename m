Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4533A0E64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhFIIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:05:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50751 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbhFIIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:03:41 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6005260014;
        Wed,  9 Jun 2021 08:01:45 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: at91: fix count of periph clocks passed to pmc_data_allocate
Date:   Wed,  9 Jun 2021 10:01:44 +0200
Message-Id: <20210609080145.44226-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating clk_hw structure, only the periph32 clocks are considered.
Since sama5d2_periphck are also added to the phws there is currently an
out of bound write. Fix this by adding the count of periphck to periph32ck.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/clk/at91/sama5d2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 3d1f78176c3e..663b73a032ee 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -170,7 +170,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
 					nck(sama5d2_systemck),
-					nck(sama5d2_periph32ck),
+					nck(sama5d2_periphck) + nck(sama5d2_periph32ck),
 					nck(sama5d2_gck), 3);
 	if (!sama5d2_pmc)
 		return;
-- 
2.32.0

