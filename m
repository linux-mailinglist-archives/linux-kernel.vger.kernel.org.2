Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37C3F2A53
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhHTKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhHTKyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A39F260C3E;
        Fri, 20 Aug 2021 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629456813;
        bh=VlCFJfF9lFTl1dJuE2e2uzICbbzwsCfyLaRHpi2W6t8=;
        h=From:To:Cc:Subject:Date:From;
        b=gvp5NIvIFYC2SgsUYcZNqtZTxTaEyKvRmu0ajo8wMC0m8WN9i5Tb6uj1/56KHNqqE
         ijWpxW2ag+TjgaB7odO+jfkzh/qGdrQicsf/Mdsw1i2TGToRA7iw+z0KXnwr1sxgkL
         05nJvsqnPJheC7AT2FzJX9lkwJgeRvULo3tjlLIJtFndvpKBhExtaks2rRFpb4dtjv
         76VCvqvCgx+EAN8ZUV0DtTRqvN0sSGArbVnhBHBtJAQtNqgVcnQBGRCIs139eoeGhH
         JtYbgBrXFk6uiPDzNAtHXM7HmmbsDaWLRd/XcfNM1Lej0xRkCG6Wbx6sURiWQgutAM
         r7IrDPP5OT+QA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: enable realtime discard iff device supports discard
Date:   Fri, 20 Aug 2021 18:53:26 +0800
Message-Id: <20210820105326.26922-1-chao@kernel.org>
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
 fs/f2fs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f92c582f8008..597e5dbc2f6d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -660,10 +660,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			break;
 		case Opt_discard:
+			if (!f2fs_hw_support_discard(sbi)) {
+				f2fs_warn(sbi, "device does not support discard");
+				return -EINVAL;
+			}
 			set_opt(sbi, DISCARD);
 			break;
 		case Opt_nodiscard:
-			if (f2fs_sb_has_blkzoned(sbi)) {
+			if (f2fs_hw_should_discard(sbi)) {
 				f2fs_warn(sbi, "discard is required for zoned block devices");
 				return -EINVAL;
 			}
@@ -1999,7 +2003,8 @@ static void default_options(struct f2fs_sb_info *sbi)
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

