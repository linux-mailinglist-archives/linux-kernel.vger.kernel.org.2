Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405913E90CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhHKMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhHKMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBFC0617BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:22:50 -0700 (PDT)
Message-ID: <20210811121415.042354334@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6jUQXdf3FIGfQqzBHZjjH8dyajN+nY5y2EU2dTJyUBM=;
        b=Y8EUiSSfmjldgolQ4fxyD1RQPa3E8qFW0Do4PHNswIFxTpQBPYKO/2FWelzLtTSw72jv+u
        6mI41zKUgrTC/VLjnQy+bEn7gaCI9hhj6e5CB/6pN+4PatKgq224WC8ttc6qnJJMlhHfml
        YSg+HEmWm4VnxdJmL4Wv/0d+oqj82y/89nW3nvxaBq9AiuS/wMeiXQP5FK3qA1M9JSkOML
        UZGcuFIbaWFgyEcYUecASw4uGb71Vto4xCqgUtfOg3+c21uTAgtIGA6345ylLlj3NU0D4y
        GroKYo01/MG/IbSP4RtoRHM+5/mrPH44vZogM8vJKhjD4gy8nN+jA0puv0X4DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6jUQXdf3FIGfQqzBHZjjH8dyajN+nY5y2EU2dTJyUBM=;
        b=cMsL3xGkPdSndpFjpXb2QNR59dUjK124lS6zwL8X86+5XPzZoElHDIhlelHVV4oSSh91Az
        XfPEJsfaOH46ybDA==
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
Subject: [patch V4 15/68] rtmutex: Provide rt_mutex_base_is_locked()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:49 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide rt_mutex_base_is_locked() which will be used for various wrapped
locking primitives for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Use READ_ONCE() - Davidlohr
---
 include/linux/rtmutex.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_RT_MUTEX_H
 #define __LINUX_RT_MUTEX_H
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock_types.h>
@@ -32,6 +33,17 @@ struct rt_mutex_base {
 	.owner = NULL							\
 }
 
+/**
+ * rt_mutex_base_is_locked - is the rtmutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns true if the mutex is locked, false if unlocked.
+ */
+static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
+{
+	return READ_ONCE(lock->owner) != NULL;
+}
+
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
 
 /**

