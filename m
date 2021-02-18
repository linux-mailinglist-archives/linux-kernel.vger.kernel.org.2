Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4531E837
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhBRJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:32:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhBRITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:49 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpms4UHG5lYw1f4g258FYWdkRPP5f7Th8WlLi8oO1GA=;
        b=4wbv4R5wX3Lkni0lOZdkvpmFuc8DPWXld5NPpOdNOHzmuvJev+5D9PilFl45Yu77csRdBv
        EbjhFMAAAKKhRwtoqW7eF02cPiC0yJEkDMFSIm1ZZFs/OZ2Uz8IawVQlOgo4c59lJqEbP/
        DmVDQElO7Q4k2qQtK83pX+hAqHNbJNXNMBvdeVhFN3Pp4RAOC4DUPkRNfTtA0V9RIkHSQX
        6/KaojokvdYPXRO6NxWKsnN0g02igN5dbU97aO8LXkYuCFqZlH9QUhPSq1n+xu/zLPwzzS
        oKLifIph/dEC3UMX+LPxf0/yT6nE0N4dfI9zxyhfeZG3wnIB40ggIvDSajeVDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpms4UHG5lYw1f4g258FYWdkRPP5f7Th8WlLi8oO1GA=;
        b=Asy70bWcarUVvmv9IEn61mFi68gvQ4og7Z/7GHFHTS62fDk/8MPLazx0k2j8SV+cQr0meH
        c9Xsz9Ezf089ErBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 12/14] printk: kmsg_dump: remove _nolock() variants
Date:   Thu, 18 Feb 2021 09:18:15 +0100
Message-Id: <20210218081817.28849-13-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_rewind() and kmsg_dump_get_line() are lockless, so there is
no need for _nolock() variants. Remove these functions and switch all
callers of the _nolock() variants.

The functions without _nolock() were chosen because they are already
exported to kernel modules.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/xmon/xmon.c    |  4 +--
 include/linux/kmsg_dump.h   | 18 +----------
 kernel/debug/kdb/kdb_main.c |  8 ++---
 kernel/printk/printk.c      | 60 +++++--------------------------------
 4 files changed, 15 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 43162b885259..4cac114ba32d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3015,9 +3015,9 @@ dump_log_buf(void)
 	catch_memory_errors = 1;
 	sync();
 
-	kmsg_dump_rewind_nolock(&iter);
+	kmsg_dump_rewind(&iter);
 	xmon_start_pagination();
-	while (kmsg_dump_get_line_nolock(&iter, false, buf, sizeof(buf), &len)) {
+	while (kmsg_dump_get_line(&iter, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 2fdb10ab1799..86673930c8ea 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -60,18 +60,13 @@ struct kmsg_dumper {
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len);
-
 bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
 bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter);
-
-void kmsg_dump_rewind(struct kmsg_dumper_iter *dumper_iter);
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
@@ -83,13 +78,6 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter,
-					     bool syslog, const char *line,
-					     size_t size, size_t *len)
-{
-	return false;
-}
-
 static inline bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
@@ -102,10 +90,6 @@ static inline bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool sysl
 	return false;
 }
 
-static inline void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
-{
-}
-
 static inline void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 }
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7ae9da245e4b..dbf1d126ac5e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2126,8 +2126,8 @@ static int kdb_dmesg(int argc, const char **argv)
 		kdb_set(2, setargs);
 	}
 
-	kmsg_dump_rewind_nolock(&iter);
-	while (kmsg_dump_get_line_nolock(&iter, 1, NULL, 0, NULL))
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, NULL, 0, NULL))
 		n++;
 
 	if (lines < 0) {
@@ -2159,8 +2159,8 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (skip >= n || skip < 0)
 		return 0;
 
-	kmsg_dump_rewind_nolock(&iter);
-	while (kmsg_dump_get_line_nolock(&iter, 1, buf, sizeof(buf), &len)) {
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, sizeof(buf), &len)) {
 		if (skip) {
 			skip--;
 			continue;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c5ea46ed88c7..744b806d5457 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3378,7 +3378,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 }
 
 /**
- * kmsg_dump_get_line_nolock - retrieve one kmsg log line (unlocked version)
+ * kmsg_dump_get_line - retrieve one kmsg log line
  * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
@@ -3393,18 +3393,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  *
  * A return value of FALSE indicates that there are no more records to
  * read.
- *
- * The function is similar to kmsg_dump_get_line(), but grabs no locks.
  */
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len)
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+			char *line, size_t size, size_t *len)
 {
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	unsigned long flags;
 	size_t l = 0;
 	bool ret = false;
 
+	printk_safe_enter_irqsave(flags);
 	prb_rec_init_rd(&r, &info, line, size);
 
 	if (!iter->active)
@@ -3428,40 +3428,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 	iter->cur_seq = r.info->seq + 1;
 	ret = true;
 out:
+	printk_safe_exit_irqrestore(flags);
 	if (len)
 		*len = l;
 	return ret;
 }
-
-/**
- * kmsg_dump_get_line - retrieve one kmsg log line
- * @iter: kmsg dumper iterator
- * @syslog: include the "<4>" prefixes
- * @line: buffer to copy the line to
- * @size: maximum size of the buffer
- * @len: length of line placed into buffer
- *
- * Start at the beginning of the kmsg buffer, with the oldest kmsg
- * record, and copy one record into the provided buffer.
- *
- * Consecutive calls will return the next available record moving
- * towards the end of the buffer with the youngest messages.
- *
- * A return value of FALSE indicates that there are no more records to
- * read.
- */
-bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
-			char *line, size_t size, size_t *len)
-{
-	unsigned long flags;
-	bool ret;
-
-	printk_safe_enter_irqsave(flags);
-	ret = kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
-	printk_safe_exit_irqrestore(flags);
-
-	return ret;
-}
 EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
 /**
@@ -3550,22 +3521,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
-/**
- * kmsg_dump_rewind_nolock - reset the iterator (unlocked version)
- * @iter: kmsg dumper iterator
- *
- * Reset the dumper's iterator so that kmsg_dump_get_line() and
- * kmsg_dump_get_buffer() can be called again and used multiple
- * times within the same dumper.dump() callback.
- *
- * The function is similar to kmsg_dump_rewind(), but grabs no locks.
- */
-void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
-{
-	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
-	iter->next_seq = prb_next_seq(prb);
-}
-
 /**
  * kmsg_dump_rewind - reset the iterator
  * @iter: kmsg dumper iterator
@@ -3579,7 +3534,8 @@ void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 	unsigned long flags;
 
 	printk_safe_enter_irqsave(flags);
-	kmsg_dump_rewind_nolock(iter);
+	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
+	iter->next_seq = prb_next_seq(prb);
 	printk_safe_exit_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
-- 
2.20.1

