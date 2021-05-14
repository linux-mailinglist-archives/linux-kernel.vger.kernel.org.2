Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A15380DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhENQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhENQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:02:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D071C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:01:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so11206011edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yd0YOMLaUjGlgNJJGRY7ogVwKE514n0EDrTvayvp4V0=;
        b=eVzIHkJdGUCuK9HTd9hhoswqYkWGbeolGklbQ3EbC4nIQfoy7JeMoOB1vztLSaWbzn
         V7wOq3jRE1I5QEMyQuwxfu1XP7ejQN1JfkdXy/wWpVCf9a76vvibUcnnOzwEe+0oYrYF
         rNzUv4e/mw91PhxJBSJDzB1tXGFl0TxvEHk4aYsYMEcR7Uzg86ynwktwriGkNR3++UIO
         mMlF5BYFhBAIXxobOQ5lF0OcAZeQuoiVnp2pnteVimjP9AxnllxaY2AUtu0ZCUWmbswe
         /r5E+5AfvZIgnpFPXj9R3Tk2cFFwE0ZWHQtbtdSUEfhJ6HJcGFa7YqVQBo+8jXT5JgIf
         YelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yd0YOMLaUjGlgNJJGRY7ogVwKE514n0EDrTvayvp4V0=;
        b=SXbONknADQdeUTDzrMBk0FoWnGSEjUl/eWTnHxNdNs+qF8fGVUDkUfoZ3aeqh/0VrU
         0qVhKN6HxLIEe/nuuYS1Clk9uXZwXZ1IqZGiAyn35tE9fExkw9DYetzQGhncnb5bfqw1
         NsZ/Z4H1egPY8mOBieHKBTD07lShXkgH3Ed9jQSxQRWBaOP1/SilpAgJ8b8LRhXc0SvW
         sO5I/MlWmwkLi/YU4JbDAbClKfHrS2NiXzH3/PWPUzG0Mha5qmoIwtPuaf+9qsUAZy84
         Rz57+OLPDxcKnFgbnt2fHyEQujWeTWAQN4z8acktEgTgHk8S8a7hFc28fuDUxnrUur7c
         F8sA==
X-Gm-Message-State: AOAM530iuBhk89hzkCRUyCneT+GN0V5ZFYpVZuVBpetf4qM0iR17WWwP
        5HAds9G+KaQ1cbPQW2Nfnz8JsA==
X-Google-Smtp-Source: ABdhPJxOXiDyG/xcBbBFeuZPjt7EAplqS4SnddwDZLMy3hZZDy+hj2GK9wlQNFTORhSb3F0QoujHwg==
X-Received: by 2002:a05:6402:1d8e:: with SMTP id dk14mr52012099edb.385.1621008099008;
        Fri, 14 May 2021 09:01:39 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id h23sm3795056ejx.90.2021.05.14.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 09:01:38 -0700 (PDT)
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
To:     paulmck@kernel.org
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
 <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <20210513220127.GA3511242@paulmck-ThinkPad-P17-Gen-1>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <8479a455-1813-fcee-a6ca-9fd0c2c6aabe@colorfullife.com>
