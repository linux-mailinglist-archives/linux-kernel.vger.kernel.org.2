Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3A38E586
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhEXLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:37:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5755 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhEXLhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:37:09 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZn14ldCzmkgb;
        Mon, 24 May 2021 19:32:05 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:35:40 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 19:35:40 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] block: Replaced simple_strtol() with kstrtoint()/kstrtoul()
Date:   Mon, 24 May 2021 20:08:33 +0800
Message-ID: <20210524120833.1580295-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtol() function is deprecated in some situation since
it does not check for the range overflow. Use kstrtoint()/kstrtoul()
instead.
Attention, if the end of the input string isn't '\n', simple_strtol() will
ignore following characters and return the value but kstrtoint()/kstrtoul()
will return an error code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/block/brd.c  | 3 +--
 drivers/block/loop.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7562cf30b14e..5b43f6b2d506 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -358,8 +358,7 @@ MODULE_ALIAS("rd");
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str, NULL, 0);
-	return 1;
+	return !kstrtoul(str, 0, &rd_size);
 }
 __setup("ramdisk_size=", ramdisk_size);
 #endif
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..9fe595afa9cf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2415,8 +2415,7 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
-	return 1;
+	return !kstrtoint(str, 0, &max_loop);
 }
 
 __setup("max_loop=", max_loop_setup);
-- 
2.18.0.huawei.25

