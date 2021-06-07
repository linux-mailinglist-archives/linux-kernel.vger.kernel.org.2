Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74239E809
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFGUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhFGUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623096437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PXCh7Dqi2kbwFooxxZfx2yNPC/v9Ua5jcVXvhDX1hE=;
        b=IbdyjFonV+D5pPJv+9J1ei9ndr8kq6AzAONUeunAz1qco6Y5uUhtI0y6TgaLS4qAL2HahE
        jyNLobJd+qc8csdZbr0e3IR6fMAxUU66t8GIzfm6v23AnOXd5BBJezKE4hfOez6RJqXtqB
        cx5nZxCh/IIy2EISqQmfsohp04XZM38=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-wmzm0mBTP4mak6VZlIw8uw-1; Mon, 07 Jun 2021 16:07:16 -0400
X-MC-Unique: wmzm0mBTP4mak6VZlIw8uw-1
Received: by mail-qt1-f199.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso8103473qta.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/PXCh7Dqi2kbwFooxxZfx2yNPC/v9Ua5jcVXvhDX1hE=;
        b=cyt3hfyh/YWeluwSkYMjgb20B5KroQEXcTLYmCyEEDSwupLfxmemqroIL1pnly8/Hz
         JLDfuvcqyJAZj2ITcoTQDzXC/XgzlZGxIogETSSECmnkItBdaUmEDs8R0WFJVylLjO5y
         zNz/q17/yLZjD5d4PIwuRY7kf4+xsy8pK+KFh3tBaPnJ7LJ1pNNuvuBF4MpQ+xZrTt2N
         ztSZaBxcFzzDFSPWPqx2VKnCMyfehqGhi+C1gB/aq9h1kp864+DnUiDuIrx6fuaoOFp7
         1Y/fb7Oe8YTDlGX9F+RDIBJGiWdebA3m4sdIhuItLeeBstfdtQozvy7t0Z9NGzkK0EBs
         KULw==
X-Gm-Message-State: AOAM532THx+ltWa2jylEAoJzVN2Ial7Bz8XylMQ2In6Wpm/47isTRkwO
        XdRxHlrK+15pHhumHY2pCjGULdCZGAAj36hrVMIGBMccoSvx68LB+64z1fHwsvDHyToi0NTeFWj
        l0SA+90lyaoJM2KWjUpEO5bK11FKI/2EKOH187DKZsq60oCR4APZKNao6y7GJQgEw6k58cuLQ
X-Received: by 2002:a05:6214:441:: with SMTP id cc1mr19968682qvb.29.1623096435917;
        Mon, 07 Jun 2021 13:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzokglHC+o/VEsHWKTh4yqYsXEvJOQTHSUT6IuD+k1yuBcWoGLdullIvHUfQhhlriOWmC8/ew==
X-Received: by 2002:a05:6214:441:: with SMTP id cc1mr19968661qvb.29.1623096435658;
        Mon, 07 Jun 2021 13:07:15 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b132sm7351906qkg.116.2021.06.07.13.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 13:07:15 -0700 (PDT)
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
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <CALvZod71SyjvC7sRtkD7dSEeAbYH_ynvO_hDS=tY6KCt-kRJkQ@mail.gmail.com>
Message-ID: <b5b03f9f-0481-e59f-b2f2-5968f668dbac@redhat.com>
Date:   Mon, 7 Jun 2021 16:07:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod71SyjvC7sRtkD7dSEeAbYH_ynvO_hDS=tY6KCt-kRJkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 3:04 PM, Shakeel Butt wrote:
> On Mon, Jun 7, 2021 at 11:51 AM Waiman Long <llong@redhat.com> wrote:
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
>> It is because the other processes have a oom_adjust_score of -1000. So
>> they are non-killable. Anyway, they don't consume that much memory and
>> killing them won't free up that much.
>>
>> The other process that uses most of the memory is the one that trigger
>> the OOM kill in the first place because the memory limit has been
>> reached in new memory allocation. Based on the current logic, this
>> process cannot be killed at all even if we set the
>> oom_kill_allocating_task to 1 if the OOM happens only within the memcg
>> context, not in a global OOM situation.
> I am not really against the patch but I am still not able to
> understand why select_bad_process() was not able to select the current
> process. mem_cgroup_scan_tasks() traverses all the processes in the
> target memcg hierarchy, so why the current was skipped.

Yes, you are right. Probably there is some problem with reaping so that 
the MMF_OOM_SKIP bit gets set. I don't have the answer yet.

Regards,
Longman

