Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499636C72A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhD0NoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:44:12 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:42608 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhD0NoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:44:10 -0400
Received: from [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be] (p200300f7f70f8e007457087a58db74be.dip0.t-ipconnect.de [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: alexander@sosna.de)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 29DC5D400DE;
        Tue, 27 Apr 2021 15:43:26 +0200 (CEST)
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
To:     Michal Hocko <mhocko@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
 <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
 <c7e0a2f9-0b83-2d9b-8ec1-8141d5dca554@sosna.de>
 <YIf/bOhWIKPuwIzg@dhcp22.suse.cz>
From:   Alexander Sosna <alexander@sosna.de>
Message-ID: <93fcbc37-8c8c-a752-a191-ff8e3dc02eb1@sosna.de>
Date:   Tue, 27 Apr 2021 15:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIf/bOhWIKPuwIzg@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.04.21 14:11, Michal Hocko wrote:
> On Tue 27-04-21 13:01:33, Alexander Sosna wrote:
> [...]
>> Please correct me if I am wrong, but "modern userspace which relies on
>> considerable virtual memory overcommit" should not rely on the kernel to
>> overcommit memory when OVERCOMMIT_NEVER is explicitly set.
> 
> Correct. Which makes it application very limited from my experience.

Yes.  It is a special tool for a special use case, I use it exclusively
for database servers and hosting DBaaS.  Therefore my point is that a
change in it's behavior only effects special use cases and should take
their requirements into consideration.

>>>> When running in a memory cgroup - for example via systemd or on k8s -
>>>> the kernel will not return ENOMEM even if the cgroup's memory limit is
>>>> exceeded.
>>>
>>> Yes, memcg doesn't change the overal approach. It just restricts the
>>> existing semantic with a smaller memory limit. Also overcommit heuristic
>>> has never been implemented for memory controllers.
>>>
>>>> Instead the OOM killer is awakened and kills processes in the
>>>> violating cgroup.  If any backend is killed with SIGKILL the shared
>>>> memory of the whole cluster is deemed potentially corrupted and
>>>> PostgreSQL needs to do an emergency restart.  This cancels all operation
>>>> on all backends and it entails a potentially lengthy recovery process.
>>>> Therefore the behavior is quite "costly".
>>>
>>> One way around that would be to use high limit rather than hard limit
>>> and pro-actively watch for memory utilization and communicate that back
>>> to the application to throttle its workers. I can see how that
>>>
>>>> I totally understand that vm.overcommit_memory 2 does not mean "no OOM
>>>> killer". IMHO it should mean "no OOM killer if we can avoid it" and I
>>>
>>> I do not see how it can ever promise anything like that. Memory
>>> consumption by kernel subsystems cannot be predicted at the time virtual
>>> memory allocated from the userspace. Not only it cannot be predicted but
>>> it is also highly impractical to force kernel allocations - necessary
>>> for the OS operation - to fail just because userspace has reserved
>>> virtual memory. So this all is just a heuristic to help in some
>>> extreme cases but overall I consider OVERCOMMIT_NEVER as impractical to
>>> say the least.
>>
>> I'm not fully able to follow you why we need to let kernel allocations
>> fail here.  Yes, if you run a system to a point where the kernel can't
>> free enough memory, invasive decisions have to be made.
> 
> OK. But then I do not see what "no OOM killer if we can avoid it" is
> suppose to mean. There are only 2 ways around that. Either start
> failing allocations or reclaim by tearing down processes as all other
> means of memory reclaim have been already exercised.

Yes of cause if all means of memory reclaim have been already exercised,
there is not much todo.  But I want to prevent the OOM killer from
reaping processes especially if more than enough memory is available.
There are many reasons to enforce limits even if enough resources are
available.  For example to prevent bad neighbor behavior, leave plenty
of free memory for the file system cache or because someone pays only
for a given amount of resources in a SaaS offering and the SREs would
like to enforce the limit without shutting down their clients database
service.  :)
With KVM this is quite easy, just use one VM per RDBMS instance and set
overcommit_memory=2, but this would waste a lot of resources.

