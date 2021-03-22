Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7080A343D61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhCVKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:01:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50747 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCVKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:00:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0USuX3L7_1616407241;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USuX3L7_1616407241)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 18:00:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ndtest: Remove redundant NULL check
Date:   Mon, 22 Mar 2021 18:00:40 +0800
Message-Id: <1616407240-114077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/nvdimm/test/ndtest.c:491:2-7: WARNING: NULL check before
some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/nvdimm/test/ndtest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915..98b4a43 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -487,8 +487,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
 buf_err:
 	if (__dma && size >= DIMM_SIZE)
 		gen_pool_free(ndtest_pool, __dma, size);
-	if (buf)
-		vfree(buf);
+	vfree(buf);
 	kfree(res);
 
 	return NULL;
-- 
1.8.3.1

