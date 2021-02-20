Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1D3204C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhBTJjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:39:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12985 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:39:33 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DjNdW0gdRzjMgl;
        Sat, 20 Feb 2021 17:37:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:38:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] f2fs: avoid unused f2fs_show_compress_options()
Date:   Sat, 20 Feb 2021 17:38:41 +0800
Message-ID: <20210220093843.64379-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reports:

   fs/f2fs/super.c:1516:20: warning: unused function 'f2fs_show_compress_options' [-Wunused-function]
   static inline void f2fs_show_compress_options(struct seq_file *seq,

Fix this issue by covering f2fs_show_compress_options() with
CONFIG_F2FS_FS_COMPRESSION macro.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78d9e54bc4f7..042925c6c2cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1620,6 +1620,7 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 #endif
 }
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 static inline void f2fs_show_compress_options(struct seq_file *seq,
 							struct super_block *sb)
 {
@@ -1665,6 +1666,7 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
 		seq_printf(seq, ",compress_mode=%s", "user");
 }
+#endif
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
-- 
2.29.2

