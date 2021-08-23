Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982C93F5176
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHWToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:44:16 -0400
Received: from xppmailspam12.itap.purdue.edu ([128.210.1.216]:52757 "EHLO
        xppmailspam12.itap.purdue.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232130AbhHWToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:44:13 -0400
IronPort-SDR: Hg81Z3bVCqCnobwWtmOnYjpwrRQqVpsEV0ACK832sbHSz1MOfNVxaEZvnX9xnGwR8NyPTuKhYj
 XJozG+7vpPTwlf/8Aez9AeN7cQY2P7cD8=
X-Ironport-AuthID: sishuai@purdue.edu
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AnAa0Mqo5yPtCA4ODFkzEBOAaV5rjeYIsim?=
 =?us-ascii?q?QD101hICG9E/bo6vxG+c5x6faaslgssR0b9Oxoe5PhfZqkz+8S3WBJB8baYO?=
 =?us-ascii?q?CEggqVxeNZnPHfKlTbckWVygc679YaT0EUMrLN5DZB4foSrzPIcOoI8Z2r/K?=
 =?us-ascii?q?WpmuvE3x5WPGRXg8YJ1XYANu83KDwTeOADP+tfKLOMos5KvSCpd3g0YtTTPA?=
 =?us-ascii?q?hmY9T+?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,344,1620705600"; 
   d="scan'208";a="374995347"
Received: from switch-lwsn2133-z1r11.cs.purdue.edu (HELO rssys-server.cs.purdue.edu) ([128.10.127.250])
  by xppmailspam12.itap.purdue.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Aug 2021 15:43:30 -0400
From:   sishuaigong <sishuai@purdue.edu>
To:     jlbec@evilplan.org, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, sishuaigong <sishuai@purdue.edu>
Subject: [PATCH v2] configfs: fix a race in configfs_lookup()
Date:   Mon, 23 Aug 2021 15:43:18 -0400
Message-Id: <20210823194318.17528-1-sishuai@purdue.edu>
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

Fix this bug by grabbing configfs_dirent_lock in configfs_lookup().

Reported-by: Sishuai Gong <sishuai@purdue.edu>
Signed-off-by: sishuaigong <sishuai@purdue.edu>
---
 fs/configfs/dir.c | 86 +++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..c9af54f75051 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -417,44 +417,13 @@ static void configfs_remove_dir(struct config_item * item)
 	dput(dentry);
 }
 
-
-/* attaches attribute's configfs_dirent to the dentry corresponding to the
- * attribute file
- */
-static int configfs_attach_attr(struct configfs_dirent * sd, struct dentry * dentry)
-{
-	struct configfs_attribute * attr = sd->s_element;
-	struct inode *inode;
-
-	spin_lock(&configfs_dirent_lock);
-	dentry->d_fsdata = configfs_get(sd);
-	sd->s_dentry = dentry;
-	spin_unlock(&configfs_dirent_lock);
-
-	inode = configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG);
-	if (IS_ERR(inode)) {
-		configfs_put(sd);
-		return PTR_ERR(inode);
-	}
-	if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
-		inode->i_size = 0;
-		inode->i_fop = &configfs_bin_file_operations;
-	} else {
-		inode->i_size = PAGE_SIZE;
-		inode->i_fop = &configfs_file_operations;
-	}
-	d_add(dentry, inode);
-	return 0;
-}
-
 static struct dentry * configfs_lookup(struct inode *dir,
 				       struct dentry *dentry,
 				       unsigned int flags)
 {
 	struct configfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
 	struct configfs_dirent * sd;
-	int found = 0;
-	int err;
+	struct inode *inode = NULL;
 
 	/*
 	 * Fake invisibility if dir belongs to a group/default groups hierarchy
@@ -464,38 +433,53 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	 * not complete their initialization, since the dentries of the
 	 * attributes won't be instantiated.
 	 */
-	err = -ENOENT;
 	if (!configfs_dirent_is_ready(parent_sd))
-		goto out;
+		return ERR_PTR(-ENOENT);
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
-			const unsigned char * name = configfs_get_name(sd);
-
+			const unsigned char *name = configfs_get_name(sd);
 			if (strcmp(name, dentry->d_name.name))
 				continue;
 
-			found = 1;
-			err = configfs_attach_attr(sd, dentry);
-			break;
-		}
-	}
+			struct configfs_attribute *attr = sd->s_element;
+			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 
-	if (!found) {
-		/*
-		 * If it doesn't exist and it isn't a NOT_PINNED item,
-		 * it must be negative.
-		 */
-		if (dentry->d_name.len > NAME_MAX)
-			return ERR_PTR(-ENAMETOOLONG);
-		d_add(dentry, NULL);
-		return NULL;
+			dentry->d_fsdata = configfs_get(sd);
+			sd->s_dentry = dentry;
+
+			spin_unlock(&configfs_dirent_lock);
+
+			inode = configfs_create(dentry, mode);
+			if (IS_ERR(inode)) {
+				configfs_put(sd);
+				return ERR_CAST(inode);
+			}
+			if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
+				inode->i_size = 0;
+				inode->i_fop = &configfs_bin_file_operations;
+			} else {
+				inode->i_size = PAGE_SIZE;
+				inode->i_fop = &configfs_file_operations;
+			}
+			goto out;
+		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
+	/*
+	 * If it doesn't exist and it isn't a NOT_PINNED item,
+	 * it must be negative.
+	 */
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
 out:
-	return ERR_PTR(err);
+	d_add(dentry, inode);
+	return NULL;
 }
 
+
 /*
  * Only subdirectories count here.  Files (CONFIGFS_NOT_PINNED) are
  * attributes and are removed by rmdir().  We recurse, setting
-- 
2.17.1

