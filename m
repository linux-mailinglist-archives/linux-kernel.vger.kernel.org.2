Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A407330338
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCGRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:16:38 -0500
Received: from aposti.net ([89.234.176.197]:41002 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232583AbhCGRQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:16:18 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] clocksource: ingenic-ost: Add support for the JZ4760B
Date:   Sun,  7 Mar 2021 17:15:53 +0000
Message-Id: <20210307171553.72591-3-paul@crapouillou.net>
In-Reply-To: <20210307171553.72591-1-paul@crapouillou.net>
References: <20210307171553.72591-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OST in the JZ4760B SoC works exactly the same as in the JZ4770. But
since the JZ4760B is older, its Device Tree string does not fall back to
the JZ4770 one; so add support for the JZ4760B compatible string here.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clocksource/ingenic-ost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 029efc2731b4..d2d664601441 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -167,13 +167,14 @@ static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
 	.is64bit = false,
 };
 
-static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
+static const struct ingenic_ost_soc_info jz4760b_ost_soc_info = {
 	.is64bit = true,
 };
 
 static const struct of_device_id ingenic_ost_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
-	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
+	{ .compatible = "ingenic,jz4760b-ost", .data = &jz4760b_ost_soc_info, },
+	{ .compatible = "ingenic,jz4770-ost", .data = &jz4760b_ost_soc_info, },
 	{ }
 };
 
-- 
2.30.1

