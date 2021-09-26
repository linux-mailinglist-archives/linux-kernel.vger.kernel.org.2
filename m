Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A524188A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhIZMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:39:09 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30641 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhIZMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:39:08 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d33 with ME
        id ycdV250084m3Hzu03cdVkC; Sun, 26 Sep 2021 14:37:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Sep 2021 14:37:31 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: ti_sci: Use devm_bitmap_zalloc when applicable
Date:   Sun, 26 Sep 2021 14:36:55 +0200
Message-Id: <1bd77909ff75f62a2228a39db208c4c6d1b3e0e2.1632659746.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'xfer_alloc_table' is a bitmap. So use 'devm_bitmap_zalloc()' to simplify
code and improve the semantic of the code.

While at it, remove a redundant 'bitmap_zero()' call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/ti_sci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa..a33eb884102f 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3352,13 +3352,11 @@ static int ti_sci_probe(struct platform_device *pdev)
 	if (!minfo->xfer_block)
 		return -ENOMEM;
 
-	minfo->xfer_alloc_table = devm_kcalloc(dev,
-					       BITS_TO_LONGS(desc->max_msgs),
-					       sizeof(unsigned long),
-					       GFP_KERNEL);
+	minfo->xfer_alloc_table = devm_bitmap_zalloc(dev,
+						     desc->max_msgs,
+						     GFP_KERNEL);
 	if (!minfo->xfer_alloc_table)
 		return -ENOMEM;
-	bitmap_zero(minfo->xfer_alloc_table, desc->max_msgs);
 
 	/* Pre-initialize the buffer pointer to pre-allocated buffers */
 	for (i = 0, xfer = minfo->xfer_block; i < desc->max_msgs; i++, xfer++) {
-- 
2.30.2

