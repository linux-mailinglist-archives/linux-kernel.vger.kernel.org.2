Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAB331956
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCHVXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:23:47 -0500
Received: from aposti.net ([89.234.176.197]:42988 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhCHVX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:23:29 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] clocksource: ingenic-ost: Add support for the JZ4760B
Date:   Mon,  8 Mar 2021 21:23:02 +0000
Message-Id: <20210308212302.10288-3-paul@crapouillou.net>
In-Reply-To: <20210308212302.10288-1-paul@crapouillou.net>
References: <20210308212302.10288-1-paul@crapouillou.net>
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

Notes:
    v2: No change

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

