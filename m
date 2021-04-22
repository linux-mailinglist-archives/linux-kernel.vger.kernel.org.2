Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6001E36813B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhDVNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:09:21 -0400
Received: from mail-m176233.qiye.163.com ([59.111.176.233]:11738 "EHLO
        mail-m176233.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbhDVNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:09:19 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 09:09:19 EDT
Received: from ubuntu.localdomain (unknown [58.250.176.229])
        by mail-m176233.qiye.163.com (Hmail) with ESMTPA id 650D58C00A4;
        Thu, 22 Apr 2021 20:59:15 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: set prefree as free segments after clear prefree segments
Date:   Thu, 22 Apr 2021 20:59:10 +0800
Message-Id: <20210422125910.127871-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU9MGVYaT0pPGE4eH0IdGUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6KRw4Hz8VSw4cTwkhQhoU
        Ax5PFEtVSlVKTUpCS0JNSE5OQktJVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBSU1OSzcG
X-HM-Tid: 0a78f9a9c2f2d9abkuws650d58c00a4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, when do_checkpoint fails, the prefree bitmap is not cleared,
but these segments are already in the free state. If these segments
are used, the segments in use will be reset to the free state when
f2fs_clear_prefree_segments is called next time.

So move set_prefree_as_free_segments after clear_prefree_segments.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c2866561263e..ea1334e17a0d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1945,20 +1945,6 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi)
 		release_discard_addr(entry);
 }
 
-/*
- * Should call f2fs_clear_prefree_segments after checkpoint is done.
- */
-static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
-{
-	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned int segno;
-
-	mutex_lock(&dirty_i->seglist_lock);
-	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
-		__set_test_and_free(sbi, segno, false);
-	mutex_unlock(&dirty_i->seglist_lock);
-}
-
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 						struct cp_control *cpc)
 {
@@ -1993,6 +1979,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		for (i = start; i < end; i++) {
 			if (test_and_clear_bit(i, prefree_map))
 				dirty_i->nr_dirty[PRE]--;
+			__set_test_and_free(sbi, i, false);
 		}
 
 		if (!f2fs_realtime_discard_enable(sbi))
@@ -4188,8 +4175,6 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		cpc->trim_start = trim_start;
 	}
 	up_write(&sit_i->sentry_lock);
-
-	set_prefree_as_free_segments(sbi);
 }
 
 static int build_sit_info(struct f2fs_sb_info *sbi)
-- 
2.25.1

