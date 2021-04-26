Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1B36B961
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhDZSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239008AbhDZSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619463033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yD6J++tFGN2JroTP2/fJSOvNTeeHAc+T/Yq8Saih9NQ=;
        b=H4SdH27d3v/z1BtdgW/HQ2LvSQ/6NcfJla5XBnEf/MWKUbAIvNU7zR8sIr985lBn9d8Dii
        L0un4F3LxsutiVdFcioUz+sNNCJraZFnuVRab9LYdv7xzHHsEApsUk2MIbW+af6vhwD8Gc
        BTkbpisWGvjpQoD9avspzQV3zByCzZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-VX1-4-GwPm2Gz4imiOJ4hQ-1; Mon, 26 Apr 2021 14:50:31 -0400
X-MC-Unique: VX1-4-GwPm2Gz4imiOJ4hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19661107ACCA;
        Mon, 26 Apr 2021 18:50:30 +0000 (UTC)
Received: from llong.com (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1E015D6A1;
        Mon, 26 Apr 2021 18:50:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
Date:   Mon, 26 Apr 2021 14:50:17 -0400
Message-Id: <20210426185017.19815-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more readable by replacing the atomic_cmpxchg_acquire()
by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
to atomic_or().

For architectures that use qrwlock, I do not find one that has an
atomic_add() defined but not an atomic_or().  I guess it should be fine
by changing atomic_add() to atomic_or().

Note that the previous use of atomic_add() isn't wrong as only one
writer that is the wait_lock owner can set the waiting flag and the
flag will be cleared later on when acquiring the write lock.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qrwlock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index b94f3831e963..ec36b73f4733 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -66,12 +66,12 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
-	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	if (!(cnts = atomic_read(&lock->cnts)) &&
+	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		goto unlock;
 
 	/* Set the waiting flag to notify readers that a writer is pending */
-	atomic_add(_QW_WAITING, &lock->cnts);
+	atomic_or(_QW_WAITING, &lock->cnts);
 
 	/* When no more readers or writers, set the locked flag */
 	do {
-- 
2.18.1

