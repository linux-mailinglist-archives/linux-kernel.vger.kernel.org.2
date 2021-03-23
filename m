Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9E345B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCWJiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:38:51 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42369 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCWJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:38:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UT3IFAC_1616492323;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UT3IFAC_1616492323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 17:38:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] genirq: Add missing IRQF_ONESHOT
Date:   Tue, 23 Mar 2021 17:38:41 +0800
Message-Id: <1616492321-72383-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./kernel/irq/manage.c:2193:8-28: ERROR: Threaded IRQ with no primary
handler requested without IRQF_ONESHOT

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 21ea370..a309fd3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2191,7 +2191,7 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 
 	if (irq_settings_is_nested_thread(desc)) {
 		ret = request_threaded_irq(irq, NULL, handler,
-					   flags, name, dev_id);
+					   flags | IRQF_ONESHOT, name, dev_id);
 		return !ret ? IRQC_IS_NESTED : ret;
 	}
 
-- 
1.8.3.1

