Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A337F0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbhEMAsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245698AbhEMAqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:46:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06A4F613CA;
        Thu, 13 May 2021 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620866729;
        bh=bInJzrzMTKEfUz71kqIhWS61jCi+MWogtSHtDwqlFXc=;
        h=From:To:Cc:Subject:Date:From;
        b=XWnkDbHOGwNKujT3ouCBL+/UL2qYQXQwpCsGEfZuLF6Y9UHT6eYU67L87ad12otRu
         hfLx/HoZrPYiSrhbnEJeolCYrIW7IK6CJmdXuOR1D92tcK+tYk+xMPgQt+TSGsaGBV
         9nQG65XCgM0f6qLljD+JA6/9ePcid0jJ7Dt7sAim4b0C1wlk3l5wbpgudFugCzO17u
         LhMSmi+rMO3+E5U0ByiUFBrmkdFo8aprFmysz8w/yI6M5RB8SD97UWWTvat7ov1I2u
         vtjhbk15f0Lsu/a6hwl+VMOcTdXGD7OIvkg0eiP5GXfvvIMZxK2l+/xMhRKVcmZOQS
         Wat533KHjDEKg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return EINVAL for hole cases in swap file
Date:   Wed, 12 May 2021 17:45:27 -0700
Message-Id: <20210513004527.3721604-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tries to fix xfstests/generic/495.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41e260680b27..009a09fb9d88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3896,7 +3896,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 		/* hole */
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			f2fs_err(sbi, "Swapfile has holes\n");
-			ret = -ENOENT;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -4052,7 +4052,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	return ret;
 bad_bmap:
 	f2fs_err(sbi, "Swapfile has holes\n");
-	return -ENOENT;
+	return -EINVAL;
 }
 
 static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
-- 
2.31.1.607.g51e8a6a459-goog

