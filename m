Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3D3DEEE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhHCNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE4C061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:13:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBZxalqluOqBwUp0oMToaz0x30OWgLLYk1iiNzqwZd0=;
        b=frPs0YbzNW72eq9iEhQY0g+CpnaKsUoVnK4CXGiB0hUvPtP7hafaW7ZZrKz0ySBa28znkM
        fPWhXt6U+EgV0CTlOuessbceZ05stZBhSwe8acpB6DxNDi00A0WiuZDfg+3ZRWyz5e4rQi
        jqSxMNt13DbJouw48Iry74w6u1Doe7SWGZ5zeITyyom6NnaG/InC4yywHTSBFAnuD2GHm9
        xLEO8g16MPivXzA9EGxSLlmBlo0WSh5k+24IsqHf+wLoNrIJYuVeSMBdYTExmTLO2wYC9n
        CLzPTusXlZHOrw5CgvjUmgN2dxYRlvUjGB24QhTXf7nLNl3UdAulrOlRSCQ2FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBZxalqluOqBwUp0oMToaz0x30OWgLLYk1iiNzqwZd0=;
        b=fzBM2SU+NwWZYoU8vTDqHLuFBUa5vy2aNsjgja4vAFfxo0poGQ2Mm4TEE2yHRs4Pv2D7Te
        0c5w4HE05uxkXTAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 06/10] printk: use seqcount_latch for console_seq
Date:   Tue,  3 Aug 2021 15:18:57 +0206
Message-Id: <20210803131301.5588-7-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for synchronous printing, change @console_seq to use
seqcount_latch so that it can be read without requiring @console_sem.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 73 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d07d98c1e846..f8f46d9fba9b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -489,9 +489,7 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
-/* All 3 protected by @console_sem. */
-/* the next printk record to write to the console */
-static u64 console_seq;
+/* Both protected by @console_sem. */
 static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
 
@@ -500,6 +498,17 @@ struct latched_seq {
 	u64			val[2];
 };
 
+/*
+ * The next printk record to write to the console. There are two
+ * copies (updated with seqcount_latch) so that reads can locklessly
+ * access a valid value. Writers are synchronized by @console_sem.
+ */
+static struct latched_seq console_seq = {
+	.latch		= SEQCNT_LATCH_ZERO(console_seq.latch),
+	.val[0]		= 0,
+	.val[1]		= 0,
+};
+
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
@@ -563,7 +572,7 @@ bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
-/* Must be called under syslog_lock. */
+/* Must be called under associated write-protection lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
@@ -2405,9 +2414,9 @@ EXPORT_SYMBOL(_printk);
 
 #define prb_read_valid(rb, seq, r)	false
 #define prb_first_valid_seq(rb)		0
+#define latched_seq_read_nolock(seq)	0
+#define latched_seq_write(dst, src)
 
-static u64 syslog_seq;
-static u64 console_seq;
 static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
 
@@ -2735,7 +2744,7 @@ void console_unlock(void)
 	bool do_cond_resched, retry;
 	struct printk_info info;
 	struct printk_record r;
-	u64 __maybe_unused next_seq;
+	u64 seq;
 
 	if (console_suspended) {
 		up_console_sem();
@@ -2779,12 +2788,14 @@ void console_unlock(void)
 		size_t len;
 
 skip:
-		if (!prb_read_valid(prb, console_seq, &r))
+		seq = latched_seq_read_nolock(&console_seq);
+		if (!prb_read_valid(prb, seq, &r))
 			break;
 
-		if (console_seq != r.info->seq) {
-			console_dropped += r.info->seq - console_seq;
-			console_seq = r.info->seq;
+		if (seq != r.info->seq) {
+			console_dropped += r.info->seq - seq;
+			latched_seq_write(&console_seq, r.info->seq);
+			seq = r.info->seq;
 		}
 
 		if (suppress_message_printing(r.info->level)) {
@@ -2793,13 +2804,13 @@ void console_unlock(void)
 			 * directly to the console when we received it, and
 			 * record that has level above the console loglevel.
 			 */
-			console_seq++;
+			latched_seq_write(&console_seq, seq + 1);
 			goto skip;
 		}
 
 		/* Output to all consoles once old messages replayed. */
 		if (unlikely(exclusive_console &&
-			     console_seq >= exclusive_console_stop_seq)) {
+			     seq >= exclusive_console_stop_seq)) {
 			exclusive_console = NULL;
 		}
 
@@ -2820,7 +2831,7 @@ void console_unlock(void)
 		len = record_print_text(&r,
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time);
-		console_seq++;
+		latched_seq_write(&console_seq, seq + 1);
 
 		/*
 		 * While actively printing out messages, if another printk()
@@ -2848,9 +2859,6 @@ void console_unlock(void)
 			cond_resched();
 	}
 
-	/* Get consistent value of the next-to-be-used sequence number. */
-	next_seq = console_seq;
-
 	console_locked = 0;
 	up_console_sem();
 
@@ -2860,7 +2868,7 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	retry = prb_read_valid(prb, next_seq, NULL);
+	retry = prb_read_valid(prb, latched_seq_read_nolock(&console_seq), NULL);
 	if (retry && console_trylock())
 		goto again;
 }
@@ -2912,18 +2920,19 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
-	/*
-	 * If someone else is holding the console lock, trylock will fail
-	 * and may_schedule may be set.  Ignore and proceed to unlock so
-	 * that messages are flushed out.  As this can be called from any
-	 * context and we don't want to get preempted while flushing,
-	 * ensure may_schedule is cleared.
-	 */
-	console_trylock();
-	console_may_schedule = 0;
-
-	if (mode == CONSOLE_REPLAY_ALL)
-		console_seq = prb_first_valid_seq(prb);
+	if (console_trylock()) {
+		if (mode == CONSOLE_REPLAY_ALL)
+			latched_seq_write(&console_seq, prb_first_valid_seq(prb));
+	} else {
+		/*
+		 * Another context is holding the console lock and
+		 * @console_may_schedule may be set. Ignore and proceed to
+		 * unlock so that messages are flushed out. As this can be
+		 * called from any context and we don't want to get preempted
+		 * while flushing, ensure @console_may_schedule is cleared.
+		 */
+		console_may_schedule = 0;
+	}
 	console_unlock();
 }
 
@@ -3159,11 +3168,11 @@ void register_console(struct console *newcon)
 		 * ignores console_lock.
 		 */
 		exclusive_console = newcon;
-		exclusive_console_stop_seq = console_seq;
+		exclusive_console_stop_seq = latched_seq_read_nolock(&console_seq);
 
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		console_seq = syslog_seq;
+		latched_seq_write(&console_seq, syslog_seq);
 		mutex_unlock(&syslog_lock);
 	}
 	console_unlock();
-- 
2.20.1

