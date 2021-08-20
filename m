Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1F3F362A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhHTVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:52:54 -0400
Received: from xppmailspam11.itap.purdue.edu ([128.210.1.215]:54618 "EHLO
        xppmailspam11.itap.purdue.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhHTVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:52:48 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 17:52:48 EDT
IronPort-SDR: KBJfo//jnLPko2SrkSQKskvNYd2Xr6KkJjhbFSoSG2K7gLn9cI8CZ6U4N0gCbH/tqhmUET6Ff4
 9y8fzENPTlY/j8k/w2ObU919As8S9JRts=
X-Ironport-AuthID: sishuai@purdue.edu
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2wWELql3R4+4WcdsCKwDKNp9C6jpDfJC3D?=
 =?us-ascii?q?Abv31ZSRFFG/FwWfrCoB1173DJYVoqM03I5+rvBEDoexq1yXcf2+Us1NmZNj?=
 =?us-ascii?q?UOwFHIEL1f?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,338,1620705600"; 
   d="scan'208";a="375256756"
Received: from switch-lwsn2133-z1r11.cs.purdue.edu (HELO rssys-server.cs.purdue.edu) ([128.10.127.250])
  by xppmailspam11.itap.purdue.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2021 17:45:01 -0400
From:   sishuaigong <sishuai@purdue.edu>
To:     jlbec@evilplan.org, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, sishuaigong <sishuai@purdue.edu>
Subject: [PATCH] configfs: fix a race in configfs_lookup()
Date:   Fri, 20 Aug 2021 17:44:58 -0400
Message-Id: <20210820214458.14087-1-sishuai@purdue.edu>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configfs_lookup() is executing list_for_each_entry(),
it is possible that configfs_dir_lseek() is calling list_del().
Some unfortunate interleavings of them can cause a kernel NULL
pointer dereference error

Thread 1                  Thread 2
//configfs_dir_lseek()    //configfs_lookup()
list_del(&cursor->s_sibling);
                          list_for_each_entry(sd, ...)

Fix this bug by using list_for_each_entry_safe() instead.

Reported-by: Sishuai Gong <sishuai@purdue.edu>
Signed-off-by: sishuaigong <sishuai@purdue.edu>
---
 fs/configfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..8f5d0309fb4a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -452,7 +452,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 				       unsigned int flags)
 {
 	struct configfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
-	struct configfs_dirent * sd;
+	struct configfs_dirent *sd, *tmp;
 	int found = 0;
 	int err;
 
@@ -468,7 +468,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
-	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
 
-- 
2.17.1

