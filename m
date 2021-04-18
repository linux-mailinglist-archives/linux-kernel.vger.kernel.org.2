Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916A73632E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 02:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhDRAvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhDRAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 20:51:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BAC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 17:50:34 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXvdo-006B5x-7a; Sun, 18 Apr 2021 00:50:24 +0000
Date:   Sun, 18 Apr 2021 00:50:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Message-ID: <YHuCUGVX0b7VYiiM@zeniv-ca.linux.org.uk>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
 <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
 <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
 <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk>
 <YHtFciNvBWYJ0ku2@zeniv-ca.linux.org.uk>
 <YHtGhqBXhWlUHHRm@zeniv-ca.linux.org.uk>
 <CAHk-=wi+8sz1kjpVnZ_MNbX0YNzGBXTTu4UyiR+1RWrFdbJ7Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+8sz1kjpVnZ_MNbX0YNzGBXTTu4UyiR+1RWrFdbJ7Hw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 03:11:49PM -0700, Linus Torvalds wrote:
> On Sat, Apr 17, 2021 at 1:35 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > No, wait - we have non-NULL buf->prev_reclen, so we'll hit
> > with buf->error completely ignored.  Nevermind.
> 
> Yeah, I'm pretty sure I even tested that -EINTR case at one point.
> 
> Of course, it could easily have gotten broken again, so that's not a
> strong argument.
> 
> That said, the "buf->err" handling has always been very confusing, and
> it would be lovely to get rid of that confusion.
> 
> I don't remember why we did it that way, but I think it's because
> low-level filesystems ended up changing the error that the filldir()
> function returned or something like that.

Propagating errors from e.g. filldir() out through ->iterate() instances 
turns out to be painful.  If anything, considering that there's a lot
more ->iterate/->iterate_shared instances that ->actor ones, it would
make sense to change the calling conventions for the latter.  IOW,
stop pretending that they return an error value and just have them
return a bool: "should the caller keep going".

Here's what I've got sitting in a local branch; not sure if it would
be better to invert the rules, though - I went for "should we keep
going", but we could do "should we stop" instead.

Change calling conventions for filldir_t

filldir_t instances (directory iterators callbacks) used to return 0 for
"OK, keep going" or -E... for "stop".  Note that it's *NOT* how the
error values are reported - the rules for those are callback-dependent
and ->iterate{,_shared}() instances only care about zero vs. non-zero
(look at emit_dir() and friends).

So let's just return bool - it's less confusing that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 0302035781be..268c2ac616d1 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -890,3 +890,14 @@ been called or returned with non -EIOCBQUEUED code.
 
 mnt_want_write_file() can now only be paired with mnt_drop_write_file(),
 whereas previously it could be paired with mnt_drop_write() as well.
+
+---
+
+*mandatory*
+
+filldir_t (readdir callbacks) calling conventions have changed.  Instead of
+returning 0 or -E... it returns bool now.  true means "keep going" (as 0 used
+to to) and false - "no more" (as -E... in old calling conventions).  Rationale:
+callers never looked at specific -E... values anyway.  ->iterate() and
+->iterate_shared() instance require no changes at all, all filldir_t ones in
+the tree converted.
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5367a1c6300..6864794b663a 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -107,7 +107,7 @@ struct osf_dirent_callback {
 	int error;
 };
 
-static int
+static bool
 osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 	    loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -119,11 +119,11 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
-		return -EINVAL;
+		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->error = -EOVERFLOW;
-		return -EOVERFLOW;
+		return false;
 	}
 	if (buf->basep) {
 		if (put_user(offset, buf->basep))
@@ -140,10 +140,10 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 	dirent = (void __user *)dirent + reclen;
 	buf->dirent = dirent;
 	buf->count -= reclen;
-	return 0;
+	return true;
 Efault:
 	buf->error = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 714fcca9af99..aa3bdf389d47 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -24,9 +24,9 @@ static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
 static void afs_d_iput(struct dentry *dentry, struct inode *inode);
-static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
+static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
 				  loff_t fpos, u64 ino, unsigned dtype);
