Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C2325B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBZBkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:40:24 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47091 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBZBkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:40:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UPaXUWV_1614303577;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPaXUWV_1614303577)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Feb 2021 09:39:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     cristian.marussi@arm.com
Cc:     sudeep.holla@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] regulator: add missing call to of_node_put()
Date:   Fri, 26 Feb 2021 09:39:35 +0800
Message-Id: <1614303575-27436-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./drivers/regulator/scmi-regulator.c:343:1-23: WARNING: Function
"for_each_child_of_node" should have of_node_put() before return around
line 347.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Changes in v2:
-add braces for if

 drivers/regulator/scmi-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 0e8b3ca..a917c81 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -343,8 +343,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(child);
 			return ret;
+		}
 	}
 
 	/*
-- 
1.8.3.1

