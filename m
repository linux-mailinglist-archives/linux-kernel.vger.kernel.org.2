Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5953E185A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhHEPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbhHEPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:41 -0400
Message-ID: <20210805153953.683678014@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UrNR0djrmauHt61tRaE2+iZTNd/mMoVONuviNIKMRKA=;
        b=3U4EtvjMdwev/4ojs4Ip41eDwvV7gp371A/WBo4L8aY0sxkX8KTln2j6dGpoqiNXduSui4
        3BnFWy21hw136UTZOjGyTuJOqaA9xFD3Si1Hqd4Ia9AdAU3lFWD8WHXWAwbbQk80CcYgr2
        WbA+pDRHtEeC9kcL9AUl44SOUYZJGPVZa8azHzbVren3UfzjcWgfFTTb7eITPDS8SVCSAq
        AoKHi7w5vUFJRdJNjP4Od63D3t/ctec3+tmbvQcqX4YKbx1v1oyi3vKGKF6FCcJfbkl5cH
        518rf4vIu5l1bwCt38zDTGMoXM1qzYjuXdJe59imlT730C2WqA5vzg2cGhRPAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UrNR0djrmauHt61tRaE2+iZTNd/mMoVONuviNIKMRKA=;
        b=6PTXzdrVru9A2ky5+x8uicTOXcmAcSviGo6i9BJnr81eKLLb7GFcYBfmKNgBi/hwkbhSvs
        aoipyLCkgl7E1UBQ==
Date:   Thu, 05 Aug 2021 17:13:15 +0200
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
Subject: [patch V3 15/64] rtmutex: Provide rt_mutex_base_is_locked()
References: <20210805151300.330412127@linutronix.de>
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

