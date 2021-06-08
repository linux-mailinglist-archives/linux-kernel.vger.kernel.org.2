Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21D39EF51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFHHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:16:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8076 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhFHHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:16:30 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzhHl1b70zYrxp;
        Tue,  8 Jun 2021 15:11:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:14:35 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:14:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lib: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 15:14:30 +0800
Message-ID: <20210608071430.12687-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/string.c               | 4 ++--
 lib/zlib_deflate/deflate.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 7548eb715ddb..b900c6c5efdf 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -982,7 +982,7 @@ void *memscan(void *addr, int c, size_t size)
 		p++;
 		size--;
 	}
-  	return (void *)p;
+	return (void *)p;
 }
 EXPORT_SYMBOL(memscan);
 #endif
@@ -1051,7 +1051,7 @@ void *memchr(const void *s, int c, size_t n)
 {
 	const unsigned char *p = s;
 	while (n-- != 0) {
-        	if ((unsigned char)c == *p++) {
+		if ((unsigned char)c == *p++) {
 			return (void *)(p - 1);
 		}
 	}
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 8a878d0d892c..3fa66fc7fbd7 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -888,7 +888,7 @@ static block_state deflate_stored(
 	s->lookahead = 0;
 
 	/* Emit a stored block if pending_buf will be full: */
- 	max_start = s->block_start + max_block_size;
+	max_start = s->block_start + max_block_size;
         if (s->strstart == 0 || (ulg)s->strstart >= max_start) {
 	    /* strstart == 0 is possible when wraparound on 16-bit machine */
 	    s->lookahead = (uInt)(s->strstart - max_start);
-- 
2.25.1


