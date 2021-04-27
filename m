Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7C36BF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhD0GiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:38:19 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:47686 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhD0GiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:38:17 -0400
Received: from [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be] (p200300f7f70f8e007457087a58db74be.dip0.t-ipconnect.de [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: alexander@sosna.de)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 3499ED400BA;
        Tue, 27 Apr 2021 08:37:31 +0200 (CEST)
From:   Alexander Sosna <alexander@sosna.de>
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
Message-ID: <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
Date:   Tue, 27 Apr 2021 08:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIdWMC/iAdanDjLh@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Am 27.04.21 um 02:09 schrieb Chris Down:
> Hi Alexander,
> 
> Alexander Sosna writes:
>> Before this commit memory cgroup limits were not enforced during
>> allocation.  If a process within a cgroup tries to allocates more
>> memory than allowed, the kernel will not prevent the allocation even if
>> OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
>> processes in the corresponding cgroup.
> 
> Unresolvable cgroup overages are indifferent to vm.overcommit_memory,
> since exceeding memory.max is not overcommitment, it's just a natural
> consequence of the fact that allocation and reclaim are not atomic
> processes. Overcommitment, on the other hand, is about the bounds of
> available memory at the global resource level.
> 
>> This behavior is not to be expected
>> when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
>> problem for applications assuming that the kernel will deny an allocation
>> if not enough memory is available, like PostgreSQL.  To prevent this a
>> check is implemented to not allow a process to allocate more memory than
>> limited by it's cgroup.  This means a process will not be killed while
>> accessing pages but will receive errors on memory allocation as
>> appropriate.  This gives programs a chance to handle memory allocation
>> failures gracefully instead of being reaped.
> 
> We don't guarantee that vm.overcommit_memory 2 means "no OOM killer". It
> can still happen for a bunch of reasons, so I really hope PostgreSQL
> isn't relying on that.
> 
> Could you please be more clear about the "huge problem" being solved
> here? I'm not seeing it.

let me explain the problem I encounter and why I fell down the mm rabbit
hole.  It is not a PostgreSQL specific problem but that's where I run
into it.  PostgreSQL forks a backend for each client connection.  All
backends have shared memory as well as local work memory.  When a
backend needs more dynamic work_mem to execute a query, new memory
is allocated.  It is normal that such an allocation can fail.  If the
backend gets an ENOMEM the current query is rolled back an all dynamic
work_mem is freed. The RDBMS stays operational an no other query is
disturbed.

When running in a memory cgroup - for example via systemd or on k8s -
the kernel will not return ENOMEM even if the cgroup's memory limit is
exceeded.  Instead the OOM killer is awakened and kills processes in the
violating cgroup.  If any backend is killed with SIGKILL the shared
memory of the whole cluster is deemed potentially corrupted and
PostgreSQL needs to do an emergency restart.  This cancels all operation
on all backends and it entails a potentially lengthy recovery process.
Therefore the behavior is quite "costly".

I totally understand that vm.overcommit_memory 2 does not mean "no OOM
killer". IMHO it should mean "no OOM killer if we can avoid it" and I
would highly appreciate if the kernel would use a less invasive means
whenever possible.  I guess this might also be the expectation by many
other users.  In my described case - which is a real pain for me - it is
quite easy to tweak the kernel behavior in order to handle this and
other similar situations with less casualties.  This is why I send a
patch instead of starting a theoretical discussion.

What do you think is necessary to get this to an approvable quality?

>> Signed-off-by: Alexander Sosna <alexander@sosna.de>
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index a8bf17f18a81..c84b83c532c6 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -853,6 +853,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
>>  *
>>  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
>>  * Additional code 2002 Jul 20 by Robert Love.
>> + * Code to enforce memory cgroup limits added 2021 by Alexander Sosna.
>>  *
>>  * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
>>  *
>> @@ -891,6 +892,34 @@ int __vm_enough_memory(struct mm_struct *mm, long
>> pages, int cap_sys_admin)
>>         long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
>>
>>         allowed -= min_t(long, mm->total_vm / 32, reserve);
>> +
>> +#ifdef CONFIG_MEMCG
>> +        /*
>> +         * If we are in a memory cgroup we also evaluate if the cgroup
>> +         * has enough memory to allocate a new virtual mapping.
> 
> This comment confuses me further, I'm afraid. You're talking about
> virtual mappings, but then checking memory.max, which is about allocated
> pages.

I had some problems understanding all mm and cgroup related code in the
kernel and wished for helpfull comments here and there.  So I tried at
least to document my code and made it worse.  Thank you for pointing
this out.

>> +         * This is how we can keep processes from exceeding their
>> +         * limits and also prevent that the OOM killer must be
>> +         * awakened.  This gives programs a chance to handle memory
>> +         * allocation failures gracefully and not being reaped.
>> +         * In the current version mem_cgroup_get_max() is used which
>> +         * allows the processes to exceeded their memory limits if
>> +         * enough SWAP is available.  If this is not intended we could
>> +         * use READ_ONCE(memcg->memory.max) instead.
>> +         *
>> +         * This code is only reached if sysctl_overcommit_memory equals
>> +         * OVERCOMMIT_NEVER, both other options are handled above.
>> +         */
>> +        {
>> +            struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>> +
>> +            if (memcg) {
>> +                long available = mem_cgroup_get_max(memcg)
>> +                        - mem_cgroup_size(memcg);
>> +
>> +                allowed = min_t(long, available, allowed);
>> +            }
>> +        }
>> +#endif
>>     }
>>
>>     if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>>

