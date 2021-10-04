Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229B420617
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhJDG6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:58:55 -0400
Received: from first.geanix.com ([116.203.34.67]:37328 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhJDG6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:58:54 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id BA3F9B37B5;
        Mon,  4 Oct 2021 06:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633330623; bh=Wz7aNGZ4h8K0IMIM6FbsYYWN7J3JFO9PsGOhVVuoFkY=;
        h=From:To:Cc:Subject:Date;
        b=AwD6f2E5sWwDs+CaLjRpQXJjc6jGgT6aLezeJEHWsymKs+ghV3r5iMaXOA+AbvMz0
         IHdQbehtMACeFORXsOHY+Gp8vtFwBK1tUEMHUTmA/335JbGx+8NQ6lu56o9s8BJuWh
         sYaziK8VfzdNKK71AYkQFD+Z8hF7j+Mr3Jan+Mbdd3l2ULVLwaYR6tcmL6wc7kucTL
         eN3T/uYHxZpvODBr3NJgjTJsq0LTbVxRjdt/uB6ZMaNfk9U6wND07dUj2Sv8OIVU2h
         necZ0ghakrsdoB+ynGgdW2Ka+OXFHfXyGr9JsQJ+SvB5RtWOy7AMfbl9g4QXlNI2MI
         9Ru28RmJDIp+A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mtd: rawnand: use mutex to protect access while in suspend
Date:   Mon,  4 Oct 2021 08:56:09 +0200
Message-Id: <20211004065608.3190348-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will prevent nand_get_device() from returning -EBUSY.
It will force mtd_write()/mtd_read() to wait for the nand_resume() to unlock
access to the mtd device.

Then we avoid -EBUSY is returned to ubifsi via mtd_write()/mtd_read(),
that will in turn hard error on every error returened.
We have seen during ubifs tries to call mtd_write before the mtd device
is resumed.

Exec_op[0] speed things up, so we see this race when the device is
resuming. But it's actually "mtd: rawnand: Simplify the locking" that
allows it to return -EBUSY, before that commit it would have waited for
the mtd device to resume.

Tested on a iMX6ULL.

[0]:
ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

I did this a RFC as we probably will need to remove the suspended
variable as it's kinda made obsolute by this change.
Should we introduce a new mutex? Or maybe a spin_lock?

 drivers/mtd/nand/raw/nand_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d6c6e880520..0ea343404cac 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4567,7 +4567,6 @@ static int nand_suspend(struct mtd_info *mtd)
 		ret = chip->ops.suspend(chip);
 	if (!ret)
 		chip->suspended = 1;
-	mutex_unlock(&chip->lock);
 
 	return ret;
 }
@@ -4580,7 +4579,6 @@ static void nand_resume(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	mutex_lock(&chip->lock);
 	if (chip->suspended) {
 		if (chip->ops.resume)
 			chip->ops.resume(chip);
-- 
2.33.0

