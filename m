Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EF38CDD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhEUTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhEUTDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D98D613AD;
        Fri, 21 May 2021 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621623743;
        bh=PwYVEBdAYioTg9dJDanRYBbNY1d6VzNe8pGxwNgHwts=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6pBlx9PqRwpvhLSpS84t22o70Jagai7OtGqHdaPV+fIYO5XMz1N/8T7Y09nXFFpg
         9Xe5GPyKesQTFirhUtEyFp9Npa+tHN0GMPSt7EenGDbQQHnqdziXFuFisgd6Y80mPd
         B4je9HWSH56F2nC/Y0A26eeB/lnq93i2W13D55snJP0FdJkX5L+32CcFJlNm2HvDn8
         iDlr191ukjmJm70oPL+tERx5bJdf+WHDklvTUbY6ur8+zYQ5ISdjaLfeTQUOncryiN
         Zb+yuh9HETAuuTca0yIUZS8OoJvCMQ4r3awG/SqYztbThqjVNubiKub4axbdq4xH3C
         ZNNCtxofktY3Q==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: immutable file can have null address in compressed chunk
Date:   Fri, 21 May 2021 12:02:16 -0700
Message-Id: <20210521190217.2484099-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we released compressed blocks having an immutable bit, we can see less
number of compressed block addresses. Let's fix wrong BUG_ON.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d4f7371fb0d8..1189740aa141 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -927,7 +927,8 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 			}
 		}
 
-		f2fs_bug_on(F2FS_I_SB(inode), !compr && ret != cluster_size);
+		f2fs_bug_on(F2FS_I_SB(inode),
+			!compr && ret != cluster_size && !IS_IMMUTABLE(inode));
 	}
 fail:
 	f2fs_put_dnode(&dn);
-- 
2.31.1.818.g46aad6cb9e-goog

