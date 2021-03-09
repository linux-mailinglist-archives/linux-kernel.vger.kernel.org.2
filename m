Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0363321C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCIJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:16:44 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35043 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhCIJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:16:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UR4gh8C_1615281374;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UR4gh8C_1615281374)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 17:16:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: cma: Use pr_err_ratelimited for CMA warning
Date:   Tue,  9 Mar 2021 17:16:06 +0800
Message-Id: <ce2251ef49e1727a9a40531d1996660b05462bd2.1615279825.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we did not reserve extra CMA memory, the log buffer can be
easily filled up by CMA failure warning when the devices calling
dmam_alloc_coherent() to alloc DMA memory. Thus we can use
pr_err_ratelimited() instead to reduce the duplicate CMA warning.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 54eee21..d101bdb 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	if (ret && !no_warn) {
-		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
-		       __func__, cma->name, count, ret);
+		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
+				   __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
 
-- 
1.8.3.1

