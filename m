Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9636C120
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhD0Iiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhD0Iim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:42 -0400
Message-Id: <20210427083724.542646194@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZfQPUmFK3i1rendKXuXOwZFwcyhEqPqcrvIv3liPQ4M=;
        b=1ITDX4YkLMthIK9c/TRUNUUlvSJFYZyTFWr+7c2gokcDCXyzeqaGsXbfRGpnas9iFcb6kr
        jjNTn+fqVyiSQ+T5lrgg7ojsJFJLTxxChIrrls0BVpZAF84fGMZz2wqmYxOpPCP2qYzLMS
        dgajNJ54K3dYhXLy3t3nagt99aka7TIRafOv907fJzbzqgO+6tBg6hl2Z6rDnw8zycexl6
        jCmTBM6fCezt0+xx1C5gQwXpcYI+q+3RJ2Tn7ICtEwlvpDYUixyBher7Q0NJArGpgMjTZO
        cAozYN+l/lCXWhk3Bb37ygT1o+AOjSTvVO2ieQd3oaqg8SMbtf//b/kyD/CsTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZfQPUmFK3i1rendKXuXOwZFwcyhEqPqcrvIv3liPQ4M=;
        b=WQkOeGrSJ8+XuT5DB5vFu/QTqUpGWV84Rycb05FyYBBB9/pQPAbfJxGObL5BJNr2qxlTXM
        ZBlBXTkKaOf4A/BA==
Date:   Tue, 27 Apr 2021 10:25:42 +0200
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
Subject: [patch 5/8] time/timekeeping: Avoid invoking clock_was_set() twice
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_adjtimex() might end up scheduling a delayed clock_was_set() via
timekeeping_advance() and then invoke clock_was_set() directly which is
pointless.

Make timekeeping_advance() return whether an invocation of clock_was_set()
is required and handle it at the call sites which allows do_adjtimex() to
issue a single direct call if required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2126,7 +2126,7 @@ static u64 logarithmic_accumulation(stru
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static void timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
@@ -2197,9 +2197,8 @@ static void timekeeping_advance(enum tim
 	write_seqcount_end(&tk_core.seq);
 out:
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-	if (clock_set)
-		/* Have to call _delayed version, since in irq context*/
-		clock_was_set_delayed();
+
+	return !!clock_set;
 }
 
 /**
@@ -2208,7 +2207,8 @@ static void timekeeping_advance(enum tim
  */
 void update_wall_time(void)
 {
-	timekeeping_advance(TK_ADV_TICK);
+	if (timekeeping_advance(TK_ADV_TICK))
+		clock_was_set_delayed();
 }
 
 /**
@@ -2388,8 +2388,9 @@ int do_adjtimex(struct __kernel_timex *t
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
-	unsigned long flags;
+	bool clock_set = false;
 	struct timespec64 ts;
+	unsigned long flags;
 	s32 orig_tai, tai;
 	int ret;
 
@@ -2424,6 +2425,7 @@ int do_adjtimex(struct __kernel_timex *t
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		clock_set = true;
 	}
 	tk_update_leap_state(tk);
 
@@ -2434,9 +2436,9 @@ int do_adjtimex(struct __kernel_timex *t
 
 	/* Update the multiplier immediately if frequency was set directly */
 	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		timekeeping_advance(TK_ADV_FREQ);
+		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
-	if (tai != orig_tai)
+	if (clock_set)
 		clock_was_set();
 
 	ntp_notify_cmos_timer();

