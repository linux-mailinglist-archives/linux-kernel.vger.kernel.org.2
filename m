Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826EA3B6C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhF2B5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:57:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5940 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhF2B5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:57:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GDSB45KBDz755J;
        Tue, 29 Jun 2021 09:51:08 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 09:54:29 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 29 Jun
 2021 09:54:28 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <konishi.ryusuke@gmail.com>
CC:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/6] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
Date:   Tue, 29 Jun 2021 10:25:51 +0800
Message-ID: <20210629022556.3985106-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210629022556.3985106-1-sunnanyong@huawei.com>
References: <20210629022556.3985106-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by syzkaller:
BUG: memory leak
unreferenced object 0xffff888100ca8988 (size 8):
comm "syz-executor.1", pid 1930, jiffies 4294745569 (age 18.052s)
hex dump (first 8 bytes):
6c 6f 6f 70 31 00 ff ff loop1...
backtrace:
[<000000009d9e0ac4>] slab_alloc_node mm/slub.c:2972 [inline]
[<000000009d9e0ac4>] slab_alloc mm/slub.c:2980 [inline]
[<000000009d9e0ac4>] __kmalloc_track_caller+0x164/0x330 mm/slub.c:4644
[<00000000b1825477>] kstrdup+0x36/0x70 mm/util.c:60
[<00000000fa081499>] kstrdup_const+0x35/0x60 mm/util.c:83
[<0000000024d13570>] kvasprintf_const+0xf1/0x180 lib/kasprintf.c:48
[<0000000024b69715>] kobject_set_name_vargs+0x56/0x150 lib/kobject.c:289
[<000000003fedac3d>] kobject_add_varg lib/kobject.c:384 [inline]
[<000000003fedac3d>] kobject_init_and_add+0xc9/0x150 lib/kobject.c:473
[<000000002795bd99>] nilfs_sysfs_create_device_group+0x150/0x7d0 fs/nilfs2/sysfs.c:986
[<00000000567fa12d>] init_nilfs+0xa21/0xea0 fs/nilfs2/the_nilfs.c:637
[<00000000082e7458>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
[<00000000082e7458>] nilfs_mount+0x7b4/0xe80 fs/nilfs2/super.c:1316
[<00000000adc3fd88>] legacy_get_tree+0x105/0x210 fs/fs_context.c:592
[<00000000a98c45b8>] vfs_get_tree+0x8e/0x2d0 fs/super.c:1498
[<00000000e96282d3>] do_new_mount fs/namespace.c:2905 [inline]
[<00000000e96282d3>] path_mount+0xf9b/0x1990 fs/namespace.c:3235
[<000000003d2eb1b0>] do_mount+0xea/0x100 fs/namespace.c:3248
[<00000000e1ce771a>] __do_sys_mount fs/namespace.c:3456 [inline]
[<00000000e1ce771a>] __se_sys_mount fs/namespace.c:3433 [inline]
[<00000000e1ce771a>] __x64_sys_mount+0x14b/0x1f0 fs/namespace.c:3433
[<000000007c7f81e8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
[<000000007c7f81e8>] do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
[<00000000fd23ff06>] entry_SYSCALL_64_after_hwframe+0x44/0xae

If kobject_init_and_add return with error, then the cleanup of kobject
is needed because memory may be allocated in kobject_init_and_add
without freeing.
And the place of cleanup_dev_kobject should use kobject_put to free
the memory associated with the kobject. As the section "Kobject removal"
of "Documentation/core-api/kobject.rst" says, kobject_del() just makes
the kobject "invisible", but it is not cleaned up. And no more cleanup
will do after cleanup_dev_kobject, so kobject_put is needed here.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 fs/nilfs2/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 68e8d61e28dd..d2d8ea89937a 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -986,7 +986,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
 				    "%s", sb->s_id);
 	if (err)
-		goto free_dev_subgroups;
+		goto cleanup_dev_kobject;
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
@@ -1023,9 +1023,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
 
 cleanup_dev_kobject:
-	kobject_del(&nilfs->ns_dev_kobj);
-
-free_dev_subgroups:
+	kobject_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 
 failed_create_device_group:
-- 
2.18.0.huawei.25

