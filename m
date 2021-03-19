Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F83418D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCSJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:52:23 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:46337 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:52:06 -0400
X-Greylist: delayed 1670 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2021 05:52:06 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 12J9FMco021248
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 17:15:22 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 12J9ErwR021038;
        Fri, 19 Mar 2021 17:14:53 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.206) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar
 2021 17:23:47 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jenmin_yuan@aspeedtech.com>, <kuohsiang_chou@aspeedtech.com>,
        <arc_sung@aspeedtech.com>, <tommy_huang@aspeedtech.com>
Subject: [PATCH V3] drm/ast: Disable fast reset after DRAM initial
Date:   Fri, 19 Mar 2021 17:23:40 +0800
Message-ID: <20210319092340.140267-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <HK2PR06MB330087DBCD724A93EBACC17C8CA10@HK2PR06MB3300.apcprd06.prod.outlook.com>
References: <HK2PR06MB330087DBCD724A93EBACC17C8CA10@HK2PR06MB3300.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.206]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 12J9ErwR021038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Bug][AST2500]

V1:
When AST2500 acts as stand-alone VGA so that DRAM and DVO initialization
have to be achieved by VGA driver with P2A (PCI to AHB) enabling.
However, HW suggests disable Fast reset mode after DRAM initializaton,
because fast reset mode is mainly designed for ARM ICE debugger.
Once Fast reset is checked as enabling, WDT (Watch Dog Timer) should be
first enabled to avoid system deadlock before disable fast reset mode.

V2:
Use to_pci_dev() to get revision of PCI configuration.

V3:
If SCU00 is not unlocked, just enter its password again.
It is unnecessary to clear AHB lock condition and restore WDT default
setting again, before Fast-reset clearing.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_drv.h  |  1 +
 drivers/gpu/drm/ast/ast_main.c |  5 +++
 drivers/gpu/drm/ast/ast_post.c | 68 +++++++++++++++++++++-------------
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index da6dfb677540..a2cf5fef2399 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -320,6 +320,7 @@ bool ast_is_vga_enabled(struct drm_device *dev);
 void ast_post_gpu(struct drm_device *dev);
 u32 ast_mindwm(struct ast_private *ast, u32 r);
 void ast_moutdwm(struct ast_private *ast, u32 r, u32 v);
+void ast_patch_ahb_2500(struct ast_private *ast);
 /* ast dp501 */
 void ast_set_dp501_video_output(struct drm_device *dev, u8 mode);
 bool ast_backup_fw(struct drm_device *dev, u8 *addr, u32 size);
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 3775fe26f792..0e4dfcc25623 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -69,6 +69,7 @@ static void ast_detect_config_mode(struct drm_device *dev, u32 *scu_rev)
 {
 	struct device_node *np = dev->pdev->dev.of_node;
 	struct ast_private *ast = to_ast_private(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	uint32_t data, jregd0, jregd1;

 	/* Defaults */
@@ -96,6 +97,10 @@ static void ast_detect_config_mode(struct drm_device *dev, u32 *scu_rev)
 	jregd0 = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
 	jregd1 = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd1, 0xff);
 	if (!(jregd0 & 0x80) || !(jregd1 & 0x10)) {
+		/* Patch AST2500 */
+		if (((pdev->revision & 0xF0) == 0x40) && ((jregd0 & 0xC0) == 0))
+			ast_patch_ahb_2500(ast);
+
 		/* Double check it's actually working */
 		data = ast_read32(ast, 0xf004);
 		if (data != 0xFFFFFFFF) {
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 8902c2f84bf9..4f194c5fd2c2 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -2026,6 +2026,30 @@ static bool ast_dram_init_2500(struct ast_private *ast)
 	return true;
 }

+void ast_patch_ahb_2500(struct ast_private *ast)
+{
+	u32	data;
+
+	/* Clear bus lock condition */
+	ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
+	ast_moutdwm(ast, 0x1e600084, 0x00010000);
+	ast_moutdwm(ast, 0x1e600088, 0x00000000);
+	ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
+	data = ast_mindwm(ast, 0x1e6e2070);
+	if (data & 0x08000000) {					/* check fast reset */
+
+		ast_moutdwm(ast, 0x1E785004, 0x00000010);
+		ast_moutdwm(ast, 0x1E785008, 0x00004755);
+		ast_moutdwm(ast, 0x1E78500c, 0x00000033);
+		udelay(1000);
+	}
+	do {
+		ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
+		data = ast_mindwm(ast, 0x1e6e2000);
+	}	while (data != 1);
+	ast_moutdwm(ast, 0x1e6e207c, 0x08000000);	/* clear fast reset */
+}
+
 void ast_post_chip_2500(struct drm_device *dev)
 {
 	struct ast_private *ast = to_ast_private(dev);
@@ -2033,39 +2057,31 @@ void ast_post_chip_2500(struct drm_device *dev)
 	u8 reg;

 	reg = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
-	if ((reg & 0x80) == 0) {/* vga only */
+	if ((reg & 0xC0) == 0) {/* vga only */
 		/* Clear bus lock condition */
-		ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
-		ast_moutdwm(ast, 0x1e600084, 0x00010000);
-		ast_moutdwm(ast, 0x1e600088, 0x00000000);
-		ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
-		ast_write32(ast, 0xf004, 0x1e6e0000);
-		ast_write32(ast, 0xf000, 0x1);
-		ast_write32(ast, 0x12000, 0x1688a8a8);
-		while (ast_read32(ast, 0x12000) != 0x1)
-			;
-
-		ast_write32(ast, 0x10000, 0xfc600309);
-		while (ast_read32(ast, 0x10000) != 0x1)
-			;
+		ast_patch_ahb_2500(ast);
+
+		/* Disable watchdog */
+		ast_moutdwm(ast, 0x1E78502C, 0x00000000);
+		ast_moutdwm(ast, 0x1E78504C, 0x00000000);
+		/* Reset USB port */
+		ast_moutdwm(ast, 0x1E6E2090, 0x20000000);
+		ast_moutdwm(ast, 0x1E6E2094, 0x00004000);
+		if (ast_mindwm(ast, 0x1E6E2070) & 0x00800000) {
+			ast_moutdwm(ast, 0x1E6E207C, 0x00800000);
+			mdelay(100);
+			ast_moutdwm(ast, 0x1E6E2070, 0x00800000);
+		}
+		/* Modify eSPI reset pin */
+		temp = ast_mindwm(ast, 0x1E6E2070);
+		if (temp & 0x02000000)
+			ast_moutdwm(ast, 0x1E6E207C, 0x00004000);

 		/* Slow down CPU/AHB CLK in VGA only mode */
 		temp = ast_read32(ast, 0x12008);
 		temp |= 0x73;
 		ast_write32(ast, 0x12008, temp);

-		/* Reset USB port to patch USB unknown device issue */
-		ast_moutdwm(ast, 0x1e6e2090, 0x20000000);
-		temp  = ast_mindwm(ast, 0x1e6e2094);
-		temp |= 0x00004000;
-		ast_moutdwm(ast, 0x1e6e2094, temp);
-		temp  = ast_mindwm(ast, 0x1e6e2070);
-		if (temp & 0x00800000) {
-			ast_moutdwm(ast, 0x1e6e207c, 0x00800000);
-			mdelay(100);
-			ast_moutdwm(ast, 0x1e6e2070, 0x00800000);
-		}
-
 		if (!ast_dram_init_2500(ast))
 			drm_err(dev, "DRAM init failed !\n");

--
2.18.4

