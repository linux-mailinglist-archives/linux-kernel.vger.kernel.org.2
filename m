Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9167336BD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhD0Co0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:44:26 -0400
Received: from pv50p00im-ztdg10022001.me.com ([17.58.6.58]:59640 "EHLO
        pv50p00im-ztdg10022001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhD0CoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1619491422; bh=zwZm+iDbKecQVi47Pk7oEQ5PMltYN64tGoJ4C40Spps=;
        h=From:To:Subject:Date:Message-Id;
        b=y7fF6x2Ddk9Ziiqxq8/0R6k1SW8AMir95ovaql+t/AhtGr+7FosEBYny+8xnjU0qO
         ozNWHwivXpGfHLYB+Hjl3Ozoryxf2cW1FQpOO4BfJGXLQm1koYxBT16qGrEd0bDL+j
         hEFV6VTtYQZapVV9UNxor9l9kcG4Wd4oP79qqreqW9vxeA3LQzQlDgBUulGvRFxMB+
         03leRsbDZLRYYHWZ5dTXqo3n1Had5I3qL6H5tTGQ3vYgVR+CkLOUeIi4uP/zgSgIPL
         1Lygy2VShxX1eJ3e/vh9jQM3US9IudTfn4h2CKogaefXz9g1N1klmmyEg2PNBkFWh4
         16WzRT/77lrIg==
Received: from pek-xsong2-d1.wrs.com (unknown [60.247.85.82])
        by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id AD486A03F9;
        Tue, 27 Apr 2021 02:43:37 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] mm: append __GFP_COMP flag for trace_malloc
Date:   Tue, 27 Apr 2021 10:43:20 +0800
Message-Id: <1619491400-1904-1-git-send-email-sxwjean@me.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_01:2021-04-26,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=388 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104270017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When calling kmalloc_order, the flags should include __GFP_COMP here,
so that trace_malloc can trace the precise flags.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 585a6f9..c23e1e8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -928,7 +928,7 @@ EXPORT_SYMBOL(kmalloc_order);
 void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 {
 	void *ret = kmalloc_order(size, flags, order);
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
+	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags | __GFP_COMP);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order_trace);
-- 
2.7.4

