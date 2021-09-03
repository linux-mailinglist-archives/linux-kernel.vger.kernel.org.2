Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9C3FFE59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbhICKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbhICKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:47:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB997C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:46:00 -0700 (PDT)
Date:   Fri, 3 Sep 2021 12:45:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630665959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJUkYWH5EgQF3BAiivD6rbUBrHW821BhOp5wV972Zrc=;
        b=ynZs+fDgr04G7UNasadVt+AmOOHQya+l6vLThASYPGWNsMDPcaQvBNfFlzJqUEGtUf0IDj
        64dobhUJnk/cqZlZ/iyoFEJKqZX3i1W7KYIINgsjGwz8Nx3SMwx2D5Ad26he6xqXidW16T
        E7oOYQmwuUnI1La0Js54qgbmurPUjgsqKEaUp5SnR/lZ7mkKkajUUU4DY5PwrNTV0rrcBw
        zWzGRcLvGpJUwFIqsbdOQz8TxmzwuyaqCVhgWmdQYn/U0oPeytUX9RpR2hUYSFhyyro9it
        ifnFRwyynUtVOHghIBLbyQNvPop9qGc1wbUmtj2Q3tuzoNKrZQT3JseD1pExHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630665959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJUkYWH5EgQF3BAiivD6rbUBrHW821BhOp5wV972Zrc=;
        b=GKnLbVWGMQRIYdqJTJf+6MBOa+jP6XqJU+NfMQL2sXSnCd2bQ+2sebUoWmudsr+cVyg9yE
        HOO/aZv0fG5lcsBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: Let lock_is_held_type() detect recursive read
 as read
Message-ID: <20210903104557.rqss65jn4ozoptcj@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <YS+twcAQ9uivowDS@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS+twcAQ9uivowDS@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-02 00:43:45 [+0800], Boqun Feng wrote:
> If a reader is recursive, then a pending writer doesn't block the
> recursive reader, otherwise, a pending write blocks the reader. IOW, a
> pending writer blocks non-recursive readers but not recursive readers.

Puh. So I would describe it as writer fair but maybe I'm not fluent in
locking. But you don't mean recursive reader as in 

   T1			T2
   read_lock(a);
			write_lock(a);
   read_lock(a);

which results in a deadlock (but T1 recursively acquired the `a' lock). 

However, PREEMPT_RT's locking implementation always blocks further
reader from entering locked section once a writer is pending so that
would then ask for something like this:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5572,16 +5572,19 @@ static bool lockdep_nmi(void)
 }
 
 /*
- * read_lock() is recursive if:
- * 1. We force lockdep think this way in selftests or
- * 2. The implementation is not queued read/write lock or
- * 3. The locker is at an in_interrupt() context.
+ * read_lock() is recursive if the implementation allows readers to enter the
+ * locked section even if a writer is pending. This is case if:
+ * - We force lockdep think this way in selftests
+ * - The implementation is queued read/write lock and the locker is in
+ *   in_interrupt() context.
+ * - Non queued read/write implementation allow it unconditionally.
+ * - PREEMPT_RT's implementation never allows it.
  */
 bool read_lock_is_recursive(void)
 {
 	return force_read_lock_recursive ||
-	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
-	       in_interrupt();
+	       (IS_ENABLED(CONFIG_QUEUED_RWLOCKS) && in_interrupt()) ||
+	       !IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 EXPORT_SYMBOL_GPL(read_lock_is_recursive);
 
Sebastian
