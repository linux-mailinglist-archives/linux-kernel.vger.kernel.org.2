Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89F3447382
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhKGP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234785AbhKGP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636298685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5X/F3Q9OQWTedZdg5p9+xsGsujEfRxHSgnzYTtOxz1U=;
        b=Xf+5dIq989gcUccPuFo2JVeddBfsvLmteW8xyO3jT+c9dlu6aga7f41ZrWRD3JngjeIa+/
        7WdEDQGoNWQHRrrdjyQKUaQ+CYTmjFeBonmQtvnpVxzAH8AqTetkINKbHzQYHn/uLzBjdy
        usOmhqS+VmJf/WhkQT46t1E/73nyHa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-15sQjqSfNtGVCpO37Sh1rw-1; Sun, 07 Nov 2021 10:24:39 -0500
X-MC-Unique: 15sQjqSfNtGVCpO37Sh1rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41EA310066F3;
        Sun,  7 Nov 2021 15:24:38 +0000 (UTC)
Received: from [10.22.16.43] (unknown [10.22.16.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1536467842;
        Sun,  7 Nov 2021 15:24:31 +0000 (UTC)
Message-ID: <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
Date:   Sun, 7 Nov 2021 10:24:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        peterz <peterz@infradead.org>, mingo <mingo@redhat.com>,
        will <will@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211107090131.1535-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/21 04:01, Hillf Danton wrote:
> On Sat, 6 Nov 2021 23:25:38 -0400 Waiman Long wrote:
>> On 11/6/21 08:39, 马振华 wrote:
>>> Dear longman,
>>>
>>> recently , i find a issue which rwsem count is negative value, it
>>> happened always when a task try to get the lock
>>> with __down_write_killable , then it is killed
>>>
>>> this issue happened like this
>>>
>>>              CPU2         CPU4
>>>      task A[reader]     task B[writer]
>>>      down_read_killable[locked]
>>>      sem->count=0x100
>>>              down_write_killable
>>>              sem->count=0x102[wlist not empty]
>>>      up_read
>>>      count=0x2
>>>              sig kill received
>>>      down_read_killable
>>>      sem->count=0x102[wlist not empty]
>>>              goto branch out_nolock:
>>> list_del(&waiter.list);
>>> wait list is empty
>>> sem->count-RWSEM_FLAG_HANDOFF
>>> sem->count=0xFE
>>>      list_empty(&sem->wait_list) is TRUE
>>>       sem->count andnot RWSEM_FLAG_WAITERS
>>>        sem->count=0xFC
>>>      up_read
>>>      sem->count -= 0x100
>>>      sem->count=0xFFFFFFFFFFFFFFFC
>>>      DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
>>>
>>> so sem->count will be negative after writer is killed
>>> i think if flag RWSEM_FLAG_HANDOFF is not set, we shouldn't clean it
>> Thanks for reporting this possible race condition.
>>
>> However, I am still trying to figure how it is possible to set the
>> wstate to WRITER_HANDOFF without actually setting the handoff bit as
>> well. The statement sequence should be as follows:
>>
>> wstate = WRITER_HANDOFF;
>> raw_spin_lock_irq(&sem->wait_lock);
>> if (rwsem_try_write_lock(sem, wstate))
>> raw_spin_unlock_irq(&sem->wait_lock);
>>    :
>> if (signal_pending_state(state, current))
>>      goto out_nolock
>>
>> The rwsem_try_write_lock() function will make sure that we either
>> acquire the lock and clear handoff or set the handoff bit. This should
>> be done before we actually check for signal. I do think that it is
> Given that WRITER_HANDOFF makes no sure that RWSEM_FLAG_HANDOFF is set in
> wsem_try_write_lock(), the flag should be cleared only by the setter to
> avoid count underflow.
>
> Hillf
>
>> probably safer to use atomic_long_andnot to clear the handoff bit
>> instead of using atomic_long_add().

I did have a tentative patch to address this issue which is somewhat 
similar to your approach. However, I would like to further investigate 
the exact mechanics of the race condition to make sure that I won't miss 
a latent bug somewhere else in the rwsem code.

-Longman

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..20be967620c0 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -347,7 +347,8 @@ enum rwsem_wake_type {
  enum writer_wait_state {
      WRITER_NOT_FIRST,    /* Writer is not first in wait list */
      WRITER_FIRST,        /* Writer is first in wait list     */
-    WRITER_HANDOFF        /* Writer is first & handoff needed */
+    WRITER_NEED_HANDOFF    /* Writer is first & handoff needed */
+    WRITER_HANDOFF        /* Writer is first & handoff set */
  };

  /*
@@ -532,11 +533,11 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
   * race conditions between checking the rwsem wait list and setting the
   * sem->count accordingly.
   *
- * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
+ * If wstate is WRITER_NEED_HANDOFF, it will make sure that either the 
handoff
   * bit is set or the lock is acquired with handoff bit cleared.
   */
  static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-                    enum writer_wait_state wstate)
+                    enum writer_wait_state *wstate)
  {
      long count, new;

@@ -546,13 +547,13 @@ static inline bool rwsem_try_write_lock(struct 
rw_semaphore *sem,
      do {
          bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);

-        if (has_handoff && wstate == WRITER_NOT_FIRST)
+        if (has_handoff && *wstate == WRITER_NOT_FIRST)
              return false;

          new = count;

          if (count & RWSEM_LOCK_MASK) {
-            if (has_handoff || (wstate != WRITER_HANDOFF))
+            if (has_handoff || (*wstate != WRITER_NEED_HANDOFF))
                  return false;

              new |= RWSEM_FLAG_HANDOFF;
@@ -569,8 +570,10 @@ static inline bool rwsem_try_write_lock(struct 
rw_semaphore *sem,
       * We have either acquired the lock with handoff bit cleared or
       * set the handoff bit.
       */
-    if (new & RWSEM_FLAG_HANDOFF)
+    if (new & RWSEM_FLAG_HANDOFF) {
+        *wstate = WRITER_HANDOFF;
          return false;
+    }

      rwsem_set_owner(sem);
      return true;
@@ -1083,7 +1086,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
      /* wait until we successfully acquire the lock */
      set_current_state(state);
      for (;;) {
-        if (rwsem_try_write_lock(sem, wstate)) {
+        if (rwsem_try_write_lock(sem, &wstate)) {
              /* rwsem_try_write_lock() implies ACQUIRE on success */
              break;
          }
@@ -1138,7 +1141,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
               */
              if ((wstate == WRITER_FIRST) && (rt_task(current) ||
                  time_after(jiffies, waiter.timeout))) {
-                wstate = WRITER_HANDOFF;
+                wstate = WRITER_NEED_HANDOFF;
                  lockevent_inc(rwsem_wlock_handoff);
                  break;
              }
@@ -1159,7 +1162,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
      list_del(&waiter.list);

      if (unlikely(wstate == WRITER_HANDOFF))
-        atomic_long_add(-RWSEM_FLAG_HANDOFF, &sem->count);
+        atomic_long_addnot(RWSEM_FLAG_HANDOFF, &sem->count);

      if (list_empty(&sem->wait_list))
          atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-- 


