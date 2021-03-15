Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9133C989
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhCOWzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhCOWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:55:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60886C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:55:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLw6z-00Gf7T-H4; Mon, 15 Mar 2021 23:54:57 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] gcov: combine common code
Date:   Mon, 15 Mar 2021 23:54:53 +0100
Message-Id: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a lot of duplicated code between gcc and clang
implementations, move it over to fs.c to simplify the
code, there's no reason to believe that for small data
like this one would not just implement the simple
convert_to_gcda() function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/gcov/base.c    |  49 +++++++++++++
 kernel/gcov/clang.c   | 167 +-----------------------------------------
 kernel/gcov/fs.c      | 116 +++++++++++++++++++++++++++++
 kernel/gcov/gcc_4_7.c | 167 +-----------------------------------------
 kernel/gcov/gcov.h    |  14 +---
 5 files changed, 171 insertions(+), 342 deletions(-)

diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 0ffe9f194080..073a3738c5e6 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -49,6 +49,55 @@ void gcov_enable_events(void)
 	mutex_unlock(&gcov_lock);
 }
 
+/**
+ * store_gcov_u32 - store 32 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. Returns the number of bytes stored. If @buffer is %NULL, doesn't
+ * store anything.
+ */
+size_t store_gcov_u32(void *buffer, size_t off, u32 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data = buffer + off;
+		*data = v;
+	}
+
+	return sizeof(*data);
+}
+
+/**
+ * store_gcov_u64 - store 64 bit number in gcov format to buffer
+ * @buffer: target buffer or NULL
+ * @off: offset into the buffer
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. 64 bit numbers are stored as two 32 bit numbers, the low part
+ * first. Returns the number of bytes stored. If @buffer is %NULL, doesn't store
+ * anything.
+ */
+size_t store_gcov_u64(void *buffer, size_t off, u64 v)
+{
+	u32 *data;
+
+	if (buffer) {
+		data = buffer + off;
+
+		data[0] = (v & 0xffffffffUL);
+		data[1] = (v >> 32);
+	}
+
+	return sizeof(*data) * 2;
+}
+
 #ifdef CONFIG_MODULES
 /* Update list and generate events when modules are unloaded. */
 static int gcov_module_notifier(struct notifier_block *nb, unsigned long event,
diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index c94b820a1b62..e59c290527b2 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -48,7 +48,6 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/ratelimit.h>
-#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "gcov.h"
@@ -376,71 +375,6 @@ void gcov_info_free(struct gcov_info *info)
 	kfree(info);
 }
 
-#define ITER_STRIDE	PAGE_SIZE
-
-/**
- * struct gcov_iterator - specifies current file position in logical records
- * @info: associated profiling data
- * @buffer: buffer containing file data
- * @size: size of buffer
- * @pos: current position in file
- */
-struct gcov_iterator {
-	struct gcov_info *info;
-	void *buffer;
-	size_t size;
-	loff_t pos;
-};
-
-/**
- * store_gcov_u32 - store 32 bit number in gcov format to buffer
- * @buffer: target buffer or NULL
- * @off: offset into the buffer
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. Returns the number of bytes stored. If @buffer is %NULL, doesn't
- * store anything.
- */
-static size_t store_gcov_u32(void *buffer, size_t off, u32 v)
-{
-	u32 *data;
-
-	if (buffer) {
-		data = buffer + off;
-		*data = v;
-	}
-
-	return sizeof(*data);
-}
-
-/**
- * store_gcov_u64 - store 64 bit number in gcov format to buffer
- * @buffer: target buffer or NULL
- * @off: offset into the buffer
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. 64 bit numbers are stored as two 32 bit numbers, the low part
- * first. Returns the number of bytes stored. If @buffer is %NULL, doesn't store
- * anything.
- */
-static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
-{
-	u32 *data;
-
-	if (buffer) {
-		data = buffer + off;
-
-		data[0] = (v & 0xffffffffUL);
-		data[1] = (v >> 32);
-	}
-
-	return sizeof(*data) * 2;
-}
-
 /**
  * convert_to_gcda - convert profiling data set to gcda file format
  * @buffer: the buffer to store file data or %NULL if no data should be stored
@@ -448,7 +382,7 @@ static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
  *
  * Returns the number of bytes that were/would have been stored into the buffer.
  */
-static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
+size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 {
 	struct gcov_fn_info *fi_ptr;
 	size_t pos = 0;
@@ -480,102 +414,3 @@ static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 
 	return pos;
 }
