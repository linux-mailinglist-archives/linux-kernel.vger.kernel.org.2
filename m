Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E48401D00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbhIFObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhIFObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:31:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADCC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:30:10 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuOSYRcz1cQFF4/KyvQFNtMd4/OSY5cRar+8d4V1PI4=;
        b=YKfVqatieY1PsnfA9TMcRyjffA+NUrzcUxa+qhZilcxOlX6LorGmN0E+ubEb3RsfQtko/8
        W02oBhv8oLGKNOqz7tl7K49KbF+m5v2Ilpywy6yvxPUFrqG4yAz+Gj9lB5bzMmd3A3mUT5
        un5UlRgBvHocS61qNZPp/E4clhg8fg1nDkgGixh9TJMT7e20Q3Ce2rJ1mWXJegD24kSVYw
        wU0S3niziMkqRJ6jhLjG1NznU0evuxteOYhxrluQo/gHA9K6A9mIbP3zI9ng0FCMihZeXL
        A2BOVKeKk0vhxylpXqHl4FOlWvzESANg+nVNRql5k2seoyxK/DNkXPe3wme9WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuOSYRcz1cQFF4/KyvQFNtMd4/OSY5cRar+8d4V1PI4=;
        b=jxUJ86G82cI9u3xlgsFFK3f/2yJKWqOwSsIAu4BgAAVipxhtYKOkO8syPTJ9NlWZHAsYYb
        cUxrQ9BE0OBTj6DA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] locking: Wire up rwlock_is_contended() on PREEMPT_RT
Date:   Mon,  6 Sep 2021 16:30:03 +0200
Message-Id: <20210906143004.2259141-2-bigeasy@linutronix.de>
In-Reply-To: <20210906143004.2259141-1-bigeasy@linutronix.de>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rwlock_is_contended() should return 0 if there are no waiters pending
on that lock on, !=3D 0 otherwise.
PREEMPT_RT's implementation of RW-locks provides
rt_rwlock_is_contended() which returns !=3D 0 if there is a writer about
to acquire the lock. The only downside is that a writter, that is
using that function, will always see that this lock is contended even if
there are no readers or writters pending.

Wire up rwlock_is_contended() with RT's rt_rwlock_is_contended().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rwlock_rt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 49c1f3842ed5b..e482671ff49ee 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -30,6 +30,7 @@ extern void rt_read_unlock(rwlock_t *rwlock);
 extern void rt_write_lock(rwlock_t *rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock);
+extern int rt_rwlock_is_contended(rwlock_t *rwlock);
=20
 static __always_inline void read_lock(rwlock_t *rwlock)
 {
@@ -135,6 +136,6 @@ static __always_inline void write_unlock_irqrestore(rwl=
ock_t *rwlock,
 	rt_write_unlock(rwlock);
 }
=20
-#define rwlock_is_contended(lock)		(((void)(lock), 0))
+#define rwlock_is_contended(lock)		rt_rwlock_is_contended(lock)
=20
 #endif /* __LINUX_RWLOCK_RT_H */
--=20
2.33.0

