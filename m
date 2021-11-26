Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B445E4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357848AbhKZCgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357680AbhKZCeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF08E61163;
        Fri, 26 Nov 2021 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637893844;
        bh=1bJXgMPjotzg4shCd/vFtSiQm9PWDHgzlsTJ28Iny8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=QHQpv8oCt5Jf7AyTiNOBBnTto6rEzI5XjxfwiwFTLej9c9cvs2rYu61WOGIn1DbYS
         UgEN8ey3zBR+VjQBNfYt+61iuuMe+KDTgwZBifujr4+c664f447c1OR7wLO80jONR8
         TrRR3fu7R9ukdh0RSBmCT1xOm+RuKZk6xxMtysQKfRRCoVh/0Kn/YG4xNKI0MeSXdv
         7iYkV+wdJGwg8ECIqLht3Sm7HzUkY1k0GNHh/q+r3ESku09sps1nK7ssaiSsaIfIzu
         +8PtAq8T6OuZIngZcsTDgPcB/eIcvw6SkpsFM1FaYgDHUMyH//5ANZAFKd7sa6kGHG
         fcu73V1re+UGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weichao Guo <guoweichao@oppo.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 1/2] f2fs: set SBI_NEED_FSCK flag when inconsistent node block found
Date:   Thu, 25 Nov 2021 21:30:41 -0500
Message-Id: <20211126023042.441107-1-sashal@kernel.org>
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
index 4cb182c20eedd..0cd1d51dde06d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1385,6 +1385,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			  nid, nid_of_node(page), ino_of_node(page),
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EINVAL;
 out_err:
 		ClearPageUptodate(page);
-- 
2.33.0

