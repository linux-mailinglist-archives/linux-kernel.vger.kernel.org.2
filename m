Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBC345DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCWM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:26:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13668 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCWMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:25:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4Vrs0yXHznTsx;
        Tue, 23 Mar 2021 20:23:25 +0800 (CST)
Received: from hulk-robot-4.huawei.com (10.175.124.27) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 20:25:46 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <heiko@sntech.de>
CC:     <yifeng.zhao@rock-chips.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mtd: rawnand: rockchip: Use flexible-array member instead of zero-length array
Date:   Tue, 23 Mar 2021 13:11:37 +0000
Message-ID: <20210323131137.45552-1-zou_wei@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppresses the following coccinelle warning:

drivers/mtd/nand/raw/rockchip-nand-controller.c:162:4-8: WARNING use flexible-array member instead

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 796b678cb108..b5405bc7ca3a 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -159,7 +159,7 @@ struct rk_nfc_nand_chip {
 	u32 timing;
 
 	u8 nsels;
-	u8 sels[0];
+	u8 sels[];
 	/* Nothing after this field. */
 };
 
-- 
2.17.1

