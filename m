Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CA40F329
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhIQHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:24:31 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:37437 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhIQHYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:24:30 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18H72ZTG030518;
        Fri, 17 Sep 2021 15:02:35 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.142) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Sep
 2021 15:22:34 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jenmin_yuan@aspeedtech.com>, <kuohsiang_chou@aspeedtech.com>,
        <arc_sung@aspeedtech.com>
Subject: [PATCH] drm/ast: Atomic CR/SR reg R/W
Date:   Fri, 17 Sep 2021 15:22:26 +0800
Message-ID: <20210917072226.17357-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.142]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18H72ZTG030518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Avoid IO-index racing
2. IO-index racing happened on resolustion switching
   and mouse moving at the same time
3. System hung while IO-index racing occurred.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_main.c | 48 +++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 79a361867..1d8fa70c5 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -41,28 +41,52 @@ void ast_set_index_reg_mask(struct ast_private *ast,
 			    uint32_t base, uint8_t index,
 			    uint8_t mask, uint8_t val)
 {
-	u8 tmp;
-	ast_io_write8(ast, base, index);
-	tmp = (ast_io_read8(ast, base + 1) & mask) | val;
-	ast_set_index_reg(ast, base, index, tmp);
+	uint16_t volatile usData;
+	uint8_t  volatile jData;
+
+	do {
+		ast_io_write8(ast, base, index);
+		usData = ast_io_read16(ast, base);
+	} while ((uint8_t)(usData) != index);
+
+	jData  = (uint8_t)(usData >> 8);
+	jData &= mask;
+	jData |= val;
+	usData = ((uint16_t) jData << 8) | (uint16_t) index;
+	ast_io_write16(ast, base, usData);
 }

 uint8_t ast_get_index_reg(struct ast_private *ast,
 			  uint32_t base, uint8_t index)
 {
-	uint8_t ret;
-	ast_io_write8(ast, base, index);
-	ret = ast_io_read8(ast, base + 1);
-	return ret;
+	uint16_t volatile usData;
+	uint8_t  volatile jData;
+
+	do {
+		ast_io_write8(ast, base, index);
+		usData = ast_io_read16(ast, base);
+	} while ((uint8_t)(usData) != index);
+
+	jData  = (uint8_t)(usData >> 8);
+
+	return jData;
 }

 uint8_t ast_get_index_reg_mask(struct ast_private *ast,
 			       uint32_t base, uint8_t index, uint8_t mask)
 {
-	uint8_t ret;
-	ast_io_write8(ast, base, index);
-	ret = ast_io_read8(ast, base + 1) & mask;
-	return ret;
+	uint16_t volatile usData;
+	uint8_t  volatile jData;
+
+	do {
+		ast_io_write8(ast, base, index);
+		usData = ast_io_read16(ast, base);
+	} while ((uint8_t)(usData) != index);
+
+	jData  = (uint8_t)(usData >> 8);
+	jData &= mask;
+
+	return jData;
 }

 static void ast_detect_config_mode(struct drm_device *dev, u32 *scu_rev)
--
2.18.4

