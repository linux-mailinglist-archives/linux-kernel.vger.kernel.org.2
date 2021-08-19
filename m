Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228133F1F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhHSSJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHSSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:09:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA26C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:08:54 -0700 (PDT)
Date:   Thu, 19 Aug 2021 20:08:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629396532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Krxko92OcnnxeuGLUpevk+gOLBcctvo45CW7C991Auw=;
        b=uHocKjBTEd0KsawDnzHKpVTa+fii9+83sCOBYQVj2xs6y9jibN7iQ95jQ2gcVBP2KlWRd5
        KrSeRwKNgsU63AO8iybti6QgszghX7EURKDOfpKHyxIVytloCP+7d8e9cbyTSk1sUfxwYj
        iTKHBI15Sh1tX8AcF30KltEZX1Sa9XxnxUa6LfV6d+3vWITdyPGD+WI4a1Wu0nUXfDABIn
        N6d2BVhXogZtqXQ7ZpqB9c2NoekTNUtBVymQDVlhMlgxP+2TC1JGUAnVoukTxGoX1X66VS
        hbACs7sLmKhGYZSyPkJa5ITwoGMiYEE4IpYFq0ZmMfMo/GtOM9GlClX0KJwFrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629396532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Krxko92OcnnxeuGLUpevk+gOLBcctvo45CW7C991Auw=;
        b=ALvyDT3lbOi1O/ca6Nj0F7DKAKdhKLISX3xlEQtJKBCL/v02DopO4MX/wRTLC8F2e/t318
        4HjmzWC3bonjaTAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH] locking/ww_mutex: Initialize waiter.ww_ctx properly
Message-ID: <20210819180850.koqw3ujmxga5wo4n@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819165409.GA2335652@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819165409.GA2335652@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gathering of the debug code for the ww-mutex initialized moved the
POISON initialiation into one spot and only set waiter.ww_ctx if the
ww_ctx was non-NULL thus keeping the POISON value in ww-mutex case.

For ww-mutex without a context it is expected to set the context to
NULL, the poison value was intended only for the regular mutex.

Move the waiter.ww_ctx where it was previously so it is initialized to
NULL if no ww_ctx was passed.

Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/mutex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 05b68931622d1..d1068b0b163af 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -614,8 +614,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (ww_ctx)
-		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
 
@@ -630,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
+		waiter.ww_ctx = ww_ctx;
 	}
 
 	set_current_state(state);
-- 
2.33.0

