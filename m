Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B1325799
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhBYU1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:27:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhBYUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:27 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAnJIgR/CTnBt9x/EHKtesHS7Vx5fct1XicfsTWpa/Y=;
        b=svK53kI/q3MoJRtnVKyEA9QIRM7RnbBbT6oE/t37t6hVUt2RspYJL0F0oZjb7FcP+n0UKS
        y4E6rgYXugMcj//f4+y9g1LgLZ9aBw87rCAB7JzAO7RAgCCc7U6XeWzBZHWLhyKAbUX8Ph
        HH1QiQlgFouckYMeOqrmy1/1xrNjgkYLpWDuUDjpcLH8S5wU6HpTz/h1axvDI6YjXIpf/H
        ID7uJPpQOTBsK90vp0pUgRjw7Yxg/AQLlHDWyGn8//JVsK3aHAXRejxL2Lvl3KqrBPPlhr
        LWzPOtj20R+Vfkflptt/cagFZnp5rxhUEQ1ALCCKtUQgRsk239XmCQTNdyYFug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAnJIgR/CTnBt9x/EHKtesHS7Vx5fct1XicfsTWpa/Y=;
        b=euv5naXleiYhIzMoGwsLYwhFgjx5t5FAgtl24pUMCQQSNQ3OtjZOL9hMIEicpxI+1W3yQn
        +eouYuqb7WvtixBg==
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
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH next v3 11/15] printk: kmsg_dumper: remove @active field
Date:   Thu, 25 Feb 2021 21:24:34 +0100
Message-Id: <20210225202438.28985-12-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 6 kmsg_dumpers do not benefit from the @active flag:

  (provide their own synchronization)
  - arch/powerpc/kernel/nvram_64.c
  - arch/um/kernel/kmsg_dump.c
  - drivers/mtd/mtdoops.c
  - fs/pstore/platform.c

  (only dump on KMSG_DUMP_PANIC, which does not require
  synchronization)
  - arch/powerpc/platforms/powernv/opal-kmsg.c
  - drivers/hv/vmbus_drv.c

The other 2 kmsg_dump users also do not rely on @active:

  (hard-code @active to always be true)
  - arch/powerpc/xmon/xmon.c
  - kernel/debug/kdb/kdb_main.c

Therefore, @active can be removed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/xmon/xmon.c    |  2 +-
 include/linux/kmsg_dump.h   |  2 --
 kernel/debug/kdb/kdb_main.c |  2 +-
 kernel/printk/printk.c      | 10 +---------
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3fe37495f63d..80ed3e1becf9 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3001,7 +3001,7 @@ print_address(unsigned long addr)
 static void
 dump_log_buf(void)
 {
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper dumper;
 	unsigned char buf[128];
 	size_t len;
 
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 070c994ff19f..84eaa2090efa 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,7 +36,6 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
- * @active:	Flag that specifies if this is currently dumping
  * @cur_seq:	Points to the oldest message to dump
  * @next_seq:	Points after the newest message to dump
  */
@@ -44,7 +43,6 @@ struct kmsg_dumper {
 	struct list_head list;
 	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
 	enum kmsg_dump_reason max_reason;
-	bool active;
 	bool registered;
 
 	/* private state of the kmsg iterator */
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 930ac1b25ec7..315169d5e119 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2101,7 +2101,7 @@ static int kdb_dmesg(int argc, const char **argv)
 	int adjust = 0;
 	int n = 0;
 	int skip = 0;
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper dumper;
 	size_t len;
 	char buf[201];
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c2ed7db8930b..45cb3e9c62c5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3408,8 +3408,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 			continue;
 
 		/* initialize iterator with data about the stored records */
-		dumper->active = true;
-
 		logbuf_lock_irqsave(flags);
 		dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 		dumper->next_seq = prb_next_seq(prb);
@@ -3417,9 +3415,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason);
-
-		/* reset iterator */
-		dumper->active = false;
 	}
 	rcu_read_unlock();
 }
@@ -3454,9 +3449,6 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 	prb_rec_init_rd(&r, &info, line, size);
 
-	if (!dumper->active)
-		goto out;
-
 	/* Read text or count text lines? */
 	if (line) {
 		if (!prb_read_valid(prb, dumper->cur_seq, &r))
@@ -3542,7 +3534,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	if (!dumper->active || !buf || !size)
+	if (!buf || !size)
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-- 
2.20.1

