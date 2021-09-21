Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860254135FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhIUPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:17:05 -0400
Received: from mail.alarsen.net ([144.76.18.233]:51866 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233924AbhIUPRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:17:03 -0400
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:5122:9a9:28f5:243d])
        by joe.alarsen.net (Postfix) with ESMTPS id 0EFD518018A;
        Tue, 21 Sep 2021 17:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1632237334; bh=Xc8kufFZafE7aLPr2mFQk3CJmK8fqwpsdRVSZda3cYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i0z6gnApfMDOv56D5YZ2ggWExPoxQGXR69Cnq/XFdAta0OTQDAddQGlGFeuJtrPLJ
         qJ5kYjjqJpoIPg6U4EikuDwzRwebqyCrxWQO399cpWm10HKq2bxdoMcpYFGNG2dq1U
         sNeNooruOwOtF56uXZtxKCYwrVV7L3ekRCCRcBlo=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 0397A27C04DA;
        Tue, 21 Sep 2021 17:15:34 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
Date:   Tue, 21 Sep 2021 17:15:33 +0200
Message-ID: <2955101.xlVK0Xs8nM@alarsen.net>
In-Reply-To: <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com>
References: <20210920121208.54732-1-arnd@kernel.org> <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com> <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart52656314.epeZYTENiI"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart52656314.epeZYTENiI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 2021-09-21 10:18 Arnd Bergmann wrote:
> On Mon, Sep 20, 2021 at 7:26 PM Linus Torvalds 
<torvalds@linux-foundation.org> wrote:
> > It sounds like we can avoid the gcc bug if we just always use
> > "de->de_name[]". Then we don't need to depend on magical behavior
> > about one particular gcc version and a strange empty array in front of
> > it.
> >
> > IOW, something like the attached simpler thing that just does that
> > "always use de_name[]" and has a comment about why we don't do the
> > natural thing

well, the code in question actually does not use anything from struct 
qnx4_inode_entry except di_fname and di_status;
they are available at the same offsets in struct qnx4_link_info as well, so 
wouldn't it be even simpler to just always use the fields of the latter 
structure?

