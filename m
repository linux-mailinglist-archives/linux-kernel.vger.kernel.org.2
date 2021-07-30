Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16CB3DBA40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhG3OUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbhG3ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A424C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:10 -0700 (PDT)
Message-ID: <20210730135205.491944910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=gMAfFdA6OhUpRUjW8cMAa+bV+9k/axIXU5S/p0IjNLvJnxFcBVVPSGCxdCOmsQg5vAHgNC
        923SO7w5Vn6Fy24Z3nUpZ9oIr3DDtfYfEwc95urxF5Q/zirKpCY6A/JRmZ30Na1eG2GgB/
        irvDJpo8D3X+ZCz6cw7ZH0arGTc5FDcpaoa/TdG440nWHHNWiagOhJi8LX/sxtuippUjnm
        /W6dWZjLIcyEpP4cq/HPCH+cClxWAO87E0LyDJxSiVeLyTtp007534Ny9Mo4EOAGpV30rL
        Y+TydSMeJ/1ISMDRQ5EnS2pAxY4GrfRyPKfMInW9mpWCewV/LmDwpd+VKlwGwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=l9CPcnQ40sEIaWIfcu9A7joI1XjRiPg3cjxjqMJdZk9auh+Q5hURtbJmMcyVy6E9dLDViU
        Y4qQC8iuEFLWt+CA==
Date:   Fri, 30 Jul 2021 15:50:13 +0200
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
Subject: [patch 06/63] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

