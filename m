Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8A447151
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 04:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhKGD21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 23:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234381AbhKGD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 23:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636255542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuPga3VlnwdEXzKHOAfmbH2n3UjZXJclALQ/G/FJiZk=;
        b=DbNApelHG8NuFhkxntScpVZm2MTucbbLCGwAVdEr76hjK5OVMJhsWaGScBzXUcE7OKXxxp
        y928GGLSGdjc+I/TlhCVPQ/9+8oeBCLJGQdCWD9gZ8wVxtYzgKKAkAg15S8kui0Vh4f7ci
        KRqzllCE7/cKWw2fIQN/sdSuiCm72CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Bh5FkndKM-CcXdnnGPB0BQ-1; Sat, 06 Nov 2021 23:25:41 -0400
X-MC-Unique: Bh5FkndKM-CcXdnnGPB0BQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E4A0802C91;
        Sun,  7 Nov 2021 03:25:40 +0000 (UTC)
Received: from [10.22.32.9] (unknown [10.22.32.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E79319730;
        Sun,  7 Nov 2021 03:25:39 +0000 (UTC)
Message-ID: <55bfbf1c-5906-9cc9-ee68-a1c69651bbc3@redhat.com>
Date:   Sat, 6 Nov 2021 23:25:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
To:     =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        peterz <peterz@infradead.org>, mingo <mingo@redhat.com>,
        will <will@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/21 08:39, 马振华 wrote:
> Dear longman,
>
> recently , i find a issue which rwsem count is negative value, it 
> happened always when a task try to get the lock 
> with __down_write_killable , then it is killed
>
> this issue happened like this
>
>             CPU2         CPU4
>     task A[reader]     task B[writer]
>     down_read_killable[locked]
>     sem->count=0x100
>             down_write_killable
>             sem->count=0x102[wlist not empty]
>     up_read
>     count=0x2
>             sig kill received
>     down_read_killable
>     sem->count=0x102[wlist not empty]
>             goto branch out_nolock:
> list_del(&waiter.list);
> wait list is empty
> sem->count-RWSEM_FLAG_HANDOFF
> sem->count=0xFE
>     list_empty(&sem->wait_list) is TRUE
>      sem->count andnot RWSEM_FLAG_WAITERS
>       sem->count=0xFC
>     up_read
>     sem->count -= 0x100
>     sem->count=0xFFFFFFFFFFFFFFFC
>     DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
>
> so sem->count will be negative after writer is killed
> i think if flag RWSEM_FLAG_HANDOFF is not set, we shouldn't clean it

Thanks for reporting this possible race condition.

However, I am still trying to figure how it is possible to set the 
wstate to WRITER_HANDOFF without actually setting the handoff bit as 
well. The statement sequence should be as follows:

wstate = WRITER_HANDOFF;
raw_spin_lock_irq(&sem->wait_lock);
if (rwsem_try_write_lock(sem, wstate))
raw_spin_unlock_irq(&sem->wait_lock);
   :
if (signal_pending_state(state, current))
     goto out_nolock

The rwsem_try_write_lock() function will make sure that we either 
acquire the lock and clear handoff or set the handoff bit. This should 
be done before we actually check for signal. I do think that it is 
probably safer to use atomic_long_andnot to clear the handoff bit 
instead of using atomic_long_add().

Cheers,
Longman

