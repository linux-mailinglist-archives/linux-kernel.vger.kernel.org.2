Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4893D7782
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhG0Nt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhG0Ntk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:49:40 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C79C0619E6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:47:38 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by xavier.telenet-ops.be with bizsmtp
        id aDnb2500K1fSPfK01Dnbz6; Tue, 27 Jul 2021 15:47:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQl-001Pc1-1f; Tue, 27 Jul 2021 15:47:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQk-00FnhI-Bu; Tue, 27 Jul 2021 15:47:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/5] video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
Date:   Tue, 27 Jul 2021 15:47:27 +0200
Message-Id: <20210727134730.3765898-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727134730.3765898-1-geert@linux-m68k.org>
References: <20210727134730.3765898-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the nested loops to handle conversion from linear frame buffer
to ssd1307 page layout:
  1. Move last page handling one level up, as the value of "m" is the
     same inside a page,
  2. array->data[] is filled linearly, so there is no need to
     recalculate array_idx over and over again; a simple increment is
     sufficient.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
v2:
  - Add Acked-by.
---
 drivers/video/fbdev/ssd1307fb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index e6b6263e3bef847f..6d7bd025bca1a175 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -158,6 +158,7 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	u8 *vmem = par->info->screen_buffer;
 	unsigned int line_length = par->info->fix.line_length;
 	unsigned int pages = DIV_ROUND_UP(par->height, 8);
+	u32 array_idx = 0;
 	int ret, i, j, k;
 
 	array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
@@ -194,19 +195,21 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	 */
 
 	for (i = 0; i < pages; i++) {
+		int m = 8;
+
+		/* Last page may be partial */
+		if (i + 1 == pages && par->height % 8)
+			m = par->height % 8;
 		for (j = 0; j < par->width; j++) {
-			int m = 8;
-			u32 array_idx = i * par->width + j;
-			array->data[array_idx] = 0;
-			/* Last page may be partial */
-			if (i + 1 == pages && par->height % 8)
-				m = par->height % 8;
+			u8 data = 0;
+
 			for (k = 0; k < m; k++) {
 				u8 byte = vmem[(8 * i + k) * line_length +
 					       j / 8];
 				u8 bit = (byte >> (j % 8)) & 1;
-				array->data[array_idx] |= bit << k;
+				data |= bit << k;
 			}
+			array->data[array_idx++] = data;
 		}
 	}
 
-- 
2.25.1

