Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4600430B932
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhBBIFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:05:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12099 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhBBIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:04:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVHNm34d1z162vB;
        Tue,  2 Feb 2021 16:02:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 16:03:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: relocate inline conversion from mmap() to mkwrite()
Date:   Tue, 2 Feb 2021 16:03:11 +0800
Message-ID: <20210202080311.53448-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is page fault only for read case on inline inode, we don't need
to convert inline inode, instead, let's do conversion for write case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 00b2ce47fa37..8e53f8898688 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -72,6 +72,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto err;
 	}
 
+	err = f2fs_convert_inline_inode(inode);
+	if (err)
+		goto err;
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
 		int ret = f2fs_is_compressed_cluster(inode, page->index);
@@ -506,7 +510,6 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	int err;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
@@ -514,11 +517,6 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	/* we don't need to use inline_data strictly */
-	err = f2fs_convert_inline_inode(inode);
-	if (err)
-		return err;
-
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
 	set_inode_flag(inode, FI_MMAP_FILE);
-- 
2.29.2

