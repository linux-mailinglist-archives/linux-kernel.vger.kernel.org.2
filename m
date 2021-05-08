Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5816E377358
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhEHROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 13:14:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35069C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 10:13:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so12318528wrr.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=MlJ15Eimaa/ohi2NqJkSgI1k0gxqgltxjJ+GZTJTu6g=;
        b=xmttTTCD+L0FItd29ZapV6IJf/Uqh04ytF3bf7lr6tPZdkh56kJwEpB8VKYFYzYMFB
         l+wl5C0xIYGM8wpww13Fo3YLL+wiEUsIt5m5uwUvF7KPP7sQtRXTGrCeNAwzFo/6Cihd
         GdHh6mzMeVNbc8HglmfYdKnilsfjj7UdLy6FYmOb9qdbO/aLdd/0LN34FT9W8xIyIV66
         eAKlOkkU2bqwsQklWoYFh4IPmkBHlJ71bel00pRi188RR8xp3+T4lLtpdqhxuV/LxcC0
         CmTULppT9ubeXWKfSrBoNV9CrxzHPaaBeWFPP54o8CPgk7siz1jlw4i/qe2bmFtOsC2U
         EdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=MlJ15Eimaa/ohi2NqJkSgI1k0gxqgltxjJ+GZTJTu6g=;
        b=ad62oC0aE5IkxAWnjcbNrpL1XvUrbUPBF7k5PpkbaNqKJzWIEQu20Hscae/ML7sbOM
         PoWRaWIK48BaVht3QI/3vkQll9cBa3sGtCdDiIihibn770I76wpSR7Pkv3lMjmJlwMFS
         JQEYWdtEiczjIsO6G7hnI6UGIQ9D0vCxPuHZgOKmTxdYQP8cAqiNDVCle6r21CopoClv
         jsknyEZWBHOZMn9ZoOhw2iUk6PwuZyitnTDh1zUa//Rf1m9Ddu6LYbFzQonOmzmfX+EQ
         Jtrw/RR8WhlQRchxESy3EwSjRrZCix57+F2cKkpNJcqDIfxjgSV9BPvrUD6vISnwowD2
         etJA==
X-Gm-Message-State: AOAM531xrr4VxJD9txeM0eC+Kn7zMQcCjp58Q/j4D3K689edvG792JgR
        j/88Miurk/FQTdcXLMxx5OA5Xg==
X-Google-Smtp-Source: ABdhPJzzL+54gpEljBFqKWMNVQUR7Bcsh+SI5YM5rBoMgYAfW/f3HmQl9FsUA5Up9pIXBPb490a/jg==
X-Received: by 2002:a5d:4304:: with SMTP id h4mr20425448wrq.210.1620493978405;
        Sat, 08 May 2021 10:12:58 -0700 (PDT)
Received: from localhost.localdomain (p200300d99735cc000203a406ef8aeb48.dip0.t-ipconnect.de. [2003:d9:9735:cc00:203:a406:ef8a:eb48])
        by smtp.googlemail.com with ESMTPSA id x4sm18214270wmj.17.2021.05.08.10.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 10:12:57 -0700 (PDT)
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
To:     Varad Gautam <varad.gautam@suse.com>, linux-kernel@vger.kernel.org
Cc:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210504155534.17270-1-varad.gautam@suse.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <b693cd00-0cd4-3d4b-04c1-1c007f1c26d3@colorfullife.com>
Date:   Sat, 8 May 2021 19:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504155534.17270-1-varad.gautam@suse.com>
Content-Type: multipart/mixed;
 boundary="------------34D77433C2BE168C9815A1F9"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------34D77433C2BE168C9815A1F9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Varad,

On 5/4/21 5:55 PM, Varad Gautam wrote:
> do_mq_timedsend::__pipelined_op() should not dereference `this` after
> setting STATE_READY, as the receiver counterpart is now free to return.
> Change __pipelined_op to call wake_q_add_safe on the receiver's
> task_struct returned by get_task_struct, instead of dereferencing
> `this` which sits on the receiver's stack.
Correct. I was so concentrated on the risks of reordered memory that I 
have overlooked the simple bug.
> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
Actually, sem.c and msg.c contain the same bug. Thus all three must be 
fixed.
> Signed-off-by: Varad Gautam <varad.gautam@suse.com>
> Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Davidlohr Bueso <dbueso@suse.de>
>
> ---
>   ipc/mqueue.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 8031464ed4ae2..8f78057c6be53 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1004,12 +1004,14 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
>   				  struct mqueue_inode_info *info,
>   				  struct ext_wait_queue *this)
>   {
> +	struct task_struct *t;
> +
>   	list_del(&this->list);
> -	get_task_struct(this->task);
> +	t = get_task_struct(this->task);
>   
>   	/* see MQ_BARRIER for purpose/pairing */
>   	smp_store_release(&this->state, STATE_READY);
> -	wake_q_add_safe(wake_q, this->task);
> +	wake_q_add_safe(wake_q, t);
>   }

