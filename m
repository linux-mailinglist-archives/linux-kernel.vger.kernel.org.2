Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6641E331955
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhCHVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:23:46 -0500
Received: from aposti.net ([89.234.176.197]:42972 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhCHVXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:23:22 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] clocksource: ingenic: Add support for the JZ4760
Date:   Mon,  8 Mar 2021 21:23:01 +0000
Message-Id: <20210308212302.10288-2-paul@crapouillou.net>
In-Reply-To: <20210308212302.10288-1-paul@crapouillou.net>
References: <20210308212302.10288-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TCU (Timer/Counter Unit) of the JZ4760 and JZ4760B
SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/clocksource/ingenic-timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 905fd6b163a8..24ed0f1f089b 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -264,6 +264,7 @@ static const struct ingenic_soc_info jz4725b_soc_info = {
 static const struct of_device_id ingenic_tcu_of_match[] = {
 	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
+	{ .compatible = "ingenic,jz4760-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,x1000-tcu", .data = &jz4740_soc_info, },
 	{ /* sentinel */ }
@@ -358,6 +359,7 @@ static int __init ingenic_tcu_init(struct device_node *np)
 
 TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
+TIMER_OF_DECLARE(jz4760_tcu_intc,  "ingenic,jz4760-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(x1000_tcu_intc,  "ingenic,x1000-tcu",  ingenic_tcu_init);
 
-- 
2.30.1

