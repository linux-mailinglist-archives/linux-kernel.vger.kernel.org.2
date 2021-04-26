Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEBD36B586
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhDZPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:14:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE989C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FM/VJtHf2XEbmY4rOKY8L9soinry1q5BGhfjGq2tgBM=; b=myagE4mgsoKBKT/KdSVGwv99wr
        WYHLtjgV+t/k2OMKS/Mxi1ZyxnXb1L+ZLMiO3Qr+txFT6Qs0B+q6MszQuUvLQNueYPgOrzU8XwppO
        qbcRNZAyDRBJ2SSdvFJtpM0JqGLQpXSs4Ky7QrAJ/p+u3mVSjkRF9mEwIX2ZlpQlX+rB3P/JcWhx+
        CKd0FlN5aLUMZqyokfge7dQtvikfAzdXUnM/j2/fq6W50CCCLjAIFGpT+EvQVSqYrcnZfHprRID/F
        0iaTshjQGEGxIrOaKIrSTM/Sab/F0sBNN8FdyfYNlxWnuNoUwENXfJvVLtQ/EXj7m8Qn4ZMxFIxqG
        XkgGqubw==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb2v9-005l7n-Hd; Mon, 26 Apr 2021 15:13:17 +0000
Subject: Re: Documentation/memory-barriers.txt: Is "stores are not speculated"
 correct?
To:     Luc Maranget <Luc.Maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     szyhb810501.student@sina.com, stern <stern@rowland.harvard.edu>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        peterz <peterz@infradead.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
 <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426093000.GA2583903@yquem.paris.inria.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1c077a9-cae3-724e-a2e5-832cf5a86708@infradead.org>
Date:   Mon, 26 Apr 2021 08:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210426093000.GA2583903@yquem.paris.inria.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 2:30 AM, Luc Maranget wrote:
>> On Mon, Apr 26, 2021 at 10:23:09AM +0800, szyhb810501.student@sina.com wrote:
>>>
>>> Hello everyone, I have a question."Documentation/memory-barriers.txt"
>>> says:However, stores are not speculated.  This means that ordering -is-
>>> providedfor load-store control dependencies, as in the following example:
>> 	q = READ_ONCE(a);
>> 	if (q) {
>> 		WRITE_ONCE(b, 1);
>> 	}
>>> Is "stores are not speculated" correct? I
>>> think store instructions can be executed speculatively.
>>> "https://stackoverflow.com/questions/64141366/can-a-speculatively-executed-cpu-branch-contain-opcodes-that-access-ram"
>>> says:Store instructions can also be executed speculatively thanks to the
>>> store buffer. The actual execution of a store just writes the address and
>>> data into the store buffer.Commit to L1d cache happens some time after
>>> the store instruction retires from the ROB, i.e. when the store is known
>>> to be non-speculative, the associated store-buffer entry "graduates"
>>> and becomes eligible to commit to cache and become globally visible.
>>
>> >From the viewpoint of other CPUs, the store hasn't really happened
>> until it finds its way into a cacheline.  As you yourself note above,
>> if the store is still in the store buffer, it might be squashed when
>> speculation fails.
>>
>> So Documentation/memory-barriers.txt and that stackoverflow entry are
>> not really in conflict, but are instead using words a bit differently
>> from each other.  The stackoverflow entry is considering a store to have
>> in some sense happened during a time when it might later be squashed.
>> In contrast, the Documentation/memory-barriers.txt document only considers
>> a store to have completed once it is visible outside of the CPU executing
>> that store.
>>
>> So from a stackoverflow viewpoint, stores can be speculated, but until
>> they are finalized, they must be hidden from other CPUs.
>>
>> >From a Documentation/memory-barriers.txt viewpoint, stores don't complete
>> until they update their cachelines, and stores may not be speculated.
>> Some of the actions that lead up to the completion of a store may be
>> speculated, but not the completion of the store itself.
>>
>> Different words, but same effect.  Welcome to our world!  ;-)
>>
>> 							Thanx, Paul
> 
> Hi all,
> 
> Here is a complement to Paul's excellent answer.
> 
> The "CPU-local" speculation of stores can be observed
> by the following test (in C11)
> 
> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
> 
> C PPOCA
> 
> {}
> 
> P0(volatile int* y, volatile int* x) {
> 
>   atomic_store(x,1);
>   atomic_store(y,1);
> 
> }
> 
> P1(volatile int* z, volatile int* y, volatile int* x) {
> 
>   int r1=-1; int r2=-1;
>   int r0 = atomic_load_explicit(y,memory_order_relaxed);
>   if (r0) {
>     atomic_store_explicit(z,1,memory_order_relaxed);
>     r1 = atomic_load_explicit(z,memory_order_relaxed);
>     r2 = atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
>   }
> 
> }
> 
> 
> This is a variation on the MP test.
> 
> Because of tht conditionnal "if (..) { S }" Statements "S" can be executed
> speculatively.
> 
> More precisely, the store statement writes value 1 into the CPU local
> structure for variable z. The next load statement reads the value,
> and the last load statement can be peformed (speculatively)
> as its address is known.
> 
> The resulting outcomme is observed for instance on a RaspBerry Pi3,
> see attached file.

?attached file?

-- 
~Randy

