Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7043D7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJ0Xsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ0Xsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:48:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:46:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3317736pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vg6E5OmGYHn5+IyE3WrLoYyvAdoqCM0a4q0JJegvWrM=;
        b=HOcNND3NwAYdfC1iNgX23mLTtOXmPIeoXtLFFSOH8mSPtJPxBBFyvKWiHvpKsSy8We
         IwxkX99QGe6YVajOZUV4bNuLB280NVgc15b+Ai/mLg+LY1Iu+UlYz4TRoPEu+gLuf1TI
         RRbLh+nA93ctjQuxpPc9kUHRv7MkDqdFYfItF+1z1m6SBNtzKuEH6Gg8pOAlOynKCAkq
         OZJGWw5f6YoIlx9LmLTFRRDUB9DRIxnaC2ZRxuQsUrl7sHWxO0BsyjEZAPlTZw4tjhnk
         emvD7ZyM0HQgqSngwBM2to43ZkPGBfcP3rp3KS8Xe5DgqCnMh8RszzBDnohYhPgLAGnZ
         HXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vg6E5OmGYHn5+IyE3WrLoYyvAdoqCM0a4q0JJegvWrM=;
        b=CCYpIeIFvlgDJ/obTIkg7HEX5FCqP7cSxOI/C8nBBmg60HMMR++ZqXhJl+QyeK1x1S
         JbGIDU0xL+owiHXYY6vQZcs/SHp56HOR94SNVVNKkbxNy5/y/hKN+9sT7qJI7qcF2fbF
         LPVZPjZX4TVdiGL6xcnnHJiZ6sfjvj8OpgYcUfZsWKvuchr23sedTAhG792+sKjM2d8W
         G85IIFPpiLWDwBtCihJMfam7m+pXfJhLcjWkly6+qESikLIGie8SWKzYaQOGL3YLZCRN
         /XTi/gMP31P9zcnaLsT1vkBFls2PLtYKdR9XBbeCcXQNvg59HBBtLZvjz288yTbq2167
         YR9w==
X-Gm-Message-State: AOAM531dcXwEIw5TVQWXWsmG8Y+7p+rZsiPXtrpi67PaVG1cXcIB02HG
        Uy9bgEdIwEH9XMbdo/Z0PjGgYm9gYrM=
X-Google-Smtp-Source: ABdhPJwru7fnm40/ZeI7chy9uRFBqMQzp9ueR9qQPxssv9pW8hb9WOS0dxvezOR572DrXZFOdM6cgA==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr9162564pjq.137.1635378375954;
        Wed, 27 Oct 2021 16:46:15 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b75c:b351:dcb7:11d8])
        by smtp.gmail.com with ESMTPSA id b9sm1048168pfv.158.2021.10.27.16.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:46:15 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs-tools: remove false failure alarm when fixing quota
Date:   Wed, 27 Oct 2021 16:46:10 -0700
Message-Id: <20211027234611.1958146-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Even though fsck fixed quota issues, fsck returns failure status and
makes the user code misunderstand like errors are still there.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c       | 6 ++++--
 include/f2fs_fs.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 110c1ec..bc11e07 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2025,7 +2025,7 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 			f2fs_filesize_update(sbi, ino, 0);
 			ret = quota_write_inode(sbi, qtype);
 			if (!ret) {
-				c.bug_on = 1;
+				c.quota_fixed = true;
 				DBG(1, "OK\n");
 			} else {
 				ASSERT_MSG("Unable to write quota file");
@@ -2197,6 +2197,8 @@ void fsck_init(struct f2fs_sb_info *sbi)
 	ASSERT(fsck->dentry != NULL);
 	memcpy(fsck->dentry->name, "/", 1);
 	fsck->dentry_end = fsck->dentry;
+
+	c.quota_fixed = false;
 }
 
 static void fix_hard_links(struct f2fs_sb_info *sbi)
@@ -3330,7 +3332,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	if (force || (c.fix_on && f2fs_dev_is_writable())) {
 		struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
-		if (force || c.bug_on || c.bug_nat_bits) {
+		if (force || c.bug_on || c.bug_nat_bits || c.quota_fixed) {
 			/* flush nats to write_nit_bits below */
 			flush_journal_entries(sbi);
 			fix_hard_links(sbi);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 69260a6..9f918ba 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -491,6 +491,7 @@ struct f2fs_configuration {
 	int defset;
 	int bug_on;
 	int bug_nat_bits;
+	bool quota_fixed;
 	int alloc_failed;
 	int auto_fix;
 	int layout;
-- 
2.33.0.1079.g6e70778dc9-goog

