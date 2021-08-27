Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB53F983B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbhH0KtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:49:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46844 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233193AbhH0KtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:49:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UmGn.lV_1630061300;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UmGn.lV_1630061300)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Aug 2021 18:48:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ccaulfie@redhat.com
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fs: dlm: Remove unneeded semicolon
Date:   Fri, 27 Aug 2021 18:48:02 +0800
Message-Id: <1630061282-110080-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./fs/dlm/midcomms.c:972:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/dlm/midcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 7ae39ec..aa42153 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -969,7 +969,7 @@ void dlm_midcomms_receive_done(int nodeid)
 		spin_unlock(&node->state_lock);
 		/* do nothing FIN has it's own ack send */
 		break;
-	};
+	}
 	srcu_read_unlock(&nodes_srcu, idx);
 }
 
-- 
1.8.3.1

