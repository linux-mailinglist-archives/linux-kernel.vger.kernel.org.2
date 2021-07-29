Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664A73D9B06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 03:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhG2BWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 21:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2BWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:22:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4127E608FB;
        Thu, 29 Jul 2021 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627521767;
        bh=d0zv6RtbSmg5wdXW/LCxn3s+mk2wN2t8jhgBEjbtGcc=;
        h=From:To:Cc:Subject:Date:From;
        b=i6G5Yx3LUfltP2gYE3dSAYTM95ux/dp35zDFndVUcM+TfanOFNDYYHIcLykSo6+j9
         YUUgXI05NgJKg5EYRAjF1BqMu53YGvSs5kiOCVudslok1nJadGH3lotbzM1zjAxCIB
         qmpQ5F/yzhIf8oBontwcdfvcyY6EUzUK1Yq4MI64anGhz/vXe+zJNAm+0+9ARfs3tl
         77bmbHBEJXiY9jh/eFNZIdDqv31qH/W9WuHkQf7cAlzHGUGovTu30eOQiRwsxFb33a
         VaeiYmAlyOkLEDcCQYOakvmzs1jHGBZiH2lhfpJttzFsKzge8wl4sUfZeQNGoYGDIx
         AfgarM/OLsTgg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH RESEND] f2fs: fix wrong checkpoint_changed value in f2fs_remount()
Date:   Thu, 29 Jul 2021 09:22:17 +0800
Message-Id: <20210729012217.788321-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_remount(), return value of test_opt() is an unsigned int type
variable, however when we compare it to a bool type variable, it cause
wrong result, fix it.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 41765e90caa2..18c1ffb8710e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2062,11 +2062,10 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_ckpt = false, need_stop_ckpt = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
-	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
 	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool no_atgc = !test_opt(sbi, ATGC);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
-	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -2111,8 +2110,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	err = parse_options(sb, data, true);
 	if (err)
 		goto restore_opts;
-	checkpoint_changed =
-			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
 
 	/*
 	 * Previous and new state of filesystem is RO,
@@ -2234,7 +2231,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_flush = true;
 	}
 
-	if (checkpoint_changed) {
+	if (enable_checkpoint == !!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 			err = f2fs_disable_checkpoint(sbi);
 			if (err)
-- 
2.22.1

