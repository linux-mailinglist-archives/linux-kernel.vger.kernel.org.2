Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E132BC80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbhCCODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842910AbhCCKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DC9C08ED81
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CVCDvgkqaxh7MYJebjzfGDlcpHL5EV9JmU/3T5/E9o=;
        b=Zm7xKp9CT+sUU4WRzec8CVEpFrLLJdFNgYAi1a92dvtdqPPKabAr6dQ1ygaKwBhaQh1B7M
        vHeaI2YzUCOY3nHlbmeurQavz9gccOovBkvDoEsmUo+eyeYkpBEMpqPcH5Iw86ET2ZMpK0
        V8XJq5OjwzoLNWgDpbJnl3zMaxlG0Bvevf/LKPWFu7UuD8/SSgX6tTh81/mRFyzmz2r9T4
        bUxUgucGyycystzxjpWp2ddmSgxUTqCaZJICMULeqFqG8a1Yqn2vM0bg37svlJM0yq49XG
        h1ck627ETJj80c96ClUDLmUtcUcjHIGtXzAJ9RUPhWiy+KMwpf+tE3vnCpQx6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CVCDvgkqaxh7MYJebjzfGDlcpHL5EV9JmU/3T5/E9o=;
        b=bVf+wnuWrrtIo4HglvFNUtHsGhnWYVuWdv8nO4uJMFQhqNPABIruxkBynt1DXoWmG7hPu5
        lrRlsI5dtVWhuaDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH next v4 14/15] printk: kmsg_dump: remove _nolock() variants
Date:   Wed,  3 Mar 2021 11:15:27 +0100
Message-Id: <20210303101528.29901-15-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/powerpc/xmon/xmon.c    |  4 +--
 include/linux/kmsg_dump.h   | 16 ----------
 kernel/debug/kdb/kdb_main.c |  8 ++---
 kernel/printk/printk.c      | 60 +++++--------------------------------
 4 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 5978b90a885f..bf7d69625a2e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3013,9 +3013,9 @@ dump_log_buf(void)
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
index 36c8c57e1051..906521c2329c 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -57,17 +57,12 @@ struct kmsg_dumper {
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line_nolock(struct kmsg_dump_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len);
-
 bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
 bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind_nolock(struct kmsg_dump_iter *iter);
-
 void kmsg_dump_rewind(struct kmsg_dump_iter *iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
@@ -80,13 +75,6 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line_nolock(struct kmsg_dump_iter *iter,
-					     bool syslog, const char *line,
-					     size_t size, size_t *len)
-{
-	return false;
-}
-
 static inline bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
@@ -99,10 +87,6 @@ static inline bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog
 	return false;
 }
 
-static inline void kmsg_dump_rewind_nolock(struct kmsg_dump_iter *iter)
-{
-}
-
 static inline void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 {
 }
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 8544d7a55a57..67d9f2403b52 100644
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
index 8994bc192b88..602de86d4e76 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3373,7 +3373,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 }
 
 /**
- * kmsg_dump_get_line_nolock - retrieve one kmsg log line (unlocked version)
+ * kmsg_dump_get_line - retrieve one kmsg log line
  * @iter: kmsg dump iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
@@ -3388,22 +3388,22 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  *
  * A return value of FALSE indicates that there are no more records to
  * read.
- *
- * The function is similar to kmsg_dump_get_line(), but grabs no locks.
  */
-bool kmsg_dump_get_line_nolock(struct kmsg_dump_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len)
+bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
+			char *line, size_t size, size_t *len)
 {
 	u64 min_seq = latched_seq_read_nolock(&clear_seq);
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	unsigned long flags;
 	size_t l = 0;
 	bool ret = false;
 
 	if (iter->cur_seq < min_seq)
 		iter->cur_seq = min_seq;
 
+	printk_safe_enter_irqsave(flags);
 	prb_rec_init_rd(&r, &info, line, size);
 
 	/* Read text or count text lines? */
@@ -3424,40 +3424,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dump_iter *iter, bool syslog,
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
- * @iter: kmsg dump iterator
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
-bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
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
@@ -3550,22 +3521,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
-/**
- * kmsg_dump_rewind_nolock - reset the iterator (unlocked version)
- * @iter: kmsg dump iterator
- *
- * Reset the dumper's iterator so that kmsg_dump_get_line() and
- * kmsg_dump_get_buffer() can be called again and used multiple
- * times within the same dumper.dump() callback.
- *
- * The function is similar to kmsg_dump_rewind(), but grabs no locks.
- */
-void kmsg_dump_rewind_nolock(struct kmsg_dump_iter *iter)
-{
-	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
-	iter->next_seq = prb_next_seq(prb);
-}
-
 /**
  * kmsg_dump_rewind - reset the iterator
  * @iter: kmsg dump iterator
@@ -3579,7 +3534,8 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
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