-static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
+static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
 			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl);
@@ -527,7 +527,7 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
  * - if afs_dir_iterate_block() spots this function, it'll pass the FID
  *   uniquifier through dtype
  */
-static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
+static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
 				  int nlen, loff_t fpos, u64 ino, unsigned dtype)
 {
 	struct afs_lookup_one_cookie *cookie =
@@ -543,16 +543,16 @@ static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
 
 	if (cookie->name.len != nlen ||
 	    memcmp(cookie->name.name, name, nlen) != 0) {
-		_leave(" = 0 [no]");
-		return 0;
+		_leave(" = true [keep looking]");
+		return true;
 	}
 
 	cookie->fid.vnode = ino;
 	cookie->fid.unique = dtype;
 	cookie->found = 1;
 
-	_leave(" = -1 [found]");
-	return -1;
+	_leave(" = false [found]");
+	return false;
 }
 
 /*
@@ -596,12 +596,11 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
  * - if afs_dir_iterate_block() spots this function, it'll pass the FID
  *   uniquifier through dtype
  */
-static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
+static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
 			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
 {
 	struct afs_lookup_cookie *cookie =
 		container_of(ctx, struct afs_lookup_cookie, ctx);
-	int ret;
 
 	_enter("{%s,%u},%s,%u,,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
@@ -623,12 +622,10 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
 		cookie->fids[1].unique	= dtype;
 		cookie->found = 1;
 		if (cookie->one_only)
-			return -1;
+			return false;
 	}
 
-	ret = cookie->nr_fids >= 50 ? -1 : 0;
-	_leave(" = %d", ret);
-	return ret;
+	return cookie->nr_fids < 50;
 }
 
 /*
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5fb45d865ce5..a06810fc2bc8 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -53,7 +53,7 @@ struct ecryptfs_getdents_callback {
 };
 
 /* Inspired by generic filldir in fs/readdir.c */
-static int
+static bool
 ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
 		 int lower_namelen, loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -61,18 +61,19 @@ ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
 		container_of(ctx, struct ecryptfs_getdents_callback, ctx);
 	size_t name_size;
 	char *name;
-	int rc;
+	int err;
+	bool res;
 
 	buf->filldir_called++;
-	rc = ecryptfs_decode_and_decrypt_filename(&name, &name_size,
-						  buf->sb, lower_name,
-						  lower_namelen);
-	if (rc) {
-		if (rc != -EINVAL) {
+	err = ecryptfs_decode_and_decrypt_filename(&name, &name_size,
+						   buf->sb, lower_name,
+						   lower_namelen);
+	if (err) {
+		if (err != -EINVAL) {
 			ecryptfs_printk(KERN_DEBUG,
 					"%s: Error attempting to decode and decrypt filename [%s]; rc = [%d]\n",
-					__func__, lower_name, rc);
-			return rc;
+					__func__, lower_name, err);
+			return false;
 		}
 
 		/* Mask -EINVAL errors as these are most likely due a plaintext
@@ -81,16 +82,15 @@ ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
 		 * the "lost+found" dentry in the root directory of an Ext4
 		 * filesystem.
 		 */
-		return 0;
+		return true;
 	}
 
 	buf->caller->pos = buf->ctx.pos;
-	rc = !dir_emit(buf->caller, name, name_size, ino, d_type);
+	res = dir_emit(buf->caller, name, name_size, ino, d_type);
 	kfree(name);
-	if (!rc)
+	if (res)
 		buf->entries_written++;
-
-	return rc;
+	return res;
 }
 
 /**
@@ -111,14 +111,8 @@ static int ecryptfs_readdir(struct file *file, struct dir_context *ctx)
 	lower_file = ecryptfs_file_to_lower(file);
 	rc = iterate_dir(lower_file, &buf.ctx);
 	ctx->pos = buf.ctx.pos;
-	if (rc < 0)
-		goto out;
-	if (buf.filldir_called && !buf.entries_written)
-		goto out;
-	if (rc >= 0)
-		fsstack_copy_attr_atime(inode,
-					file_inode(lower_file));
-out:
+	if (rc >= 0 && (buf.entries_written || !buf.filldir_called))
+		fsstack_copy_attr_atime(inode, file_inode(lower_file));
 	return rc;
 }
 
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0106eba46d5a..88096d842d31 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -248,21 +248,20 @@ struct getdents_callback {
  * A rather strange filldir function to capture
  * the name matching the specified inode number.
  */
