Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35003324CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhBYJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:21:12 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57899 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236307AbhBYJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:18:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UPXQzEw_1614244675;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPXQzEw_1614244675)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:17:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     p.zabel@pengutronix.de
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] phy: ti: j721e-wiz: add missing call to of_node_put()
Date:   Thu, 25 Feb 2021 17:17:54 +0800
Message-Id: <1614244674-66556-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the for_each_child_of_node() loop in
of_property_read_u32, add missing call to of_node_put().

Fix the following coccicheck warning:
./drivers/phy/ti/phy-j721e-wiz.c:786:1-23: WARNING: Function
"for_each_child_of_node" should have of_node_put() before return around
line 795.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index c9cfafe..448d8d1 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -789,6 +789,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
+			of_node_put(subnode);
 			dev_err(dev,
 				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
 				__func__, subnode->name, ret);
-- 
1.8.3.1

