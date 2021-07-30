Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E83DBA72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhG3OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbhG3OSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6DC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:18:17 -0700 (PDT)
Message-ID: <20210730135208.527297723@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=oHK7sq9mMxyCH5HIQQc8nkbkCWybT1B8eG5GTIkfAd+kmWKZtnn3UJzISXYB0zrF/b9Jpt
        doJqVWkhZ5gBZTk77awqLEaPlVtHlbQhs9Un/TzaaQk1fAR3DDrJwuvaZXsRTIQ4EQJu35
        h4WoYFGvsQQWWboQ3tFo2AsRJlH+UNmoML3SAoYfjeUlHQrLDlrTAAZ/9YYkwkigBdplhg
        gN0nbG+oLhrmmpRjIszw6bJee1+eePmU7cXAuD8yCu8embZwY+BeGUV5RJKBoe3UD4EVA+
        NDpms8Zx10WIwzK/OUKkKVuqzbM12aYAPxKZnic/1fJiwGVsIHkWV0z8Dd1rsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=zDP11fn+m2SwCB/PwKynM9XcDtma6sw6MFsL0MvuaDTVx0x4U0sitxUB2HrpovNSqAyz07
        /37DGHoy+Z8wacAQ==
Date:   Fri, 30 Jul 2021 15:51:07 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 60/63] preempt: Adjust PREEMPT_LOCK_OFFSET for RT
References: <20210730135007.155909613@linutronix.de>
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

