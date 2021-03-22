Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD27343C07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCVIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:46:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:46:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616402773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Hqq4ausxSlWz7cdyqfKkvEhB7Sd6oMXfttdJKeC344o=;
        b=ZTvqbdjozHCmrtEW8ymzK0l6X7XboaeK17UTt6S8EUvTYdyzfAMinGXLEzDeMfHuOEE/au
        aYOvm9bwHJw7THDaP83e0eTDaDP24KARfX/cFS+++/q932yny9x7+hn4TJBTLb7cC88Tce
        INnYaiidTEmvVjOMu2AyuQKIUYBc/Iu6+A6gwTeTlyjocmsV1ylVUcgnC5ox+DgCJtVOHq
        FBxLa5IPRT4cNmsR9H3bkvGv0U9hbSF/fdMXDovDiUek+kKOaysk8/olvdcPj1mabeEdId
        q2fL7EB9UiQgIf6HAJVdZY8uPwxBC/Kjf02f5azYNrUqVNbFvAmBvL86QLSTpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616402773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Hqq4ausxSlWz7cdyqfKkvEhB7Sd6oMXfttdJKeC344o=;
        b=QVafu7DLlP8GlOjA9mogD9f9btMcTodKb/uI2iEBDLE36l++H/RrbvVuCgJtbZDU0lra3F
        DS7FJ4mP/js3aeCA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: locking/mutex: Fix non debug version of mutex_lock_io_nested()
Date:   Mon, 22 Mar 2021 09:46:13 +0100
Message-ID: <878s6fshii.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_LOCK_ALLOC=n then mutex_lock_io_nested() maps to
mutex_lock() which is clearly wrong because mutex_lock() lacks the
io_schedule_prepare()/finish() invocations.

Map it to mutex_lock_io().

Fixes: f21860bac05b ("locking/mutex, sched/wait: Fix the mutex_lock_io_nested() define")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 include/linux/mutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -185,7 +185,7 @@ extern void mutex_lock_io(struct mutex *
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
 # define mutex_lock_killable_nested(lock, subclass) mutex_lock_killable(lock)
 # define mutex_lock_nest_lock(lock, nest_lock) mutex_lock(lock)
-# define mutex_lock_io_nested(lock, subclass) mutex_lock(lock)
+# define mutex_lock_io_nested(lock, subclass) mutex_lock_io(lock)
 #endif
 
 /*
