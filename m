Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17E36C490
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhD0LC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:02:27 -0400
Received: from mailproxy05.manitu.net ([217.11.48.69]:53358 "EHLO
        mailproxy05.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhD0LCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:02:22 -0400
Received: from [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be] (p200300f7f70f8e007457087a58db74be.dip0.t-ipconnect.de [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: alexander@sosna.de)
        by mailproxy05.manitu.net (Postfix) with ESMTPSA id 850A91B616DE;
        Tue, 27 Apr 2021 13:01:34 +0200 (CEST)
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
To:     Michal Hocko <mhocko@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
 <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
From:   Alexander Sosna <alexander@sosna.de>
Message-ID: <c7e0a2f9-0b83-2d9b-8ec1-8141d5dca554@sosna.de>
Date:   Tue, 27 Apr 2021 13:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.21 10:08, Michal Hocko wrote:
> On Tue 27-04-21 08:37:30, Alexander Sosna wrote:
>> Hi Chris,
>>
>> Am 27.04.21 um 02:09 schrieb Chris Down:
>>> Hi Alexander,
>>>
>>> Alexander Sosna writes:
>>>> Before this commit memory cgroup limits were not enforced during
>>>> allocation.  If a process within a cgroup tries to allocates more
>>>> memory than allowed, the kernel will not prevent the allocation even if
>>>> OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
>>>> processes in the corresponding cgroup.
>>>
>>> Unresolvable cgroup overages are indifferent to vm.overcommit_memory,
>>> since exceeding memory.max is not overcommitment, it's just a natural
>>> consequence of the fact that allocation and reclaim are not atomic
>>> processes. Overcommitment, on the other hand, is about the bounds of
>>> available memory at the global resource level.
>>>
>>>> This behavior is not to be expected
>>>> when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
>>>> problem for applications assuming that the kernel will deny an allocation
>>>> if not enough memory is available, like PostgreSQL.  To prevent this a
>>>> check is implemented to not allow a process to allocate more memory than
>>>> limited by it's cgroup.  This means a process will not be killed while
>>>> accessing pages but will receive errors on memory allocation as
>>>> appropriate.  This gives programs a chance to handle memory allocation
>>>> failures gracefully instead of being reaped.
>>>
>>> We don't guarantee that vm.overcommit_memory 2 means "no OOM killer". It
>>> can still happen for a bunch of reasons, so I really hope PostgreSQL
>>> isn't relying on that.
>>>
>>> Could you please be more clear about the "huge problem" being solved
>>> here? I'm not seeing it.
>>
>> let me explain the problem I encounter and why I fell down the mm rabbit
>> hole.  It is not a PostgreSQL specific problem but that's where I run
>> into it.  PostgreSQL forks a backend for each client connection.  All
>> backends have shared memory as well as local work memory.  When a
>> backend needs more dynamic work_mem to execute a query, new memory
>> is allocated.  It is normal that such an allocation can fail.  If the
>> backend gets an ENOMEM the current query is rolled back an all dynamic
>> work_mem is freed. The RDBMS stays operational an no other query is
>> disturbed.
> 
> I am afraid the kernel MM implementation has never been really
> compatible with such a memory allocation model. Linux has always
> preferred to pretend there is always memory available and rather reclaim
> memory - including by killing some processes - rather than fail the
> allocation eith ENOMEM. Overcommit configuration (especially
> OVERCOMMIT_NEVER) is an attempt to somehow mitigate this ambitious
> memory allocation approach but in reality this has turned out a)
> unreliable and b) unsuable with modern userspace which relies on
> considerable virtual memory overcommit.

Thank you for taking the time to discuss this issue with me.  I agree
that the kernel and a lot of software prefers to pretend there is more
memory than there really is.  It was also never possible to assume that
the OOM killer is fully absent.  I'm running production Linux systems
for quite a while now and without memory cgroups involved
OVERCOMMIT_NEVER does a pretty good job.  I can't even remember the last
time the OOM killer caused me any problems on a properly configured
database server.  This is what I would like and what users should be
able to expect for the use with cgroup memory limits as well.

Please correct me if I am wrong, but "modern userspace which relies on
considerable virtual memory overcommit" should not rely on the kernel to
overcommit memory when OVERCOMMIT_NEVER is explicitly set.

>> When running in a memory cgroup - for example via systemd or on k8s -
>> the kernel will not return ENOMEM even if the cgroup's memory limit is
>> exceeded.
> 
> Yes, memcg doesn't change the overal approach. It just restricts the
> existing semantic with a smaller memory limit. Also overcommit heuristic
> has never been implemented for memory controllers.
> 
>> Instead the OOM killer is awakened and kills processes in the
>> violating cgroup.  If any backend is killed with SIGKILL the shared
>> memory of the whole cluster is deemed potentially corrupted and
>> PostgreSQL needs to do an emergency restart.  This cancels all operation
>> on all backends and it entails a potentially lengthy recovery process.
>> Therefore the behavior is quite "costly".
> 
> One way around that would be to use high limit rather than hard limit
> and pro-actively watch for memory utilization and communicate that back
> to the application to throttle its workers. I can see how that
> 
>> I totally understand that vm.overcommit_memory 2 does not mean "no OOM
>> killer". IMHO it should mean "no OOM killer if we can avoid it" and I
> 
> I do not see how it can ever promise anything like that. Memory
> consumption by kernel subsystems cannot be predicted at the time virtual
> memory allocated from the userspace. Not only it cannot be predicted but
> it is also highly impractical to force kernel allocations - necessary
> for the OS operation - to fail just because userspace has reserved
> virtual memory. So this all is just a heuristic to help in some
> extreme cases but overall I consider OVERCOMMIT_NEVER as impractical to
> say the least.

I'm not fully able to follow you why we need to let kernel allocations
fail here.  Yes, if you run a system to a point where the kernel can't
free enough memory, invasive decisions have to be made.  Think of an
application server running multiple applications in memcgs each with its
limits way below the available resources.  Why is it preferable to
SIGKILL a process rather than just deny the limit exceeding malloc, when
OVERCOMMIT_NEVER is set of cause?

>> would highly appreciate if the kernel would use a less invasive means
>> whenever possible.  I guess this might also be the expectation by many
>> other users.  In my described case - which is a real pain for me - it is
>> quite easy to tweak the kernel behavior in order to handle this and
>> other similar situations with less casualties.  This is why I send a
>> patch instead of starting a theoretical discussion.
> 
> I am pretty sure that many users would agree with you on that but the
> matter of fact is that a different approach has been chosen
> historically. We can argue whether this has been a good or bad design
> decision but I do not see that to change without a lot of fallouts. Btw.
> a strong memory reservation approach can be found with hugetlb pages and
> this one has turned out to be very tricky both from implementation and
> userspace usage POV. Needless to say that it operates on a single
> purpose preallocated memory pool and it would be quite reasonable to
> expect the complexity would grow with more users of the pool which is
> the general case for general purpose memory allocator.

The history is very interesting and needs to be taken into
consideration.  What drives me is to help myself and all other Linux
user to run workloads like RDBMS reliable, even in modern environments
like k8s which make use of memory cgroups.  I see a gain for the
community to develop a reliable and easy available solution, even if my
current approach might be amateurish and is not the right answer.  Could
you elaborate on where you see "a lot of fallouts"?  overcommit_memory 2
is only set when needed for the desired workload.

If the gain is worth it one could implement an overcommit_memory 3 in
order to set this behavior, overcommit_memory needs to be explicitly set
by the sysadmin anyways.

>> What do you think is necessary to get this to an approvable quality?
> 
> See my other reply.