-
-/**
- * gcov_iter_new - allocate and initialize profiling data iterator
- * @info: profiling data set to be iterated
- *
- * Return file iterator on success, %NULL otherwise.
- */
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
-{
-	struct gcov_iterator *iter;
-
-	iter = kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
-	if (!iter)
-		goto err_free;
-
-	iter->info = info;
-	/* Dry-run to get the actual buffer size. */
-	iter->size = convert_to_gcda(NULL, info);
-	iter->buffer = vmalloc(iter->size);
-	if (!iter->buffer)
-		goto err_free;
-
-	convert_to_gcda(iter->buffer, info);
-
-	return iter;
-
-err_free:
-	kfree(iter);
-	return NULL;
-}
-
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-void gcov_iter_free(struct gcov_iterator *iter)
-{
-	vfree(iter->buffer);
-	kfree(iter);
-}
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
-{
-	return iter->info;
-}
-
-/**
- * gcov_iter_start - reset file iterator to starting position
- * @iter: file iterator
- */
-void gcov_iter_start(struct gcov_iterator *iter)
-{
-	iter->pos = 0;
-}
-
-/**
- * gcov_iter_next - advance file iterator to next logical record
- * @iter: file iterator
- *
- * Return zero if new position is valid, non-zero if iterator has reached end.
- */
-int gcov_iter_next(struct gcov_iterator *iter)
-{
-	if (iter->pos < iter->size)
-		iter->pos += ITER_STRIDE;
-
-	if (iter->pos >= iter->size)
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
- * gcov_iter_write - write data for current pos to seq_file
- * @iter: file iterator
- * @seq: seq_file handle
- *
- * Return zero on success, non-zero otherwise.
- */
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
-{
-	size_t len;
-
-	if (iter->pos >= iter->size)
-		return -EINVAL;
-
-	len = ITER_STRIDE;
-	if (iter->pos + len > iter->size)
-		len = iter->size - iter->pos;
-
-	seq_write(seq, iter->buffer + iter->pos, len);
-
-	return 0;
-}
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 82babf5aa077..2d29e1d1225d 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include "gcov.h"
 
 /**
@@ -85,6 +86,121 @@ static int __init gcov_persist_setup(char *str)
 }
 __setup("gcov_persist=", gcov_persist_setup);
 
+#define ITER_STRIDE	PAGE_SIZE
+
+/**
+ * struct gcov_iterator - specifies current file position in logical records
+ * @info: associated profiling data
+ * @buffer: buffer containing file data
+ * @size: size of buffer
+ * @pos: current position in file
+ */
+struct gcov_iterator {
+	struct gcov_info *info;
+	void *buffer;
+	size_t size;
+	loff_t pos;
+};
+
+/**
+ * gcov_iter_new - allocate and initialize profiling data iterator
+ * @info: profiling data set to be iterated
+ *
+ * Return file iterator on success, %NULL otherwise.
+ */
+static struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
+{
+	struct gcov_iterator *iter;
+
+	iter = kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
+	if (!iter)
+		goto err_free;
+
+	iter->info = info;
+	/* Dry-run to get the actual buffer size. */
+	iter->size = convert_to_gcda(NULL, info);
+	iter->buffer = vmalloc(iter->size);
+	if (!iter->buffer)
+		goto err_free;
+
+	convert_to_gcda(iter->buffer, info);
+
+	return iter;
+
+err_free:
+	kfree(iter);
+	return NULL;
+}
+
+
+/**
+ * gcov_iter_free - free iterator data
+ * @iter: file iterator
+ */
+static void gcov_iter_free(struct gcov_iterator *iter)
+{
+	vfree(iter->buffer);
+	kfree(iter);
+}
+
+/**
+ * gcov_iter_get_info - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+static struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
+{
+	return iter->info;
+}
+
+/**
+ * gcov_iter_start - reset file iterator to starting position
+ * @iter: file iterator
+ */
+static void gcov_iter_start(struct gcov_iterator *iter)
+{
+	iter->pos = 0;
+}
+
+/**
+ * gcov_iter_next - advance file iterator to next logical record
+ * @iter: file iterator
+ *
+ * Return zero if new position is valid, non-zero if iterator has reached end.
+ */
+static int gcov_iter_next(struct gcov_iterator *iter)
+{
+	if (iter->pos < iter->size)
+		iter->pos += ITER_STRIDE;
+
+	if (iter->pos >= iter->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * gcov_iter_write - write data for current pos to seq_file
+ * @iter: file iterator
+ * @seq: seq_file handle
+ *
+ * Return zero on success, non-zero otherwise.
+ */
+static int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
+{
+	size_t len;
+
+	if (iter->pos >= iter->size)
+		return -EINVAL;
+
+	len = ITER_STRIDE;
+	if (iter->pos + len > iter->size)
+		len = iter->size - iter->pos;
+
+	seq_write(seq, iter->buffer + iter->pos, len);
+
+	return 0;
+}
+
 /*
  * seq_file.start() implementation for gcov data files. Note that the
  * gcov_iterator interface is designed to be more restrictive than seq_file
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index c53408a00d0b..1251f2434e90 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -15,7 +15,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include "gcov.h"
 
@@ -363,71 +362,6 @@ void gcov_info_free(struct gcov_info *info)
 	kfree(info);
 }
 
-#define ITER_STRIDE	PAGE_SIZE
-
-/**
- * struct gcov_iterator - specifies current file position in logical records
- * @info: associated profiling data
- * @buffer: buffer containing file data
- * @size: size of buffer
- * @pos: current position in file
- */
-struct gcov_iterator {
-	struct gcov_info *info;
-	void *buffer;
-	size_t size;
-	loff_t pos;
-};
-
-/**
- * store_gcov_u32 - store 32 bit number in gcov format to buffer
- * @buffer: target buffer or NULL
- * @off: offset into the buffer
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. Returns the number of bytes stored. If @buffer is %NULL, doesn't
- * store anything.
- */
-static size_t store_gcov_u32(void *buffer, size_t off, u32 v)
-{
-	u32 *data;
-
-	if (buffer) {
-		data = buffer + off;
-		*data = v;
-	}
-
-	return sizeof(*data);
-}
-
-/**
- * store_gcov_u64 - store 64 bit number in gcov format to buffer
- * @buffer: target buffer or NULL
- * @off: offset into the buffer
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. 64 bit numbers are stored as two 32 bit numbers, the low part
- * first. Returns the number of bytes stored. If @buffer is %NULL, doesn't store
- * anything.
- */
-static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
-{
-	u32 *data;
-
-	if (buffer) {
-		data = buffer + off;
-
-		data[0] = (v & 0xffffffffUL);
-		data[1] = (v >> 32);
-	}
-
-	return sizeof(*data) * 2;
-}
-
 /**
  * convert_to_gcda - convert profiling data set to gcda file format
  * @buffer: the buffer to store file data or %NULL if no data should be stored
@@ -435,7 +369,7 @@ static size_t store_gcov_u64(void *buffer, size_t off, u64 v)
  *
  * Returns the number of bytes that were/would have been stored into the buffer.
  */
-static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
+size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 {
 	struct gcov_fn_info *fi_ptr;
 	struct gcov_ctr_info *ci_ptr;
@@ -481,102 +415,3 @@ static size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 
 	return pos;
 }
-
-/**
- * gcov_iter_new - allocate and initialize profiling data iterator
- * @info: profiling data set to be iterated
- *
- * Return file iterator on success, %NULL otherwise.
- */
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
-{
-	struct gcov_iterator *iter;
-
-	iter = kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
-	if (!iter)
-		goto err_free;
-
-	iter->info = info;
-	/* Dry-run to get the actual buffer size. */
-	iter->size = convert_to_gcda(NULL, info);
-	iter->buffer = vmalloc(iter->size);
-	if (!iter->buffer)
-		goto err_free;
-
-	convert_to_gcda(iter->buffer, info);
-
-	return iter;
-
-err_free:
-	kfree(iter);
-	return NULL;
-}
-
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-void gcov_iter_free(struct gcov_iterator *iter)
-{
-	vfree(iter->buffer);
-	kfree(iter);
-}
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
-{
-	return iter->info;
-}
-
-/**
- * gcov_iter_start - reset file iterator to starting position
- * @iter: file iterator
- */
-void gcov_iter_start(struct gcov_iterator *iter)
-{
-	iter->pos = 0;
-}
-
-/**
- * gcov_iter_next - advance file iterator to next logical record
- * @iter: file iterator
- *
- * Return zero if new position is valid, non-zero if iterator has reached end.
- */
-int gcov_iter_next(struct gcov_iterator *iter)
-{
-	if (iter->pos < iter->size)
-		iter->pos += ITER_STRIDE;
-
-	if (iter->pos >= iter->size)
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
- * gcov_iter_write - write data for current pos to seq_file
- * @iter: file iterator
- * @seq: seq_file handle
- *
- * Return zero on success, non-zero otherwise.
- */
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
-{
-	size_t len;
-
-	if (iter->pos >= iter->size)
-		return -EINVAL;
-
-	len = ITER_STRIDE;
-	if (iter->pos + len > iter->size)
-		len = iter->size - iter->pos;
-
-	seq_write(seq, iter->buffer + iter->pos, len);
-
-	return 0;
-}
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index 6ab2c1808c9d..912b8ea01d33 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -48,6 +48,7 @@ struct gcov_info *gcov_info_next(struct gcov_info *info);
 void gcov_info_link(struct gcov_info *info);
 void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
 bool gcov_info_within_module(struct gcov_info *info, struct module *mod);
+size_t convert_to_gcda(char *buffer, struct gcov_info *info);
 
 /* Base interface. */
 enum gcov_action {
@@ -58,16 +59,9 @@ enum gcov_action {
 void gcov_event(enum gcov_action action, struct gcov_info *info);
 void gcov_enable_events(void);
 
-/* Iterator control. */
-struct seq_file;
-struct gcov_iterator;
-
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info);
-void gcov_iter_free(struct gcov_iterator *iter);
-void gcov_iter_start(struct gcov_iterator *iter);
-int gcov_iter_next(struct gcov_iterator *iter);
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq);
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter);
+/* writing helpers */
+size_t store_gcov_u32(void *buffer, size_t off, u32 v);
+size_t store_gcov_u64(void *buffer, size_t off, u64 v);
 
 /* gcov_info control. */
 void gcov_info_reset(struct gcov_info *info);
-- 
2.30.2

