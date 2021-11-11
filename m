Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475344DD57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhKKV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKKV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636667662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uyb6gupJPXW7XooSy16kFkzK4TtoraLht0oTzL6zeN4=;
        b=ftNaq5PhP9kLshWz63CLS4ZaXRGosvkN5LNpQUteuJXCSFd8X1ZPpqg3ZwBxtQHQoH49Ul
        d5lq0Hg0SOxdPckO7RHDr8X1JlDJM/gRIxgV6kteebPIArnyZQw1SaToq3V5rG26h6q5jE
        gmJ1LyIeJcb3RsSFnBu8/3Bo9OxrbWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-1ZA7hkGsNGGCR0EpygX7mg-1; Thu, 11 Nov 2021 16:54:19 -0500
X-MC-Unique: 1ZA7hkGsNGGCR0EpygX7mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A99101F001;
        Thu, 11 Nov 2021 21:54:17 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F55160C05;
        Thu, 11 Nov 2021 21:54:16 +0000 (UTC)
Message-ID: <18ff812e-4ccb-479e-b13e-686c40ccb872@redhat.com>
Date:   Thu, 11 Nov 2021 16:54:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111203500.GI174703@worktop.programming.kicks-ass.net>
 <fae2008b-2cca-b483-6b40-d4b95da007d3@redhat.com>
 <YY2Kt9pvmVA+uGmG@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YY2Kt9pvmVA+uGmG@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 16:27, Peter Zijlstra wrote:
> On Thu, Nov 11, 2021 at 03:45:30PM -0500, Waiman Long wrote:
>> On 11/11/21 15:35, Peter Zijlstra wrote:
>>> On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
>>>> On 11/11/21 14:20, Peter Zijlstra wrote:
>>>>> On Thu, Nov 11, 2021 at 02:14:48PM -0500, Waiman Long wrote:
>>>>>> As for the PHASE_CHANGE name, we have to be consistent in both rwsem and
>>>>>> mutex. Maybe a follow up patch if you think we should change the
>>>>>> terminology.
>>>>> Well, that's exactly the point, they do radically different things.
>>>>> Having the same name for two different things is confusing.
>>>>>
>>>>> Anyway, let me go read that patch you sent.
>>>> My understanding of handoff is to disable optimistic spinning to let waiters
>>>> in the wait queue have an opportunity to acquire the lock. There are
>>>> difference in details on how to do that in mutex and rwsem, though.
>>> Ah, but the mutex does an actual hand-off, it hands the lock to a
>>> specific waiting task. That is, unlock() sets owner, as opposed to
>>> trylock().
>>>
>>> The rwsem code doesn't, it just forces a phase change. Once a waiter has
>>> been blocked too long, the handoff bit is set, causing new readers to be
>>> blocked. Then we wait for existing readers to complete. At that point,
>>> any next waiter (most likely a writer) should really get the lock (and
>>> in that regards the rwsem code is a bit funny).
>>>
>>> So while both ensure fairness, the means of doing so is quite different.
>>> One hands the lock ownership to a specific waiter, the other arranges
>>> for a quiescent state such that the next waiter can proceed.
>> That is a valid argument. However, the name PHASE_CHANGE sounds weird to me.
>> I am not objecting to changing the term, but probably with a better name
>> NO_OPTSPIN, NO_LOCKSTEALING or something like that to emphasize that fact
>> that optimistic spinning or lock stealing should not be allowed.
> RWSEM_FLAG_QUIESCE ?

I think that is a more acceptable term than PHASE_CHANGE. Will have a 
follow up patch later on. This one is more urgent and I want to get it 
done first.

Cheers,
Longman.

