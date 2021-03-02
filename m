Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DD32A1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836267AbhCBG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577107AbhCBFnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:43:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A886146B;
        Tue,  2 Mar 2021 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614663755;
        bh=L/xAWAJDwAT+puMjWqJVBI895stEzEJP7zB19lOugg8=;
        h=From:To:Cc:Subject:Date:From;
        b=Vl/PqZSu+l9Incm849CFvZbxe0KngocrQNhV44bnpS/hW7HwmyMw1TScNTNjW/wOJ
         GGS4KBwj3Fq4ap8JhEVfVVGe6t8TAIIejbmtRXV9/8aRl9BPHuaiVu1puwwBic/Zmk
         9D5uGh/775rbSjetWtieVwrqCphQ1pb0V7xtIDhAFM4scS4+RZYXr0TAmNEIpNJjRk
         zOzceXGPY+WJjCQG544WZKnq/8TVDASBB5c3Pcta81OtQzB+/dPYyeyUpa9FOkTeRT
         vTrdBs0tVRT3RLqudoO15zioQXeoOcWLTEYFnrh7tsfM/TV58FAiIdfPaTKfw8ROAb
         6UMJpstpWpayQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: expose # of overprivision segments
Date:   Mon,  1 Mar 2021 21:42:33 -0800
Message-Id: <20210302054233.3886681-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful when checking conditions during checkpoint=disable in Android.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e38a7f6921dd..254b6fa17406 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
 			(unsigned long long)(free_segments(sbi)));
 }
 
+static ssize_t ovp_segments_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(overprovision_segments(sbi)));
+}
+
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
 F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
+F2FS_GENERAL_RO_ATTR(ovp_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 F2FS_GENERAL_RO_ATTR(features);
 F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
-- 
2.30.1.766.gb4fecdf3b7-goog

