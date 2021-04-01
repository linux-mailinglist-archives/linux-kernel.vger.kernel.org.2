Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36F35124A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhDAJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:31:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15569 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhDAJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:31:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9yYV0gSsz19KPb;
        Thu,  1 Apr 2021 17:29:02 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 17:31:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>
Subject: [PATCH -next] locking/ww_mutex: fix missing destroy_workqueue() on error in test_ww_mutex_init()
Date:   Thu, 1 Apr 2021 17:33:58 +0800
Message-ID: <20210401093358.1175493-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If test_ww_mutex_init() failed, the module won't be loaded,
so test_ww_mutex_exit() can not be called, in this case, wq
will be leaked, fix it by adding destroy_workqueue() on error
path of test_ww_mutex_init().

Fixes: d1b42b800e5d ("locking/ww_mutex: Add kselftests for resolving...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/locking/test-ww_mutex.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 3e82f449b4ff..6e4faa853e56 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -589,37 +589,41 @@ static int __init test_ww_mutex_init(void)
 
 	ret = test_mutex();
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = test_aa();
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = test_abba(false);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = test_abba(true);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = test_cycle(ncpus);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = stress(16, 2*ncpus, STRESS_INORDER);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = stress(16, 2*ncpus, STRESS_REORDER);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = stress(4095, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
 	if (ret)
-		return ret;
+		goto out;
 
 	return 0;
+
+out:
+	destroy_workqueue(wq);
+	return ret;
 }
 
 static void __exit test_ww_mutex_exit(void)
-- 
2.25.1

