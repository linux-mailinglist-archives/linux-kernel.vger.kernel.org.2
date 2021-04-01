Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8E351BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhDASKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:10:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15458 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhDARzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FB3P96W1NzqSQh;
        Thu,  1 Apr 2021 21:07:09 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 21:09:05 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] mm/vmalloc: Fix non-conforming function headers
Date:   Thu, 1 Apr 2021 21:22:48 +0800
Message-ID: <20210401132248.396947-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel build warning(s):
 mm/vmalloc.c:425: warning: expecting prototype for vunmap_range_noflush(). Prototype was for vunmap_range() instead

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8b564f91a610..4238e407eb2d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -413,7 +413,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
 }
 
 /**
- * vunmap_range_noflush - unmap kernel virtual addresses
+ * vunmap_range - unmap kernel virtual addresses
  * @addr: start of the VM area to unmap
  * @end: end of the VM area to unmap (non-inclusive)
  *
-- 
2.25.1

