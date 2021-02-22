Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D7321120
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBVHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:07:13 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60675 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhBVHHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:07:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UPA9tD4_1613977589;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPA9tD4_1613977589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:06:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] w1: Switch to using the new API kobj_to_dev()
Date:   Mon, 22 Feb 2021 15:06:26 +0800
Message-Id: <1613977586-110976-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./include/linux/w1.h:314:62-63: WARNING opportunity for kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 include/linux/w1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 949d3b1..93f3be8 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -311,7 +311,7 @@ static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
 
 static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
 {
-	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
+	return dev_to_w1_slave(kobj_to_dev(kobj));
 }
 
 static inline struct w1_master* dev_to_w1_master(struct device *dev)
-- 
1.8.3.1

