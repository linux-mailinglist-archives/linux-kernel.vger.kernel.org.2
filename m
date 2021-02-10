Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FB316197
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhBJI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:56:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhBJIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:53:38 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suP2IuJO8+dYJ1CH56zFNwdykrbdPK11uoWDfR/SBnk=;
        b=PWnL2mb/sAfZngRhgt7zY7W8R0yzNYWlwzL1uuCsReQcMtgdRQdCNx3FdChND2M9CtrMhC
        FQN4fB1yd+A7kEoZYHiTzXC3VtMZ7XrlVfojeuFD+S4qD4Ym50BT7MX+UY2wHYw0D0h7dI
        awz7yUzZ8N+QI8eYBhI/CZbkldb0rGV9YzyxfnN5ChSWIGSkj54K60sCglgxbQNdxh/kRe
        UaIzAHsrp0jCVQnmel6o2P1bxk9lVKZCIRjIT36JRWyICDxT1pnQbIIy35N9FSu/WBAAzJ
        C1aIQb+6eWR+i2s3xmnLApNan0HdAsXubEJaSlAub39eQFO8O45FHHI4xKKj4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suP2IuJO8+dYJ1CH56zFNwdykrbdPK11uoWDfR/SBnk=;
        b=WLdJVzqkJxmvCeOuq8Y6wFcBJ6tZNDGbHTdj1+6NOwbZJagwyzqt//KqMB/Rkf60C62DqG
        zkFLJ+5bWh/24ZDA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] locking/mutex: Kill mutex_trylock_recursive()
Date:   Wed, 10 Feb 2021 09:52:47 +0100
Message-Id: <20210210085248.219210-2-bigeasy@linutronix.de>
In-Reply-To: <20210210085248.219210-1-bigeasy@linutronix.de>
References: <20210210085248.219210-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are not users of mutex_trylock_recursive() in tree as of
v5.11-rc7.

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/mutex.h  | 25 -------------------------
 kernel/locking/mutex.c | 10 ----------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd185cbfe793..0cd631a197276 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -199,29 +199,4 @@ extern void mutex_unlock(struct mutex *lock);
=20
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
=20
-/*
- * These values are chosen such that FAIL and SUCCESS match the
- * values of the regular mutex_trylock().
- */
-enum mutex_trylock_recursive_enum {
-	MUTEX_TRYLOCK_FAILED    =3D 0,
-	MUTEX_TRYLOCK_SUCCESS   =3D 1,
-	MUTEX_TRYLOCK_RECURSIVE,
-};
-
-/**
- * mutex_trylock_recursive - trylock variant that allows recursive locking
- * @lock: mutex to be locked
- *
- * This function should not be used, _ever_. It is purely for hysterical G=
EM
- * raisins, and once those are gone this will be removed.
- *
- * Returns:
- *  - MUTEX_TRYLOCK_FAILED    - trylock failed,
- *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
- *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
- */
-extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock);
-
 #endif /* __LINUX_MUTEX_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce50a97e3..adb9350907688 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -86,16 +86,6 @@ bool mutex_is_locked(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_is_locked);
=20
-__must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock)
-{
-	if (unlikely(__mutex_owner(lock) =3D=3D current))
-		return MUTEX_TRYLOCK_RECURSIVE;
-
-	return mutex_trylock(lock);
-}
-EXPORT_SYMBOL(mutex_trylock_recursive);
-
 static inline unsigned long __owner_flags(unsigned long owner)
 {
 	return owner & MUTEX_FLAGS;
--=20
2.30.0

