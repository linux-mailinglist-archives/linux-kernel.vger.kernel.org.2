Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836BB421F03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhJEGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:47:35 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:39251 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:47:34 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1956OBIP023147;
        Tue, 5 Oct 2021 14:24:11 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Oct
 2021 14:45:16 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     ryan_chen <ryan_chen@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform to core_initcal
Date:   Tue, 5 Oct 2021 14:45:13 +0800
Message-ID: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1956OBIP023147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the reset probe sequence from builtin_platform to core_initcal.
For avoid some driver is probe but failed due to reset driver not probe.

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/clk/clk-ast2600.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 085d0a18b2b6..6293d8d1a6a8 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -686,7 +686,13 @@ static struct platform_driver aspeed_g6_clk_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(aspeed_g6_clk_driver);
+
+static int __init aspeed_g6_clk_init(void)
+{
+	return platform_driver_register(&aspeed_g6_clk_driver);
+}
+
+core_initcall(aspeed_g6_clk_init);
 
 static const u32 ast2600_a0_axi_ahb_div_table[] = {
 	2, 2, 3, 5,
-- 
2.17.1

