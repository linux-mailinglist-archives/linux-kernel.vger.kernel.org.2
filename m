Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4866244DD70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKKWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKKWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636668031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eggm79o599+HawEaUwqMAm98/at00pZzOE7bb4pOkUc=;
        b=iAjAikEuN9a/RomUcb9UhlfXM8T/w4/Xpo+yMlmz8Hq4/eXEXdgfYHvVpe9zEGfQS+C0Gl
        bAvxVc56QUdb6DwV7IoT/S4uPFv/M//KwFcUdWfGhfkefOXKsxnKtBH2ZndZNdInFGq0T5
        qKTiQhIZsDm2WqlUg4TZYorjRPxcEWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-6i53uR8eOFyVB2KSSZ4Wiw-1; Thu, 11 Nov 2021 17:00:28 -0500
X-MC-Unique: 6i53uR8eOFyVB2KSSZ4Wiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B2A1E744;
        Thu, 11 Nov 2021 22:00:26 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C0626091B;
        Thu, 11 Nov 2021 22:00:25 +0000 (UTC)
Message-ID: <404dbe55-d49b-79ce-c10f-4fb9deadfebd@redhat.com>
Date:   Thu, 11 Nov 2021 17:00:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111202647.GH174703@worktop.programming.kicks-ass.net>
 <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
 <436bcf39-297a-f5a6-ac58-a82e77cb3b83@redhat.com>
 <YY2Q220iEiFdaKlT@hirez.programming.kicks-ass.net>
 <1158f843-ee83-8dea-fade-e59f529a88fb@redhat.com>
In-Reply-To: <1158f843-ee83-8dea-fade-e59f529a88fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 16:55, Waiman Long wrote:
>
> On 11/11/21 16:53, Peter Zijlstra wrote:
>> On Thu, Nov 11, 2021 at 04:25:56PM -0500, Waiman Long wrote:
>>> On 11/11/21 16:01, Waiman Long wrote:
>>>> On 11/11/21 15:26, Peter Zijlstra wrote:
>>>>> On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
>>>>>
>>>>>> @@ -434,6 +430,7 @@ static void rwsem_mark_wake(struct
>>>>>> rw_semaphore *sem,
>>>>>>                if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>>>>>>                    time_after(jiffies, waiter->timeout)) {
>>>>>>                    adjustment -= RWSEM_FLAG_HANDOFF;
>>>>>> +                waiter->handoff_set = true;
>>>>>>                    lockevent_inc(rwsem_rlock_handoff);
>>>>>>                }
>>>>> Do we really need this flag? Wouldn't it be the same as 
>>>>> waiter-is-first
>>>>> AND sem-has-handoff ?
>>>> That is true. The only downside is that we have to read the count 
>>>> first
>>>> in rwsem_out_nolock_clear_flags(). Since this is not a fast path, it
>>>> should be OK to do that.
>>> I just realize that I may still need this flag for writer to 
>>> determine if it
>>> should spin after failing to acquire the lock. Or I will have to do 
>>> extra
>>> read of count value in the loop. I don't need to use it for writer now.
>> Maybe it's too late here, but afaict this is right after failing
>> try_write_lock(), which will have done at least that load you're
>> interested in, no?
>>
>> Simply have try_write_lock() update &count or something.
>
> You are right. I have actually decided to do an extra read after 
> second thought.

Oh, I would like to take it back. The condition to do spinning is when 
the handoff bit is set and the waiter is the first one in the queue. It 
be easier to do it with extra internal state variable.

Cheers,
Longman

