Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBD3C9456
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhGNXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 19:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhGNXVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:21:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 512066136E;
        Wed, 14 Jul 2021 23:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626304734;
        bh=7ibYkMa/Q/QRDj3MQt3Cl24drEViJhJqRnCGjYpxIHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=F10JlT0arMKc1w9jpjBvlC8MdN0dv2pvzJX2g8QZ4wF4w7y1CYduAQdwjJXVANBYt
         cTdzkVnI4f+0vOCD8HyAiuiR8xcE6+KiOyEV1N0vQv+Jd+qU4F02blA7lPVxH94m8H
         5FX/CUOoSlVgp2VkAsonkccFGL8lSSTw2+0lhvWuS3oj2NDUrq0rVzGMTYannmyLcT
         b2kzz/LQVAVDvj2Qm3wuvkL1dPgFue/NI0B88BZ0f1FvCrXmjPConh63ON7XonqmI5
         VLnhJO+RQjxOW3uodo4RcyRtVC3YENIxHj3EfZgOSRQ/fn5zSw4R9KStbEdJhU4NAa
         h5sMSqnEe/9mA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@kernel.org
Subject: [PATCH] f2fs: let's keep writing IOs on SBI_NEED_FSCK
Date:   Wed, 14 Jul 2021 16:18:50 -0700
Message-Id: <20210714231850.2567509-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
is not fully critical to stop any IO writes. So, let's allow to write data
instead of reporting EIO forever given SBI_NEED_FSCK.

Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
Cc: <stable@kernel.org> # v5.13+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 15cc89eef28d..f9b7fb785e1d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3563,7 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
+	if (f2fs_cp_error(sbi)) {
 		err = -EIO;
 		goto drop_bio;
 	}
-- 
2.32.0.93.g670b81a890-goog

