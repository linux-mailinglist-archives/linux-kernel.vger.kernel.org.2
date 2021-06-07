Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B139E441
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFGQou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhFGQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623084177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXX4QBwgXhnHy1g2ghKync/xPThQvIt5AbfFrJ16lew=;
        b=YaNviOGP3Y6QO+JEJmIaFpyFHtOh2YGkDHWhtYupUMLoyUbghN35zPxai7fkn5gnMRpCGa
        ihVXUOynMjSSJBRhjs2gkNY0UejBZwTpMZN3N2B/9kqdcOpQLrRDM3dOqBEboqS9+0QyOL
        4zD3vKQGZc4d+MFUVPG0b1DDLzMCa+U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-7KXtqxVUOSWyhuQSLAKAag-1; Mon, 07 Jun 2021 12:42:56 -0400
X-MC-Unique: 7KXtqxVUOSWyhuQSLAKAag-1
Received: by mail-qt1-f200.google.com with SMTP id c29-20020ac86e9d0000b0290247b267c8e4so1190839qtv.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 09:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eXX4QBwgXhnHy1g2ghKync/xPThQvIt5AbfFrJ16lew=;
        b=Zm4JJQDuda/Ar5hU4BzLTbgjTXYaJ1cmZmXN9yuODWqJFzZH5X1U65Sccq0+cU6NlK
         lD018RP+JI8aEuAXFWVcWComgM170ppAss43rlCp7gwcvPpQWisppXh8ihA9dKO2O8Xc
         8gRAsAs/z3/8dkAKXe+GsMPzyhRaLQNTVr1KWGdsVc+lnsmTjQD/h5WRAGqFb0Hsf44p
         YuocoKUG7fLEuKPUgPz93uwnNKB3hlcuPDz0YmXoioIavhFP/umIF8Gt9KDtADDEGuu/
         gc2+DhumPgAb/CrjF/W0oPVv3PpO/qehainWFpNkNQXFM92NntXVm7eZMWAZyxUdG1R+
         gZuA==
X-Gm-Message-State: AOAM533NmsYaGmyW1SggF225rc1+T7e/doXZno5SCLbYNHmEvvrmftI6
        ehmIxISyNeIsn8mR0BvV8oAlUM1HtO2YqNbvJpXbF89iNJR2mq9j0hXSOM/8WMqUb7xbA5DKwY2
        OZOf8Fbpr0WJm8R8K35WihSwC5ck87+kiDLXK8IqDK4gB9q4jwvgL3nbEj9SQroDvqGCFC14T
X-Received: by 2002:ad4:458d:: with SMTP id x13mr11781810qvu.42.1623084176028;
        Mon, 07 Jun 2021 09:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwF9lNE9+upcMWy1zFhyI98fDYzgXAfplW+Th0aNYId2crCtqCvBdom2RV7sOqt0YeOHNGYw==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr11781772qvu.42.1623084175578;
        Mon, 07 Jun 2021 09:42:55 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c68sm10022865qkd.112.2021.06.07.09.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:42:55 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        llong@redhat.com, linux-kernel@vger.kernel.org
References: <20210607163103.632681-1-atomlin@redhat.com>
Message-ID: <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
Date:   Mon, 7 Jun 2021 12:42:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210607163103.632681-1-atomlin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 12:31 PM, Aaron Tomlin wrote:
> At the present time, in the context of memcg OOM, even when
> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> task cannot be selected, as a target for the OOM killer.
>
> This patch removes the restriction entirely.
>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>   mm/oom_kill.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5fde46..3bae33e2d9c2 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
>   		oc->nodemask = NULL;
>   	check_panic_on_oom(oc);
>   
> -	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> -	    current->mm && !oom_unkillable_task(current) &&
> -	    oom_cpuset_eligible(current, oc) &&
> +	if (sysctl_oom_kill_allocating_task && current->mm &&
> +            !oom_unkillable_task(current) &&
> +            oom_cpuset_eligible(current, oc) &&
>   	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>   		get_task_struct(current);
>   		oc->chosen = current;

To provide more context for this patch, we are actually seeing that in a 
customer report about OOM happened in a container where the dominating 
task used up most of the memory and it happened to be the task that 
triggered the OOM with the result that no killable process could be 
found. I don't see a reason why this should be limited to a global OOM only.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

