Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30B39E89A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFGUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhFGUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623098564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVFE7839wJQhjfwahJMzdYuo8c3wA2maMZqOHJgIOFI=;
        b=T/SKummPZyP0twCTMSao7em9DVI5QkoYY39LCOB63laVLAeNIg1JXj77ijdZ5bajuECGbI
        lwGqxO51l2L5Ulv2EoF79Gd1JMgUZ92Cs5u4UdU2KDnnSopL1NAl2zWxrzX/wt/n9ZYYZS
        MC9kYB3ZqQncB44ZqgFjLuMRmbDV4tI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-ZqZzfa99N3iDM11Vo0570w-1; Mon, 07 Jun 2021 16:42:43 -0400
X-MC-Unique: ZqZzfa99N3iDM11Vo0570w-1
Received: by mail-qv1-f69.google.com with SMTP id g17-20020a0caad10000b029021886e075f0so13980506qvb.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NVFE7839wJQhjfwahJMzdYuo8c3wA2maMZqOHJgIOFI=;
        b=FY0jZAY1f8uH7v0bPrv+Zpe8+inhZ0EAzEobElpvgsvOffI1La/XHHwcl/nUJfPPWp
         QCZIwFy5ib83Jlyaxbovgvv7PTJr97UjvlRyvtlGhCpogvFsrXwZlyYJPKvlKBLDkyLe
         jjoan1RjownN8AlnM60AqfI66HtrOhJ7v1Ym7HiC7qZVhXOP98xyzhqOOjUPjne+gF7i
         IXj5kt+M+OEEon2AZlauWkq2J0T91dJKpH2/Jg6dzRwwT0tgHwuouZYasU2j/sL6nc1E
         gMD/5+brv9PQIp+Ln9f46mqIP1MLQc5PpDjR3rPw5vBYnuj5e0q9qfPlAuz9NrYhTjjF
         ZSww==
X-Gm-Message-State: AOAM531irt/lWbQ1Q8R5MRKgZwgykYudGmK7PD8n0JmYtqs7AHce5G2s
        6rL63B4MYb8vmz/Ekl4tMTP2wsAXSYkTn+mD7BAp66qDubnlUFYtDp+J7X+4hyLunbIj0rV9NQj
        wKSBrqjIE6PWrAkKrw4t3/JcHj367NrKkRZJNvGzPrTRrSmGtZLElJghn6sXLtr7jFi5sLc5Q
X-Received: by 2002:a0c:fe62:: with SMTP id b2mr10248178qvv.30.1623098562284;
        Mon, 07 Jun 2021 13:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPGiyG0OmvYR1j1nFCrdaT6qA4VcsQUJmpVnS8bNZMG/6o6Hu9CB31bkiDtvlU9zNTuK+yaw==
X-Received: by 2002:a0c:fe62:: with SMTP id b2mr10248151qvv.30.1623098562066;
        Mon, 07 Jun 2021 13:42:42 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id u123sm7330177qkh.83.2021.06.07.13.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 13:42:41 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Michal Hocko <mhocko@suse.com>, Waiman Long <llong@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
Message-ID: <a25c980a-2c26-2df4-9375-3ca91d677099@redhat.com>
Date:   Mon, 7 Jun 2021 16:42:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 3:36 PM, Michal Hocko wrote:
> On Mon 07-06-21 15:18:38, Waiman Long wrote:
>> On 6/7/21 3:04 PM, Michal Hocko wrote:
>>> On Mon 07-06-21 14:51:05, Waiman Long wrote:
>>>> On 6/7/21 2:43 PM, Shakeel Butt wrote:
>>>>> On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
>>>>>> On 6/7/21 12:31 PM, Aaron Tomlin wrote:
>>>>>>> At the present time, in the context of memcg OOM, even when
>>>>>>> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
>>>>>>> task cannot be selected, as a target for the OOM killer.
>>>>>>>
>>>>>>> This patch removes the restriction entirely.
>>>>>>>
>>>>>>> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
>>>>>>> ---
>>>>>>>      mm/oom_kill.c | 6 +++---
>>>>>>>      1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>>>>>> index eefd3f5fde46..3bae33e2d9c2 100644
>>>>>>> --- a/mm/oom_kill.c
>>>>>>> +++ b/mm/oom_kill.c
>>>>>>> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
>>>>>>>                  oc->nodemask = NULL;
>>>>>>>          check_panic_on_oom(oc);
>>>>>>>
>>>>>>> -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
>>>>>>> -         current->mm && !oom_unkillable_task(current) &&
>>>>>>> -         oom_cpuset_eligible(current, oc) &&
>>>>>>> +     if (sysctl_oom_kill_allocating_task && current->mm &&
>>>>>>> +            !oom_unkillable_task(current) &&
>>>>>>> +            oom_cpuset_eligible(current, oc) &&
>>>>>>>              current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>>>>>>>                  get_task_struct(current);
>>>>>>>                  oc->chosen = current;
>>>>>> To provide more context for this patch, we are actually seeing that in a
>>>>>> customer report about OOM happened in a container where the dominating
>>>>>> task used up most of the memory and it happened to be the task that
>>>>>> triggered the OOM with the result that no killable process could be
>>>>>> found.
>>>>> Why was there no killable process? What about the process allocating
>>>>> the memory or is this remote memcg charging?
>>>> It is because the other processes have a oom_adjust_score of -1000. So they
>>>> are non-killable. Anyway, they don't consume that much memory and killing
>>>> them won't free up that much.
>>>>
>>>> The other process that uses most of the memory is the one that trigger the
>>>> OOM kill in the first place because the memory limit has been reached in new
>>>> memory allocation. Based on the current logic, this process cannot be killed
>>>> at all even if we set the oom_kill_allocating_task to 1 if the OOM happens
>>>> only within the memcg context, not in a global OOM situation. This patch is
>>>> to allow this process to be killed under this circumstance.
>>> Do you have the oom report? I do not see why the allocating task hasn't
>>> been chosen.
>> A partial OOM report below:
> Do you happen to have the full report?
I need to ask to see if I can release the full report.
>
>> [ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
>>    :
>> [ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents  oom_score_adj name
>> [ 8227.242495] [1611298]     0 1611298    35869      635 167936        0         -1000 conmon
>> [ 8227.242518] [1702509]     0 1702509    35869      701 176128        0         -1000 conmon
>> [ 8227.242522] [1703345] 1001050000 1703294   183440        0 2125824        0           999 node
>> [ 8227.242706] Out of memory and no killable processes...
>> [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999
>> [ 8227.242732] node cpuset=crio-b8ac7e23f7b520c0365461defb66738231918243586e287bfb9e206bb3a0227a.scope mems_allowed=0-1
>>
>> So in this case, node cannot kill itself and no other processes are
>> available to be killed.
> The process is clearly listed as eligible so the oom killer should find
> it and if it hasn't then this should be investigated. Which kernel is
> this?

Right. I don't know why the current cannot be selected. I think we may 
need to enhance the OOM but no killable process report to list the 
reason a task is skipped other than oom_score_adj. The kernel is a 
RHEL8.2 kernel which has OOM code pretty close to upstream.

Cheers,
Longman

