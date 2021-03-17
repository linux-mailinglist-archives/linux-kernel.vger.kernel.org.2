Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2514F33E76C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCQDF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:05:27 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36390 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhCQDFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:05:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USD1H6X_1615950300;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USD1H6X_1615950300)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 11:05:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xen/evtchn: replace if (cond) BUG() with BUG_ON()
Date:   Wed, 17 Mar 2021 11:04:59 +0800
Message-Id: <1615950299-96787-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/xen/evtchn.c:412:2-5: WARNING: Use BUG_ON instead of if
condition followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/xen/evtchn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index c99415a..b1c59bc 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -408,8 +408,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
 err:
 	/* bind failed, should close the port now */
 	close.port = port;
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
-		BUG();
+	BUG_ON(HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0);
 	del_evtchn(u, evtchn);
 	return rc;
 }
-- 
1.8.3.1