Date:   Fri, 14 May 2021 18:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513220127.GA3511242@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 5/14/21 12:01 AM, Paul E. McKenney wrote:
> On Thu, May 13, 2021 at 12:02:01PM -0700, Paul E. McKenney wrote:
>> On Thu, May 13, 2021 at 08:10:51AM +0200, Manfred Spraul wrote:
>>> Hi Paul,
>>>
>>> On 5/12/21 10:17 PM, Paul E. McKenney wrote:
>>>> On Wed, May 12, 2021 at 09:58:18PM +0200, Manfred Spraul wrote:
>>>>> [...]
>>>>> sma->use_global_lock is evaluated in sem_lock() twice:
>>>>>
>>>>>>          /*
>>>>>>            * Initial check for use_global_lock. Just an optimization,
>>>>>>            * no locking, no memory barrier.
>>>>>>            */
>>>>>>           if (!sma->use_global_lock) {
>>>>> Both sides of the if-clause handle possible data races.
>>>>>
>>>>> Is
>>>>>
>>>>>       if (!data_race(sma->use_global_lock)) {
>>>>>
>>>>> the correct thing to suppress the warning?
>>>> Most likely READ_ONCE() rather than data_race(), but please see
>>>> the end of this message.
>>> Based on the document, I would say data_race() is sufficient:
>>>
>>> I have replaced the code with "if (jiffies %2)", and it runs fine.
>> OK, but please note that "jiffies" is marked volatile, which prevents the
>> compiler from fusing loads.  You just happen to be OK in this particular
>> case, as described below.  Use of the "jiffies_64" non-volatile synonym
>> for "jiffies" is better for this sort of checking.  But even so, just
>> because a particular version of a particular compiler refrains from
>> fusing loads in a particular situation does not mean that all future
>> versions of all future compilers will behave so nicely.
>>
>> Again, you are OK in this particular situation, as described below.
>>
>>> Thus I don't see which evil things a compiler could do, ... .
>> Fair enough, and your example is covered by the section "Reads Feeding
>> Into Error-Tolerant Heuristics".  The worst that the compiler can do is
>> to force an unnecessary acquisition of the global lock.
>>
>> This cannot cause incorrect execution, but could results in poor
>> scalability.  This could be a problem is load fusing were possible, that
>> is, if successes calls to this function were inlined and the compiler
>> just reused the value initially loaded.
>>
>> The reason that load fusing cannot happen in this case is that the
>> load is immediately followed by a lock acquisition, which implies a
>> barrier(), which prevents the compiler from fusing loads on opposite
>> sides of that barrier().
>>
>>> [...]
>>>
>>> Does tools/memory-model/Documentation/access-marking.txt, shown below,
>>>> help?
>>>>
>>> [...]
>>>> 	int foo;
>>>> 	DEFINE_RWLOCK(foo_rwlock);
>>>>
>>>> 	void update_foo(int newval)
>>>> 	{
>>>> 		write_lock(&foo_rwlock);
>>>> 		foo = newval;
>>>> 		do_something(newval);
>>>> 		write_unlock(&foo_rwlock);
>>>> 	}
>>>>
>>>> 	int read_foo(void)
>>>> 	{
>>>> 		int ret;
>>>>
>>>> 		read_lock(&foo_rwlock);
>>>> 		do_something_else();
>>>> 		ret = foo;
>>>> 		read_unlock(&foo_rwlock);
>>>> 		return ret;
>>>> 	}
>>>>
>>>> 	int read_foo_diagnostic(void)
>>>> 	{
>>>> 		return data_race(foo);
>>>> 	}
>>> The text didn't help, the example has helped:
>>>
>>> It was not clear to me if I have to use data_race() both on the read and the
>>> write side, or only on one side.
>>>
>>> Based on this example: plain C may be paired with data_race(), there is no
>>> need to mark both sides.
>> Actually, you just demonstrated that this example is quite misleading.
>> That data_race() works only because the read is for diagnostic
>> purposes.  I am queuing a commit with your Reported-by that makes
>> read_foo_diagnostic() just do a pr_info(), like this:
>>
>> 	void read_foo_diagnostic(void)
>> 	{
>> 		pr_info("Current value of foo: %d\n", data_race(foo));
>> 	}
>>
>> So thank you for that!
> And please see below for an example better illustrating your use case.
> Anything messed up or missing?
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit b4287410ee93109501defc4695ccc29144e8f3a3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu May 13 14:54:58 2021 -0700
>
>      tools/memory-model: Add example for heuristic lockless reads
>      
>      This commit adds example code for heuristic lockless reads, based loosely
>      on the sem_lock() and sem_unlock() functions.

I would refer to nf_conntrack_all_lock() instead of sem_lock():

nf_conntrack_all_lock() is far easier to read, and it contains the same 
heuristics

>      
>      Reported-by: Manfred Spraul <manfred@colorfullife.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> index 58bff2619876..e4a20ebf565d 100644
> --- a/tools/memory-model/Documentation/access-marking.txt
> +++ b/tools/memory-model/Documentation/access-marking.txt
> @@ -319,6 +319,98 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
>   concurrent lockless write.
>   
>   
> +Lock-Protected Writes With Heuristic Lockless Reads
> +---------------------------------------------------
> +
> +For another example, suppose that the code can normally make use of
> +a per-data-structure lock, but there are times when a global lock is
> +required.  These times are indicated via a global flag.  The code might
> +look as follows, and is based loosely on sem_lock() and sem_unlock():
> +
> +	bool global_flag;
> +	DEFINE_SPINLOCK(global_lock);
> +	struct foo {
> +		spinlock_t f_lock;
> +		int f_data;
> +	};
> +
> +	/* All foo structures are in the following array. */
> +	int nfoo;
> +	struct foo *foo_array;
> +
> +	void do_something_locked(struct foo *fp)
> +	{
> +		/* IMPORTANT: Heuristic plus spin_lock()! */
> +		if (!data_race(global_flag)) {
> +			spin_lock(&fp->f_lock);
> +			if (!smp_load_acquire(&global_flag)) {
> +				do_something(fp);
> +				spin_unlock(&fp->f_lock);
> +				return;
> +			}
> +			spin_unlock(&fp->f_lock);
> +		}
> +		spin_lock(&global_flag);
> +		/* Lock held, thus global flag cannot change. */
> +		if (!global_flag) {
> +			spin_lock(&fp->f_lock);
> +			spin_unlock(&global_flag);

spin_unlock(&global_lock), not &global_flag.

That was the main results from the discussions a few years ago:

Split global_lock and global_flag. Do not try to use 
spin_is_locked(&global_lock). Just add a flag. The 4 bytes are well 
invested.

> +		}
> +		do_something(fp);
> +		if (global_flag)
> +			spin_unlock(&global_flag);
&global_lock
> +		else
> +			spin_lock(&fp->f_lock);
> +	}
> +
> +	void begin_global(void)
> +	{
> +		int i;
> +
> +		spin_lock(&global_flag);
> +		WRITE_ONCE(global_flag, true);
> +		for (i = 0; i < nfoo; i++) {
> +			/* Wait for pre-existing local locks. */
> +			spin_lock(&fp->f_lock);
> +			spin_unlock(&fp->f_lock);
> +		}
> +		spin_unlock(&global_flag);
> +	}
> +
> +	void end_global(void)
> +	{
> +		spin_lock(&global_flag);
> +		smp_store_release(&global_flag, false);
> +		/* Pre-existing global lock acquisitions will recheck. */
> +		spin_unlock(&global_flag);
> +	}
> +
> +All code paths leading from the do_something_locked() function's first
> +read from global_flag acquire a lock, so endless load fusing cannot
> +happen.
> +
> +If the value read from global_flag is true, then global_flag is rechecked
> +while holding global_lock, which prevents global_flag from changing.
> +If this recheck finds that global_flag is now false, the acquisition
> +of ->f_lock prior to the release of global_lock will result in any subsequent
> +begin_global() invocation waiting to acquire ->f_lock.
> +
> +On the other hand, if the value read from global_flag is false, then
> +global_flag, then rechecking under ->f_lock combined with synchronization
> +with begin_global() guarantees than any erroneous read will cause the
> +do_something_locked() function's first do_something() invocation to happen
> +before begin_global() returns.  The combination of the smp_load_acquire()
> +in do_something_locked() and the smp_store_release() in end_global()
> +guarantees that either the do_something_locked() function's first
> +do_something() invocation happens after the call to end_global() or that
> +do_something_locked() acquires global_lock() and rechecks under the lock.
> +
> +For this to work, only those foo structures in foo_array[] may be
> +passed to do_something_locked().  The reason for this is that the
> +synchronization with begin_global() relies on momentarily locking each
> +and every foo structure.
> +
> +
>   Lockless Reads and Writes
>   -------------------------
>   


