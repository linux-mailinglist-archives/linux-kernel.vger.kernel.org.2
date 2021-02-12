Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5736E31A7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhBLWqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhBLWeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A406864DA1;
        Fri, 12 Feb 2021 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613169218;
        bh=zPLaLMvsfWolU7A16h5AwBVtaAqZZp8VsJK9aSEF+Oc=;
        h=From:To:Cc:Subject:Date:From;
        b=bz6gNxSjE+LWAL4HXxQHIymg3n3+zD6JqskLilyqGZ5jqrCqJZvHk9NWo0CNc7huw
         yKpW+I6iavEVqoSSgOO3TiJnXPmvDzNZC4MszJTW1VdhgewpuLure/rWoZMD1BSCA9
         Xott4J6YPohZZYrMGQEKQ5mm3UL5MKefqqGxP/Xc4V44YkLR7xzEgq/u8zZeVTLA7G
         5M4ApIfpA4FWYB4dXI+uQKsKUhTG6I4EGJ7QfT04sQbYUtlFCaMmWeLFALRgEqqbwm
         6nGWGwp8O/FWZ7mK0Dm4b6x4rmjpUfcbR2OKdlVqHJAELOTQh49C9qBxgZEgn+56XC
         OTw1KVO6nD28g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: give a warning only for readonly partition
Date:   Fri, 12 Feb 2021 14:33:34 -0800
Message-Id: <20210212223334.3550799-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow mounting readonly partition. We're able to recovery later once we
have it as read-write back.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4aa533cb4340..30d5abef4361 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3933,12 +3933,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
 		if (f2fs_hw_is_readonly(sbi)) {
-			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-				err = -EROFS;
+			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
 				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
-				goto free_meta;
-			}
-			f2fs_info(sbi, "write access unavailable, skipping recovery");
+			else
+				f2fs_info(sbi, "write access unavailable, skipping recovery");
 			goto reset_checkpoint;
 		}
 
-- 
2.30.0.478.g8a0d178c01-goog

