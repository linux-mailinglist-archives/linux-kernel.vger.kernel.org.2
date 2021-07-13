Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62473C718B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbhGMN5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53228 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbhGMN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:21 -0400
Message-Id: <20210713135158.580966888@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dnvLU+uTr7vwEogkNs6hQ2PurAqpWtxHRlHkc0vgym8=;
        b=l8xBs3UZX9oCUOdGSt+X5E4ZJb03XML9rCS1A1yB55zYqT/iGzDYqY+iLXWe0iKaiuo/mx
        JDvRSAcQyO2oiCIwGUpsNu69PvzVC9EIIgbKHF4kV/G81QJJfzpyLAyR/qBOVxTBdAwooX
        kPLHzz5qdWxEUJmPhsoeIRjeI+OutzDk0FoUF4K4qK3O0rB/3dWVy0Wf0xrqdZkA3EHaX4
        OFZ2GEER91DNvUFcMN5l6Yyhnud2YzVlKbZLHh5HB+IIyrFhD1McbRZMGQGDMbFfIWGqFD
        5DiumyoZewv+iiq+2qFjMJImEYZqh7EXelp3MwrKMOnoVeSrdQMkka7rV6+nig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dnvLU+uTr7vwEogkNs6hQ2PurAqpWtxHRlHkc0vgym8=;
        b=xXbFEQYKAUJ+KVX2ObjHt3Fy4HBwGjL5q31PQcjM0PdJZjrTDT/FFDkEzHeBHIAIOL0OyZ
        BRXD8a5/qJzA+VDg==
Date:   Tue, 13 Jul 2021 15:39:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 07/10] time/timekeeping: Avoid invoking clock_was_set() twice
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
@@ -2127,7 +2127,7 @@ static u64 logarithmic_accumulation(stru
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static void timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
@@ -2198,9 +2198,8 @@ static void timekeeping_advance(enum tim
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
@@ -2209,7 +2208,8 @@ static void timekeeping_advance(enum tim
  */
 void update_wall_time(void)
 {
-	timekeeping_advance(TK_ADV_TICK);
+	if (timekeeping_advance(TK_ADV_TICK))
+		clock_was_set_delayed();
 }
 
 /**
@@ -2389,8 +2389,9 @@ int do_adjtimex(struct __kernel_timex *t
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
-	unsigned long flags;
+	bool clock_set = false;
 	struct timespec64 ts;
+	unsigned long flags;
 	s32 orig_tai, tai;
 	int ret;
 
@@ -2425,6 +2426,7 @@ int do_adjtimex(struct __kernel_timex *t
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		clock_set = true;
 	}
 	tk_update_leap_state(tk);
 
@@ -2435,9 +2437,9 @@ int do_adjtimex(struct __kernel_timex *t
 
 	/* Update the multiplier immediately if frequency was set directly */
 	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		timekeeping_advance(TK_ADV_FREQ);
+		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
-	if (tai != orig_tai)
+	if (clock_set)
 		clock_was_set();
 
 	ntp_notify_cmos_timer();

