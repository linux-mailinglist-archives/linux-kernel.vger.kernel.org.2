Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B0356C39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352234AbhDGMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:36:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15946 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245543AbhDGMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:36:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFkMx71CXzyNf4;
        Wed,  7 Apr 2021 20:33:49 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 20:35:52 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <colyli@suse.de>, <kent.overstreet@gmail.com>,
        <linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v3] bcache: use DEFINE_MUTEX() for mutex lock
Date:   Wed, 7 Apr 2021 20:50:00 +0800
Message-ID: <20210407125000.858219-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX() rather
than explicitly calling mutex_init().

this patch will reduce the size of bcache.ko about 16 bytes, the reason
as follows:

though this patch will increase the size of .data segment about 32 bytes,
it will also reduce the size of .init.text and .rodata.str1.1(at x86_64),
.rodata_str1.8(at arm64) and .bss segment total about 48 bytes which reduce
 the size more than .data segment;

here is the statistics:
Sections: (arm64 platform)
Idx name		size
-.init.text		00000240
+.init.text		00000228

-.rodata.str1.8	000012cd
+.rodata.str1.8	000012b5

-.data			00000c60
+.data			00000c80

Sections: (x86 platform)
Idx name		size
-.init.text		000001d9
+.init.text		000001bf

-.rodata.str1.1	00000c80
+.rodata.str1.1	00000c6d

-.data			00000cc0
+.data			00000ce0

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---

v3:
- change commit log, delete statistic about .bss segment.
v2:
- add commit log about the reason why bcache.ko size reduced.

 drivers/md/bcache/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 03e1fe4de53d..3635f454309e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -40,7 +40,7 @@ static const char invalid_uuid[] = {
 };
 
 static struct kobject *bcache_kobj;
-struct mutex bch_register_lock;
+DEFINE_MUTEX(bch_register_lock);
 bool bcache_is_reboot;
 LIST_HEAD(bch_cache_sets);
 static LIST_HEAD(uncached_devices);
@@ -2869,7 +2869,6 @@ static int __init bcache_init(void)
 
 	check_module_parameters();
 
-	mutex_init(&bch_register_lock);
 	init_waitqueue_head(&unregister_wait);
 	register_reboot_notifier(&reboot);
 
-- 
2.25.1

