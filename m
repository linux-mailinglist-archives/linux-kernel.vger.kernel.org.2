Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64AA44DC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhKKTmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636659567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0cPNm28FmvGF69nKmphcoBlWDfSJ5fX9zp/LDfDQQ3I=;
        b=ESv2zq0JBoePMmhLHgLMkuONywnUE7CEHp8QqgL/jEPRsmb4Dd3JBxJoZfci9v2mS3Aywh
        34U3bin+ml+3hBL3onpERo8JDaerPdt9UkXZYtz1L48ea/zWZ6dzekSd6jjHRKFaZM6jm2
        TlYkGhGvZq0wjdxgO/g/KJ6RYoXGN30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-xsjv7s98MNy1w2U9edKmGg-1; Thu, 11 Nov 2021 14:39:26 -0500
X-MC-Unique: xsjv7s98MNy1w2U9edKmGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EAB19057A0;
        Thu, 11 Nov 2021 19:39:25 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1685219D9D;
        Thu, 11 Nov 2021 19:39:17 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] printk: suppress rcu stall warnings caused by slow console devices
Date:   Thu, 11 Nov 2021 16:38:54 -0300
Message-Id: <20211111193854.616163-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 kernel/printk/printk.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 142a58d124d9..cb995f8d4f8a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2523,6 +2523,20 @@ static inline int can_use_console(void)
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
@@ -2568,6 +2582,9 @@ void console_unlock(void)
 	 * and cleared after the "again" goto label.
 	 */
 	do_cond_resched = console_may_schedule;
+
+	rcu_console_stall_suppress();
+
 again:
 	console_may_schedule = 0;
 
@@ -2579,6 +2596,7 @@ void console_unlock(void)
 	if (!can_use_console()) {
 		console_locked = 0;
 		up_console_sem();
+		rcu_console_stall_unsuppress();
 		return;
 	}
 
@@ -2645,6 +2663,7 @@ void console_unlock(void)
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
+			rcu_console_stall_unsuppress();
 			return;
 		}
 
@@ -2669,6 +2688,8 @@ void console_unlock(void)
 
 	if (retry && console_trylock())
 		goto again;
+
+	rcu_console_stall_unsuppress();
 }
 EXPORT_SYMBOL(console_unlock);
 
-- 
2.27.0

