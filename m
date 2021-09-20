Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9E411405
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhITMNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhITMNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DECA760F50;
        Mon, 20 Sep 2021 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632139938;
        bh=nzt73uefio2OAcopLpAYc2RbWIrjwpkcYn0/qlrcaSo=;
        h=From:To:Cc:Subject:Date:From;
        b=ehs0nfWlz0oj+qxGtys9lkGUkwM3BEQyE1w6kGkIrlk0RyNext5oQyQoNle05MfVh
         jTVNMsstJXCC9IEY9fNHRp+gmmNcR4t0mz+ThBwbarp0i9rjqnVO2JivQwbyYnhar4
         SQI9HMVGH3w9fBpgtdIRKLAhy6F9zEkSMDO5659D/yIXPkKo7uUQN4IFH1z4fK4zgK
         Nzpr2ebuA+ikUUn6zWcoRNPnc4wl2jPcqVNYlbyLPW8y5PscuQSL5WdAapqNBz1ygl
         62nVvBctdviNE205UejVk0HU1vs30O4PH8EAhGsOB0kr8nNLnykBfUUo1HS+otJSUl
         ml1ZYCJsEpvFA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
Date:   Mon, 20 Sep 2021 14:12:02 +0200
Message-Id: <20210920121208.54732-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is still a gcc-11 warning about stringop-overread in some
configurations, despite the earlier fix that was meant to address
this issue:

fs/qnx4/dir.c: In function 'qnx4_readdir':
fs/qnx4/dir.c:76:32: error: 'strnlen' specified bound [16, 48] exceeds source size 1 [-Werror=stringop-overread]
   76 |                         size = strnlen(name, size);
      |                                ^~~~~~~~~~~~~~~~~~~
fs/qnx4/dir.c:26:22: note: source object declared here
   26 |                 char de_name;
      |                      ^~~~~~~

The problem here is that we access the same pointer using two different
structure layouts, but gcc determines the object size based on
whatever it encounters first, in this case, the single-byte field.

Rework the union once more, to have a flexible-array member as the
thing that gets accessed first to deal with current gcc versions, but
leave everything else in place so that a future fixed compiler will
correctly see the struct member sizes.

Unfortunately, this makes the code really ugly again. In my original
patch, I just changed the if (!de->de_name) check to access the longer
of the two fields, which worked. Another option would be to make
de_name a longer array.

Fixes: b7213ffa0e58 ("qnx4: avoid stringop-overread errors")
Link: https://lore.kernel.org/all/20210322160253.4032422-6-arnd@kernel.org/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rebase on top of the earlier patch.
---
 fs/qnx4/dir.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index 2a66844b7ff8..d7eb5a9b79e4 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -23,8 +23,16 @@
  */
 union qnx4_directory_entry {
 	struct {
-		char de_name;
-		char de_pad[62];
+		/*
+		 * work around gcc-11.x using the first field it observes
+		 * to determing the actual length
+		 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
+		 */
+		char __empty[0];
+		char de_name[];
+	};
+	struct {
+		char de_pad[63];
 		char de_status;
 	};
 	struct qnx4_inode_entry inode;
@@ -58,7 +66,7 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 			offset = ix * QNX4_DIR_ENTRY_SIZE;
 			de = (union qnx4_directory_entry *) (bh->b_data + offset);
 
-			if (!de->de_name)
+			if (!de->de_name[0])
 				continue;
 			if (!(de->de_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
 				continue;
-- 
2.29.2

