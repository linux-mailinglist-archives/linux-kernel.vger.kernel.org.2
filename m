Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911732A393
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382286AbhCBJIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:08:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13832 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378635AbhCBIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:54:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DqVls14Skz7s37;
        Tue,  2 Mar 2021 16:34:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 16:35:35 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove unused file_clear_encrypt()
Date:   Tue, 2 Mar 2021 16:35:32 +0800
Message-ID: <20210302083532.11669-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- file_clear_encrypt() was never be used, remove it.
- In addition, relocating macros for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4fc343aa0a08..ddd54f5cf932 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -637,21 +637,26 @@ enum {
 #define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
-#define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
-#define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_clear_cold(inode)	clear_file(inode, FADVISE_COLD_BIT)
+
+#define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_got_pino(inode)	clear_file(inode, FADVISE_LOST_PINO_BIT)
+
 #define file_is_encrypt(inode)	is_file(inode, FADVISE_ENCRYPT_BIT)
 #define file_set_encrypt(inode)	set_file(inode, FADVISE_ENCRYPT_BIT)
-#define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
+
 #define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
 #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
+
 #define file_keep_isize(inode)	is_file(inode, FADVISE_KEEP_SIZE_BIT)
 #define file_set_keep_isize(inode) set_file(inode, FADVISE_KEEP_SIZE_BIT)
+
 #define file_is_hot(inode)	is_file(inode, FADVISE_HOT_BIT)
 #define file_set_hot(inode)	set_file(inode, FADVISE_HOT_BIT)
 #define file_clear_hot(inode)	clear_file(inode, FADVISE_HOT_BIT)
+
 #define file_is_verity(inode)	is_file(inode, FADVISE_VERITY_BIT)
 #define file_set_verity(inode)	set_file(inode, FADVISE_VERITY_BIT)
 
-- 
2.29.2

