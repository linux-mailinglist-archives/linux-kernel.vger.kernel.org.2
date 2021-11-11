Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1344DC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhKKUCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233002AbhKKUCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636660782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwMEPPukUouE3TJnzvPhNZWIMakFOyOl2f5Xgk3P81g=;
        b=QrlkI/SQ+6poznaRM1JJBYE2fWt29vqqKKkNfI7IjGSIi+UaSFo6dyuVoqLLTz/f/kKQL3
        bWmlwnCrhVlxbH2TCEqvrgk1Zo4Wf9A5Nki7LVO8qah0IPRd4y1cn9K+F3/nL9+jw2uGCB
        nD4gz/EDvj8emxOJdEh7ZWlLMBdVqL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-foWY9TUdNxGn7jFcOk-P8g-1; Thu, 11 Nov 2021 14:59:39 -0500
X-MC-Unique: foWY9TUdNxGn7jFcOk-P8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ECE5839A4A;
        Thu, 11 Nov 2021 19:59:37 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94B53101E591;
        Thu, 11 Nov 2021 19:59:33 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by slow console devices
Date:   Thu, 11 Nov 2021 16:59:04 -0300
Message-Id: <20211111195904.618253-2-wander@redhat.com>
In-Reply-To: <20211111195904.618253-1-wander@redhat.com>
References: <20211111195904.618253-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a reasonable large dataset to flush in the printk ring
buffer in the presence of a slow console device (like a serial port
with a low baud rate configured), the RCU stall detector may report
warnings.

This patch suppresses RCU stall warnings while flushing the ring buffer
to the console.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/printk/printk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cbc35d586afb..42b622454314 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2588,6 +2588,20 @@ static inline int can_use_console(void)
 	return cpu_online(raw_smp_processor_id()) || have_callable_console();
 }
 
+extern int rcu_cpu_stall_suppress;
+
+static void rcu_console_stall_suppress(void)
+{
+	if (!rcu_cpu_stall_suppress)
+		rcu_cpu_stall_suppress = 4;
+}
+
+static void rcu_console_stall_unsuppress(void)
+{
+	if (rcu_cpu_stall_suppress == 4)
+		rcu_cpu_stall_suppress = 0;
+}
+
 /**
  * console_unlock - unlock the console system
  *
@@ -2634,6 +2648,9 @@ void console_unlock(void)
 	 * and cleared after the "again" goto label.
 	 */
 	do_cond_resched = console_may_schedule;
+
+	rcu_console_stall_suppress();
+
 again:
 	console_may_schedule = 0;
 
@@ -2645,6 +2662,7 @@ void console_unlock(void)
 	if (!can_use_console()) {
 		console_locked = 0;
 		up_console_sem();
+		rcu_console_stall_unsuppress();
 		return;
 	}
 
@@ -2716,8 +2734,10 @@ void console_unlock(void)
 
 		handover = console_lock_spinning_disable_and_check();
 		printk_safe_exit_irqrestore(flags);
-		if (handover)
+		if (handover) {
+			rcu_console_stall_unsuppress();
 			return;
+		}
 
 		if (do_cond_resched)
 			cond_resched();
@@ -2738,6 +2758,8 @@ void console_unlock(void)
 	retry = prb_read_valid(prb, next_seq, NULL);
 	if (retry && console_trylock())
 		goto again;
+
+	rcu_console_stall_unsuppress();
 }
 EXPORT_SYMBOL(console_unlock);
 
-- 
2.27.0

