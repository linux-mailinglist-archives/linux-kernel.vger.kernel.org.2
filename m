Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52A3ABFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFQXry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 19:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhFQXrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:47:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B261061249;
        Thu, 17 Jun 2021 23:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623973545;
        bh=b9n22f59waq6Zjf5wNWLy92938cntiW3Y6K75NuR7QE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDh8bGoKPqQJj55E1dK77PrlYbLlNSnQvEpXdfTLOJqbrL0JTHEN+nSsKgYmSS0vL
         R05fK7rvcjvi70NvKCZhZrtRM/0eBHr5YIdjjBXbSuhuNEUrGCM1AdlBaJpSRfvqKi
         KZBbRJklnu684S5fq9Pl3Fzyeus1R+8fXFsy4bIE6jrqmntsqy598LwLEMaROBkDUk
         n2+w6nHhARto4z5JZwyAGyoPPiw6HRThYppFsqqLbW1OqX0sfgiNircrhF469hLz52
         VzVx+5U0jB39cuXl54BpTFmWwel+y43a9imzokXA5N+mYHqpZ8CUNbipAoUZcSIG0R
         gFhgkpyYd2+1Q==
Subject: Re: [PATCH 1/8] membarrier: Document why membarrier() works
To:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <cover.1623813516.git.luto@kernel.org>
 <b648efcb72feb257b9fe004bd132f581805ec0d6.1623813516.git.luto@kernel.org>
 <1623814509.xcl6pmt93d.astroid@bobo.none>
 <YMmoqgLdMNu7KAV5@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b7102c74-18b0-150e-c103-85afa26a8b6a@kernel.org>
Date:   Thu, 17 Jun 2021 16:45:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMmoqgLdMNu7KAV5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 12:30 AM, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 02:00:37PM +1000, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>>> We had a nice comment at the top of membarrier.c explaining why membarrier
>>> worked in a handful of scenarios, but that consisted more of a list of
>>> things not to forget than an actual description of the algorithm and why it
>>> should be expected to work.
>>>
>>> Add a comment explaining my understanding of the algorithm.  This exposes a
>>> couple of implementation issues that I will hopefully fix up in subsequent
>>> patches.
>>>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>>> ---
>>>  kernel/sched/membarrier.c | 55 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 55 insertions(+)
>>>
>>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>>> index b5add64d9698..3173b063d358 100644
>>> --- a/kernel/sched/membarrier.c
>>> +++ b/kernel/sched/membarrier.c
>>> @@ -7,6 +7,61 @@
>>>  #include "sched.h"
>>>  
>>
>> Precisely describing the orderings is great, not a fan of the style of the
>> comment though.
> 
> I'm with Nick on that; I can't read it :/ It only makes things more
> confusing. If you want precision, English (or any natural language) is
> your enemy.
> 
> To describe ordering use the diagrams and/or litmus tests.
> 

I made some changes.  Maybe it's better now.