-static int filldir_one(struct dir_context *ctx, const char *name, int len,
+static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 			loff_t pos, u64 ino, unsigned int d_type)
 {
 	struct getdents_callback *buf =
 		container_of(ctx, struct getdents_callback, ctx);
-	int result = 0;
 
 	buf->sequence++;
 	if (buf->ino == ino && len <= NAME_MAX) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;
-		result = -1;
+		return false;	// no more
 	}
-	return result;
+	return true;
 }
 
 /**
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c4a274285858..f4366dc59f0e 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -705,7 +705,7 @@ static int fat_readdir(struct file *file, struct dir_context *ctx)
 }
 
 #define FAT_IOCTL_FILLDIR_FUNC(func, dirent_type)			   \
-static int func(struct dir_context *ctx, const char *name, int name_len,   \
+static bool func(struct dir_context *ctx, const char *name, int name_len,  \
 			     loff_t offset, u64 ino, unsigned int d_type)  \
 {									   \
 	struct fat_ioctl_filldir_callback *buf =			   \
@@ -714,7 +714,7 @@ static int func(struct dir_context *ctx, const char *name, int name_len,   \
 	struct dirent_type __user *d2 = d1 + 1;				   \
 									   \
 	if (buf->result)						   \
-		return -EINVAL;						   \
+		return false;						   \
 	buf->result++;							   \
 									   \
 	if (name != NULL) {						   \
@@ -750,10 +750,10 @@ static int func(struct dir_context *ctx, const char *name, int name_len,   \
 		    put_user(short_len, &d1->d_reclen))			   \
 			goto efault;					   \
 	}								   \
-	return 0;							   \
+	return true;							   \
 efault:									   \
 	buf->result = -EFAULT;						   \
-	return -EFAULT;							   \
+	return false;							   \
 }
 
 FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 756d05779200..f55d083f6709 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -66,7 +66,7 @@ struct get_name_filldir {
 	char *name;
 };
 
-static int get_name_filldir(struct dir_context *ctx, const char *name,
+static bool get_name_filldir(struct dir_context *ctx, const char *name,
 			    int length, loff_t offset, u64 inum,
 			    unsigned int type)
 {
@@ -74,12 +74,12 @@ static int get_name_filldir(struct dir_context *ctx, const char *name,
 		container_of(ctx, struct get_name_filldir, ctx);
 
 	if (inum != gnfd->inum.no_addr)
-		return 0;
+		return true;
 
 	memcpy(gnfd->name, name, length);
 	gnfd->name[length] = 0;
 
-	return 1;
+	return false;	// no more
 }
 
 static int gfs2_get_name(struct dentry *parent, char *name,
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 891395c6c7d3..1c54cd62ee49 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -266,7 +266,7 @@ struct nfs4_dir_ctx {
 	struct list_head names;
 };
 
-static int
+static bool
 nfsd4_build_namelist(struct dir_context *__ctx, const char *name, int namlen,
 		loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -275,14 +275,14 @@ nfsd4_build_namelist(struct dir_context *__ctx, const char *name, int namlen,
 	struct name_list *entry;
 
 	if (namlen != HEXDIR_LEN - 1)
-		return 0;
+		return true;
 	entry = kmalloc(sizeof(struct name_list), GFP_KERNEL);
 	if (entry == NULL)
-		return -ENOMEM;
+		return false;
 	memcpy(entry->name, name, HEXDIR_LEN - 1);
 	entry->name[HEXDIR_LEN - 1] = '\0';
 	list_add(&entry->list, &ctx->names);
-	return 0;
+	return true;
 }
 
 static int
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fd6be35a1642..6cde3be4fbfa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1943,7 +1943,7 @@ struct readdir_data {
 	int		full;
 };
 
-static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
+static bool nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
 				 int namlen, loff_t offset, u64 ino,
 				 unsigned int d_type)
 {
@@ -1955,7 +1955,7 @@ static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
 	reclen = ALIGN(sizeof(struct buffered_dirent) + namlen, sizeof(u64));
 	if (buf->used + reclen > PAGE_SIZE) {
 		buf->full = 1;
-		return -EINVAL;
+		return false;
 	}
 
 	de->namlen = namlen;
@@ -1965,7 +1965,7 @@ static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
 	memcpy(de->name, name, namlen);
 	buf->used += reclen;
 
-	return 0;
+	return true;
 }
 
 static __be32 nfsd_buffered_readdir(struct file *file, nfsd_filldir_t func,
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index bdfba9db558a..ec7854390dc6 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -2034,7 +2034,7 @@ struct ocfs2_empty_dir_priv {
 	unsigned seen_other;
 	unsigned dx_dir;
 };
-static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
+static bool ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
 				   int name_len, loff_t pos, u64 ino,
 				   unsigned type)
 {
@@ -2054,7 +2054,7 @@ static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
 	 */
 	if (name_len == 1 && !strncmp(".", name, 1) && pos == 0) {
 		p->seen_dot = 1;
-		return 0;
+		return true;
 	}
 
 	if (name_len == 2 && !strncmp("..", name, 2) &&
@@ -2062,13 +2062,13 @@ static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
 		p->seen_dot_dot = 1;
 
 		if (p->dx_dir && p->seen_dot)
-			return 1;
+			return false;
 
-		return 0;
+		return true;
 	}
 
 	p->seen_other = 1;
