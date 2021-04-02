Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF1352487
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhDBAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBAmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9409D61139;
        Fri,  2 Apr 2021 00:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617324156;
        bh=SPMgnl2lvjKL7Nrcau9zmsRqNKdUgqnXCr8UGhAzo9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=sY/UaNb+etD7V3umzRPHbLO+NlxgkPixM8MEF4lv4MlTs8JuvJI+/85K8PHLF2pq/
         AD7DxDa22Lhy/PIEhM2dMXlUQX3dbXiU9UUg2fZhhnUAEMSmncI7Iz3iQxGkdoaDIg
         txppSVRcSHjpOwezLXfRvwu0A6wq2MYka4XEEZauS1r7i2kM7mlRIX7iZISucPX+0d
         brm3+/eW4JkRGJ2r2TH9RxGdkQvBafLmbmyo5B84VLqAQ1kazK8zGDnHXg+aXKaIM7
         PEji1wSPVK1GOnU9A98/8DPLmp/l+0zIS/ExykcpAzFlw5XOcrqgVO6SUk2XpdzPlc
         u56d6InQY5rQw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set checkpoint_merge by default
Date:   Thu,  1 Apr 2021 17:42:25 -0700
Message-Id: <20210402004225.1677382-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we introduced checkpoint_merge, we've seen some contention w/o the option.
In order to avoid it, let's set it by default.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 14239e2b7ae7..c15800c3cdb1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1839,6 +1839,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
 	clear_opt(sbi, DISABLE_CHECKPOINT);
+	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-- 
2.31.0.208.g409f899ff0-goog

