Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8243DC06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ1HbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:31:01 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40602 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhJ1Haz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:30:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UtytgLk_1635406102;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0UtytgLk_1635406102)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Oct 2021 15:28:27 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cuibixuan@linux.alibaba.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, ivan@de.ibm.com
Subject: [PATCH -next] powerpc/44x/fsp2: add missing of_node_put
Date:   Thu, 28 Oct 2021 15:28:22 +0800
Message-Id: <1635406102-88719-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_compatible_node() should decrement the
node reference counter.  Reported by Coccinelle:

./arch/powerpc/platforms/44x/fsp2.c:206:1-25: WARNING: Function
"for_each_compatible_node" should have of_node_put() before return
around line 218.

Fixes: 7813043e1bbc ("powerpc/44x/fsp2: Add irq error handlers")
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
 arch/powerpc/platforms/44x/fsp2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index b299e43..823397c 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -208,6 +208,7 @@ static void node_irq_request(const char *compat, irq_handler_t errirq_handler)
 		if (irq == NO_IRQ) {
 			pr_err("device tree node %pOFn is missing a interrupt",
 			      np);
+			of_node_put(np);
 			return;
 		}
 
@@ -215,6 +216,7 @@ static void node_irq_request(const char *compat, irq_handler_t errirq_handler)
 		if (rc) {
 			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
 			      np, rc);
+			of_node_put(np);
 			return;
 		}
 	}
-- 
1.8.3.1

