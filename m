Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7095A36A6BE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhDYKlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 06:41:46 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50688 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhDYKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:41:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UWgfN9a_1619347259;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWgfN9a_1619347259)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:41:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     frowand.list@gmail.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] of: overlay: Remove redundant assignment to ret
Date:   Sun, 25 Apr 2021 18:40:58 +0800
Message-Id: <1619347258-55002-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

drivers/of/overlay.c:1197:2: warning: Value stored to 'ret' is never
read [clang-analyzer-deadcode.DeadStores].

drivers/of/overlay.c:1026:2: warning: Value stored to 'ret' is never
read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/of/overlay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 23effe5..74bb5e5 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1023,7 +1023,6 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	struct device_node *overlay_root = NULL;
 
 	*ovcs_id = 0;
-	ret = 0;
 
 	if (overlay_fdt_size < sizeof(struct fdt_header) ||
 	    fdt_check_header(overlay_fdt)) {
@@ -1194,8 +1193,6 @@ int of_overlay_remove(int *ovcs_id)
 	struct overlay_changeset *ovcs;
 	int ret, ret_apply, ret_tmp;
 
-	ret = 0;
-
 	if (devicetree_corrupt()) {
 		pr_err("suspect devicetree state, refuse to remove overlay\n");
 		ret = -EBUSY;
-- 
1.8.3.1