-	return 1;
+	return false;
 }
 
 static int ocfs2_empty_dir_dx(struct inode *inode,
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index db52e843002a..0c9fd036f4ab 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -2035,7 +2035,7 @@ struct ocfs2_orphan_filldir_priv {
 	enum ocfs2_orphan_reco_type orphan_reco_type;
 };
 
-static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
+static bool ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
 				int name_len, loff_t pos, u64 ino,
 				unsigned type)
 {
@@ -2044,21 +2044,21 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
 	struct inode *iter;
 
 	if (name_len == 1 && !strncmp(".", name, 1))
-		return 0;
+		return true;
 	if (name_len == 2 && !strncmp("..", name, 2))
-		return 0;
+		return true;
 
 	/* do not include dio entry in case of orphan scan */
 	if ((p->orphan_reco_type == ORPHAN_NO_NEED_TRUNCATE) &&
 			(!strncmp(name, OCFS2_DIO_ORPHAN_PREFIX,
 			OCFS2_DIO_ORPHAN_PREFIX_LEN)))
-		return 0;
+		return true;
 
 	/* Skip bad inodes so that recovery can continue */
 	iter = ocfs2_iget(p->osb, ino,
 			  OCFS2_FI_FLAG_ORPHAN_RECOVERY, 0);
 	if (IS_ERR(iter))
-		return 0;
+		return true;
 
 	if (!strncmp(name, OCFS2_DIO_ORPHAN_PREFIX,
 			OCFS2_DIO_ORPHAN_PREFIX_LEN))
@@ -2068,7 +2068,7 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
 	 * happen concurrently with unlink/rename */
 	if (OCFS2_I(iter)->ip_next_orphan) {
 		iput(iter);
-		return 0;
+		return true;
 	}
 
 	trace_ocfs2_orphan_filldir((unsigned long long)OCFS2_I(iter)->ip_blkno);
@@ -2077,7 +2077,7 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
 	OCFS2_I(iter)->ip_next_orphan = p->head;
 	p->head = iter;
 
-	return 0;
+	return true;
 }
 
 static int ocfs2_queue_orphans(struct ocfs2_super *osb,
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index f404a78e6b60..abe6d8cc1b0d 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -170,7 +170,7 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	return p;
 }
 
