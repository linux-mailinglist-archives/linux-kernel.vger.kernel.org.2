Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810953C73F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhGMQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhGMQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:06 -0400
Message-Id: <20210713160746.521100804@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tlUoEigPQBH4kXFYwpTe4Usz351++pP85C9s1qCPS/U=;
        b=jtVyna5BU9L/yMxCQLb4AxxMNUYprrvwrA4tbbLUS73qiZb75Ee2D5SSW5OrmlbBYvvv9l
        mcOktNUYW82auXQgy6gbASRF+Fg6Bf68gGZmZUl21KVqt7cZbj058C+L+Zpmx6Y8RwO9Fj
        DM4LGHmB3ZuTAWNOyeE0rJHjC8DWPNMpqL1sW23YGtB4EzyY854X8bQe5YFbh+u5RknETJ
        IznRoBs6LY8mvBai6uPzkwTtpwQXr3NLsYfuFGFCZTGuN4AK3RWJ91gTVVI+qN/7290XF3
        l3NwXutISUNJ7PVVJtFdVWUdJPzDMMFlHPWO9eboAjvYV4t9JuvCJcLgARL54Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tlUoEigPQBH4kXFYwpTe4Usz351++pP85C9s1qCPS/U=;
        b=Oqa/7/LSz2xmUtEE+Sl9bRbOVRk8yjz3ZpSMEGZVFOmB/QlAj/atDhnXNc6i3BCKyRHYIW
        nzdqQ6XMpKHsCcCA==
Date:   Tue, 13 Jul 2021 17:11:00 +0200
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
Subject: [patch 06/50] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER
References: <20210713151054.700719949@linutronix.de>
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
 include/linux/sched/wake_q.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 26a2013ac39c..06cd8fb2f409 100644
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

