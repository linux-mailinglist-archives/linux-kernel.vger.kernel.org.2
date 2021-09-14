Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A815940ABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhINKoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:44:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhINKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:44:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631616162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOP4d2X9VL4G2q0tjsxLQr1jdG3jIE3tqu86UTFeOZU=;
        b=iAvWzrHYkdE1Z0l3+uQBj/Gt5AADtXrQq95Jq5djCmJbqXQY1XnMcT6bAl8xSyrx9wcI0j
        CKH3WwbzxqNz5c5OYE78G2Fvhe+Y/T7Oe/rQ4Bm4slk+4Z9AnBizgkKWoqAP20peWGsLti
        AjxBULd0TTiCFszytSglLr1WiEH7yKt2oL9iovQFP6xjBnU/hfPr/UASbGf0Uzo7vP1eKF
        R7JJjmWCoXHEy14PFVsHg9B+lfWnNTPo3sCxfcXStG+QghXoghm0OwYvXLRB9fzMicOmYt
        2m3bPYAl6PGKCLAGgNOyPBE40xORHMO5pTLW6PaWWVxERGdwqjg23/UuDElslA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631616162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOP4d2X9VL4G2q0tjsxLQr1jdG3jIE3tqu86UTFeOZU=;
        b=6Ketdid8ptA3EDshSAE8DXVsMVdA65dml7RT3ptpmqV92heONmms+btnwhDmBT1m1a5GUC
        FZHq7fwwNlkvqyBg==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
In-Reply-To: <87ilz4fyzi.ffs@tglx>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net> <87ilz4fyzi.ffs@tglx>
Date:   Tue, 14 Sep 2021 12:42:41 +0200
Message-ID: <87wnnjcuam.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2021 at 14:20, Thomas Gleixner wrote:

> On Wed, Sep 01 2021 at 15:28, Davidlohr Bueso wrote:
>> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
>> index 4ba15088e640..3444bc709973 100644
>> --- a/kernel/locking/rwbase_rt.c
>> +++ b/kernel/locking/rwbase_rt.c
>> @@ -141,6 +141,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>>  {
>>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>>  	struct task_struct *owner;
>> +	DEFINE_WAKE_Q(wake_q);
>>  
>>  	raw_spin_lock_irq(&rtm->wait_lock);
>>  	/*
>> @@ -151,9 +152,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>>  	 */
>>  	owner = rt_mutex_owner(rtm);
>>  	if (owner)
>> -		wake_up_state(owner, state);
>> +		wake_q_add(&wake_q, owner);
>
> That's broken for rw_locks. See commit 456cfbc65cd072f4f53936ee5a37eb1447a7d3ba.

Something like the untested below should work.

Thanks,

        tglx
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6bb116c559b4..9e04bca0c11e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -459,6 +459,20 @@ static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 	}
 }
 
+static __always_inline void rt_mutex_wake_q_add_task(struct rt_wake_q_head *wqh,
+						     struct task_struct *task,
+						     unsigned int wake_state)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wake_state != TASK_NORMAL) {
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(task);
+		wqh->rtlock_task = task;
+	} else {
+		wake_q_add(&wqh->head, task);
+	}
+}
+
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba15088e640..e011b347a2c5 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -141,8 +141,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	struct task_struct *owner;
+	DEFINE_RT_WAKE_Q(wqh);
 
 	raw_spin_lock_irq(&rtm->wait_lock);
+
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
 	 * rtmutex concurrently in the fast path (due to a signal), but to
@@ -151,9 +153,12 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	 */
 	owner = rt_mutex_owner(rtm);
 	if (owner)
-		wake_up_state(owner, state);
+		rt_mutex_wake_q_add_task(&wqh, owner, state);
 
+	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
+	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
