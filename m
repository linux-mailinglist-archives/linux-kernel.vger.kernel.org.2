Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9044D39B6E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFDKXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:23:07 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53906 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFDKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:23:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UbFb0BY_1622802077;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbFb0BY_1622802077)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jun 2021 18:21:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH 1/2] NTB: perf: Fix an error code in perf_setup_inbuf()
Date:   Fri,  4 Jun 2021 18:20:50 +0800
Message-Id: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the function IS_ALIGNED() returns false, the value of ret is 0.
So, we set ret to -ENOMEM to indicate this error.

Clean up smatch warning:
drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/test/ntb_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 89df135..c20b375 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -598,6 +598,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 		return -ENOMEM;
 	}
 	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {
+		ret = -ENOMEM;
 		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
 		goto err_free_inbuf;
 	}
-- 
1.8.3.1

