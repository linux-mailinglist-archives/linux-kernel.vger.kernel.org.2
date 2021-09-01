Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC733FDFC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbhIAQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:23:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbhIAQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:23:54 -0400
Date:   Wed, 1 Sep 2021 18:22:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630513376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=spYpMafSp/9WCP2JHtujHZ7MmKjkWAGxJ5K4Xk71wHA=;
        b=HWUyaippjTMFPHXXXMe9Ba3GL/uNsP2VSVwTVOAmtoz7u+1vjhMZesoEgl4fIPBvs0TZM8
        0EjsIxFZjKnB2wIISrZXSUwowTNsWLfFZIUifzsaNXUaGn2Z7INydWmOmilwOsOSR8CjkE
        TSdqQtrKh1UUabxHuj3/5NZ5adhNiMK82ODTRhbQJb92KqvZRApzTHHemtvgMWCyr0PLHU
        RReiWrjOvVGdZUlC9UfVpe8/TAuqMImKPY/0sGJ2Q+Q9bXYSuTsnNX4SlHOtvG9sdPMDSx
        dPytwg51I7YGfVEHz2Mt3Cg0RIQaLTUfGCwnUFcjnzf3KPheFNW8dSzhFhyCVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630513376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=spYpMafSp/9WCP2JHtujHZ7MmKjkWAGxJ5K4Xk71wHA=;
        b=eqSAyeL/uw+ARtdiW7CU8G6MW8ROEuxCfSNiVi9AmjWAY4uQ57kiJqfeGpryxsRzcbDAN+
        Dh9Lx7tSnxjb4FBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] lockdep: Let lock_is_held_type() detect recursive read as
 read
Message-ID: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_is_held_type(, 1) detects acquired read locks. It only recognized
locks acquired with lock_acquire_shared(). Read locks acquired with
lock_acquire_shared_recursive() are not recognized because a `2' is
stored as the read value.

Rework the check to additionally recognise lock's read value one and two
as a read held lock.

Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

On a related note: What exactly means read_lock_is_recursive() in terms
of recursive locking? The second items mentions QRW locks. Does this
mean that a pending WRITER blocks further READER from acquiring the
lock?

 kernel/locking/lockdep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f15df3fd7c5a6..39f98454a8827 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,9 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			if (read == -1 || hlock->read == read)
+			if (read == -1 ||
+			    (read == 0 && hlock->read == 0) ||
+			    (read == 1 && hlock->read > 0))
 				return LOCK_STATE_HELD;
 
 			return LOCK_STATE_NOT_HELD;
-- 
2.33.0

