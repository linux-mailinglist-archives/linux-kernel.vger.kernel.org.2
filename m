Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDC3A79A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFOI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:58:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7270 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhFOI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:58:44 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G429l16Fyz1BMJ8;
        Tue, 15 Jun 2021 16:51:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 16:56:38 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH RFC v2] ext4:fix warning in mark_buffer_dirty as IO error when mount with errors=continue
Date:   Tue, 15 Jun 2021 17:05:37 +0800
Message-ID: <20210615090537.3423231-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We test with following step:
1. dmsetup  create dust1 --table  '0 2097152 dust /dev/sdc 0 4096'
2. mount  /dev/mapper/dust1  /home/test
3. dmsetup message dust1 0 addbadblock 0 10
4. cd /home/test
5. echo "XXXXXXX" > t
6. wait a moment we got following warning:
[   80.654487] end_buffer_async_write: bh=0xffff88842f18bdd0
[   80.656134] Buffer I/O error on dev dm-0, logical block 0, lost async page write
[   85.774450] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:193: comm kworker/u16:8: Error while async write back metadata
[   91.415513] mark_buffer_dirty: bh=0xffff88842f18bdd0
[   91.417038] ------------[ cut here ]------------
[   91.418450] WARNING: CPU: 1 PID: 1944 at fs/buffer.c:1092 mark_buffer_dirty.cold+0x1c/0x5e

[   91.440322] Call Trace:
[   91.440652]  __jbd2_journal_temp_unlink_buffer+0x135/0x220
[   91.441354]  __jbd2_journal_unfile_buffer+0x24/0x90
[   91.441981]  __jbd2_journal_refile_buffer+0x134/0x1d0
[   91.442628]  jbd2_journal_commit_transaction+0x249a/0x3240
[   91.443336]  ? put_prev_entity+0x2a/0x200
[   91.443856]  ? kjournald2+0x12e/0x510
[   91.444324]  kjournald2+0x12e/0x510
[   91.444773]  ? woken_wake_function+0x30/0x30
[   91.445326]  kthread+0x150/0x1b0
[   91.445739]  ? commit_timeout+0x20/0x20
[   91.446258]  ? kthread_flush_worker+0xb0/0xb0
[   91.446818]  ret_from_fork+0x1f/0x30
[   91.447293] ---[ end trace 66f0b6bf3d1abade ]---

If super block write back with IO error, then will call clear_buffer_uptodate
clear uptodate flag. But there is no chance to set buffer uptodate again.
So call set_buffer_uptodate before call jbd2_journal_dirty_metadata to make sure
that buffer is uptodate when buffer is jbddirty.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/ext4/super.c     | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..b96ecba91899 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -327,6 +327,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 
 	set_buffer_meta(bh);
 	set_buffer_prio(bh);
+	set_buffer_uptodate(bh);
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_dirty_metadata(handle, bh);
 		/* Errors can only happen due to aborted journal or a nasty bug */
@@ -355,7 +356,6 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 					 err);
 		}
 	} else {
-		set_buffer_uptodate(bh);
 		if (inode)
 			mark_buffer_dirty_inode(bh, inode);
 		else
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d29f6aa7d96e..67a92c11a45c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -705,15 +705,23 @@ static void flush_stashed_error_work(struct work_struct *work)
 	 * ext4 error handling code during handling of previous errors.
 	 */
 	if (!sb_rdonly(sbi->s_sb) && journal) {
+		struct buffer_head *sbh = sbi->s_sbh;
 		handle = jbd2_journal_start(journal, 1);
 		if (IS_ERR(handle))
 			goto write_directly;
-		if (jbd2_journal_get_write_access(handle, sbi->s_sbh)) {
+		if (jbd2_journal_get_write_access(handle, sbh)) {
 			jbd2_journal_stop(handle);
 			goto write_directly;
 		}
 		ext4_update_super(sbi->s_sb);
-		if (jbd2_journal_dirty_metadata(handle, sbi->s_sbh)) {
+		if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
+			ext4_msg(sbi->s_sb, KERN_ERR, "previous I/O error to "
+				 "superblock detected");
+			clear_buffer_write_io_error(sbh);
+			set_buffer_uptodate(sbh);
+		}
+
+		if (jbd2_journal_dirty_metadata(handle, sbh)) {
 			jbd2_journal_stop(handle);
 			goto write_directly;
 		}
-- 
2.31.1

