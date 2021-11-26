Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3145E4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357862AbhKZCgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357607AbhKZCeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:34:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7443F61154;
        Fri, 26 Nov 2021 02:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637893837;
        bh=JyLokz3uTX1psmva6XXCGWuAqkaTiwTqi+lVRfFS/O8=;
        h=From:To:Cc:Subject:Date:From;
        b=ErqPXU3E+clUwbGsxGi25omWapVNnGema8fA/AHdCpnCDcPaTlqbgSOtVSi+eIXfB
         4364uQPz8AVIqv3/sKnhdBfxhgHfJG0JDwDP5pXssdWjtOEOMsjXWc+gP01SlaWBLB
         ThvWV0nEp765BXQ+lCIKDkewROeD52kedkVgNqRo2CMgXwY9ZD/fdMKEl1qyRLn79v
         YQwsjx1N0fHsv14kOHtv13yZ3t93QDkBDKZpnRNTCyVd7tNLBlTyMFv9wv/l2QdZgU
         fUgizkRd8FSvUPrPpoQzjkmeUM4a8IRjAJjs9gxa9VO4mJpQiTrhEMwvHZd17omRJk
         KDxD9mtFHmtDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weichao Guo <guoweichao@oppo.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 1/4] f2fs: set SBI_NEED_FSCK flag when inconsistent node block found
Date:   Thu, 25 Nov 2021 21:30:31 -0500
Message-Id: <20211126023034.440961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weichao Guo <guoweichao@oppo.com>

[ Upstream commit 6663b138ded1a59e630c9e605e42aa7fde490cdc ]

Inconsistent node block will cause a file fail to open or read,
which could make the user process crashes or stucks. Let's mark
SBI_NEED_FSCK flag to trigger a fix at next fsck time. After
unlinking the corrupted file, the user process could regenerate
a new one and work correctly.

Signed-off-by: Weichao Guo <guoweichao@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 597a145c08ef5..7e625806bd4a2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1389,6 +1389,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			  nid, nid_of_node(page), ino_of_node(page),
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EINVAL;
 out_err:
 		ClearPageUptodate(page);
-- 
2.33.0

