Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3143F4F03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhHWRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:09:34 -0400
Received: from verein.lst.de ([213.95.11.211]:48564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhHWRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:09:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A35B67357; Mon, 23 Aug 2021 19:08:48 +0200 (CEST)
Date:   Mon, 23 Aug 2021 19:08:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <20210823170847.GA617@lst.de>
References: <20210820214458.14087-1-sishuai@purdue.edu> <20210823074636.GA23822@lst.de> <AFABA8B1-0523-4F8C-A9DD-DDC5638DEAF7@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFABA8B1-0523-4F8C-A9DD-DDC5638DEAF7@purdue.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:12:10PM +0000, Gong, Sishuai wrote:
> On Aug 23, 2021, at 3:46 AM, Christoph Hellwig <hch@lst.de<mailto:hch@lst.de>> wrote:
> 
> On Fri, Aug 20, 2021 at 05:44:58PM -0400, sishuaigong wrote:
> When configfs_lookup() is executing list_for_each_entry(),
> it is possible that configfs_dir_lseek() is calling list_del().
> Some unfortunate interleavings of them can cause a kernel NULL
> pointer dereference error
> 
> Thread 1                  Thread 2
> //configfs_dir_lseek()    //configfs_lookup()
> list_del(&cursor->s_sibling);
>                          list_for_each_entry(sd, ...)
> 
> Fix this bug by using list_for_each_entry_safe() instead.
> 
> I don't see how list_for_each_entry_safe would save you there.
> You need a lock to sychronize the two, list_for_each_entry_safe
> only ensures the next entry is looked up before iterating over
> the current one.
> Thanks for pointing that out!
> 
> It looks like config_lookup() should hold configfs_dirent_lock
> when doing list_for_each_entry(), but configfs_attach_attr()
> also needs to be changed since it might be called by
> config_lookup() and then wait for configfs_dirent_lock,
> which will cause a deadlock.
> 
> Do you think a future patch like this makes sense?

We can't hold a spinlock over inode allocation.  So it would have to be
something like this:

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..48022e27664d 100644
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
-	struct configfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
-	struct configfs_dirent * sd;
-	int found = 0;
-	int err;
+	struct configfs_dirent *parent_sd = dentry->d_parent->d_fsdata;
+	struct configfs_dirent *sd;
+	struct inode *inode = NULL;
 
 	/*
 	 * Fake invisibility if dir belongs to a group/default groups hierarchy
@@ -464,36 +433,46 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	 * not complete their initialization, since the dentries of the
 	 * attributes won't be instantiated.
 	 */
-	err = -ENOENT;
 	if (!configfs_dirent_is_ready(parent_sd))
-		goto out;
+		return ERR_PTR(-ENOENT);
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (sd->s_type & CONFIGFS_NOT_PINNED) {
-			const unsigned char * name = configfs_get_name(sd);
+		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
+		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
+		    	struct configfs_attribute *attr = sd->s_element;
+			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 
-			if (strcmp(name, dentry->d_name.name))
-				continue;
+			dentry->d_fsdata = configfs_get(sd);
+			sd->s_dentry = dentry;
+			spin_unlock(&configfs_dirent_lock);
 
-			found = 1;
-			err = configfs_attach_attr(sd, dentry);
-			break;
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
+			goto done;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
-	if (!found) {
-		/*
-		 * If it doesn't exist and it isn't a NOT_PINNED item,
-		 * it must be negative.
-		 */
-		if (dentry->d_name.len > NAME_MAX)
-			return ERR_PTR(-ENAMETOOLONG);
-		d_add(dentry, NULL);
-		return NULL;
-	}
-
-out:
-	return ERR_PTR(err);
+	/*
+	 * If it doesn't exist and it isn't a NOT_PINNED item, it must be
+	 * negative.
+	 */
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+done:
+	d_add(dentry, inode);
+	return NULL;
 }
 
 /*
