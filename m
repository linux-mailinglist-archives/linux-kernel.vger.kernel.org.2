Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F644435A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhKCOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhKCOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:25:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA839C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 07:22:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1501057pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odOeSMEh9ZpBA89eL2qhRpEs4XuRy4e44peglvFnMtU=;
        b=XvnnyeRAxuitPImPJIlZ70HPKNSIKTcgcDDCY0BNYwKZWzeSb5fDk1B3m41sj1be5e
         JBE6X0HSXj9sHYamSvwZSv0DuNVWnqQ2rPGnd5vvxwHwHjRDOPLcfuYIriiJ7GUjv/Od
         8BG9Kxs9jWpA1Xepdcr9KRfekCJQ0CmTHp+xZ5aQryS9DFroWIs6G/cYS+DuCdEP1Y5u
         scsALWMNUaNfM4hT5rvf+MJak6cx1BlCEdKDTUO49B5uDS3DftuL/XS+O43iZX1uxePw
         bVnhf1/EkcSTncJmKhvlbO72RoA2w0CDrgGISL1VMSgJQF5WpieOhKwKk3JT/ZmVIi4r
         Ghmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odOeSMEh9ZpBA89eL2qhRpEs4XuRy4e44peglvFnMtU=;
        b=ree8weNHoMtRXAKG8bUaK15UxQbh1E+WX6uUdG3xO6Uy0TB5X5Cdo97Ic5by/hnrC5
         J8T7RcPe+5XAKFiyleFQ7HgeKExc17ceMP+Nwj4XinYGH70TF78CVB/vV2Pl2QWCSI3P
         KtyU2vXVvIvZD2mLyb6N0viZEmO4pAqYf959b0MiN4Qaga9J+wZLM/RZ2Sce+BH4+niP
         LqMorNGc3RZJVFCqu/gb+nLV2dEY/nwmodGGDLN43vyuUva29wNlvKgOZo81QolHiBxD
         gdKRXmnHayKvG/eI7PPJuR36ElrlHoz0OWqRRRqzMh4o/t0vkkPJNk02gUW/tD5EPwgo
         PGzg==
X-Gm-Message-State: AOAM531jMWSgn7CW8cMrQ7AlUvDQBteEOFfyM2vGZ2wG1V5DoM+gvM1A
        8hRtkoZGainhdvWblAxaam0=
X-Google-Smtp-Source: ABdhPJx9boeHyijVo0W1PSZZtMsybz7on3bwcC9dzysQlM/8X3F4rrEQ+xNqP6JGnTelBQ2qFY9VIg==
X-Received: by 2002:a17:90b:1293:: with SMTP id fw19mr14920912pjb.155.1635949365327;
        Wed, 03 Nov 2021 07:22:45 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.123])
        by smtp.gmail.com with ESMTPSA id z21sm2855893pfk.31.2021.11.03.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 07:22:44 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: f2fs: fix UAF in f2fs_available_free_memory
Date:   Wed,  3 Nov 2021 22:22:27 +0800
Message-Id: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_fill_super
-> f2fs_build_segment_manager
   -> create_discard_cmd_control
      -> f2fs_start_discard_thread

It invokes kthread_run to create a thread and run issue_discard_thread.

However, if f2fs_build_node_manager fails, the control flow goes to
free_nm and calls f2fs_destroy_node_manager. This function will free
sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
after the deallocation, but before the f2fs_stop_discard_thread, it will
cause UAF(Use-after-free).

-> f2fs_destroy_segment_manager
   -> destroy_discard_cmd_control
      -> f2fs_stop_discard_thread

Fix this by switching the order of f2fs_build_segment_manager
and f2fs_build_node_manager.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/f2fs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b..1a23b64cfb74 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	/* setup f2fs internal modules */
-	err = f2fs_build_segment_manager(sbi);
-	if (err) {
-		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
-			 err);
-		goto free_sm;
-	}
 	err = f2fs_build_node_manager(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
 			 err);
 		goto free_nm;
 	}
+	err = f2fs_build_segment_manager(sbi);
+	if (err) {
+		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
+			 err);
+		goto free_sm;
+	}
 
 	/* For write statistics */
 	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
@@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->node_inode = NULL;
 free_stats:
 	f2fs_destroy_stats(sbi);
-free_nm:
-	f2fs_destroy_node_manager(sbi);
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
+free_nm:
+	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_post_read_wq(sbi);
 stop_ckpt_thread:
 	f2fs_stop_ckpt_thread(sbi);
-- 
2.25.1

