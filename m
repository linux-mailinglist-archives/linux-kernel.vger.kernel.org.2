Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB693DBA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbhG3OXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhG3ORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:24 -0400
Message-ID: <20210730135205.962962763@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UrNR0djrmauHt61tRaE2+iZTNd/mMoVONuviNIKMRKA=;
        b=AyuXzBzqOgahNApdZUMkonmCEfEa1o0IjnuvyiIlXbjIr52UVXjsO5X3XBmv5DU5AjDsOs
        IVrUwyOV6wdTUglOOk8GIL18wGnkJxZL6NeGmQYuXe8zeWO/q9koGtSKifdvKMhbwouGFQ
        RQP6quhtOCreH0Oq59oq6V1G3qJ5jI6AkSmU/YpRTzHDuvgaa0TBGQ+3Eszs+F3irIyVJO
        ziXY344nr/Oo/Ig3RGMGPZ2jAIUp1k+68Q5Tpxhp/3sSrHViouGaGXWKL08U0z5HJ6IANl
        gflJXra1sdplzC8bKrV9i7i0LQ5roeg6YHANvCv8/0pMgHGFS65Ju2bdGs2KBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UrNR0djrmauHt61tRaE2+iZTNd/mMoVONuviNIKMRKA=;
        b=qxrALJbym9WqmVLT9pDWHjwJ5HjrR7a46p5nWjXffnEC2LObZ7J3qpn9p8GVhFxyqu/YGb
        q9bEIIB5a4RskmCg==
Date:   Fri, 30 Jul 2021 15:50:21 +0200
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
Subject: [patch 14/63] rtmutex: Provide rt_mutex_base_is_locked()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide rt_mutex_base_is_locked() which will be used for various wrapped
locking primitives for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -32,6 +32,17 @@ struct rt_mutex_base {
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
+	return lock->owner != NULL;
+}
+
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
 
 /**

