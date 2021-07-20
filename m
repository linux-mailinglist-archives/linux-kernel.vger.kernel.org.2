Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BE3CF117
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355467AbhGTA0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240609AbhGTAXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:23:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAD4A6108B;
        Tue, 20 Jul 2021 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626743019;
        bh=pW7dgvX8qNpOLEnDjntqz8ri5q5ehXQ54m1Yym7YAoU=;
        h=From:To:Cc:Subject:Date:From;
        b=HMZkCFsbIHvDiufTmXl4sfDXppA63ordedFTPOo5V9twOlfKNpYi4iOrKZpeyvSVM
         k5HESN425dyjLwuC43TMlu7h9Dq9Tr7LtTSPCuBAyBriSghPiDFDLiRgBUHjq30gWD
         IiRpEuJMq3OISvet0p2Bd0bBK1v2/p4LaQ+DtG63f5N5vxDjHDkh/FYxp6KREYgpJh
         lEEV4VfeSQev5m5dydFuLeYooMMmcTWIlScvYJR9tiWobKh1EfJLeoUNoUXDbJiZqS
         Jpq+Bx1pweKPbfruWdg0txB/X8j2338n8L7Uz+tv7OiM1IBzc+9jfqaJujCEb45o1c
         mQNlrNTCQ815A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to force keeping write barrier for strict fsync mode
Date:   Tue, 20 Jul 2021 09:03:29 +0800
Message-Id: <20210720010329.3975-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html

As [1] reported, if lower device doesn't support write barrier, in below
case:

- write page #0; persist
- overwrite page #0
- fsync
 - write data page #0 OPU into device's cache
 - write inode page into device's cache
 - issue flush

If SPO is triggered during flush command, inode page can be persisted
before data page #0, so that after recovery, inode page can be recovered
with new physical block address of data page #0, however there may
contains dummy data in new physical block address.

Then what user will see is: after overwrite & fsync + SPO, old data in
file was corrupted, if any user do care about such case, we can suggest
user to use STRICT fsync mode, in this mode, we will force to use atomic
write sematics to keep write order in between data/node and last node,
so that it avoids potential data corruption during fsync().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..00b45876eaa1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -301,6 +301,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
+	} else {
+		/*
+		 * for OPU case, during fsync(), node can be persisted before
+		 * data when lower device doesn't support write barrier, result
+		 * in data corruption after SPO.
+		 * So for strict fsync mode, force to use atomic write sematics
+		 * to keep write order in between data/node and last node to
+		 * avoid potential data corruption.
+		 */
+		if (F2FS_OPTION(sbi).fsync_mode ==
+				FSYNC_MODE_STRICT && !atomic)
+			atomic = true;
 	}
 go_write:
 	/*
-- 
2.22.1

