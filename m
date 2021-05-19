Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E953E388FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345399AbhESOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:10:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4752 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353908AbhESOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:09:06 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlZNt4g3hzpfLv;
        Wed, 19 May 2021 22:04:14 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 22:07:44 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 22:07:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, David Howells <dhowells@redhat.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] watch_queue: Fix error return code in watch_queue_set_size()
Date:   Wed, 19 May 2021 14:16:58 +0000
Message-ID: <20210519141658.3063287-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return negative error code -ENOMEM from the alloc failed error
handling cases instead of 0, as done elsewhere in this function.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/watch_queue.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 9c9eb20dd2c5..35e03b1bfadd 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -248,21 +248,27 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
-	if (!pages)
+	if (!pages) {
+		ret = -ENOMEM;
 		goto error;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
-		if (!pages[i])
+		if (!pages[i]) {
+			ret = -ENOMEM;
 			goto error_p;
+		}
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
 	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
 	bmsize *= sizeof(unsigned long);
 	bitmap = kmalloc(bmsize, GFP_KERNEL);
-	if (!bitmap)
+	if (!bitmap) {
+		ret = -ENOMEM;
 		goto error_p;
+	}
 
 	memset(bitmap, 0xff, bmsize);
 	wqueue->notes = pages;

