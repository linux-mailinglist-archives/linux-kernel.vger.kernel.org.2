Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C9435D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJUI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:58:37 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39071 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhJUI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:58:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut84NVG_1634806575;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut84NVG_1634806575)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 16:56:16 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/dbgfs: Optimize target_ids interface write operation
Date:   Thu, 21 Oct 2021 16:56:11 +0800
Message-Id: <20211021085611.81211-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing some pids to target_ids interface, calling scanf()
to get 'id' may be failed. If the value of '*nr_ids' is 0 at this time,
there is no need to return 'ids' here, we just need to release it and
return NULL pointer to improve related code operation efficiency.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index a02cf6bee8e8..2d77bf579ffb 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -308,21 +308,25 @@ static unsigned long *str_to_target_ids(const char *str, ssize_t len,
 	unsigned long *ids;
 	const int max_nr_ids = 32;
 	unsigned long id;
-	int pos = 0, parsed, ret;
+	int pos = 0, parsed;
 
 	*nr_ids = 0;
 	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
 	if (!ids)
 		return NULL;
 	while (*nr_ids < max_nr_ids && pos < len) {
-		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
-		pos += parsed;
-		if (ret != 1)
+		if (sscanf(&str[pos], "%lu%n", &id, &parsed) != 1)
 			break;
+		pos += parsed;
 		ids[*nr_ids] = id;
 		*nr_ids += 1;
 	}
 
+	if (!*nr_ids) {
+		kfree(ids);
+		return NULL;
+	}
+
 	return ids;
 }
 
-- 
2.31.0

