Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51D45849B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhKUQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:02:25 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:62168 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhKUQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:02:25 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id opFKmFXqaf6fnopFKmxINg; Sun, 21 Nov 2021 16:59:18 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 21 Nov 2021 16:59:18 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mtd: gen_probe: Use bitmap_zalloc() when applicable
Date:   Sun, 21 Nov 2021 16:59:12 +0100
Message-Id: <a6fe58dffe553a3e79303777d3ba9c60d7613c5b.1637510255.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'chip_map' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/chips/gen_probe.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index e5bd3c2bc3b2..4d4f97841016 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -61,8 +61,8 @@ static struct cfi_private *genprobe_ident_chips(struct map_info *map, struct chi
 	struct cfi_private cfi;
 	struct cfi_private *retcfi;
 	unsigned long *chip_map;
-	int i, j, mapsize;
 	int max_chips;
+	int i, j;
 
 	memset(&cfi, 0, sizeof(cfi));
 
@@ -111,8 +111,7 @@ static struct cfi_private *genprobe_ident_chips(struct map_info *map, struct chi
 		max_chips = 1;
 	}
 
-	mapsize = sizeof(long) * DIV_ROUND_UP(max_chips, BITS_PER_LONG);
-	chip_map = kzalloc(mapsize, GFP_KERNEL);
+	chip_map = bitmap_zalloc(max_chips, GFP_KERNEL);
 	if (!chip_map) {
 		kfree(cfi.cfiq);
 		return NULL;
@@ -139,7 +138,7 @@ static struct cfi_private *genprobe_ident_chips(struct map_info *map, struct chi
 
 	if (!retcfi) {
 		kfree(cfi.cfiq);
-		kfree(chip_map);
+		bitmap_free(chip_map);
 		return NULL;
 	}
 
@@ -157,7 +156,7 @@ static struct cfi_private *genprobe_ident_chips(struct map_info *map, struct chi
 		}
 	}
 
-	kfree(chip_map);
+	bitmap_free(chip_map);
 	return retcfi;
 }
 
-- 
2.30.2

