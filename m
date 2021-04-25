Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7336A44D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhDYCyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 22:54:17 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:16260 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYCyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 22:54:16 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2021 22:54:16 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 38CE68001DD;
        Sun, 25 Apr 2021 10:45:41 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ntfs: Remove repeated uptodate check for buffer
Date:   Sun, 25 Apr 2021 10:45:33 +0800
Message-Id: <20210425024533.12540-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0tDS1YeTUNCGUMdHk8aSR9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6CRw*Hz8VOAMcTz8fND0y
        DjEwCwhVSlVKTUpCSEpDTE9KTEhJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTEtONwY+
X-HM-Tid: 0a7906eb1977b03akuuu38ce68001dd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 60f91826ca62 ("buffer: Avoid setting buffer bits that are already set"),
function set_buffer_##name was added a test_bit() to check buffer,
which is the same as function buffer_##name.
The !buffer_uptodate(bh) here is a repeated check. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/ntfs/logfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index bc1bf217b38e..9695540ce581 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -796,8 +796,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 			get_bh(bh);
 			/* Set the entire contents of the buffer to 0xff. */
 			memset(bh->b_data, -1, block_size);
-			if (!buffer_uptodate(bh))
-				set_buffer_uptodate(bh);
+			set_buffer_uptodate(bh);
 			if (buffer_dirty(bh))
 				clear_buffer_dirty(bh);
 			/*
-- 
2.25.1

