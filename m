Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B93E1892
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhHEPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbhHEPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:56 -0400
Message-ID: <20210805153956.392899146@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=gyatUV6yQz3rIdZD6Hsa6xB/WxJBMBkjcsYal5XybiPZf5jty+87i7rmR4RxQ4HCaQLwyv
        tzmikb8fuqUMc7rAwd4qXMV4esk1BrgvLefZJg6RUyyYsn+RzLeLD/WD7fBvUfu5iDfYLt
        KJCko3YBWgBJKuMBAbKiJytxpyb4P9pGV7nvMmCwzaRtMOMr56fzlxHBz0hhxBsko4tcdM
        60jDf+C1UOCPHefQjjO9FHQDd6Ay4C2/HoY0BHyhrJr9pH0K/rmjLzWHm9PIARaSL2Bv1L
        iuAe7D5iQTk1LRjd4CGeq2h38SIj+7q9k/zmiTZhtUofOEfW1kLCkjFrANgQsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=LO7xl0Bdehp2MG5bpn5bNC+rFfNKBqrBAK3GV4yuOvKn+kButmTmu7+/IqxyNmAJmrXlw9
        fCINkkLD6/R+VfBw==
Date:   Thu, 05 Aug 2021 17:14:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 62/64] preempt: Adjust PREEMPT_LOCK_OFFSET for RT
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT regular spinlocks and rwlocks are substituted with rtmutex
based constructs. spin/rwlock held regions are preemptible on PREEMPT_RT,
so PREEMPT_LOCK_OFFSET has to be 0 to make the various cond_resched_*lock()
functions work correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -121,7 +121,11 @@
 /*
  * The preempt_count offset after spin_lock()
  */
+#if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#else
+#define PREEMPT_LOCK_OFFSET	0
+#endif
 
 /*
  * The preempt_count offset needed for things like:

