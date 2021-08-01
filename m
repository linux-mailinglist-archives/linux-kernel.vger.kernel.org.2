Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8533DCE2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhHAXp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhHAXpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:45:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36BC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 16:45:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9A6121F424D4
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/3] mtdblock: Warn if the added for a NAND device
Date:   Sun,  1 Aug 2021 20:45:09 -0300
Message-Id: <20210801234509.18774-8-ezequiel@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801234509.18774-1-ezequiel@collabora.com>
References: <20210801234509.18774-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a surprisingly large number of tutorials
that suggest using mtdblock to mount SquashFS filesystems
on flash devices, including NAND devices.

This approach is suboptimal than using UBI. If the flash device
is NAND, this is specially true, due to wear leveling, bit-flips and
badblocks. In this case UBI is strongly preferred, so be nice to users
and print a warning suggesting to consider UBI block, if mtdblock
is added for a NAND device.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Untracked files not listed
---
 drivers/mtd/mtdblock.c    | 4 ++++
 drivers/mtd/mtdblock_ro.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index b2d5ed1cbc94..7c02643f862f 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -332,6 +332,10 @@ static void mtdblock_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	if (!(mtd->flags & MTD_WRITEABLE))
 		dev->mbd.readonly = 1;
 
+	if (mtd_type_is_nand(mtd))
+		pr_warn("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
+			tr->name, mtd->name);
+
 	if (add_mtd_blktrans_dev(&dev->mbd))
 		kfree(dev);
 }
diff --git a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
index fb5dc89369de..a438e2f6089c 100644
--- a/drivers/mtd/mtdblock_ro.c
+++ b/drivers/mtd/mtdblock_ro.c
@@ -60,6 +60,10 @@ static void mtdblock_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	dev->tr = tr;
 	dev->readonly = 1;
 
+	if (mtd_type_is_nand(mtd))
+		pr_warn("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
+			tr->name, mtd->name);
+
 	if (add_mtd_blktrans_dev(dev))
 		kfree(dev);
 }
-- 
2.32.0

