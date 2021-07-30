Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858B3DBA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhG3OVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbhG3ORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:39 -0400
Message-ID: <20210730135206.641495415@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=WbbiOIPV9sFhXGDqBNCjygUF+j9RNvPD4LQbluO1dUF6u+fjb/AgJ1JJY8C6qZIxI76PzA
        3r5kLYLKDZ/8l765oZh6nPWHdUrkj8c7EsO/9KaN9kciBHiDkT3EKsAnM9IZGVykHbex9Q
        8rNa+4lLSfjoK5KjVlFG9wlN2EdCa1L+9cPZAX9+0tdIvO/koFrQoI6ZK3uHTs64OAkflE
        aLIAL/1O/5/ZISqKsoqW6i/c0XhRzkBDthuVMvwsyWapj3102AGU5nUGLuV6xIPKd9gHgE
        jqWq6k0/umc8w6sjvzQoas9jWEz+jlZ97qLKU0tZTayrJT0HCpt304XpyMQo5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=H34WLBl7dUcdgQdVY9X3avzVLPX0oHET0rQSDPWLcBUBO6DIkowNMuFXfWu+2EhZHScsUE
        LZ+37/r24XuiQzBQ==
Date:   Fri, 30 Jul 2021 15:50:33 +0200
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
Subject: [patch 26/63] locking/rtmutex: Include only rbtree types
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rtmutex.h needs the definition of struct rb_root_cached. rbtree.h includes
kernel.h which includes spinlock.h. That works nicely for non-RT enabled
kernels, but on RT enabled kernels spinlocks are based on rtmutexes which
creates another circular header dependency as spinlocks.h will require
rtmutex.h.

Include rbtree_types.h instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -14,7 +14,7 @@
 #define __LINUX_RT_MUTEX_H
 
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */

