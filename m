Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C33FAF40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhH3Agd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235041AbhH3Agc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF2560F4C;
        Mon, 30 Aug 2021 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630283739;
        bh=UXaVialVYc+g0/THdnyLtCXZoh9xKNxvU2i8RfeiQFI=;
        h=From:To:Cc:Subject:Date:From;
        b=HFUutMLNwyu+ZkPlRUjy1Cpq6Km0LCCNBkoz3VAmjAfwdyTcZkql4Q4rE0wKcs6aT
         gQG0t3HbspInWnJanF+50whDuvURvEaJcadpzgCeSNMoSQjPnZUPStzBQVqMLHq1od
         wd0UeedacaOTnZ4aj4Dr9kyJEauhnMt56aLTLq6MFVmknzgnF9UslWIwwkCEjUWsZ2
         7I5dppN0jFyPcVGzFg1Snz141jP48FYvN229lzWXnsH+7C3YEfTkgMT15Q/eeXGzJg
         YjqR8eIepoXWah3Z51ydR+7x56qsJc9mKAxEAuZpNY20M3Wec6JqvTa11eORD2rDbG
         5bi3whgWx7EVA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: enable realtime discard iff device supports discard
Date:   Mon, 30 Aug 2021 08:35:33 +0800
Message-Id: <20210830003533.38898-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's only enable realtime discard if and only if device supports
discard functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- don't give EINVAL if device doesn't support discard for "-o discard"
mountoption to avoid break userspace behavior.
 fs/f2fs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f5148f2fd884..27c78c96d866 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -661,10 +661,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			break;
 		case Opt_discard:
+			if (!f2fs_hw_support_discard(sbi)) {
+				f2fs_warn(sbi, "device does not support discard");
+				break;
+			}
 			set_opt(sbi, DISCARD);
 			break;
 		case Opt_nodiscard:
-			if (f2fs_sb_has_blkzoned(sbi)) {
+			if (f2fs_hw_should_discard(sbi)) {
 				f2fs_warn(sbi, "discard is required for zoned block devices");
 				return -EINVAL;
 			}
@@ -2001,7 +2005,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	set_opt(sbi, DISCARD);
+	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
+		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
 		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
-- 
2.32.0

