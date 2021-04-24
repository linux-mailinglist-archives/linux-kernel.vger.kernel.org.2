Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6636A197
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhDXO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhDXO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:29:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:28:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d10so37110584pgf.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTPHG3ZQxyB7UgXq6RIgSrPKdFPuuTXRg5DyuPKAK+Y=;
        b=Z4f8A1pgTdnYeGDwMpAVGp0ANw7J6FCB5NT7v7t2J4FrgeFfUtmeUAsPIMyKiM+taR
         IkKW+q+XQs/flRjn46p0JEa5BXJ56dyWcgl0WZ5+iwryjbW+BpkD3sDPXn1snfRtuEXZ
         jNlESlEC5JAG9Xy9XdvutSnejlCqtbLHt6axrr1rRjbmzR1l+taRPPEKnAE7ZuV/xsp1
         96h3kZJooNoh55+n5pSFrcrzYXScvPnSsIY3ypka68GVXuSQQ0xngqYoUB8ALbe5jPcG
         vu5KvKI9cpMMadDeJ+95yIxyAEXjq62OlEmQiYgrMd8j0ykGlWsmD2z5nN5tKbyiDT65
         epIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTPHG3ZQxyB7UgXq6RIgSrPKdFPuuTXRg5DyuPKAK+Y=;
        b=MwV8Zv+1lCWhnjO33Mas65lj+nzzntflknwskg6E+BqNvqF612iB6EjmxZxOk87vs1
         7yAj0KpKjv7l1FaJjDkX4nTNUzTrcMTTIqQatWmp/pbcrClaRcUxH/bNjN6nDniT8z2M
         mCKJAs4dsrdOZqA4JnffBgGuB8IEdZeN7kkeAhwW0xYUQpbW+nNj0KUetFbI34yctSKv
         agv1WVAvx7MWu1HsVm2R62ANvf7oZZ9IXhKji6e2s4k+G0v8/4mvywxdwoibRbs1qst7
         /J9Kd3yfKj8A35qtE8Gd5SER8c3C7BYCd+1P9S1eCE5j8lyqxt5iyGJ8TnlWoFGQoUaV
         e6tQ==
X-Gm-Message-State: AOAM531Rl8SUuhTQdvkQ8Kmpn3L+/cdQjYNT7D5Knre+NtY5AaHlGNSv
        hPM0xObTckgIC86lEuMkCBk=
X-Google-Smtp-Source: ABdhPJxssnvTRDKAPb3Hm5AdHBbOCMP/gfE5aNi3TIC6Ow4QeiX3LqvKq5GfZUJIccF/ds71L8fdLw==
X-Received: by 2002:a05:6a00:1aca:b029:25a:b810:94c7 with SMTP id f10-20020a056a001acab029025ab81094c7mr8816605pfv.15.1619274510313;
        Sat, 24 Apr 2021 07:28:30 -0700 (PDT)
Received: from hyeyoo.42seoul.kr ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id p126sm7547455pga.86.2021.04.24.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 07:28:30 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] kernel/locking: make __down_common use flags previously saved
Date:   Sat, 24 Apr 2021 23:28:23 +0900
Message-Id: <20210424142823.3896-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

down, down_interruptible, down_killable, and down_timeout
call raw_spin_lock_irqsave that saves current status to flags.

but in __down_common, that is called by functions above, calls
raw_spin_lock_irq and raw_spin_unlock_irq regardless of flags previously saved.

this mismatch can potentially cause problem.
so made __down_common use raw_spin_lock_irqsave and raw_spin_unlock_irqrestore.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 kernel/locking/semaphore.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9aa855a96c4a..0ea174223441 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,10 +33,10 @@
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
 
-static noinline void __down(struct semaphore *sem);
-static noinline int __down_interruptible(struct semaphore *sem);
-static noinline int __down_killable(struct semaphore *sem);
-static noinline int __down_timeout(struct semaphore *sem, long timeout);
+static noinline void __down(struct semaphore *sem, unsigned long flags);
+static noinline int __down_interruptible(struct semaphore *sem, unsigned long flags);
+static noinline int __down_killable(struct semaphore *sem, unsigned long flags);
+static noinline int __down_timeout(struct semaphore *sem, long timeout, unsigned long flags);
 static noinline void __up(struct semaphore *sem);
 
 /**
@@ -58,7 +58,7 @@ void down(struct semaphore *sem)
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
-		__down(sem);
+		__down(sem, flags);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
 }
 EXPORT_SYMBOL(down);
@@ -81,7 +81,7 @@ int down_interruptible(struct semaphore *sem)
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
-		result = __down_interruptible(sem);
+		result = __down_interruptible(sem, flags);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
 
 	return result;
@@ -107,7 +107,7 @@ int down_killable(struct semaphore *sem)
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
-		result = __down_killable(sem);
+		result = __down_killable(sem, flags);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
 
 	return result;
@@ -161,7 +161,7 @@ int down_timeout(struct semaphore *sem, long timeout)
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
-		result = __down_timeout(sem, timeout);
+		result = __down_timeout(sem, timeout, flags);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
 
 	return result;
@@ -202,7 +202,7 @@ struct semaphore_waiter {
  * 'timeout' parameter for the cases without timeouts.
  */
 static inline int __sched __down_common(struct semaphore *sem, long state,
-								long timeout)
+					long timeout, unsigned long flags)
 {
 	struct semaphore_waiter waiter;
 
@@ -216,9 +216,9 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 		if (unlikely(timeout <= 0))
 			goto timed_out;
 		__set_current_state(state);
-		raw_spin_unlock_irq(&sem->lock);
+		raw_spin_unlock_irqrestore(&sem->lock, flags);
 		timeout = schedule_timeout(timeout);
-		raw_spin_lock_irq(&sem->lock);
+		raw_spin_lock_irqsave(&sem->lock, flags);
 		if (waiter.up)
 			return 0;
 	}
@@ -232,24 +232,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 	return -EINTR;
 }
 
-static noinline void __sched __down(struct semaphore *sem)
+static noinline void __sched __down(struct semaphore *sem, unsigned long flags)
 {
-	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT, flags);
 }
 
-static noinline int __sched __down_interruptible(struct semaphore *sem)
+static noinline int __sched __down_interruptible(struct semaphore *sem,
+							unsigned long flags)
 {
-	return __down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+	return __down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT,
+									flags);
 }
 
-static noinline int __sched __down_killable(struct semaphore *sem)
+static noinline int __sched __down_killable(struct semaphore *sem,
+							unsigned long flags)
 {
-	return __down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
+	return __down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT, flags);
 }
 
-static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
+static noinline int __sched __down_timeout(struct semaphore *sem,
+					long timeout, unsigned long flags)
 {
-	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
+	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout, flags);
 }
 
 static noinline void __sched __up(struct semaphore *sem)
-- 
2.25.1