-static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
+static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
 				  const char *name, int len, u64 ino,
 				  unsigned int d_type)
 {
@@ -179,22 +179,22 @@ static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
 	struct ovl_cache_entry *p;
 
 	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
-		return 0;
+		return true;
 
 	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
-		return -ENOMEM;
+		return false;
 	}
 
 	list_add_tail(&p->l_node, rdd->list);
 	rb_link_node(&p->node, parent, newp);
 	rb_insert_color(&p->node, rdd->root);
 
-	return 0;
+	return true;
 }
 
-static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
+static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
 			   const char *name, int namelen,
 			   loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -211,7 +211,7 @@ static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
 			list_add_tail(&p->l_node, &rdd->middle);
 	}
 
-	return rdd->err;
+	return rdd->err == 0;
 }
 
 void ovl_cache_free(struct list_head *list)
@@ -250,7 +250,7 @@ static void ovl_cache_put(struct ovl_dir_file *od, struct dentry *dentry)
 	}
 }
 
-static int ovl_fill_merge(struct dir_context *ctx, const char *name,
+static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 			  int namelen, loff_t offset, u64 ino,
 			  unsigned int d_type)
 {
@@ -538,7 +538,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 	goto out;
 }
 
-static int ovl_fill_plain(struct dir_context *ctx, const char *name,
+static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 			  int namelen, loff_t offset, u64 ino,
 			  unsigned int d_type)
 {
@@ -550,11 +550,11 @@ static int ovl_fill_plain(struct dir_context *ctx, const char *name,
 	p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
 	if (p == NULL) {
 		rdd->err = -ENOMEM;
-		return -ENOMEM;
+		return false;
 	}
 	list_add_tail(&p->l_node, rdd->list);
 
-	return 0;
+	return true;
 }
 
 static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
@@ -658,7 +658,7 @@ struct ovl_readdir_translate {
 	bool xinowarn;
 };
 
-static int ovl_fill_real(struct dir_context *ctx, const char *name,
+static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 			   int namelen, loff_t offset, u64 ino,
 			   unsigned int d_type)
 {
@@ -1037,7 +1037,7 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 	inode_unlock(upper->d_inode);
 }
 
-static int ovl_check_d_type(struct dir_context *ctx, const char *name,
+static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
 			  int namelen, loff_t offset, u64 ino,
 			  unsigned int d_type)
 {
@@ -1046,12 +1046,12 @@ static int ovl_check_d_type(struct dir_context *ctx, const char *name,
 
 	/* Even if d_type is not supported, DT_DIR is returned for . and .. */
 	if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen))
-		return 0;
+		return true;
 
 	if (d_type != DT_UNKNOWN)
 		rdd->d_type_supported = true;
 
-	return 0;
+	return true;
 }
 
 /*
diff --git a/fs/readdir.c b/fs/readdir.c
index 19434b3c982c..d5ef78273076 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -140,7 +140,7 @@ struct readdir_callback {
 	int result;
 };
 
-static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
+static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 		      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct readdir_callback *buf =
@@ -149,11 +149,11 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	unsigned long d_ino;
 
 	if (buf->result)
-		return -EINVAL;
+		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
-		return -EOVERFLOW;
+		return false;
 	}
 	buf->result++;
 	dirent = buf->dirent;
@@ -166,12 +166,12 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
 	user_write_access_end();
-	return 0;
+	return true;
 efault_end:
 	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
@@ -216,7 +216,7 @@ struct getdents_callback {
 	int error;
 };
 
-static int filldir(struct dir_context *ctx, const char *name, int namlen,
+static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 		   loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct linux_dirent __user *dirent, *prev;
@@ -229,18 +229,18 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
-		return buf->error;
+		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
-		return -EINVAL;
+		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->error = -EOVERFLOW;
-		return -EOVERFLOW;
+		return false;
 	}
 	prev_reclen = buf->prev_reclen;
 	if (prev_reclen && signal_pending(current))
-		return -EINTR;
+		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
@@ -257,12 +257,12 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
 	buf->count -= reclen;
-	return 0;
+	return true;
 efault_end:
 	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 SYSCALL_DEFINE3(getdents, unsigned int, fd,
@@ -304,7 +304,7 @@ struct getdents_callback64 {
 	int error;
 };
 
-static int filldir64(struct dir_context *ctx, const char *name, int namlen,
+static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 		     loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct linux_dirent64 __user *dirent, *prev;
@@ -316,13 +316,13 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
-		return buf->error;
+		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
-		return -EINVAL;
+		return false;
 	prev_reclen = buf->prev_reclen;
 	if (prev_reclen && signal_pending(current))
-		return -EINTR;
+		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
@@ -339,13 +339,13 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->count -= reclen;
-	return 0;
+	return true;
 
 efault_end:
 	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 SYSCALL_DEFINE3(getdents64, unsigned int, fd,
@@ -394,7 +394,7 @@ struct compat_readdir_callback {
 	int result;
 };
 
-static int compat_fillonedir(struct dir_context *ctx, const char *name,
+static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 			     int namlen, loff_t offset, u64 ino,
 			     unsigned int d_type)
 {
@@ -404,11 +404,11 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 	compat_ulong_t d_ino;
 
 	if (buf->result)
-		return -EINVAL;
+		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
-		return -EOVERFLOW;
+		return false;
 	}
 	buf->result++;
 	dirent = buf->dirent;
@@ -421,12 +421,12 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
 	user_write_access_end();
-	return 0;
+	return true;
 efault_end:
 	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
@@ -465,7 +465,7 @@ struct compat_getdents_callback {
 	int error;
 };
 
-static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
+static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 		loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct compat_linux_dirent __user *dirent, *prev;
@@ -478,18 +478,18 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
-		return buf->error;
+		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
-		return -EINVAL;
+		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->error = -EOVERFLOW;
-		return -EOVERFLOW;
+		return false;
 	}
 	prev_reclen = buf->prev_reclen;
 	if (prev_reclen && signal_pending(current))
-		return -EINTR;
+		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
@@ -505,12 +505,12 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->count -= reclen;
-	return 0;
+	return true;
 efault_end:
 	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
-	return -EFAULT;
+	return false;
 }
 
 COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index bd073836e141..70615594c19b 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -189,7 +189,7 @@ struct reiserfs_dentry_buf {
 	struct dentry *dentries[8];
 };
 
-static int
+static bool
 fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 		   loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -200,16 +200,16 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 	WARN_ON_ONCE(!inode_is_locked(d_inode(dbuf->xadir)));
 
 	if (dbuf->count == ARRAY_SIZE(dbuf->dentries))
-		return -ENOSPC;
+		return false;
 
 	if (name[0] == '.' && (namelen < 2 ||
 			       (namelen == 2 && name[1] == '.')))
-		return 0;
+		return true;
 
 	dentry = lookup_one_len(name, dbuf->xadir, namelen);
 	if (IS_ERR(dentry)) {
 		dbuf->err = PTR_ERR(dentry);
-		return PTR_ERR(dentry);
+		return false;
 	} else if (d_really_is_negative(dentry)) {
 		/* A directory entry exists, but no file? */
 		reiserfs_error(dentry->d_sb, "xattr-20003",
@@ -218,11 +218,11 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
 			       dentry, dbuf->xadir);
 		dput(dentry);
 		dbuf->err = -EIO;
