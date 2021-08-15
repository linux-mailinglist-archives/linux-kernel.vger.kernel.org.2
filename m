Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F463ECB24
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhHOV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHOV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC57C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:27:51 -0700 (PDT)
Message-ID: <20210815211302.429918071@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=11LzPJUybhIyRxhgWwOLzp1JZ6zGh4AwgW5VsGWZYnlWjT5wLkUnLfcJkNpZ8dPO8HDHrI
        AeHgYtSE6pOx8oMeo7kp5dfGdY4kL2OsV99qwNIKt0YnJMnTTSvCD1xCoPo8gXz6hId1C5
        fzRLEPttczVdSuppfZ0hb9NULNwGEU+e8cXW4o4kf3PgTg0gpsIX/JB4dv3W/ZQoyGcl2b
        ERabq1ke2uNxuGSBQdVKTwctRmnrUNUIWQ7TO05VK0YvPgpGGONtK8AUVb6xPRx4UPlwnJ
        iuTpxFoTpRlGgCUWPetDXhIyVO6eLVMwb7rAgEggxS8PKx0nzmxqBNHXYzRe1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7CBCUxlgHeb+vOFixqTSYYb16Nxvav4y8tgc2d3NAcQ=;
        b=72GSGSsKuwaCOpKxbRhsgqPAgoDO16RwA3yvQWWEVeM3MMVSGHZxrRGKjO+zmq+HqKU3Nh
        zp1ADK6K9X+cNqAA==
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
Subject: [patch V5 09/72] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:49 +0200 (CEST)
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

