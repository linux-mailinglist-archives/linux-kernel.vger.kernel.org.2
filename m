Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588EC36C119
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhD0Iin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhD0Iik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:40 -0400
Message-Id: <20210427083724.318914987@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+ngF/M8dY85HDCykm3jzyBNRwUJX3SzsWZw1Qv6fHnQ=;
        b=0n2AJCYE2dBvJLWKStOonZ95V07ASy4E/k2inud1LTm/HjPg2PCn2BfIm4DNm+vUUZsRwP
        6nu2NPDOZ8gr9IXg8QbSjmMdBoNMVPPNVZU3hMsk1SoukUuxPYEkaKrMu/80cN8Qs8zZQz
        5m/BCuUQgJjKBNCiaimAdovxK+Ikx+EDPkvq4asEi41oNlEskj8lGIVuS+roBq2diH97AM
        JxQ9oERq2bEKGQGsU812R6ChTA4b8QmiI9X3ZMlxG+OiKs3rHPxRkZO4kk4spudeHwHLi6
        1lgUBgKCIprkAUrS2ZSn7BshYJUVB8K/fb2BIIR0HT606gK9twMePP4PntIE2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+ngF/M8dY85HDCykm3jzyBNRwUJX3SzsWZw1Qv6fHnQ=;
        b=wKyNbH1zcSqyH1Nc3Ya9FVDkndYOytjcjc1Ki0ir/z+UaMX0ZBv0ujSIt1MxY/LIzEELho
        ykDyP6GsvpNi2dDA==
Date:   Tue, 27 Apr 2021 10:25:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [patch 3/8] timerfd: Provide timerfd_resume()
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resuming timekeeping is a clock-was-set event and uses the clock-was-set
notification mechanism. This is in the way of making the clock-was-set
update for hrtimers selective so unnecessary IPIs are avoided when a CPU
base does not have timers queued which are affected by the clock setting.

Provide a seperate timerfd_resume() interface so the resume logic and the
clock-was-set mechanism can be distangled in the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/timerfd.c            |   16 ++++++++++++++++
 include/linux/hrtimer.h |    2 ++
 2 files changed, 18 insertions(+)

--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -115,6 +115,22 @@ void timerfd_clock_was_set(void)
 	rcu_read_unlock();
 }
 
+static void timerfd_resume_work(struct work_struct *work)
+{
+	timerfd_clock_was_set();
+}
+
+static DECLARE_WORK(timerfd_work, timerfd_resume_work);
+
+/*
+ * Invoked from timekeeping_resume(). Defer the actual update to work so
+ * timerfd_clock_was_set() runs in task context.
+ */
+void timerfd_resume(void)
+{
+	schedule_work(&timerfd_work);
+}
+
 static void __timerfd_remove_cancel(struct timerfd_ctx *ctx)
 {
 	if (ctx->might_cancel) {
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -349,8 +349,10 @@ hrtimer_expires_remaining_adjusted(const
 
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
+extern void timerfd_resume(void);
 #else
 static inline void timerfd_clock_was_set(void) { }
+static inline void timerfd_resume(void) { }
 #endif
 extern void hrtimers_resume(void);
 