-		return -EIO;
+		return false;
 	}
 
 	dbuf->dentries[dbuf->count++] = dentry;
-	return 0;
+	return true;
 }
 
 static void
@@ -804,7 +804,7 @@ struct listxattr_buf {
 	struct dentry *dentry;
 };
 
-static int listxattr_filler(struct dir_context *ctx, const char *name,
+static bool listxattr_filler(struct dir_context *ctx, const char *name,
 			    int namelen, loff_t offset, u64 ino,
 			    unsigned int d_type)
 {
@@ -820,19 +820,19 @@ static int listxattr_filler(struct dir_context *ctx, const char *name,
 						    name);
 		if (!handler /* Unsupported xattr name */ ||
 		    (handler->list && !handler->list(b->dentry)))
-			return 0;
+			return true;
 		size = namelen + 1;
 		if (b->buf) {
 			if (b->pos + size > b->size) {
 				b->pos = -ERANGE;
-				return -ERANGE;
+				return false;
 			}
 			memcpy(b->buf + b->pos, name, namelen);
 			b->buf[b->pos + namelen] = 0;
 		}
 		b->pos += size;
 	}
-	return 0;
+	return true;
 }
 
 /*
diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 178b3455a170..10bbc9c4e7ec 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -100,7 +100,7 @@ xchk_dir_check_ftype(
  * we check the inode number to make sure it's sane, then we check that
  * we can look up this filename.  Finally, we check the ftype.
  */
