Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5F3FF8FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbhICDED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 23:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhICDEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 23:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5896360F56;
        Fri,  3 Sep 2021 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630638182;
        bh=gJtmSNZbKkbrzgxaPATLp8mnWtEdxwbpYMxFsan2BfI=;
        h=From:To:Cc:Subject:Date:From;
        b=LKME0aF4ROlzKUsehwZ5IRbV0HB3u23lNk6s3UluHX/esb12hgt/O9Pgv8u/iZZxn
         PMFSpEFh7OBLiaZ2TuY1Z8nset3Ak0WT8VXRiXULLApsopxoH8oec4tkK/Qb/tXcrh
         XbkHxpAzO3iZ5Pi+tRiECMVFqCSWiN9oC2OK6atMDQPczNMHVVyhz3S1iwzx9kEKNF
         iCFDbYaamZCVFEnVQJHI3jY1fW0lGyHVgxaQVirr1t2pVPbQedn9aAKhLM9PE122ZM
         sCxQKiTPKYBNdLPXZHQFOeIJh9tWczn3JcfNNZaZi8wPcGLGsrz1VRE8yKQSS23k2V
         +domrfjCm341A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Yi Zhuang <zhuangyi1@huawei.com>
Subject: [PATCH] f2fs: quota: fix potential deadlock
Date:   Fri,  3 Sep 2021 10:38:11 +0800
Message-Id: <20210903023811.3458-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Yi Zhuang reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=214299

There is potential deadlock during quota data flush as below:

Thread A:			Thread B:
f2fs_dquot_acquire
down_read(&sbi->quota_sem)
				f2fs_write_checkpoint
				block_operations
				f2fs_look_all
				down_write(&sbi->cp_rwsem)
f2fs_quota_write
f2fs_write_begin
__do_map_lock
f2fs_lock_op
down_read(&sbi->cp_rwsem)
				__need_flush_qutoa
				down_write(&sbi->quota_sem)

This patch changes block_operations() to use trylock, if it fails,
it means there is potential quota data updater, in this condition,
let's flush quota data first and then trylock again to check dirty
status of quota data.

The side effect is: in heavy race condition (e.g. multi quota data
upaters vs quota data flusher), it may decrease the probability of
synchronizing quota data successfully in checkpoint() due to limited
retry time of quota flush.

Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7d8803a4cbc2..6f6a7d812d60 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1159,7 +1159,8 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 	if (!is_journalled_quota(sbi))
 		return false;
 
-	down_write(&sbi->quota_sem);
+	if (!down_write_trylock(&sbi->quota_sem))
+		return true;
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)) {
 		ret = false;
 	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR)) {
-- 
2.32.0

