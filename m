Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7337B9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhELJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:54:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3732 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhELJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:54:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg94Y0wLjzqTV2;
        Wed, 12 May 2021 17:49:49 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:53:03 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: compress: remove unneeded f2fs_put_dnode()
Date:   Wed, 12 May 2021 17:52:56 +0800
Message-ID: <20210512095258.96918-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't initialize dn.inode_page for f2fs_get_block(),
f2fs_get_block() will call f2fs_put_dnode() itself, so let's
remove unneeded f2fs_put_dnode() in f2fs_vm_page_mkwrite().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1922037ea62c..9241e8e3ffff 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -117,7 +117,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_block(&dn, page->index);
-		f2fs_put_dnode(&dn);
 		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
 	}
 
-- 
2.29.2

