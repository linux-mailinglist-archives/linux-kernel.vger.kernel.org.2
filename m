Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C983E1867
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbhHEPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:43:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbhHEPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:01 -0400
Message-ID: <20210805153954.389510254@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=glQ7iUzGjVXUNthdl+QBsSpEQkIr0IE0so8RcsyE+tWRaw7gAlr2d4R9S9oN8ADZ4pHAHW
        WZYF0j9Idcs15a/92MVYApFbj6KkXa2+2nRE5QKh71rz0WVZNy2pIG9rl8ZhREyG9SMpih
        oi9CRet6M/bHOJ/easRw1fxaS5+pnaqu6tqTTnv1BhlYteub+dvwhAcndS6b58iRhY1r0R
        xzC3Szs3CGs7lLzqVPAVM8HH7x60nd4dfhyQ0fz7/EId4C8oHZQCd+tJuyiYGbyNBZqsYF
        A4Av1MM5CaOjFj6bZbhAeKTQG7047w9STSnvGgpaNYvaswLx4ufFInoIyHj1WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=aAMgMQ1+VqzCOaZ7NC6RnPu4rryJjkUhnHWgkyr2iQCMYKSXqKQIzcsHgfz8UOaDLlevr/
        AuRV0J8bXOTEQpCA==
Date:   Thu, 05 Aug 2021 17:13:27 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 27/64] locking/rtmutex: Include only rbtree types
References: <20210805151300.330412127@linutronix.de>
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

