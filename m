Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD739E75A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFGTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhFGTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623093522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jHAMDLlGs26bSzH0EU/HKABFBJg5gt0hKx9CLuP/cc=;
        b=NWZAH/YNr3fTT/YeKV+sqW6hvNlbN0awAzNIZT2Zb9gsvIuOs6J6XetdM7m3rEQ1kjiRR6
        9RaG1udPZuDFlitMxuIx2ibqv/q0oR3dSPIM0G3sYcJWriqQO3SEGfnB/Llq0N/1Nwp+cE
        8xx1WD1TuBm5H4GyQlEzMd+2K7lbArY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-DZk-Jz0xOwS3B3Q-2j6Yzw-1; Mon, 07 Jun 2021 15:18:41 -0400
X-MC-Unique: DZk-Jz0xOwS3B3Q-2j6Yzw-1
Received: by mail-qk1-f199.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so13504647qkd.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4jHAMDLlGs26bSzH0EU/HKABFBJg5gt0hKx9CLuP/cc=;
        b=KxSwy2Ojx++A3/NyHUrGmtnxA3qy+7b0tATqVl9uUAQoRIcszgDSSdkCnbEhrLz8Na
         Bzv1zEoFHS3MF4kwM1xqkoBmXBH9e18T8VAn2uitAgLUnMcDXClMfX0I2jJIV9BpghsJ
         0Eu2QUW9+6msZKbcnF1n+/JGOVsOJ5LZfi3gsq/8G9j4XWM3SVZd5jUrXyxkRBRoWe3B
         4SYoYJ8zH67Nes3GCmaAbvUN7lFRqk1FWFYl9iS2UeUsIGl3O9AahOao8fEESBWiudP+
         /cEfS1S124QeRbPZYYBFX07Wjk0R5fYk2AUI8HvOH+J1lW48VkCBNPErqBUqxX/aD8WS
         Bieg==
X-Gm-Message-State: AOAM531to1WokFf5DJmDWta4P0y3ESg1CkVy0pedFS7rOVJuxaDE6ZO2
        2zkQgrql7WTDyrLp+oIW4mdH9+DBKhYlqlQQIhhg9D3cIvgKip0oGCDJH3FWJyp8eTNHlJQepCe
        zuNUO89B4lOtOjfYFZvcLeAnqr37JAH+J/+AUAiWTeq/6ADPBs14UZNIvSTizQE+7iNE8xVrq
X-Received: by 2002:a05:622a:1751:: with SMTP id l17mr3658221qtk.35.1623093520590;
        Mon, 07 Jun 2021 12:18:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFsfKEokNa3CNprmhCHqjeCDn2h/x/3OTEZAnrZ9lOae/RDFBNo5Tmaul5x2KfbnUkQJlhhg==
X-Received: by 2002:a05:622a:1751:: with SMTP id l17mr3658191qtk.35.1623093520279;
        Mon, 07 Jun 2021 12:18:40 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id z12sm2571178qtq.25.2021.06.07.12.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 12:18:39 -0700 (PDT)
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
Message-ID: <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
Date:   Mon, 7 Jun 2021 15:18:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 3:04 PM, Michal Hocko wrote:
> On Mon 07-06-21 14:51:05, Waiman Long wrote:
>> On 6/7/21 2:43 PM, Shakeel Butt wrote:
>>> On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
>>>> On 6/7/21 12:31 PM, Aaron Tomlin wrote:
>>>>> At the present time, in the context of memcg OOM, even when
>>>>> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
>>>>> task cannot be selected, as a target for the OOM killer.
>>>>>
>>>>> This patch removes the restriction entirely.
>>>>>
>>>>> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
>>>>> ---
>>>>>     mm/oom_kill.c | 6 +++---
>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>>>> index eefd3f5fde46..3bae33e2d9c2 100644
>>>>> --- a/mm/oom_kill.c
>>>>> +++ b/mm/oom_kill.c
>>>>> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
>>>>>                 oc->nodemask = NULL;
>>>>>         check_panic_on_oom(oc);
>>>>>
>>>>> -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
>>>>> -         current->mm && !oom_unkillable_task(current) &&
>>>>> -         oom_cpuset_eligible(current, oc) &&
>>>>> +     if (sysctl_oom_kill_allocating_task && current->mm &&
>>>>> +            !oom_unkillable_task(current) &&
>>>>> +            oom_cpuset_eligible(current, oc) &&
>>>>>             current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>>>>>                 get_task_struct(current);
>>>>>                 oc->chosen = current;
>>>> To provide more context for this patch, we are actually seeing that in a
>>>> customer report about OOM happened in a container where the dominating
>>>> task used up most of the memory and it happened to be the task that
>>>> triggered the OOM with the result that no killable process could be
>>>> found.
>>> Why was there no killable process? What about the process allocating
>>> the memory or is this remote memcg charging?
>> It is because the other processes have a oom_adjust_score of -1000. So they
>> are non-killable. Anyway, they don't consume that much memory and killing
>> them won't free up that much.
>>
>> The other process that uses most of the memory is the one that trigger the
>> OOM kill in the first place because the memory limit has been reached in new
>> memory allocation. Based on the current logic, this process cannot be killed
>> at all even if we set the oom_kill_allocating_task to 1 if the OOM happens
>> only within the memcg context, not in a global OOM situation. This patch is
>> to allow this process to be killed under this circumstance.
> Do you have the oom report? I do not see why the allocating task hasn't
> been chosen.

A partial OOM report below:

[ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
   :
[ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes 
swapents oom_score_adj name
[ 8227.242495] [1611298]     0 1611298    35869      635 167936        
0         -1000 conmon
[ 8227.242518] [1702509]     0 1702509    35869      701 176128        
0         -1000 conmon
[ 8227.242522] [1703345] 1001050000 1703294   183440        0 
2125824        0           999 node
[ 8227.242706] Out of memory and no killable processes...
[ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), 
nodemask=(null), order=0, oom_score_adj=999
[ 8227.242732] node 
cpuset=crio-b8ac7e23f7b520c0365461defb66738231918243586e287bfb9e206bb3a0227a.scope 
mems_allowed=0-1

So in this case, node cannot kill itself and no other processes are 
available to be killed.

Cheers,
Longman


