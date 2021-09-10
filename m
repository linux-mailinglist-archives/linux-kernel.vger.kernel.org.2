Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC84406D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhIJNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:54:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhIJNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:54:26 -0400
Date:   Fri, 10 Sep 2021 15:53:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631281994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6pxcfUfqepcmfNTX+DNeLKNNP9jLrEk/ehng0WwRfw=;
        b=yG/H4GMCbptSO7FFcgIZ3+sX9PJQnoS+zgFEMIv+9T8v8/wQYYfHCqW3I9ka5COSD59xmU
        TWkLyIOd0xvuyA2mqh4fAiN0Z9D3kU4KKRWAO127ve37IHLj+pdcquIhyOHh2uSMLxSFqo
        U64INnaE7tgFSKSWlrhJrv5Gx4BE5vxFhLrmDvbBQHg+xq86zHI5bPThiur/1bMFl9bMqx
        61/9Il1VJ6+Ubhg5zNS+k3ADJcg2HSR3g0MoAW7/JxqwacB2ZFcPQyLU7WbxjrYoWNjqRK
        2e3hFDPZjgifTaRnBIjtS9NkeKtPWV/poC+e6JvneYf0qL/GkZx+gFzloTIabQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631281994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6pxcfUfqepcmfNTX+DNeLKNNP9jLrEk/ehng0WwRfw=;
        b=vIw2vRZVwOSK2r6u9SnvhSeInTcZdGwE5kQKYgymfiOoj2p1indCiqAZUBAx4FXF9765IQ
        c/OxepXxr02YYLDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] lockdep: Let lock_is_held_type() detect recursive read as
 read
Message-ID: <20210910135312.4axzdxt74rgct2ur@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
 <20210903084001.lblecrvz4esl4mrr@linutronix.de>
 <YTgc8xXuVlpOhoUT@boqun-archlinux>
 <YTiN1HLeHeIhi/nT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTiN1HLeHeIhi/nT@hirez.programming.kicks-ass.net>
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
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
v3: move the !! to the right spot so it actually works.

 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e48..bfa0a347f27c4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			if (read == -1 || hlock->read == read)
+			if (read == -1 || !!hlock->read == read)
 				return LOCK_STATE_HELD;
 
 			return LOCK_STATE_NOT_HELD;
-- 
2.33.0

