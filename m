Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0DB3F209F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHSTbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:31:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhHSTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:31:09 -0400
Date:   Thu, 19 Aug 2021 21:30:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629401431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUcMYajZ3XxOlpgPob8whWq+KnBsy7RRJI0UjbXqROI=;
        b=r9am8/e1sz+2r6VbO/tcCiWYPw6pMlA/yGZAH7DY5XaUU5+rIvcczfRUzy3kCOlnt3Vf9Z
        TVzFZHFKy5W30ffaKUatkjORiwpUZl4qNe7qW9V2KF9Ub6WSqHwmihBfejkMHsJBmREhLj
        373aDRdVH9+z0M6hLRtBMxviqFI2yTy1SUtSaQShO0XB2omZV5awxGdfbrv/2oPMcwlHmY
        mn9cm0w9D01tltvHPHOuifVqqyS2jHWpsCFEV7rKerWwy0hbM+C4s7t2sbgrnsmTbwxI4T
        nD4NSsvoIgRH8tFAVTq8zlK4oyWS+bQh1KcfzNU6esMs8eSDg7uW/KB/9kvEGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629401431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUcMYajZ3XxOlpgPob8whWq+KnBsy7RRJI0UjbXqROI=;
        b=7PTBCJCfoWujjpGQY3epP+t8QkAzdvEup71G7EYiNqNPyXbExd1Cgohpr+3d6qlcy6O5hl
        xMrNnFIfh5GatoDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] locking/ww_mutex: Initialize waiter.ww_ctx properly
Message-ID: <20210819193030.zpwrpvvrmy7xxxiy@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819175110.w7lxq5w3gdj5vhwf@linutronix.de>
 <YR6gUaz2QMeNkPXp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YR6gUaz2QMeNkPXp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gathering of the debug code for the ww-mutex initialized moved the
POISON initialiation into one spot and only set waiter.ww_ctx if the
ww_ctx was non-NULL thus keeping the POISON value in ww-mutex case.

For ww-mutex without a context it is expected to set the context to
NULL, the poison value was intended only for the regular mutex.

Always initialized waiter.ww_ctx to ww_ctx in the ww-mutex case.

Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization=
")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: Use PeterZ' approach.

 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 05b68931622d1..2c70213934cd4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -614,7 +614,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int st=
ate, unsigned int subclas
=20
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task =3D current;
-	if (ww_ctx)
+	if (use_ww_ctx)
 		waiter.ww_ctx =3D ww_ctx;
=20
 	lock_contended(&lock->dep_map, ip);
--=20
2.33.0

