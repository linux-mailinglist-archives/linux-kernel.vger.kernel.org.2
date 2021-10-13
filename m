Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855742BF30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJMLvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:51:03 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44005 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhJMLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:51:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Urh7-.x_1634125736;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Urh7-.x_1634125736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Oct 2021 19:48:57 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Adjust the size of kbuf array to avoid overflow
Date:   Wed, 13 Oct 2021 19:48:54 +0800
Message-Id: <20211013114854.15705-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid the 'count' size space of kbuf array is
used up, but a "\0" is still added.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index faee070977d8..20c61eed54af 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -247,7 +247,7 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	char *kbuf;
 	ssize_t len;
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	kbuf = kmalloc(count + 1, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
-- 
2.31.0

