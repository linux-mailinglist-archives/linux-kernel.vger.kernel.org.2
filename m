Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D773ABFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhFQXvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 19:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhFQXvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:51:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D99E36128B;
        Thu, 17 Jun 2021 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623973770;
        bh=nSxwA4kUOitAUVHMWqIwKq28yMKy3VPBBPja5BVj3ac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QdUqaxaCNxKcwchVDO6u0pqLB7txf9m3HI6+iqYyd/t6cWk0Djt8524fn/h5xpJNn
         blqY7bla8WHR9zJlFkbR8v6C0ERlv5fzT+aePOzsYsOvmn2KGCJH5eMGaBjVUw4SK9
         UFg5hPthTZtDuNiur4iNawgaE040CndKO1RiPfuDlQcQUj7fPCJeQuZl38Hih57Pkk
         5NSYAM3iL5+XGb2UhZq+W7AMTLBSB64QbVAN/6BT2k8szd3Ga7pXoGCYXcFwnnaSPp
         JjVPKr/a/G6Iypa+jOU5UXfUnHbFrmvxrRJLI1dRnTHWtjGx8kisUvuIwY55jsTfES
         fY66yrkVTvMew==
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <1623911501.q97zemobmw.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <5efaca70-35a0-1ce5-98ff-651a5f153a0a@kernel.org>
Date:   Thu, 17 Jun 2021 16:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623911501.q97zemobmw.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 11:51 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 17, 2021 3:32 pm:
>> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
>>>
>>>
>>> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
>>>> Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
>>>>> On 6/16/21 12:35 AM, Peter Zijlstra wrote:
>>>>>> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>>>>>>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>>>>>>>> membarrier() needs a barrier after any CPU changes mm.  There is currently
>>>>>>>> a comment explaining why this barrier probably exists in all cases.  This
>>>>>>>> is very fragile -- any change to the relevant parts of the scheduler
>>>>>>>> might get rid of these barriers, and it's not really clear to me that
>>>>>>>> the barrier actually exists in all necessary cases.
>>>>>>>
>>>>>>> The comments and barriers in the mmdrop() hunks? I don't see what is 
>>>>>>> fragile or maybe-buggy about this. The barrier definitely exists.
>>>>>>>
>>>>>>> And any change can change anything, that doesn't make it fragile. My
>>>>>>> lazy tlb refcounting change avoids the mmdrop in some cases, but it
>>>>>>> replaces it with smp_mb for example.
>>>>>>
>>>>>> I'm with Nick again, on this. You're adding extra barriers for no
>>>>>> discernible reason, that's not generally encouraged, seeing how extra
>>>>>> barriers is extra slow.
>>>>>>
>>>>>> Both mmdrop() itself, as well as the callsite have comments saying how
>>>>>> membarrier relies on the implied barrier, what's fragile about that?
>>>>>>
>>>>>
>>>>> My real motivation is that mmgrab() and mmdrop() don't actually need to
>>>>> be full barriers.  The current implementation has them being full
>>>>> barriers, and the current implementation is quite slow.  So let's try
>>>>> that commit message again:
>>>>>
>>>>> membarrier() needs a barrier after any CPU changes mm.  There is currently
>>>>> a comment explaining why this barrier probably exists in all cases. The
>>>>> logic is based on ensuring that the barrier exists on every control flow
>>>>> path through the scheduler.  It also relies on mmgrab() and mmdrop() being
>>>>> full barriers.
>>>>>
>>>>> mmgrab() and mmdrop() would be better if they were not full barriers.  As a
>>>>> trivial optimization, mmgrab() could use a relaxed atomic and mmdrop()
>>>>> could use a release on architectures that have these operations.
>>>>
>>>> I'm not against the idea, I've looked at something similar before (not
>>>> for mmdrop but a different primitive). Also my lazy tlb shootdown series 
>>>> could possibly take advantage of this, I might cherry pick it and test 
>>>> performance :)
>>>>
>>>> I don't think it belongs in this series though. Should go together with
>>>> something that takes advantage of it.
>>>
>>> I’m going to see if I can get hazard pointers into shape quickly.
>>
>> Here it is.  Not even boot tested!
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=sched/lazymm&id=ecc3992c36cb88087df9c537e2326efb51c95e31
>>
>> Nick, I think you can accomplish much the same thing as your patch by:
>>
>> #define for_each_possible_lazymm_cpu while (false)
> 
> I'm not sure what you mean? For powerpc, other CPUs can be using the mm 
> as lazy at this point. I must be missing something.

What I mean is: if you want to shoot down lazies instead of doing the
hazard pointer trick to track them, you could do:

#define for_each_possible_lazymm_cpu while (false)

which would promise to the core code that you don't have any lazies left
by the time exit_mmap() is done.  You might need a new hook in
exit_mmap() depending on exactly how you implement the lazy shootdown.
