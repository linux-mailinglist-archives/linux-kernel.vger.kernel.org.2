Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41730A2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhBAHuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:50:06 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49609 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhBAHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:49:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNWydfP_1612165750;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNWydfP_1612165750)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 15:49:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] treewide: remove unneeded semicolon
Date:   Mon,  1 Feb 2021 15:48:54 +0800
Message-Id: <1612165734-105738-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./tools/virtio/virtio-trace/trace-agent-ctl.c:78:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/virtio/virtio-trace/trace-agent-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 73d253d..39860be 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
 
 		if (ret)
 			break;
-	};
+	}
 
 	return ret;
 
-- 
1.8.3.1

