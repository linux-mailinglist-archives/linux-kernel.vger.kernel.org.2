Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1183AAF13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFQIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:54:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4831 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFQIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:54:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5Fzc0JjjzXglp
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 16:47:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:52:10 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:52:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] hpfs: remove unnecessary oom message
Date:   Thu, 17 Jun 2021 16:52:03 +0800
Message-ID: <20210617085203.1332-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/hpfs/dnode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
index 4ada525c5c43..40edbd6c2b7e 100644
--- a/fs/hpfs/dnode.c
+++ b/fs/hpfs/dnode.c
@@ -34,10 +34,8 @@ int hpfs_add_pos(struct inode *inode, loff_t *pos)
 				return 0;
 	if (!(i&0x0f)) {
 		ppos = kmalloc_array(i + 0x11, sizeof(loff_t *), GFP_NOFS);
-		if (!ppos) {
-			pr_err("out of memory for position list\n");
+		if (!ppos)
 			return -ENOMEM;
-		}
 		if (hpfs_inode->i_rddir_off) {
 			memcpy(ppos, hpfs_inode->i_rddir_off, i * sizeof(loff_t));
 			kfree(hpfs_inode->i_rddir_off);
-- 
2.25.1


