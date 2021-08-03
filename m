Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD083DEEDE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhHCNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhHCNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:17 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Qr1/Kql4O0uUbgY9eaNCn9AjwMvkGvYOIbAKwtn7DQ=;
        b=l7gAQM6vPEFU3q48/AIDY/E5KMgsfBKluKK2sHEkc6iK5ofJlzL6jlU/2MkzrD4ND8sFB5
        CE+7+MVik84513uwVP0Fk/HJYNulgNtEdffhPmgZm8JdFebQ6sUaKOHKNgw170FoGj3S4/
        GiCNLOjt7gQX+H8SAO+futriABH1bpyFHzyF1/vCVleMmG1lF63lJOspnFYnH1WRf4uCwR
        BORqpgsMsJuim+9JoOQS/x7acqw7OcEanCBDJcwTRuq/k+02sv4tZGn+vaEvxi5ei8b+oo
        BptfMVYEVTCbDFc68eIEneJlPcyhnzG3UtKwsfptX8TC2gVIpr+shb9XKNzotg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Qr1/Kql4O0uUbgY9eaNCn9AjwMvkGvYOIbAKwtn7DQ=;
        b=8iQnPrlVkMTkTFvufX6/nDahtEIhBbn10FVm0uK/6R1D0PUjy7CGZKIbkQcFlQFzpyZ5fX
        ie151AQHliJ/tFCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 04/10] printk: relocate printk_delay()
Date:   Tue,  3 Aug 2021 15:18:55 +0206
Message-Id: <20210803131301.5588-5-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move printk_delay() "as is" further up so that it can be used by
new functions in an upcoming commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b546e117f10..8bdfac4c9ee9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1875,6 +1875,20 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+int printk_delay_msec __read_mostly;
+
+static inline void printk_delay(void)
+{
+	if (unlikely(printk_delay_msec)) {
+		int m = printk_delay_msec;
+
+		while (m--) {
+			mdelay(1);
+			touch_nmi_watchdog();
+		}
+	}
+}
+
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -2129,20 +2143,6 @@ static u8 *__printk_recursion_counter(void)
 		local_irq_restore(flags);		\
 	} while (0)
 
-int printk_delay_msec __read_mostly;
-
-static inline void printk_delay(void)
-{
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
-
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
-}
-
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-- 
2.20.1

