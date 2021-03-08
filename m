Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87DF3308A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhCHHKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:10:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42986 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235143AbhCHHKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:10:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UQqOqPM_1615187407;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQqOqPM_1615187407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 15:10:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] phy: hisilicon: add missing call to of_node_put()
Date:   Mon,  8 Mar 2021 15:10:05 +0800
Message-Id: <1615187405-28337-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./drivers/phy/hisilicon/phy-hisi-inno-usb2.c:138:1-23: WARNING: Function
"for_each_child_of_node" should have of_node_put() before break around
line 158.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 34a6a9a..c58115e 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -146,8 +146,10 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		priv->ports[i].priv = priv;
 
 		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
+			of_node_put(child);
 			return PTR_ERR(phy);
+		}
 
 		phy_set_bus_width(phy, 8);
 		phy_set_drvdata(phy, &priv->ports[i]);
-- 
1.8.3.1

