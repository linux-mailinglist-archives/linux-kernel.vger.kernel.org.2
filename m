Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0816C36A917
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhDYUHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 16:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhDYUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 16:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619381217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WNLmXfNHHFxJs3CZDbz/p8vZ8D/qmUMYK+vF6Nbj3qY=;
        b=SKL558aGsvZ21zVBZBOW4PFk/y+SKRZGx1L5RbCRwjhwvu7GWQKWktlXOJNLWgI20Qigwu
        ai3gvJXq5jyH3whAY/k29z3UDRPNQoQ6l+ZBpnFB3qpCFSbH7he2H0dDzmlXcEmxl1eJos
        /ah00ObSCs8vlWUEvPzFoDQWh+bP1Bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-qBlmxkS1OcicwS1fDheDZQ-1; Sun, 25 Apr 2021 16:06:56 -0400
X-MC-Unique: qBlmxkS1OcicwS1fDheDZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB49A107ACCA;
        Sun, 25 Apr 2021 20:06:54 +0000 (UTC)
Received: from llong.com (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0602719D80;
        Sun, 25 Apr 2021 20:06:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
Date:   Sun, 25 Apr 2021 16:06:37 -0400
Message-Id: <20210425200637.31298-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more readable by replacing the atomic_cmpxchg_acquire()
by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
to atomic_or().

For architectures that use qrwlock, I do not find one that has an
atomic_add() defined but not an atomic_or().  I guess it should be fine
by changing atomic_add() to atomic_or(). I add a comment to state that
we can change it back to atomic_add() if there is an architecture that
has a more performant atomic_add() than an atomic_or().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qrwlock.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index b94f3831e963..a1fa0f636b07 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -60,18 +60,26 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
-	int cnts;
+	int cnts = 0;
 
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
 	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		goto unlock;
 
-	/* Set the waiting flag to notify readers that a writer is pending */
-	atomic_add(_QW_WAITING, &lock->cnts);
+	/*
+	 * Set the waiting flag to notify readers that a writer is pending
+	 *
+	 * As only one writer who is the wait_lock owner can set the waiting
+	 * flag which will be cleared later on when acquiring the write lock,
+	 * we can easily replace atomic_or() by an atomic_add() if there is
+	 * an architecture where an atomic_add() performs better than an
+	 * atomic_or().
+	 */
+	atomic_or(_QW_WAITING, &lock->cnts);
 
 	/* When no more readers or writers, set the locked flag */
 	do {
-- 
2.18.1

