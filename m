Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDD391968
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhEZOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:02:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6718 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhEZOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:02:21 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FqsvT6cjHzncY8;
        Wed, 26 May 2021 21:57:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 22:00:47 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 26 May
 2021 22:00:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <jglisse@redhat.com>, <apopple@nvidia.com>, <sfr@canb.auug.org.au>
Subject: [PATCH -next] lib/test_hmm: check page after calling xa_untag_pointer()
Date:   Wed, 26 May 2021 22:05:22 +0800
Message-ID: <20210526140522.2535643-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check page after calling xa_untag_pointer() to fix compile warning:
  lib/test_hmm.c:631:16: warning: variable ‘page’ set but not used [-Wunused-but-set-variable]
  631 |   struct page *page;
      |                ^~~~

Fixes: 8b2a105c3794 ("mm: selftests for exclusive device memory")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/test_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 74d69f87691e..87db37e51d7b 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -632,7 +632,7 @@ static int dmirror_check_atomic(struct dmirror *dmirror, unsigned long start,
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
-		if (xa_pointer_tag(entry) == DPT_XA_TAG_ATOMIC)
+		if (!page || xa_pointer_tag(entry) == DPT_XA_TAG_ATOMIC)
 			return -EPERM;
 	}
 
-- 
2.25.1

