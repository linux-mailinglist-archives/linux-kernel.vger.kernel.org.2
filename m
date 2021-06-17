Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422FA3ABDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFQUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhFQUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623962738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpTnIUemqOshEpd//f5xMntFtlQkGOaInP6j17WpXWI=;
        b=iTflhj/coDAw8So9pBsifMvIWEP4HGtkRlNesWPk36aeADUcubbNOKRbiv6yjd2rpDgf8j
        Scf7FcxGWql1ds1GoqgKR4LsU8OFoCW0GTJ5DhHJ1nAMFqN2q5V5S4l4zFC9FV2zNov9F2
        bZJ97k2LjCfyv8vpJFXjsa/gEsLQ75o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-NMUWDyRqPGu9gtOtyxLXXg-1; Thu, 17 Jun 2021 16:45:37 -0400
X-MC-Unique: NMUWDyRqPGu9gtOtyxLXXg-1
Received: by mail-qk1-f200.google.com with SMTP id t131-20020a37aa890000b02903a9f6c1e8bfso3175604qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 13:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vpTnIUemqOshEpd//f5xMntFtlQkGOaInP6j17WpXWI=;
        b=mXta17AfSer5al08xWsMAjTkRUHNFv/Du5zHk86nWsnqss/6W9uiwPY/so9h8Ycrbr
         PtAJs5nqv55eIlpNVaBqge5rTD39T2I6K89M/YU1E+aWzZsk3YeWDDlnRgyDqqfYXR59
         ODP0IH2RT9373vK3hcXScMW6e+fuO7LNUXf2c/99iLiWQuSvoMPAgAC3GUSCP3Q51NXF
         PeJl7tAmMVe+qUcajTeIOaa4JH89YlMqVNYcfae1HFb+74GbTbrNzE+h9AelpYDXP+Yh
         UCKgSqyMIyFNyqiPbs5+577FeAp73BfZFcamHEevAc/mjT9pZiOkdRxhaWfe3/+6udyz
         sIUw==
X-Gm-Message-State: AOAM531YwHlC5BN7gz5nDgKsXhBZEVLtlpKs3GAKZDehMzEfWovYKOiy
        pRpD1ww6HiJW6NAXbeJLV3zcn+VD4b8tJMaGoAeY6YA0NDPIn+6ewyWiXzg1MIgXpbro1nv7B93
        KtOid7y7UBjJl72SajN1rJNLQ
X-Received: by 2002:ac8:5e87:: with SMTP id r7mr1753321qtx.325.1623962737278;
        Thu, 17 Jun 2021 13:45:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+oHpsqIx+NBzTLes07czJPTW873K6oP8vENp+xLmoU04jdAkKJ4RFfNYLnjvR6dWKWFFv/g==
X-Received: by 2002:ac8:5e87:: with SMTP id r7mr1753310qtx.325.1623962737068;
        Thu, 17 Jun 2021 13:45:37 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t196sm2477328qke.50.2021.06.17.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 13:45:36 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/5] cgroup/cpuset: Allow non-top parent partition root to
 distribute out all CPUs
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-4-longman@redhat.com>
 <YMplzNzg7mMCU4JJ@slm.duckdns.org>
Message-ID: <7f0a0f23-3fcd-a1a3-341a-2dbbde1f25ec@redhat.com>
Date:   Thu, 17 Jun 2021 16:45:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMplzNzg7mMCU4JJ@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 4:57 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 03, 2021 at 05:24:14PM -0400, Waiman Long wrote:
>> @@ -2181,6 +2192,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>   	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
>>   		goto out_unlock;
>>   
>> +	/*
>> +	 * On default hierarchy, task cannot be moved to a cpuset with empty
>> +	 * effective cpus.
>> +	 */
>> +	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
>> +		goto out_unlock;
>> +
> This is inconsistent with how other events which leave a root partition
> empty is handled. Woudln't it be more consistent to switch the parent to
> PRS_ERROR and behave accordingly but allow it to have valid child roots?

 From my point of view, PRS_ERROR is used when cpus are gone because of 
cpu hotplug (offline). It can be a temporary condition that will be 
corrected later on. I don't want to use PRS_ERROR for the particular 
case that the users have explicitly distributed out all the cpus to 
child partitions. I will clarify it in the next version and double check 
to make sure that this rule is consistently apply.

Thanks,
Longman

