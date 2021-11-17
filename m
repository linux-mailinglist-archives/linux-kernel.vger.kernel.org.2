Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6645405D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhKQFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:49:21 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:54177 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhKQFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:49:18 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AH5LlxS034569;
        Wed, 17 Nov 2021 13:21:47 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Nov 2021 13:45:29 +0800
From:   tommy-huang <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v3 4/4] drm/aspeed: Add AST2600 chip support
Date:   Wed, 17 Nov 2021 13:45:18 +0800
Message-ID: <20211117054518.3555-5-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
References: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AH5LlxS034569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AST2600 chip support and setting.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4b56b3c7597..d10246b1d1c2 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -82,9 +82,18 @@ static const struct aspeed_gfx_config ast2500_config = {
 	.scan_line_max = 128,
 };
 
+static const struct aspeed_gfx_config ast2600_config = {
+	.dac_reg = 0xc0,
+	.int_clear_reg = 0x68,
+	.vga_scratch_reg = 0x50,
+	.throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
+	.scan_line_max = 128,
+};
+
 static const struct of_device_id aspeed_gfx_match[] = {
 	{ .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
+	{ .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
-- 
2.17.1

