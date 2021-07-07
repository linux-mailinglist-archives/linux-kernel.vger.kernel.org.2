Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2E3BF047
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhGGTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGTdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:33:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08D8661C6D;
        Wed,  7 Jul 2021 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625686252;
        bh=3pODlJmfBdRZUct1Nd+7/oWJuLC7tASVT2444KEehJA=;
        h=From:To:Cc:Subject:Date:From;
        b=jW49LuE5IDef38qMg2fJPfUyoUapV9yA8K76i0BmqMaLxTujkLYshGo++CxDhuC1s
         TlOoxvFV+rXcX2AzlaAxUdPOPQCmMDyuQNiPPp9qG9rkULA/X7jk7QTPX7tA9N7waN
         Oh6uBao8oal91hfx+oEeMxPzQgL4bzaygVH/fVCkwc3iNGAU8w15Qo+EfOqWMCTEZP
         UKitmWIhbisTePb64ayH4DAkW7MI5vKDwjkbSZP9YmpgvoxhBsnjQPOlixzkPcdI4q
         11kWrpEY72K4q3j35hCPxFwNKrp2t2TdmEZOfmMchAJul7mat+C1VCNI1FIWakaMDe
         X9TrtiXqvCzXA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: drop dirty node pages when cp is in error status
Date:   Wed,  7 Jul 2021 12:30:43 -0700
Message-Id: <20210707193043.969238-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, writeback is going to fall in a loop to flush dirty inode forever
before getting SBI_CLOSING.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dd611efa8aa4..0be9e2d7120e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1549,13 +1549,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	trace_f2fs_writepage(page, NODE);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
-			ClearPageUptodate(page);
-			dec_page_count(sbi, F2FS_DIRTY_NODES);
-			unlock_page(page);
-			return 0;
-		}
-		goto redirty_out;
+		ClearPageUptodate(page);
+		dec_page_count(sbi, F2FS_DIRTY_NODES);
+		unlock_page(page);
+		return 0;
 	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-- 
2.32.0.93.g670b81a890-goog

