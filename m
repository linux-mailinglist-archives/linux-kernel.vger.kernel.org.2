Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6E324C83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhBYJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:11:41 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48436 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235816AbhBYJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:08:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UPXQxjx_1614244047;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPXQxjx_1614244047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:07:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] regulator: add missing call to of_node_put()
Date:   Thu, 25 Feb 2021 17:07:26 +0800
Message-Id: <1614244046-57560-1-git-send-email-yang.lee@linux.alibaba.com>
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
 drivers/regulator/scmi-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 0e8b3ca..a41bb06 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -344,6 +344,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 		ret = process_scmi_regulator_of_node(sdev, child, rinfo);
 		/* abort on any mem issue */
 		if (ret == -ENOMEM)
+			of_node_put(child);
 			return ret;
 	}
 
-- 
1.8.3.1

