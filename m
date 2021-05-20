Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82E389BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhETDqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:46:51 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:36378 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhETDqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:46:50 -0400
Received: by mail-pj1-f53.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so4697469pjt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wXqElQRkopl21ZPYblcLk2cmVZq3rqAdYuKshPdrR8=;
        b=rlQSK1oUkcmHbUUt7oy4sW/Xyk0jz8iRs7aAya4pG30W8GqlSwzOV+IdsIlLcBggEs
         YAIkyWZjq6e6zZ+0wn2aBh942CcvDHpWYXw8dUZuxMOwBv0YYJybE+U8GLK0LsBr1ScW
         juyQ9hTU5g/b/JRTO8NzeOZjnZjBe/qKel5aReOSB675T0D3VK9dVSQCEP+lDGYizYG4
         G8bHCCegfAYsQ9tdpcRnWPLRgVDsLzxi8Zu1XZfmNzVZMUKnnHs/oPj+/SGnRyzxRilk
         qgxHgYKpr/sITOyAm7XIAkf2ClxII+HHG548P+8m70To+lbXw4sSu8Iqly4Rk4vGJs/j
         D9xQ==
X-Gm-Message-State: AOAM530Xt2AD/Lr+kJ/h7PxRHbXdLH39g+HMVt5UHTLqbhFwzXNFQRRM
        TB/d2MMKhA2XscYAOkK7FfQ=
X-Google-Smtp-Source: ABdhPJyMiAhO65oJ4Dscpf0QBxkFPePcoojRjYAt7X5H0LXncLNbmj6hUhlCPnk+v0dFyVmxLRrijQ==
X-Received: by 2002:a17:90a:4d4f:: with SMTP id l15mr283366pjh.78.1621482328330;
        Wed, 19 May 2021 20:45:28 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:b043:994b:7f8b:3169])
        by smtp.gmail.com with ESMTPSA id g13sm660500pfr.75.2021.05.19.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:45:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] configfs: Implement the .read_iter and .write_iter callbacks
Date:   Wed, 19 May 2021 20:45:21 -0700
Message-Id: <20210520034521.16102-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configfs is one of the few filesystems that does not yet support the
.read_iter and .write_iter callbacks. This patch adds support for these
callbacks in configfs. Additionally, fix the kernel-doc comment above
configfs_create_bin_file().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/file.c | 126 +++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 68 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index da8351d1e455..1c63251356f9 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -16,7 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
-
+#include <linux/uio.h>
 #include <linux/configfs.h>
 #include "configfs_internal.h"
 
@@ -80,11 +80,9 @@ static int fill_read_buffer(struct file *file, struct configfs_buffer *buffer)
 }
 
 /**
- *	configfs_read_file - read an attribute.
- *	@file:	file pointer.
- *	@buf:	buffer to fill.
- *	@count:	number of bytes to read.
- *	@ppos:	starting offset in file.
+ *	configfs_read_iter - Read a configfs attribute.
+ *	@iocb: file to read and offset at which to start reading.
+ *	@to: buffer to copy the output to.
  *
  *	Userspace wants to read an attribute file. The attribute descriptor
  *	is in the file's ->d_fsdata. The target item is in the directory's
@@ -97,10 +95,9 @@ static int fill_read_buffer(struct file *file, struct configfs_buffer *buffer)
  *	We then call flush_read_buffer() to copy the buffer to userspace
  *	in the increments specified.
  */
-
-static ssize_t
-configfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t configfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct configfs_buffer *buffer = file->private_data;
 	ssize_t retval = 0;
 
@@ -110,21 +107,21 @@ configfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *pp
 		if (retval)
 			goto out;
 	}
-	pr_debug("%s: count = %zd, ppos = %lld, buf = %s\n",
-		 __func__, count, *ppos, buffer->page);
-	retval = simple_read_from_buffer(buf, count, ppos, buffer->page,
-					 buffer->count);
+	pr_debug("%s: count = %zd, pos = %lld, buf = %s\n",
+		 __func__, iov_iter_count(to), iocb->ki_pos, buffer->page);
+	retval = copy_to_iter(buffer->page, buffer->count, to);
+	iocb->ki_pos += retval;
+	if (retval == 0)
+		retval = -EFAULT;
 out:
 	mutex_unlock(&buffer->mutex);
 	return retval;
 }
 
 /**
- *	configfs_read_bin_file - read a binary attribute.
- *	@file:	file pointer.
- *	@buf:	buffer to fill.
- *	@count:	number of bytes to read.
- *	@ppos:	starting offset in file.
+ *	configfs_bin_read_iter - Read a binary configfs attribute.
+ *	@iocb: file to read and offset at which to start reading.
+ *	@to: buffer to copy the output to.
  *
  *	Userspace wants to read a binary attribute file. The attribute
  *	descriptor is in the file's ->d_fsdata. The target item is in the
@@ -139,14 +136,13 @@ configfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *pp
  *	Then we just copy to user-space using simple_read_from_buffer.
  */
 
