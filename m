Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89732A3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382561AbhCBJjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:55 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60866 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837993AbhCBJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:17:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQ4ApPR_1614676600;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQ4ApPR_1614676600)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 17:16:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] of: property: Remove unneeded return variable
Date:   Tue,  2 Mar 2021 17:16:38 +0800
Message-Id: <1614676598-105267-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./drivers/of/property.c:1371:5-8: Unneeded variable: "ret". Return "0"
on line 1388

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/of/property.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 5036a36..2381695 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1368,7 +1368,6 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 	const struct supplier_bindings *s = of_supplier_bindings;
 	unsigned int i = 0;
 	bool matched = false;
-	int ret = 0;
 
 	/* Do not stop at first failed link, link all available suppliers. */
 	while (!matched && s->parse_prop) {
@@ -1385,7 +1384,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 		}
 		s++;
 	}
-	return ret;
+	return 0;
 }
 
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
-- 
1.8.3.1

