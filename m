Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027263E90A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhHKMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50272 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbhHKMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:03 -0400
Message-ID: <20210811121414.546749057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=h1OD9jieTATsTKN1Y9tP75EDhm6c3pYePrqhSiXuol3jUnPr29gD/KV84cp7LTSgFIzwQl
        /T2Dgat1HOXpRTF+YyLVxKIOrPoxVkkO/tp4xoYuhDmEZ5u0YmO0xSTBm+cKwqjoM1ch79
        DDjkZ5AbXfDD+wGWz7jVMmSSQfqH5EWGhyGkcDjNJrUcB6dP3xlckZ3fCBKRvbdMDS0rqW
        IgiN5p1vd++QWoiVuHx4nmMMAqS+6dtov0ySlBPzSLJtZFWaLAmxp2wKJks5bCm9HDjOLp
        kk6GBJMYct3/nhlXcouYEszGP16F5rxVHEniz0y7DnyL13CGGnvwEDKVPS+1SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=aDxZJU8tjmAKK58NMit9bRQBnA9izEQ7I9EYnnLQStWLzXK2EQzfKLagaZjrWYTTdQtOU/
        sZ0JN1qWqGHoKLAQ==
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
Subject: [patch V4 07/68] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:39 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The RT specific spin/rwlock implementation requires special handling of the
to be woken waiters. Provide a WAKE_Q_HEAD_INITIALIZER which can be used by
the rtmutex code to implement a RT aware wake_q derivative.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/wake_q.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -42,8 +42,11 @@ struct wake_q_head {
 
 #define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
 
-#define DEFINE_WAKE_Q(name)				\
-	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
+#define WAKE_Q_HEAD_INITIALIZER(name)				\
+	{ WAKE_Q_TAIL, &name.first }
+
+#define DEFINE_WAKE_Q(name)					\
+	struct wake_q_head name = WAKE_Q_HEAD_INITIALIZER(name)
 
 static inline void wake_q_init(struct wake_q_head *head)
 {