Like in the attached patch which replaces b7213ffa0e58?
($me feeling bad for reverting Linus' patch!)

That way, the compiler should never see any access to the (shorter) 
qnx4_inode_entry.di_fname

BTW, in the process I noticed that fs/qnx4/namei.c was missed by 663f4deca76 
back in 2013 and so is still calling strlen() on untrusted data; the second 
part of the patch takes care of that.

> > Also, just what version of gcc is the broken one? You say "gcc-11",
> > but I certainly don't see it with _my_ version of gcc-11, so can we
> > (just for that comment) document more precisely what version you have
> > (or possibly what config you use to trigger it).
> 
> I'm using the gcc-11.1.0 that I uploaded to
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/

I don't have that compiler version, so obviously I couldn't test if the patch 
solves the problem.

Cheers
Anders

--nextPart52656314.epeZYTENiI
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="patch.diff"

 fs/qnx4/dir.c   | 18 ++++++++----------
 fs/qnx4/namei.c | 34 +++++++++++++++-------------------
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..45b0262c6fac 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -20,7 +20,6 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	unsigned int offset;
 	struct buffer_head *bh;
-	struct qnx4_inode_entry *de;
 	struct qnx4_link_info *le;
 	unsigned long blknum;
 	int ix, ino;
@@ -39,26 +38,25 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 		ix = (ctx->pos >> QNX4_DIR_ENTRY_SIZE_BITS) % QNX4_INODES_PER_BLOCK;
 		for (; ix < QNX4_INODES_PER_BLOCK; ix++, ctx->pos += QNX4_DIR_ENTRY_SIZE) {
 			offset = ix * QNX4_DIR_ENTRY_SIZE;
-			de = (struct qnx4_inode_entry *) (bh->b_data + offset);
-			if (!de->di_fname[0])
+			le = (struct qnx4_link_info *) (bh->b_data + offset);
+			if (!le->dl_fname[0])
 				continue;
-			if (!(de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
+			if (!(le->dl_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
 				continue;
-			if (!(de->di_status & QNX4_FILE_LINK))
+			if (!(le->dl_status & QNX4_FILE_LINK))
 				size = QNX4_SHORT_NAME_MAX;
 			else
 				size = QNX4_NAME_MAX;
-			size = strnlen(de->di_fname, size);
-			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, de->di_fname));
-			if (!(de->di_status & QNX4_FILE_LINK))
+			size = strnlen(le->dl_fname, size);
+			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, le->dl_fname));
+			if (!(le->dl_status & QNX4_FILE_LINK))
 				ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;
 			else {
-				le  = (struct qnx4_link_info*)de;
 				ino = ( le32_to_cpu(le->dl_inode_blk) - 1 ) *
 					QNX4_INODES_PER_BLOCK +
 					le->dl_inode_ndx;
 			}
-			if (!dir_emit(ctx, de->di_fname, size, ino, DT_UNKNOWN)) {
+			if (!dir_emit(ctx, le->dl_fname, size, ino, DT_UNKNOWN)) {
 				brelse(bh);
 				return 0;
 			}
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..75ff330ce5e0 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -26,28 +26,26 @@
 static int qnx4_match(int len, const char *name,
 		      struct buffer_head *bh, unsigned long *offset)
 {
-	struct qnx4_inode_entry *de;
-	int namelen, thislen;
+	struct qnx4_link_info *le;
+	int namelen;
 
 	if (bh == NULL) {
 		printk(KERN_WARNING "qnx4: matching unassigned buffer !\n");
 		return 0;
 	}
-	de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
+	le = (struct qnx4_link_info *) (bh->b_data + *offset);
 	*offset += QNX4_DIR_ENTRY_SIZE;
-	if ((de->di_status & QNX4_FILE_LINK) != 0) {
+	if ((le->dl_status & QNX4_FILE_LINK) != 0) {
 		namelen = QNX4_NAME_MAX;
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
-	if (len != thislen) {
+	namelen = strnlen( le->dl_fname, namelen );
+	if (len != namelen) {
 		return 0;
 	}
-	if (strncmp(name, de->di_fname, len) == 0) {
-		if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) != 0) {
+	if (strncmp(name, le->dl_fname, len) == 0) {
+		if ((le->dl_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) != 0) {
 			return 1;
 		}
 	}
@@ -55,7 +53,7 @@ static int qnx4_match(int len, const char *name,
 }
 
 static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
-	   const char *name, struct qnx4_inode_entry **res_dir, int *ino)
+	   const char *name, struct qnx4_link_info **res_dir, int *ino)
 {
 	unsigned long block, offset, blkofs;
 	struct buffer_head *bh;
@@ -73,7 +71,7 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 				continue;
 			}
 		}
-		*res_dir = (struct qnx4_inode_entry *) (bh->b_data + offset);
+		*res_dir = (struct qnx4_link_info *) (bh->b_data + offset);
 		if (qnx4_match(len, name, bh, &offset)) {
 			*ino = block * QNX4_INODES_PER_BLOCK +
 			    (offset / QNX4_DIR_ENTRY_SIZE) - 1;
@@ -95,21 +93,19 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	int ino;
-	struct qnx4_inode_entry *de;
-	struct qnx4_link_info *lnk;
+	struct qnx4_link_info *le;
 	struct buffer_head *bh;
 	const char *name = dentry->d_name.name;
 	int len = dentry->d_name.len;
 	struct inode *foundinode = NULL;
 
-	if (!(bh = qnx4_find_entry(len, dir, name, &de, &ino)))
+	if (!(bh = qnx4_find_entry(len, dir, name, &le, &ino)))
 		goto out;
 	/* The entry is linked, let's get the real info */
-	if ((de->di_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
-		lnk = (struct qnx4_link_info *) de;
-		ino = (le32_to_cpu(lnk->dl_inode_blk) - 1) *
+	if ((le->dl_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
+		ino = (le32_to_cpu(le->dl_inode_blk) - 1) *
                     QNX4_INODES_PER_BLOCK +
-		    lnk->dl_inode_ndx;
+		    le->dl_inode_ndx;
 	}
 	brelse(bh);
 

--nextPart52656314.epeZYTENiI--



