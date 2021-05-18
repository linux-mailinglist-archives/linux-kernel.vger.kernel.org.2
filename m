Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AA3874B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347784AbhERJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347722AbhERJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:07:18 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A47C06138E
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:05:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by andre.telenet-ops.be with bizsmtp
        id 695s2500d446CkP0195sSL; Tue, 18 May 2021 11:05:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-9r; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069nJ-NY; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] video: fbdev: ssd1307fb: Extract ssd1307fb_set_address_range()
Date:   Tue, 18 May 2021 10:28:07 +0200
Message-Id: <20210518082809.1467549-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518082809.1467549-1-geert@linux-m68k.org>
References: <20210518082809.1467549-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the code to set the column and page ranges into a helper
function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 61 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 6d7bd025bca1a175..cfa27ea0feab4f01 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -152,6 +152,38 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
 	return ret;
 }
 
+static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
+				       u8 cols, u8 page_start, u8 pages)
+{
+	u8 col_end = col_start + cols - 1;
+	u8 page_end = page_start + pages - 1;
+	int ret;
+
+	/* Set column range */
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_start);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_end);
+	if (ret < 0)
+		return ret;
+
+	/* Set page range */
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, page_start);
+	if (ret < 0)
+		return ret;
+
+	return ssd1307fb_write_cmd(par->client, page_end);
+}
+
 static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
@@ -461,31 +493,10 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	/* Set column range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
-	if (ret < 0)
-		return ret;
-
-	/* Set page range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->page_offset);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client,
-				  par->page_offset +
-				  DIV_ROUND_UP(par->height, 8) - 1);
+	/* Set column and page range */
+	ret = ssd1307fb_set_address_range(par, par->col_offset, par->width,
+					  par->page_offset,
+					  DIV_ROUND_UP(par->height, 8));
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

