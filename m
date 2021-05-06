Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2C375B81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhEFTOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234467AbhEFTOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B3C61107;
        Thu,  6 May 2021 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620328431;
        bh=Xd/ndCtgZJ2dO4cS5u02uHTb6AeNYHoi+rl86LUAbso=;
        h=From:To:Cc:Subject:Date:From;
        b=GYgkzkyezQq25+wnQeXre7srZxxQyVeHIWgdt+aJ9BwHucvGsxj8IqBFxcABjkdyf
         fTSQFXtZHhvZeevvP/MtiPeAZS7gaZK/9Hw2zF5fSRcQmrNLVYUs2w7hBeWQcNvDV6
         699A6NY5iSs56tuPkLBWjPVv/ikWYjzSIyrlTQEMsedhHv1sS8KAGlaDS3zOx6FB0J
         AurGdOsFF+ZI332T8HAT4lt4Wjn5INvv/eR8PDtB8yc3odCV0EuSuLP+HkZE+v6Z4O
         6mp9SKlDDkUVOM8EMd2Kv+8bvhef2RN6t/afdelMtddteKTSjucLS5ojIpNr4Fjaz3
         q8qiVhYbYmA7A==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return -EPERM given generic mask
Date:   Thu,  6 May 2021 12:13:47 -0700
Message-Id: <20210506191347.1242802-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_fileattr_set(),

	if (!fa->flags_valid)
		mask &= FS_COMMON_FL;

In this case, we should not allow to set FS_COMPR_FL, instead of BUG_ON.

/* Flags shared betwen flags/xflags */
	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
	 FS_PROJINHERIT_FL)

Fixes: 4c5b47997521 ("vfs: add fileattr ops")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e01ce802cf10..38015ef84893 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1817,7 +1817,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	u32 masked_flags = fi->i_flags & mask;
 
-	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
+	/* mask can be shrunk by flags_valid selector */
+	if (iflags & ~mask)
+		return -EPERM;
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
-- 
2.31.1.607.g51e8a6a459-goog