>> Think of an
>> application server running multiple applications in memcgs each with its
>> limits way below the available resources.  Why is it preferable to
>> SIGKILL a process rather than just deny the limit exceeding malloc, when
>> OVERCOMMIT_NEVER is set of cause?
> 
> Because the actual physical memory allocation for malloc might (and
> usually does) happen much later than the virtual memory allocated for it
> (brk or mmap). Memory requirements could have changed considerably
> between the two events. An allocation struggling to make a forward
> progress might be for a completely different purpose than the overcommit
> accounted one. Does this make more sense now?

Yes.  Thank you for the explanation.  What you describe is the
observable behavior in many pieces of software.  We have to keep in mind
that we are talking about the special case of OVERCOMMIT_NEVER here.
Software that want's / expects to run on such a system normally has a
much tighter allocation behavior.  PostgreSQL for example allocates
memory when it is needed and in the needed quantity and will swiftly
write on all of it.  Further, it deals very gracefully with an
out-of-memory situation (malloc returns NULL) by simply reporting back
to the client that a query was aborted due to out of memory.
Overcommiting doesn't make any sense with such a disciplined application
and sysadmins configure their kernel accordingly.  Implying overcommit
and OOM-killer-activity currently rules out using cgroup-limits with
such an application, there is no way to handle a SIGKILL gracefully.
Therefore I was quite happy with the results when testing my patch with
a DBaaS workload.

>>>> would highly appreciate if the kernel would use a less invasive means
>>>> whenever possible.  I guess this might also be the expectation by many
>>>> other users.  In my described case - which is a real pain for me - it is
>>>> quite easy to tweak the kernel behavior in order to handle this and
>>>> other similar situations with less casualties.  This is why I send a
>>>> patch instead of starting a theoretical discussion.
>>>
>>> I am pretty sure that many users would agree with you on that but the
>>> matter of fact is that a different approach has been chosen
>>> historically. We can argue whether this has been a good or bad design
>>> decision but I do not see that to change without a lot of fallouts. Btw.
>>> a strong memory reservation approach can be found with hugetlb pages and
>>> this one has turned out to be very tricky both from implementation and
>>> userspace usage POV. Needless to say that it operates on a single
>>> purpose preallocated memory pool and it would be quite reasonable to
>>> expect the complexity would grow with more users of the pool which is
>>> the general case for general purpose memory allocator.
>>
>> The history is very interesting and needs to be taken into
>> consideration.  What drives me is to help myself and all other Linux
>> user to run workloads like RDBMS reliable, even in modern environments
>> like k8s which make use of memory cgroups.  I see a gain for the
>> community to develop a reliable and easy available solution, even if my
>> current approach might be amateurish and is not the right answer.
> 
> Well, I am afraid that a reliable and easy solutions would be extremely
> hard to find. A memcg aware overcommit policy is certainly possible but
> as I've said it would require an additional accounting, it would be
> quite unreliable - especially with small limits where the mapped (and
> accounted) address space is not predominant. A lack of background
> reclaim (kswapd in the global case) would result in ENOMEM reported even
> though there is reclaimable memory to satisfy the reserved address space
> etc.

Thank you very much for this information.  Would you share the opinion
that it would be too hacky to define an arbitrary memory threshold here?
 One could say that below a used memory of X the memory cgroup limit is
not enforced by denying a malloc().  So that the status quo behavior is
only altered when the memory usage is above X.  This would mitigate the
problem with small limits and does not introduce new risks or surprises,
because in this edge case it will behaves identical to the current kernel.
>> Could
>> you elaborate on where you see "a lot of fallouts"?  overcommit_memory 2
>> is only set when needed for the desired workload.
> 
> My above comment was more general to the approach Linux is embracing
> overcommit and relies on oom killer to handle fallouts. This to change
> would lead to lot of fallouts. E.g. many syscalls returning unexpected
> and unhandled ENOMEM etc.

We are talking about a special use case here.  Do you see a problem in
the domain where and how overcommit_memory=2 is used today?
