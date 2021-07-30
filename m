Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA53DBEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhG3TJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhG3TJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30A360F00;
        Fri, 30 Jul 2021 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627672152;
        bh=00uKcfkCA0b/QBJBHFd/NCx0VSTJMUeiq41umtW8K/o=;
        h=From:To:Cc:Subject:Date:From;
        b=tgKBp5fC17GSQ9dnb6fsykoMRDRPkNPxQTRdLSmyvpP8lRnOSwTXiMP1ScyMpVPd3
         q+QQ/4/Te76EHAG/7DWuwPCCI+8Wwm1ykpVd8WprTuR0FJwYULb6DXaEz1lok9KcOd
         hXXMbwwyTH5B9WjOE1M+BzBhO4Pylz57h0ajj01Lpz1xEatNvw9arBq/8xeJifrbQu
         HeMy59T7kSH8HuLIyWAG0zip7dD+AAnwm/vn+2Vpey4XYhZBpjdFO0xC2bKTrnS80y
         PpF6mkC62NXr+0+EHZlBbd4lF8Yq765l5EEv6vT0oBrFTuHw77IKsuYXrG+BhjA0fj
         aNPbfbJdeRDSA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: show sbi status in debugfs/f2f/sstatus
Date:   Fri, 30 Jul 2021 12:09:07 -0700
Message-Id: <20210730190907.2072122-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to get sbi->s_flag to understand the current f2fs status as well.
One example is SBI_NEED_FSCK.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 53ed1e9191f0..473ad04d1891 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -333,11 +333,12 @@ static int stat_show(struct seq_file *s, void *v)
 	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
 		update_general_status(si->sbi);
 
-		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
+		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s (sbi: 0x%lx)]=====\n",
 			si->sbi->sb->s_bdev, i++,
 			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
 			is_set_ckpt_flags(si->sbi, CP_DISABLED_FLAG) ?
-			"Disabled": (f2fs_cp_error(si->sbi) ? "Error": "Good"));
+			"Disabled": (f2fs_cp_error(si->sbi) ? "Error": "Good"),
+			si->sbi->s_flag);
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
-- 
2.32.0.554.ge1b32706d8-goog

