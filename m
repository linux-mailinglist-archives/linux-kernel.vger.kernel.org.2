Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEE39E6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFGSxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhFGSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623091873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH3QD293Oo2Gx0DQLiXZTLoiWa9ki35zP3VJcWDnpJc=;
        b=LfBvC2Mv8qcBDibYBlXUMsc8hyIITPdND6bcSs5T2bHx3PXZWlyHLDagYThnF6Un/y1qTP
        x/1fTVNzG3wZTCIkOJBcH3LIFb+nruwHQi4HZklBK9PuINi/KMZYHUl28ucdH35v9MW7/n
        GxJd9nbrybbrbaIMdzWwMXO0jZlDbhc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Ig9uDa7-NzuHy6uXgTB-zg-1; Mon, 07 Jun 2021 14:51:08 -0400
X-MC-Unique: Ig9uDa7-NzuHy6uXgTB-zg-1
Received: by mail-qk1-f198.google.com with SMTP id s68-20020a372c470000b0290305f75a7cecso13488675qkh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aH3QD293Oo2Gx0DQLiXZTLoiWa9ki35zP3VJcWDnpJc=;
        b=bnjDPTgLMATkhEXj1lZOht8e5W+Yrx2X3KRksDlWpLmRW7X2X2HcCK9Sk18kYE7mXr
         /sjMc5KUQ7pJmEb5LWqGRitDjaAUfYpXex73flmADZajgJx6plPICEVA9w8W8E09COOd
         SFGwRYL4dFbjCBxtEe0YCnvK/J2cFKJ1+ZTv0jyoWXYrkiD/C+0WCp5uZ2t43Llkmp/j
         0wlAsB8I/jriYZEht7eLZdvJRHKQENsUDs3xPeWXHjBQYpvE64OTxZ0QyQ+sT6StcKO2
         Wa5tGHHx445u4zwT3JDMh2rwAMIHQ629L4OoXanET+y6kTsryHRHSTqBGZioql3/F77P
         yw3A==
X-Gm-Message-State: AOAM5306zBqhxIPDkhSHj0u1/NsvPrszpUq/ss+8vUpAnydnW8RHkql0
        Q1+xkSTNdywS9vmkULjSOmg4DJtD5dqXxBPPF6AnH8wpQtjpwO/T8rcxOdIOqovUPw6MSOZJ8Gn
        BDbnW0CjE9c/8wFjWOCSwZOLtqKCI6unjoY3YQ9eLimhRAeEXW3Lm1EXHmvcW/ZWMjAQPa+oY
X-Received: by 2002:a05:620a:5b5:: with SMTP id q21mr12974275qkq.58.1623091867646;
        Mon, 07 Jun 2021 11:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAyUl3jh5QUrk9UgJcf2xIvEAWP+/yVr6OZomzEWmLoMcbAnfFWMgB/NQggg1aLvOtjaD19A==
X-Received: by 2002:a05:620a:5b5:: with SMTP id q21mr12974248qkq.58.1623091867372;
        Mon, 07 Jun 2021 11:51:07 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 16sm4559409qtt.19.2021.06.07.11.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 11:51:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Shakeel Butt <shakeelb@google.com>, Waiman Long <llong@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
Message-ID: <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
Date:   Mon, 7 Jun 2021 14:51:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 2:43 PM, Shakeel Butt wrote:
> On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
>> On 6/7/21 12:31 PM, Aaron Tomlin wrote:
>>> At the present time, in the context of memcg OOM, even when
>>> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
>>> task cannot be selected, as a target for the OOM killer.
>>>
>>> This patch removes the restriction entirely.
>>>
>>> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
>>> ---
>>>    mm/oom_kill.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>> index eefd3f5fde46..3bae33e2d9c2 100644
>>> --- a/mm/oom_kill.c
>>> +++ b/mm/oom_kill.c
>>> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
>>>                oc->nodemask = NULL;
>>>        check_panic_on_oom(oc);
>>>
>>> -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
>>> -         current->mm && !oom_unkillable_task(current) &&
>>> -         oom_cpuset_eligible(current, oc) &&
>>> +     if (sysctl_oom_kill_allocating_task && current->mm &&
>>> +            !oom_unkillable_task(current) &&
>>> +            oom_cpuset_eligible(current, oc) &&
>>>            current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>>>                get_task_struct(current);
>>>                oc->chosen = current;
>> To provide more context for this patch, we are actually seeing that in a
>> customer report about OOM happened in a container where the dominating
>> task used up most of the memory and it happened to be the task that
>> triggered the OOM with the result that no killable process could be
>> found.
> Why was there no killable process? What about the process allocating
> the memory or is this remote memcg charging?

It is because the other processes have a oom_adjust_score of -1000. So 
they are non-killable. Anyway, they don't consume that much memory and 
killing them won't free up that much.

The other process that uses most of the memory is the one that trigger 
the OOM kill in the first place because the memory limit has been 
reached in new memory allocation. Based on the current logic, this 
process cannot be killed at all even if we set the 
oom_kill_allocating_task to 1 if the OOM happens only within the memcg 
context, not in a global OOM situation. This patch is to allow this 
process to be killed under this circumstance.

Cheers,
Longman

