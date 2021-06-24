Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38C3B327A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFXP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhFXP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624548229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6782uv/lR78IFZdWPlWYnzNvjYHBRQ4Y4k+rewPDws=;
        b=cCJrE5diLfQTcZvUvuxVxrqaiOl4tKRDuZ7QNo3pMQzvXzERM3riKOa5h3B0Fhn0umEzmI
        1an5aPee9f+xm+C3k7DTEClH2veWkXtcyQIrL9zZdxp7zymd/gt8s8EXbTGnIX3zhFrRyP
        Ndnf0lQttVe4cck7T5M3MYbKwIGbFQg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-swQbUcOBMMyc3BXmEymThw-1; Thu, 24 Jun 2021 11:23:47 -0400
X-MC-Unique: swQbUcOBMMyc3BXmEymThw-1
Received: by mail-qv1-f70.google.com with SMTP id cu3-20020a05621417c3b0290272a51302bdso7389255qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V6782uv/lR78IFZdWPlWYnzNvjYHBRQ4Y4k+rewPDws=;
        b=AWsmRasqml+9LIVLxCQaFotf2e1U/FUKfMv+Umj175oMi7kuS7guS2B3uY82yhmOe2
         ZhK5P9jj242e3V/luZJofi8VgPnfWJaleGR4VCsQm6zZxrFjxTzFttwLJT4XjgOSWsnf
         zyWDQXxp9k444CISnfWHABmyR55uEKM51sfeQaaBL5J3COUieFPpvNEp+QHK5Oq8rjdu
         Pd8MsXDwl3tgwoUsMrsdYz9M4lvTCpLRZSsgJIm0uORccK7xR/Gh1gEpLxiJ8E58bnT+
         pROHH+SYdgPycp7urLQHlTcWxUMMn4OTx9KLNDOAc8mCuuYLMFQ+U3ur9ROJxlwLmPjl
         dF/w==
X-Gm-Message-State: AOAM531uWpSnfEP1DigYrCN81xHfBolgfJbn6xRY+7TD4aXGfiHHGXj/
        V/dPYkANNEbxm9Oynfe57yMNXmRhrV5R1xe8ZDmlAufLuSLPrkdZDog4SkfQ6PoFi7gD9iiEdim
        rq7ZehxA5kp6WSWbimWsnm2hl
X-Received: by 2002:ac8:58c5:: with SMTP id u5mr5197971qta.173.1624548227376;
        Thu, 24 Jun 2021 08:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYuNEZN+9M5YXJudVbsP8p1092eOJS1bJJ8jW9TETrlaT7t2iO4Ywmwh2AvAPDOjtmD90/qw==
X-Received: by 2002:ac8:58c5:: with SMTP id u5mr5197943qta.173.1624548227156;
        Thu, 24 Jun 2021 08:23:47 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k1sm2096694qtm.49.2021.06.24.08.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:23:46 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 3/6] cgroup/cpuset: Add a new isolated cpus.partition
 type
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-4-longman@redhat.com> <YNR/3fydXvAi3OsN@blackbook>
Message-ID: <58c87587-417b-1498-185f-1db6bb612c82@redhat.com>
Date:   Thu, 24 Jun 2021 11:23:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNR/3fydXvAi3OsN@blackbook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 8:51 AM, Michal Koutný wrote:
> Hello.
>
> On Mon, Jun 21, 2021 at 02:49:21PM -0400, Waiman Long <longman@redhat.com> wrote:
>>      cgroup/cpuset: Add a new isolated cpus.partition type
>>
>>      Cpuset v1 uses the sched_load_balance control file to determine if load
>>      balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>>      as its use may require disabling load balancing at cgroup root.
>>
>>      For workloads that require very low latency like DPDK, the latency
>>      jitters caused by periodic load balancing may exceed the desired
>>      latency limit.
>>
>>      When cpuset v2 is in use, the only way to avoid this latency cost is to
>>      use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
>>      the kernel boot, however, there is no way to add or remove CPUs from
>>      this isolated set. For workloads that are more dynamic in nature, that
>>      means users have to provision enough CPUs for the worst case situation
>>      resulting in excess idle CPUs.
>>
>>      To address this issue for cpuset v2, a new cpuset.cpus.partition type
>>      "isolated" is added which allows the creation of a cpuset partition
>>      without load balancing. This will allow system administrators to
>>      dynamically adjust the size of isolated partition to the current need
>>      of the workload without rebooting the system.
> I like this work.
> Would it be worth generalizing the API to be on par with what isolcpus=
> can configure? (I.e. not only load balancing but the other dimensions of
> isolation (like the flags nohz and managed_irq now).)
Good point, the isolated partition is equivalent to isolcpus=domain. I 
will need to evaluate the nohz and managed_irq options to see if they 
can be done dynamically without adding a lot of overhead. If so, we can 
extend the functionality to cover that in future patches. Right now, 
this is for the domain functionality only. If we can cover the nohz and 
managed_irq options, we can deprecate isolcpus and advocate the use of 
cgroup instead.
>
> I don't know if all such behaviors could be implemented dynamically
> (likely not easy) but the API could initially implement just what you do
> here with the "isolated" partition type.
>
> The variant I'm thinking of would keep just the "root" and "member"
> partitions type and the "root" type could be additionally configured via
> cpuset.cpus.partition.flags (for example).
>
> WDYT?

What I am thinking is that "isolated" means "isolated:domain" or one can 
do "isolated:nohz,domain,manged_irq" just like the current isolcpus boot 
option. I don't think we really need to add an extra flags control file.

Cheers,
Longman


