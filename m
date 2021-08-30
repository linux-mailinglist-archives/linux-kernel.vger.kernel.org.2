Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51A3FBAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhH3R1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbhH3R1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:26:39 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLg28R0I4l42Wp7Kr6HQPjKRPPqXBv2DvuNgpG1iY5M=;
        b=ehsCfouJeh/ja5KwdXJp2BtTn8k3mZR4eYhxb1VByftnQZCYc3XffelOBZqrJUHRzpoQHb
        S+Vv0iyAi4QSba7WgOxaCnwoobcjXl0+4TFHYcevrkvXnF/M9gDdVZa769oQKyR80Az2Uc
        uK9Uk5lsB7aniZ8trZcQDuMyIksYefch2W8Xz5b/euGMSvnQKelk0NUF1zDwRiNZq6zMKQ
        tK3oAHbVJSua6dsP0hXJnmn6K9AbNELeBUlIcrv0HTPFQd3QQm+uUQLEHL8PHpkbQSDdwZ
        pphrD9LGp/Twj3ip4etP/Z0Bs/VeFZMr7EYgO9qIuETp0YyLbd/ZRgJ3Qs8EDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLg28R0I4l42Wp7Kr6HQPjKRPPqXBv2DvuNgpG1iY5M=;
        b=S2DTr7c1IxjCxgx3N644I91/3XaWsZOle5agj4KO1+2tpsOwd3zGMbg4wOq3dUdChi7RsL
        xaaOT4s95aJisKDw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] kcov: Replace local_irq_save() with a local_lock_t.
Date:   Mon, 30 Aug 2021 19:26:27 +0200
Message-Id: <20210830172627.267989-6-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kcov code mixes local_irq_save() and spin_lock() in
kcov_remote_{start|end}(). This creates a warning on PREEMPT_RT because
local_irq_save() disables interrupts and spin_lock_t is turned into a
sleeping lock which can not be acquired in a section with disabled
interrupts.

The kcov_remote_lock is used to synchronize the access to the hash-list
kcov_remote_map. The local_irq_save() block protects access to the
per-CPU data kcov_percpu_data.

There no compelling reason to change the lock type to raw_spin_lock_t to
make it work with local_irq_save(). Changing it would require to move
memory allocation (in kcov_remote_add()) and deallocation outside of the
locked section.
Adding an unlimited amount of entries to the hashlist will increase the
IRQ-off time during lookup. It could be argued that this is debug code
and the latency does not matter. There is however no need to do so and
it would allow to use this facility in an RT enabled build.

Using a local_lock_t instead of local_irq_save() has the befit of adding
a protection scope within the source which makes it obvious what is
protected. On a !PREEMPT_RT && !LOCKDEP build the local_lock_irqsave()
maps directly to local_irq_save() so there is overhead at runtime.

Replace the local_irq_save() section with a local_lock_t.

Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kcov.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 620dc4ffeb685..36ca640c4f8e7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -88,6 +88,7 @@ static struct list_head kcov_remote_areas =3D LIST_HEAD_I=
NIT(kcov_remote_areas);
=20
 struct kcov_percpu_data {
 	void			*irq_area;
+	local_lock_t		lock;
=20
 	unsigned int		saved_mode;
 	unsigned int		saved_size;
@@ -96,7 +97,9 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
=20
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) =3D {
+	.lock =3D INIT_LOCAL_LOCK(lock),
+};
=20
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -824,7 +827,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_serving_softirq())
 		return;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
=20
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -832,7 +835,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode =3D READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -841,14 +844,15 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
=20
 	spin_lock(&kcov_remote_lock);
 	remote =3D kcov_remote_find(handle);
 	if (!remote) {
-		spin_unlock_irqrestore(&kcov_remote_lock, flags);
+		spin_unlock(&kcov_remote_lock);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	kcov_debug("handle =3D %llx, context: %s\n", handle,
@@ -873,13 +877,13 @@ void kcov_remote_start(u64 handle)
=20
 	/* Can only happen when in_task(). */
 	if (!area) {
-		local_irqrestore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		area =3D vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
-		local_irq_save(flags);
+		local_lock_irqsave(&kcov_percpu_data.lock, flags);
 	}
=20
 	/* Reset coverage size. */
@@ -891,7 +895,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
=20
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -965,12 +969,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_serving_softirq())
 		return;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
=20
 	mode =3D READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -978,12 +982,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
=20
@@ -1013,7 +1017,7 @@ void kcov_remote_stop(void)
 		spin_unlock(&kcov_remote_lock);
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
=20
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
--=20
2.33.0

