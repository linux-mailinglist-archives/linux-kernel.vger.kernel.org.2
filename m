Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185D144756A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhKGTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234197AbhKGTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636314762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRtXsfbwe6sOVTWzEkkVLz9nsb5DFuluw4QwOrwL+4g=;
        b=KDmfZ4JZ7bmQo5oAITg1VYO/8ymNRCDQ3L54NgEHw8hL1zZgsQFG6xfLa78IjqtI5eUI7m
        jwi89yKJNNAhHkPsKhQBVGEFYWTbAP2dEzA5ErsvFwWd4QdoFSN6IoSZMpw7VWI9J5aSkb
        993Z5oH4i2bZZhmaokjfocyszn1JMSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-5xq37IY-NwGG6F5KjLr3mw-1; Sun, 07 Nov 2021 14:52:39 -0500
X-MC-Unique: 5xq37IY-NwGG6F5KjLr3mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6154CC621;
        Sun,  7 Nov 2021 19:52:37 +0000 (UTC)
Received: from [10.22.32.104] (unknown [10.22.32.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E824619730;
        Sun,  7 Nov 2021 19:52:36 +0000 (UTC)
Message-ID: <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
Date:   Sun, 7 Nov 2021 14:52:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        peterz <peterz@infradead.org>, mingo <mingo@redhat.com>,
        will <will@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
In-Reply-To: <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/21 10:24, Waiman Long wrote:
> On 11/7/21 04:01, Hillf Danton wrote:
>> On Sat, 6 Nov 2021 23:25:38 -0400 Waiman Long wrote:
>>> On 11/6/21 08:39, 马振华 wrote:
>>>> Dear longman,
>>>>
>>>> recently , i find a issue which rwsem count is negative value, it
>>>> happened always when a task try to get the lock
>>>> with __down_write_killable , then it is killed
>>>>
>>>> this issue happened like this
>>>>
>>>>              CPU2         CPU4
>>>>      task A[reader]     task B[writer]
>>>>      down_read_killable[locked]
>>>>      sem->count=0x100
>>>>              down_write_killable
>>>>              sem->count=0x102[wlist not empty]
>>>>      up_read
>>>>      count=0x2
>>>>              sig kill received
>>>>      down_read_killable
>>>>      sem->count=0x102[wlist not empty]
>>>>              goto branch out_nolock:
>>>> list_del(&waiter.list);
>>>> wait list is empty
>>>> sem->count-RWSEM_FLAG_HANDOFF
>>>> sem->count=0xFE
>>>>      list_empty(&sem->wait_list) is TRUE
>>>>       sem->count andnot RWSEM_FLAG_WAITERS
>>>>        sem->count=0xFC
>>>>      up_read
>>>>      sem->count -= 0x100
>>>>      sem->count=0xFFFFFFFFFFFFFFFC
>>>>      DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
>>>>
>>>> so sem->count will be negative after writer is killed
>>>> i think if flag RWSEM_FLAG_HANDOFF is not set, we shouldn't clean it
>>> Thanks for reporting this possible race condition.
>>>
>>> However, I am still trying to figure how it is possible to set the
>>> wstate to WRITER_HANDOFF without actually setting the handoff bit as
>>> well. The statement sequence should be as follows:
>>>
>>> wstate = WRITER_HANDOFF;
>>> raw_spin_lock_irq(&sem->wait_lock);
>>> if (rwsem_try_write_lock(sem, wstate))
>>> raw_spin_unlock_irq(&sem->wait_lock);
>>>    :
>>> if (signal_pending_state(state, current))
>>>      goto out_nolock
>>>
>>> The rwsem_try_write_lock() function will make sure that we either
>>> acquire the lock and clear handoff or set the handoff bit. This should
>>> be done before we actually check for signal. I do think that it is
>> Given that WRITER_HANDOFF makes no sure that RWSEM_FLAG_HANDOFF is 
>> set in
>> wsem_try_write_lock(), the flag should be cleared only by the setter to
>> avoid count underflow.
>>
>> Hillf
>>
>>> probably safer to use atomic_long_andnot to clear the handoff bit
>>> instead of using atomic_long_add().
>
> I did have a tentative patch to address this issue which is somewhat 
> similar to your approach. However, I would like to further investigate 
> the exact mechanics of the race condition to make sure that I won't 
> miss a latent bug somewhere else in the rwsem code.

I still couldn't figure how this race condition can happen. However, I 
do discover that it is possible to leave rwsem with no waiter but 
handoff bit set if we kill or interrupt all the waiters in the wait 
queue. I have just sent out a patch to address that concern, but it 
should be able to handle this race condition as well if it really happens.

Cheers,
Longman