-STATIC int
+STATIC bool
 xchk_dir_actor(
 	struct dir_context	*dir_iter,
 	const char		*name,
@@ -125,7 +125,7 @@ xchk_dir_actor(
 			xfs_dir2_dataptr_to_db(mp->m_dir_geo, pos));
 
 	if (xchk_should_terminate(sdc->sc, &error))
-		return error;
+		return error == 0;
 
 	/* Does this inode number make sense? */
 	if (!xfs_verify_dir_ino(mp, ino)) {
@@ -192,8 +192,8 @@ xchk_dir_actor(
 	 * and return zero to xchk_directory.
 	 */
 	if (error == 0 && sdc->sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
-		return -EFSCORRUPTED;
-	return error;
+		return false;
+	return error == 0;
 }
 
 /* Scrub a directory btree record. */
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 66c35f6dfc24..3b4a3ba23e68 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -39,7 +39,7 @@ struct xchk_parent_ctx {
 };
 
 /* Look for a single entry in a directory pointing to an inode. */
-STATIC int
+STATIC bool
 xchk_parent_actor(
 	struct dir_context	*dc,
 	const char		*name,
@@ -63,7 +63,7 @@ xchk_parent_actor(
 	if (xchk_should_terminate(spc->sc, &error))
 		spc->cancelled = true;
 
-	return error;
+	return error == 0;
 }
 
 /* Count the number of dentries in the parent dir that point to this inode. */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..76073123964b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1836,7 +1836,7 @@ extern bool may_open_dev(const struct path *path);
  * to have different dirent layouts depending on the binary type.
  */
 struct dir_context;
-typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
+typedef bool (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
 			 unsigned);
 
 struct dir_context {
@@ -3518,17 +3518,17 @@ static inline bool dir_emit(struct dir_context *ctx,
 			    const char *name, int namelen,
 			    u64 ino, unsigned type)
 {
-	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type) == 0;
+	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type);
 }
 static inline bool dir_emit_dot(struct file *file, struct dir_context *ctx)
 {
 	return ctx->actor(ctx, ".", 1, ctx->pos,
-			  file->f_path.dentry->d_inode->i_ino, DT_DIR) == 0;
+			  file->f_path.dentry->d_inode->i_ino, DT_DIR);
 }
 static inline bool dir_emit_dotdot(struct file *file, struct dir_context *ctx)
 {
 	return ctx->actor(ctx, "..", 2, ctx->pos,
-			  parent_ino(file->f_path.dentry), DT_DIR) == 0;
+			  parent_ino(file->f_path.dentry), DT_DIR);
 }
 static inline bool dir_emit_dots(struct file *file, struct dir_context *ctx)
 {
