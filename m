Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAF3FEB90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbhIBJtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:49:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42686 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbhIBJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:49:49 -0400
Message-ID: <20210902094414.618613025@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630576130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T5lG5uLv15TVF5sEvsiG4FEpF8NOkNLs+0ILPxhTva8=;
        b=IJyuzFBjWJ4md5dwY0w4EEUUlq4/N8mkVInB5yCMhPtAQJ/zh64fyESyN7DfZN1KZbpfzI
        anzyBhACWeRjybmEfbfMbzUGBGl3Gt3yVyRd5XXHdeYWETiD3xJaTj/051ptWDvNrU97dF
        64ltXe+29PjGAGkJ16SE01rhr8uoT7UiL7WEK0ZkS+XdelaIKWw0YxoMrKqxrwW0erR137
        OUXkaNnZzYuv/g1nyK1MMGw/ervmtgBk686q/Z+CtISX1DHkLsCUZ8LdSNcoSB2vyeq9Mp
        R1809SLF9MgDKuKXcK8myUSoEq8UlVeTF7f4TYcTyfL1NW01JsIcXg6F/miEEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630576130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T5lG5uLv15TVF5sEvsiG4FEpF8NOkNLs+0ILPxhTva8=;
        b=WEjLxktHNOFp5HLTj5F3ltxZCoFyhh1bEKTWlYJNlTAagjuSO+j9G9mybsLywde3vmcVNi
        odkSrt4VJzxbZUAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 2/3] futex: Clarify comment for requeue_pi_wake_futex()
References: <20210902093755.087908334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Thu,  2 Sep 2021 11:48:50 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's slightly confusing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1954,12 +1954,26 @@ static inline int futex_requeue_pi_wakeu
  * @hb:		the hash_bucket of the requeue target futex
  *
  * During futex_requeue, with requeue_pi=1, it is possible to acquire the
- * target futex if it is uncontended or via a lock steal.  Set the futex_q key
- * to the requeue target futex so the waiter can detect the wakeup on the right
- * futex, but remove it from the hb and NULL the rt_waiter so it can detect
- * atomic lock acquisition.  Set the q->lock_ptr to the requeue target hb->lock
- * to protect access to the pi_state to fixup the owner later.  Must be called
- * with both q->lock_ptr and hb->lock held.
+ * target futex if it is uncontended or via a lock steal.
+ *
+ * 1) Set @q::key to the requeue target futex key so the waiter can detect
+ *    the wakeup on the right futex.
+ *
+ * 2) Dequeue @q from the hash bucket.
+ *
+ * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
+ *    acquisition.
+ *
+ * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
+ *    the waiter has to fixup the pi state.
+ *
+ * 5) Complete the requeue state so the waiter can make progress. After
+ *    this point the waiter task can return from the syscall immediately in
+ *    case that the pi state does not have to be fixed up.
+ *
+ * 6) Wake the waiter task.
+ *
+ * Must be called with both q->lock_ptr and hb->lock held.
  */
 static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,

