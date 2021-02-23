Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D335B3227D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhBWJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:28:24 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53961 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232336AbhBWJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:27:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UPLS4QM_1614072412;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPLS4QM_1614072412)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Feb 2021 17:26:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] pcmcia: Switch to using the new API kobj_to_dev()
Date:   Tue, 23 Feb 2021 17:26:50 +0800
Message-Id: <1614072410-32725-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./drivers/pcmcia/cistpl.c:1584:53-54: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pcmcia/cistpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index cf109d9..7b296ba 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1581,7 +1581,7 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	if (error)
 		return error;
 
-	s = to_socket(container_of(kobj, struct device, kobj));
+	s = to_socket(kobj_to_dev(kobj));
 
 	if (off)
 		return -EINVAL;
-- 
1.8.3.1

