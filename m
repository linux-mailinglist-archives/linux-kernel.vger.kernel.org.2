Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367823D6424
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhGZPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234726AbhGZPdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:33:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D5F604AC;
        Mon, 26 Jul 2021 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627316043;
        bh=tv3iEgitgc75A0bg23isqSqMFGNrby9uKXpFxgZ/wQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=utJLbSCklriQ95YuJeTxtNPqCtLoCJ6D1KUkkDK2z45T4Sy/65l8Zl6aPQvwueHJd
         J2jKif7/gwuCrkXdZe2z4y1p+8FyQp/rYJRuy/ucaKIWgmiirjMwkQz3UgUm7xHmEC
         vFml30psnBaWCZ2xQpdxoIr3WCoB2vvHM4YDZZ3rPeELWygJxkdjWzOagbiclQzYd5
         hWQVvLiZYePNVb/5qO5gEsCn0GTIbkPcDN93Srd+juawUkUSvmJ/suBYcKzviN4AdO
         E007aB+rODfQkt8mWpkUO7AbjDkYzi4N4OmkP38qo3NElg5brrFw9rrHmPx+3o3UlS
         SbwRVAsVvmBog==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not submit NEW_ADDR to read node block
Date:   Mon, 26 Jul 2021 09:13:57 -0700
Message-Id: <20210726161357.105332-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the below patch, give cp is errored, we drop dirty node pages. This
can give NEW_ADDR to read node pages. Don't do WARN_ON() which gives
generic/475 failure.

Fixes: 28607bf3aa6f ("f2fs: drop dirty node pages when cp is in error status")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c945a9730f3c..5840b82ce311 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1330,7 +1330,8 @@ static int read_node_page(struct page *page, int op_flags)
 	if (err)
 		return err;
 
-	if (unlikely(ni.blk_addr == NULL_ADDR) ||
+	/* NEW_ADDR can be seen, after cp_error drops some dirty node pages */
+	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR) ||
 			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
-- 
2.32.0.432.gabb21c7263-goog

