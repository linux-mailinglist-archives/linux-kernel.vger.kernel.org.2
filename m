Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF8451C47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhKPAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245366AbhKOWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637015356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIt+27Ybc/xFYhGbecRA+0z9cXZAuYWYBls/D16W8Nw=;
        b=GX4cwn56feQ/3aRIW84ikHaRlFCzigBJK6dPR4fKU6r4cUJ6Oj15Z3S9FDafGWHaoePY9E
        +Vhwk6M1UDvAUl+RXLlJ7LKt5M85vkrVWHeFllYfihUzIli949gAnvH8GVZJGqivcZLVDP
        OChOyKbWNtfeUxHa01oUFWNjW/ToDV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-EW6pyXFhMWW_xake_gd2mw-1; Mon, 15 Nov 2021 17:29:14 -0500
X-MC-Unique: EW6pyXFhMWW_xake_gd2mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D20418D6A2C;
        Mon, 15 Nov 2021 22:29:13 +0000 (UTC)
Received: from [10.22.33.148] (unknown [10.22.33.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7576960657;
        Mon, 15 Nov 2021 22:29:11 +0000 (UTC)
Message-ID: <ce034084-364b-e30f-cb7c-d6434afe3a7d@redhat.com>
Date:   Mon, 15 Nov 2021 17:29:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
References: <20211112040753.389380-1-longman@redhat.com>
 <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
 <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
 <YZKEc+SgijOcB+0W@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YZKEc+SgijOcB+0W@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/21 11:01, Peter Zijlstra wrote:
> On Sun, Nov 14, 2021 at 10:38:57PM -0500, Waiman Long wrote:
>> On 11/12/21 07:10, Peter Zijlstra wrote:
>>> Argh, rwsem_mark_wake() doesn't clear HANDOFF when list_empty(), and
>>> write_slowpath() is *far* too clever about all of this.
>> rwsem_mark_wake() does clear the HANDOFF flag if it was set.
> Argh, yeah, I got confused by the whole !woken case, but that case won't
> ever hit list_empty() either. Perhaps that stuff could use a bit of a
> reflow too.
I think your modification already have included the rewrite for that part.
>
>>>> @@ -1098,7 +1110,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>>>    		 * In this case, we attempt to acquire the lock again
>>>>    		 * without sleeping.
>>>>    		 */
>>>> -		if (wstate == WRITER_HANDOFF) {
>>>> +		if (waiter.handoff_set) {
>>> I'm thinking this wants to be something like:
>>>
>>> 		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {
>> handoff_set flag is only set when the waiter becomes the first.
> Yes, but a random waiter can wake up and see it be set and also start
> spinning.

The handoff_set flag can only be true for a first waiter. A random 
waiter in the middle of a wait queue will never has this flag set.

This flag is set in two places in rwsem_try_write_lock():

1)

                if (has_handoff && !first)
                         return false;
                 new = count;

                 if (count & RWSEM_LOCK_MASK) {
                         /*
                          * Only the first waiter can inherit a 
previously set
                          * handoff bit.
                          */
                         waiter->handoff_set = has_handoff;

handoff_set can only be set to true here if first is also true. In that 
case, it will also return false immediately afterward.

2)

         if (new & RWSEM_FLAG_HANDOFF) {
                 waiter->handoff_set = true;
                 lockevent_inc(rwsem_wlock_handoff);
                 return false;
         }

Again, only first waiter will have a chance of setting the handoff bit 
and have handoff_set set to true.

>>>>    			enum owner_state owner_state;
>>>>    			preempt_disable();
>>> @@ -575,6 +610,11 @@ static inline bool rwsem_try_write_lock(
>>>    		return false;
>>>    	}
>>> +	/*
>>> +	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
>>> +	 * success.
>>> +	 */
>>> +	list_del(&waiter->list);
>>>    	rwsem_set_owner(sem);
>>>    	return true;
>>>    }
>>> @@ -1128,16 +1153,14 @@ rwsem_down_write_slowpath(struct rw_sema
>>>    		raw_spin_lock_irq(&sem->wait_lock);
>>>    	}
>>>    	__set_current_state(TASK_RUNNING);
>>> -	list_del(&waiter.list);
>> +    rwsem_del_waiter(sem, &waiters); ?
> I tried that, but then we get an extra atomic in this path. As is I made
> try_write_lock() do the full del_waiter, see the hunk above.

You are right. I missed your change in rwsem_try_write_lock().

Thanks,
Longman