-static ssize_t
-configfs_read_bin_file(struct file *file, char __user *buf,
-		       size_t count, loff_t *ppos)
+static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct configfs_fragment *frag = to_frag(file);
 	struct configfs_buffer *buffer = file->private_data;
 	ssize_t retval = 0;
-	ssize_t len = min_t(size_t, count, PAGE_SIZE);
+	ssize_t len;
 
 	mutex_lock(&buffer->mutex);
 
@@ -202,8 +198,10 @@ configfs_read_bin_file(struct file *file, char __user *buf,
 		buffer->needs_read_fill = 0;
 	}
 
-	retval = simple_read_from_buffer(buf, count, ppos, buffer->bin_buffer,
-					buffer->bin_buffer_size);
+	retval = copy_to_iter(buffer->bin_buffer, buffer->bin_buffer_size, to);
+	iocb->ki_pos += retval;
+	if (retval == 0)
+		retval = -EFAULT;
 out:
 	mutex_unlock(&buffer->mutex);
 	return retval;
@@ -212,32 +210,29 @@ configfs_read_bin_file(struct file *file, char __user *buf,
 
 /**
  *	fill_write_buffer - copy buffer from userspace.
- *	@buffer:	data buffer for file.
- *	@buf:		data from user.
- *	@count:		number of bytes in @userbuf.
+ *	@buffer:	data buffer that represents the attribute contents.
+ *	@from:		data to copy into the attribute.
  *
  *	Allocate @buffer->page if it hasn't been already, then
  *	copy the user-supplied buffer into it.
  */
 
-static int
-fill_write_buffer(struct configfs_buffer * buffer, const char __user * buf, size_t count)
+static int fill_write_buffer(struct configfs_buffer *buffer,
+			     struct iov_iter *from)
 {
-	int error;
+	int copied;
 
 	if (!buffer->page)
 		buffer->page = (char *)__get_free_pages(GFP_KERNEL, 0);
 	if (!buffer->page)
 		return -ENOMEM;
 
-	if (count >= SIMPLE_ATTR_SIZE)
-		count = SIMPLE_ATTR_SIZE - 1;
-	error = copy_from_user(buffer->page,buf,count);
+	copied = copy_from_iter(buffer->page, SIMPLE_ATTR_SIZE - 1, from);
 	buffer->needs_read_fill = 1;
 	/* if buf is assumed to contain a string, terminate it by \0,
 	 * so e.g. sscanf() can scan the string easily */
-	buffer->page[count] = 0;
-	return error ? -EFAULT : count;
+	buffer->page[copied] = 0;
+	return copied ? : -EFAULT;
 }
 
 static int
@@ -255,13 +250,11 @@ flush_write_buffer(struct file *file, struct configfs_buffer *buffer, size_t cou
 
 
 /**
- *	configfs_write_file - write an attribute.
- *	@file:	file pointer
- *	@buf:	data to write
- *	@count:	number of bytes
- *	@ppos:	starting offset
+ *	configfs_write_iter - Write a configfs attribute.
+ *	@iocb: file to write to and offset at which to start writing.
+ *	@from: data to copy into the attribute.
  *
- *	Similar to configfs_read_file(), though working in the opposite direction.
+ *	Similar to configfs_read_iter(), though working in the opposite direction.
  *	We allocate and fill the data from the user in fill_write_buffer(),
  *	then push it to the config_item in flush_write_buffer().
  *	There is no easy way for us to know if userspace is only doing a partial
@@ -271,28 +264,26 @@ flush_write_buffer(struct file *file, struct configfs_buffer *buffer, size_t cou
  *	the value you're changing, then write entire buffer back.
  */
 
-static ssize_t
-configfs_write_file(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct configfs_buffer *buffer = file->private_data;
 	ssize_t len;
 
 	mutex_lock(&buffer->mutex);
-	len = fill_write_buffer(buffer, buf, count);
+	len = fill_write_buffer(buffer, from);
 	if (len > 0)
 		len = flush_write_buffer(file, buffer, len);
 	if (len > 0)
-		*ppos += len;
+		iocb->ki_pos += len;
 	mutex_unlock(&buffer->mutex);
 	return len;
 }
 
 /**
- *	configfs_write_bin_file - write a binary attribute.
- *	@file:	file pointer
- *	@buf:	data to write
- *	@count:	number of bytes
- *	@ppos:	starting offset
+ *	configfs_bin_write_iter - Write a binary attribute.
+ *	@iocb: file to write to and offset at which to start writing.
+ *	@from: data to copy into the attribute.
  *
  *	Writing to a binary attribute file is similar to a normal read.
  *	We buffer the consecutive writes (binary attribute files do not
@@ -300,12 +291,13 @@ configfs_write_file(struct file *file, const char __user *buf, size_t count, lof
  *	commit until the close of the file.
  */
 
-static ssize_t
-configfs_write_bin_file(struct file *file, const char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t configfs_bin_write_iter(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct configfs_buffer *buffer = file->private_data;
 	void *tbuf = NULL;
+	size_t end_offset;
 	ssize_t len;
 
 	mutex_lock(&buffer->mutex);
@@ -318,15 +310,14 @@ configfs_write_bin_file(struct file *file, const char __user *buf,
 	buffer->write_in_progress = true;
 
 	/* buffer grows? */
-	if (*ppos + count > buffer->bin_buffer_size) {
-
-		if (buffer->cb_max_size &&
-			*ppos + count > buffer->cb_max_size) {
+	end_offset = iocb->ki_pos + iov_iter_count(from);
+	if (end_offset > buffer->bin_buffer_size) {
+		if (buffer->cb_max_size && end_offset > buffer->cb_max_size) {
 			len = -EFBIG;
 			goto out;
 		}
 
-		tbuf = vmalloc(*ppos + count);
+		tbuf = vmalloc(end_offset);
 		if (tbuf == NULL) {
 			len = -ENOMEM;
 			goto out;
@@ -341,16 +332,15 @@ configfs_write_bin_file(struct file *file, const char __user *buf,
 
 		/* clear the new area */
 		memset(tbuf + buffer->bin_buffer_size, 0,
-			*ppos + count - buffer->bin_buffer_size);
+			end_offset - buffer->bin_buffer_size);
 		buffer->bin_buffer = tbuf;
-		buffer->bin_buffer_size = *ppos + count;
+		buffer->bin_buffer_size = end_offset;
 	}
 
-	len = simple_write_to_buffer(buffer->bin_buffer,
-			buffer->bin_buffer_size, ppos, buf, count);
+	len = copy_from_iter(buffer->bin_buffer, buffer->bin_buffer_size, from);
 out:
 	mutex_unlock(&buffer->mutex);
-	return len;
+	return len ? : -EFAULT;
 }
 
 static int __configfs_open_file(struct inode *inode, struct file *file, int type)
@@ -495,16 +485,16 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 
 
 const struct file_operations configfs_file_operations = {
-	.read		= configfs_read_file,
-	.write		= configfs_write_file,
+	.read_iter	= configfs_read_iter,
+	.write_iter	= configfs_write_iter,
 	.llseek		= generic_file_llseek,
 	.open		= configfs_open_file,
 	.release	= configfs_release,
 };
 
 const struct file_operations configfs_bin_file_operations = {
-	.read		= configfs_read_bin_file,
-	.write		= configfs_write_bin_file,
+	.read_iter	= configfs_bin_read_iter,
+	.write_iter	= configfs_bin_write_iter,
 	.llseek		= NULL,		/* bin file is not seekable */
 	.open		= configfs_open_bin_file,
 	.release	= configfs_release_bin_file,
@@ -534,7 +524,7 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
 /**
  *	configfs_create_bin_file - create a binary attribute file for an item.
  *	@item:	item we're creating for.
- *	@attr:	atrribute descriptor.
+ *	@bin_attr: atrribute descriptor.
  */
 
 int configfs_create_bin_file(struct config_item *item,
