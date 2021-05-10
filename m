Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5737912C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhEJOp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237585AbhEJOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:43:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE505613B6;
        Mon, 10 May 2021 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620657748;
        bh=+zaTw2MyhWZVx6mLMle52nf82JFa4RkhC/eaBmVOGqw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=EuS1/s50iuxWebKL/qEe+XTto+YydQ8k9+cOQralxHFdsGYn4lcfefmtE0MLmhpjN
         65ihnBZX4cwS0FywI3zAO2P5Vf9FbtUqeAKaLywFdU3vk56ThylUJCT0OUtzdh1H79
         n9/0l9ab6ZlBq8zjz3pAMwxLN3BSwfDgSmoY7gzNqAwy2mH/ErmJNt/BFp7VTKpFUO
         31EFACexSkoBxucPDd75Pqn54ZGitKtHTyPBDJTm+BQJq4fYbLlhXc5tMI9qxHdiwz
         a/9XHR4uY10VOmFtSOtD9nyLLR7TXM2isNp3llFom4Z8aBCd/9NdxUqXJbzyNPrUjn
         Rfj62WVuqptTQ==
Date:   Mon, 10 May 2021 07:42:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: support iflag change given the mask
Message-ID: <YJlGU+STYD5geyIc@google.com>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506191347.1242802-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_fileattr_set(),

	if (!fa->flags_valid)
		mask &= FS_COMMON_FL;

In this case, we can set supported flags by mask only instead of BUG_ON.

/* Flags shared betwen flags/xflags */
	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
	 FS_PROJINHERIT_FL)

Fixes: 4c5b47997521 ("vfs: add fileattr ops")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 44a4650aea7b..ceb575f99048 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1817,7 +1817,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	u32 masked_flags = fi->i_flags & mask;
 
-	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
+	/* mask can be shrunk by flags_valid selector */
+	iflags &= mask;
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
-- 
2.31.1.607.g51e8a6a459-goog

