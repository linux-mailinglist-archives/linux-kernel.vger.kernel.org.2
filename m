Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF13768D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhEGQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:33:27 -0400
Received: from p3plsmtp18-04-2.prod.phx3.secureserver.net ([173.201.193.188]:42154
        "EHLO p3plwbeout18-04.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238212AbhEGQdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:33:24 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 12:33:24 EDT
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id f3HClA8MoYVy3f3HDlTMr6; Fri, 07 May 2021 09:24:31 -0700
X-CMAE-Analysis: v=2.4 cv=dv8et3s4 c=1 sm=1 tr=0 ts=609569bf
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=5FLXtPjwQuUA:10 a=FXvPX3liAAAA:8 a=hSkVLCK3AAAA:8
 a=VwQbUJbxAAAA:8 a=mRSd3HlHm2GdjYksQScA:9 a=UObqyxdv-6Yh2QiB9mM_:22
 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  f3HClA8MoYVy3
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp05.mailcore.me with esmtpa (Exim 4.92.3)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1lf3HB-0003rf-Sg; Fri, 07 May 2021 17:24:30 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] squashfs: fix divide error in calculate_skip()
Date:   Fri,  7 May 2021 16:26:18 +0100
Message-Id: <20210507152618.9447-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-122-reg-Authenticated: 439999529
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfKDegQQ4GkAAUAUcaUUEz458Vib1J34Pqok97818qdu5N9POvuo3qbZFxbbiEELlF88QTPll/BoHYl1I+KYuCxyZgqLMr4dbxbfNklEmuVFXUVa3HR2f
 qQzf/QwJqM/BvPC0zrHAY29pvvgWjvyIGNp8iUnh6r6y4zwZjY86N57resL4Lb9DCByuq5v2LkpRwYvl3aV2rFZPXYeKiVz3z24=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysbot has reported a "divide error" which has been
identified as being caused by a corrupted file_size
value within the file inode.  This value has been
corrupted to a much larger value than expected.

Calculate_skip() is passed i_size_read(inode) >> msblk->block_log.
Due to the file_size value corruption this overflows
the int argument/variable in that function, leading
to the divide error.

This patch changes the function to use u64.  This will
accommodate any unexpectedly large values due to
corruption.

The value returned from calculate_skip() is clamped to
be never more than SQUASHFS_CACHED_BLKS - 1, or 7.
So file_size corruption does not lead to an unexpectedly
large return result here.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+e8f781243ce16ac2f962@syzkaller.appspotmail.com
Reported-by: syzbot+7b98870d4fec9447b951@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
---
 fs/squashfs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 7b1128398976..89d492916dea 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -211,11 +211,11 @@ static long long read_indexes(struct super_block *sb, int n,
  * If the skip factor is limited in this way then the file will use multiple
  * slots.
  */
-static inline int calculate_skip(int blocks)
+static inline int calculate_skip(u64 blocks)
 {
-	int skip = blocks / ((SQUASHFS_META_ENTRIES + 1)
+	u64 skip = blocks / ((SQUASHFS_META_ENTRIES + 1)
 		 * SQUASHFS_META_INDEXES);
-	return min(SQUASHFS_CACHED_BLKS - 1, skip + 1);
+	return min((u64) SQUASHFS_CACHED_BLKS - 1, skip + 1);
 }
 
 
-- 
2.31.1

