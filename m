Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8F3ECB28
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhHOVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhHOV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD9C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:03 -0700 (PDT)
Message-ID: <20210815211302.899572818@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6jUQXdf3FIGfQqzBHZjjH8dyajN+nY5y2EU2dTJyUBM=;
        b=ep95i6F2bTN87Y4+2TjxkipZi7tmsMpwt/BZgoitsRCdAYKNNljAuox5b1QkhzOsy/8qW8
        +Xp+QXSPvmCZlwtWbROYElQGXRdOHwM94KywkY1lI98GofgsPY1X98ED50lJnLxgx/CLRr
        j27t++OcQRy7ELK17QWzI7hJkBdtUEZtU6Mgdn9mNq4M6v0Ah0980JH2aw13IjXd92CcKD
        Fhvje9oBbHVN4DtV041UpSdzIdEIyL2m00/e3E/Puoov/R72BDv0mC824Z/zganwyg6y5U
        fEIiHCSul7iPYbPtaVTcM8eHhB4o4ATH2FEIwMxjn/EcEpRxsjAv4QDq4dYsow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6jUQXdf3FIGfQqzBHZjjH8dyajN+nY5y2EU2dTJyUBM=;
        b=lbyvGd4c6ijZp2TiSxt7R8cFSP9PbyrNWzbdisidgkaF11oh3dkY2M9eSzEeuaqq3z1H0H
        8Xai/WbMdJHT2DAA==
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
Subject: [patch V5 17/72] rtmutex: Provide rt_mutex_base_is_locked()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:02 +0200 (CEST)
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

