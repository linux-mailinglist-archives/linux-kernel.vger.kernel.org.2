Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3425F410FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhITHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:07:30 -0400
Received: from mail.thorsis.com ([92.198.35.195]:51632 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhITHH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:07:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 5AE5FCEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:06:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h3a6R7oaEhzF for <linux-kernel@vger.kernel.org>;
        Mon, 20 Sep 2021 09:06:01 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 3BB461AB8; Mon, 20 Sep 2021 09:06:01 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: thorsis.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Received: from adahl by ada.ifak-system.com with local (Exim 4.92)
        (envelope-from <ada@thorsis.com>)
        id 1mSDND-0001hB-VT; Mon, 20 Sep 2021 09:05:55 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: Fix spelling mistakes
Date:   Mon, 20 Sep 2021 09:05:55 +0200
Message-Id: <20210920070555.6474-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with `codespell -i 3 -w fs/ubifs/**` and proof reading that parts.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 fs/ubifs/dir.c    | 4 ++--
 fs/ubifs/replay.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 7c61d0ec0159..dbe72f664abf 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1207,7 +1207,7 @@ static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
  * @inode1: first inode
  * @inode2: second inode
  * @inode3: third inode
- * @inode4: fouth inode
+ * @inode4: fourth inode
  *
  * This function is used for 'ubifs_rename()' and @inode1 may be the same as
  * @inode2 whereas @inode3 and @inode4 may be %NULL.
@@ -1233,7 +1233,7 @@ static void lock_4_inodes(struct inode *inode1, struct inode *inode2,
  * @inode1: first inode
  * @inode2: second inode
  * @inode3: third inode
- * @inode4: fouth inode
+ * @inode4: fourth inode
  */
 static void unlock_4_inodes(struct inode *inode1, struct inode *inode2,
 			    struct inode *inode3, struct inode *inode4)
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 5260d3e531bb..4211e4456b1e 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -106,7 +106,7 @@ static int set_bud_lprops(struct ubifs_info *c, struct bud_entry *b)
 		 * property values should be @lp->free == @c->leb_size and
 		 * @lp->dirty == 0, but that is not the case. The reason is that
 		 * the LEB had been garbage collected before it became the bud,
-		 * and there was not commit inbetween. The garbage collector
+		 * and there was no commit in between. The garbage collector
 		 * resets the free and dirty space without recording it
 		 * anywhere except lprops, so if there was no commit then
 		 * lprops does not have that information.

base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.30.2

