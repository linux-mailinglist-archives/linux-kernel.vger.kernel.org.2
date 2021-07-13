Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF43C7188
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhGMN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhGMN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4972C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:29 -0700 (PDT)
Message-Id: <20210713135158.395287410@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=osj+ks1cOu8NjNNx7rqOTsPuHKywEGIXMM1hlLfNxco=;
        b=eKqAjQpkdODJ7G/LRgGDYSX3/FMcAS1pdyy+Q37ayMX3hGdJkhd6TkxGh57En7iFaUjVRA
        7BLmTqUWP1SpAfqbRQIU3wV3LRXGexoF98VuRUuMiR9mRjw9fgocVCD7cMxzfQZC4CzaNC
        mV3tx4rciTcBIWbFSRpCPL5gvvhMJ1yIPkY8lV52ELAmbzEIjNxF5Wvt6BvJUE15SexuNn
        jRgNKp5mRiZI5+hz8g+5jN5c2vTORmc7nYnA4c7C8lXMC7HQ+FY9VcdSgzmk4JF7J9Cx6U
        iTaypw5mwo0Eb60JQKyK7v+RAqo6cDpj0Y1J2hxkyU7FbWi1VYeDZas0rWxgrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=osj+ks1cOu8NjNNx7rqOTsPuHKywEGIXMM1hlLfNxco=;
        b=m/PZ9T4HZxHu2wrh8SGlOl1T7LeCyh3HAxq+5O2UKMCufHp6CQyALMqo2isXdm/3D/owbt
        /RLT8V5WuyDL6/CQ==
Date:   Tue, 13 Jul 2021 15:39:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 05/10] timerfd: Provide timerfd_resume()
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
 


