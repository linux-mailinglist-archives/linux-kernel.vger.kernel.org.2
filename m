Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF21C3E984C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhHKTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhHKTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628708821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QE/fAtzET4+bnEA1B+px7kFDrqIsaQmncafMGX56pg=;
        b=acGaNmFyQOUPi9V004SBa6Y7J0E2zAMjHPX2EUY3ISuppRIeUnNBPNbqi90J8qiXCY1zk+
        pVJmCyCefZR6P8GddJoEMfXWNbKMoDs+S+DJl2w7bQCfrJKUlXggzSAUb830md29DbRJmt
        1eaBs1vmHeJvRIwB9hoEON6JUg81pW4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-nvjtjfukOpSPxe3jmXIT9g-1; Wed, 11 Aug 2021 15:07:00 -0400
X-MC-Unique: nvjtjfukOpSPxe3jmXIT9g-1
Received: by mail-qk1-f197.google.com with SMTP id p123-20020a378d810000b02903ad5730c883so1915411qkd.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5QE/fAtzET4+bnEA1B+px7kFDrqIsaQmncafMGX56pg=;
        b=luPAEst+hBlbVN8ilNIPnuNQ1ZgDuXdW5f4tPMkaWWMH54mCin53boLDd2bNGiM203
         nAtSA2ItbzcodIia05APzpXJIJhn4TLVm1LvJWoxLBUpXkwz47EXjOUdwX+RHfhhZ5Ne
         xyenCpA0RdIzv5UlHlchNZeopDvCk1IrptMcRT8e7DpUbcx77tyqrLkqy2ROde30Ckl4
         Idm7Fh4gQK91xkCu+Nu0RMucMcO5xI5SBXn+RVj0Jnrc9tK2ynqpUnuibiGkJkQ3VdEi
         7w2ERWVXMMFVUME2ZQubRvK1qVokk66vvcDXZBEspf1ZbbhUmNY0LSU1/EldBWmlezuO
         LT2g==
X-Gm-Message-State: AOAM532/NnQ+apb6QuSV1+8V58KFxyCGwwemQ02uM01IAKvpVFJxKxls
        Q5Adl5MJevUX88ounE0qIQc54L8VsyzHTeNaoOoYhmVJMNmAhShdTYNFxLchtj36is2+WItt6Ia
        dBDo8bW3IBw9+ktTnIrKq+SuA
X-Received: by 2002:a05:620a:d54:: with SMTP id o20mr546817qkl.326.1628708819956;
        Wed, 11 Aug 2021 12:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKHjAyXPoQ+oPzvXay29LjdH91msFnZE5INVFTZ7WTWz4fV05+iXY5Xx2XjtEEZI8g965sFQ==
X-Received: by 2002:a05:620a:d54:: with SMTP id o20mr546794qkl.326.1628708819787;
        Wed, 11 Aug 2021 12:06:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b7sm57742qtj.72.2021.08.11.12.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:06:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Enable memory migration for cpuset v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210811163035.1977-1-longman@redhat.com>
 <YRQbdTgprUJyuis7@cmpxchg.org>
Message-ID: <b85cfcb5-9037-b92e-6513-871944995090@redhat.com>
Date:   Wed, 11 Aug 2021 15:06:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQbdTgprUJyuis7@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 2:48 PM, Johannes Weiner wrote:
> On Wed, Aug 11, 2021 at 12:30:35PM -0400, Waiman Long wrote:
>> When a user changes cpuset.cpus, each task in a v2 cpuset will be moved
>> to one of the new cpus if it is not there already. For memory, however,
>> they won't be migrated to the new nodes when cpuset.mems changes. This is
>> an inconsistency in behavior.
>>
>> In cpuset v1, there is a memory_migrate control file to enable such
>> behavior by setting the CS_MEMORY_MIGRATE flag. Make it the default
>> for cpuset v2 so that we have a consistent set of behavior for both
>> cpus and memory.
>>
>> There is certainly a cost to make memory migration the default, but it
>> is a one time cost that shouldn't really matter as long as cpuset.mems
>> isn't changed frequenty.  Update the cgroup-v2.rst file to document the
>> new behavior and recommend against changing cpuset.mems frequently.
>>
>> Since there won't be any concurrent access to the newly allocated cpuset
>> structure in cpuset_css_alloc(), we can use the cheaper non-atomic
>> __set_bit() instead of the more expensive atomic set_bit().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>>   kernel/cgroup/cpuset.c                  | 6 +++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 5c7377b5bd3e..47c832ad1322 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2056,6 +2056,12 @@ Cpuset Interface Files
>>   	The value of "cpuset.mems" stays constant until the next update
>>   	and won't be affected by any memory nodes hotplug events.
>>   
>> +	Setting a non-empty value to "cpuset.mems" causes memory of
>> +	tasks within the cgroup to be migrated to the designated nodes if
>> +	they are currently using memory outside of the designated nodes.
>> +	There is a cost for this migration.  So "cpuset.mems" shouldn't
>> +	be changed frequently.
> The migration skips over pages that are (temporarily) off the LRU for
> reclaim, compaction etc. so it can leave random pages behind.
>
> In practice it's probably fine, but it probably makes sense to say
> it's advisable to set this config once before the workload launches
> for best results, and not rely too much on changing things around
> post-hoc, due to cost you pointed out but also due to reliability.
>
> Otherwise no objection from me.
>
Thanks for the suggestion. Will update the patch to include additional 
wording about that.

Cheers,
Longman