The change fixes the issue, but I would prefer to use t = this->task 
instead of using the return value of get_task_struct():
Then all wake_q_add_safe() users are identical.

Ok for you?

Slightly tested patch attached.

--

     Manfred


--------------34D77433C2BE168C9815A1F9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ipc-sem.c-mqueue.c-msg.c-Fix-incorrect-wake_q_add_sa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ipc-sem.c-mqueue.c-msg.c-Fix-incorrect-wake_q_add_sa.pa";
 filename*1="tch"

From 06f91b4bbc440e9509c85acb7be1b15388b7bc0f Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sat, 8 May 2021 18:41:30 +0200
Subject: [PATCH] ipc/sem.c, mqueue.c, msg.c: Fix incorrect wake_q_add_safe()

The wakeup code used by ipc contains a potential use-after-free:
When modifying the code to use wake_q_add_safe(), it was
forgotten to transfer the task struct pointer into a local
variable before the smp_store_release().

Solution: Add local variables to the affected functions.

Result: ipc is now using the same approach as kernel/futex.c
and kernel/locking/rwsem.c.

Note: No need to use READ_ONCE(), as smp_store_release() contains
a barrier(), thus the compiler cannot reread ptr->task.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
Fixes: 8116b54e7e23ef ("ipc/sem.c: document and update memory barriers")
Fixes: 0d97a82ba830d8 ("ipc/msg.c: update and document memory barriers")
Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
Cc: Varad Gautam <varad.gautam@suse.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/mqueue.c | 12 +++++++++---
 ipc/msg.c    |  6 ++++--
 ipc/sem.c    |  6 ++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8031464ed4ae..838c4f24a337 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -78,7 +78,11 @@ struct posix_msg_tree_node {
  * MQ_BARRIER:
  * To achieve proper release/acquire memory barrier pairing, the state is set to
  * STATE_READY with smp_store_release(), and it is read with READ_ONCE followed
- * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() is used.
+ * by smp_acquire__after_ctrl_dep(). Immediately after the smp_store_release(),
+ * the struct ext_wait_queue can go out of scope. Thus the task struct pointer
+ * is copied into a local variable. The wakeup is performed using
+ * wake_q_add_safe().
+ *
  *
  * This prevents the following races:
  *
@@ -1004,12 +1008,14 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
 				  struct mqueue_inode_info *info,
 				  struct ext_wait_queue *this)
 {
+	struct task_struct *task = this->task;
+
 	list_del(&this->list);
-	get_task_struct(this->task);
+	get_task_struct(task);
 
 	/* see MQ_BARRIER for purpose/pairing */
 	smp_store_release(&this->state, STATE_READY);
-	wake_q_add_safe(wake_q, this->task);
+	wake_q_add_safe(wake_q, task);
 }
 
 /* pipelined_send() - send a message directly to the task waiting in
diff --git a/ipc/msg.c b/ipc/msg.c
index acd1bc7af55a..d273482b71ea 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -251,11 +251,13 @@ static void expunge_all(struct msg_queue *msq, int res,
 	struct msg_receiver *msr, *t;
 
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
-		get_task_struct(msr->r_tsk);
+		struct task_struct *task = msr->r_tsk;
+
+		get_task_struct(task);
 
 		/* see MSG_BARRIER for purpose/pairing */
 		smp_store_release(&msr->r_msg, ERR_PTR(res));
-		wake_q_add_safe(wake_q, msr->r_tsk);
+		wake_q_add_safe(wake_q, task);
 	}
 }
 
diff --git a/ipc/sem.c b/ipc/sem.c
index e0ec239680cb..04700a823e79 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -784,12 +784,14 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
 					     struct wake_q_head *wake_q)
 {
-	get_task_struct(q->sleeper);
+	struct task_struct *task = q->sleeper;
+
+	get_task_struct(task);
 
 	/* see SEM_BARRIER_2 for purpose/pairing */
 	smp_store_release(&q->status, error);
 
-	wake_q_add_safe(wake_q, q->sleeper);
+	wake_q_add_safe(wake_q, task);
 }
 
 static void unlink_queue(struct sem_array *sma, struct sem_queue *q)
-- 
2.30.2


--------------34D77433C2BE168C9815A1F9--
