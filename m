Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2763DBA77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhG3OXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbhG3ORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:35 -0400
Message-ID: <20210730135206.472475934@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=XqrAng028EdGlCngKNK9sTC6ZL66cdfvWvsXPqZk/+LgxINOfMYF4EdD8c4YCpjv5A3bJY
        goJJnrHc/v2XarS6p6wrk9xPhyBu6+qqwL9nACeevLJj3ZIeF3XEXHzTKC4romZMKkTRbg
        s6WPBzhj01+p02DizYZBRDHlQBKNyS3vyQbL3HpCQ6QK+3cwK6IlBL9kDanM/HOtKBtngn
        9gjtSpQIcuskAK6WQrW2Nt74RX6ySqQAcrPzf/e4Ribeua1XpiYA0V+R7wklDKiLm21uot
        +csPTCeWlSJtJ3/xJidBGORSKXHhF+Y9mCAFShLjX7y/PUHFgwADNliJGLEihQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=XgTubAalcS2qf4IQPzgkjl6TRau1bm2LlNKCcd1ZAMFzUBhdTcq+yu3OEPblo6g9fDChI4
        +oAKrZWypO7oC8Cg==
Date:   Fri, 30 Jul 2021 15:50:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 23/63] locking/rtmutex: Prevent future include recursion hell
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rtmutex only needs raw_spinlock_t, but it includes spinlock_types.h which
is not a problem on an non RT enabled kernel.

RT kernels substitute regular spinlocks with 'sleeping' spinlocks which
are based on rtmutexes and therefore must be able to include rtmutex.h.

Include spinlock_types_raw.h instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,7 +15,7 @@
 
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 

