Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1287B3FA1A0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhH0WvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbhH0WvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630104614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En27XuojdaIOCdDdv7ALogd6FL3p5QlR3VuvOI+21oc=;
        b=Mq+qFALNALfEp76UYjYy6GgmawNUqQK/iXPYqLQ9aLacJs4SjBZ1P61AddPBM5tPNAXd4C
        QDs8DO51n0S5oLPCQB4AMvW96vNJC06kyDKcZ59YMmBZlTBkEUTJf9ek4cK9zn5LULPtcD
        eKCeHDVNMgn4UKbSpyxaQaYxY74nL/M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-BCeChyQoOsSDJ4lxQvQfIw-1; Fri, 27 Aug 2021 18:50:13 -0400
X-MC-Unique: BCeChyQoOsSDJ4lxQvQfIw-1
Received: by mail-qv1-f70.google.com with SMTP id q2-20020ad45ca2000000b00374fa0dbedfso4310638qvh.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=En27XuojdaIOCdDdv7ALogd6FL3p5QlR3VuvOI+21oc=;
        b=dSyeUFOVUKrLiUUpbnRnKjtyQJiKUsavc//N+OIOKPZHfryD0+J7cpLFP8iadf7XJ9
         Y29IFQf42ubj8eBvFWPcUy7FCzNiubKUa7dLxvUrm2xpBs8jVyQ2umBtXB17KWh32kzw
         SSbUDRTHGgkGrbPSsON6bPp5j/+BC0+8SnnSP+Xa+udommZBayf5U4QAZ/HO9v+xN6u6
         zxu8JbkfWZ5mziLpUgloNtT8+HG3NRCae/QE4HVx4pRr5waCH+oukXuEBR3VESAztfN0
         pIeJkOYptND0t7uw2QfDaQ6O27+br6xI+j3Mu5KCBaR237IHY+TEjfFsKgAud3rU3M7h
         L2dg==
X-Gm-Message-State: AOAM530RrQzUwwFuNlF0yZVI/PJdFrSJC39zeFb9qwdn36wjMUgF3Gty
        kgszbfocxtInNr6A9ZoKhA32VSkT1k9mKhtS0mjhsFSKI2m9hD82+Iwek8+yPpm58fCmU6CpD70
        hJm5fqxj+IClluDJzErsbbQFW
X-Received: by 2002:a37:6c2:: with SMTP id 185mr11562364qkg.260.1630104612874;
        Fri, 27 Aug 2021 15:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDwQTZ4QOhNVfh2Wu90ofVKbf58SD0ih0hTl4Eu7RstEN8nFTD7XE3SpMp4kcVkOfvIHjAtw==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr11562356qkg.260.1630104612655;
        Fri, 27 Aug 2021 15:50:12 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k186sm5784054qkd.47.2021.08.27.15.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:50:12 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com> <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
Message-ID: <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
Date:   Fri, 27 Aug 2021 18:50:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSlY0H/qeXQIGOfk@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 5:27 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Aug 27, 2021 at 05:19:31PM -0400, Waiman Long wrote:
>> Well, that is a valid point. The cpus may have been offlined when a
>> partition is being created. I can certainly relent on this check in forming
>> a partition. IOW, cpus_allowed can contain some or all offline cpus and a
>> valid (some are online) or invalid (all are offline) partition can be
>> formed. I can also allow an invalid child partition to be formed with an
>> invalid parent partition. However, the cpu exclusivity rules will still
>> apply.
>>
>> Other than that, do you envision any other circumstances where we should
>> allow an invalid partition to be formed?
> Now that most restrictions are removed from configuration side, just go all
> the way? Given that the user must check the status afterwards anyway, I
> don't see technical or even usability reasons for leaving some pieces
> behind. Going all the way would be easier to use too - bang in the target
> config and read the resulting state to reliably find out why a partition
> isn't valid, especially if we list *all* the reasons so that the user
> tell whether the configuration is as intended immediately.

The cpu exclusivity rule is due to the setting of CPU_EXCLUSIVE bit. 
This is a pre-existing condition unless you want to change how the 
cpuset.cpu_exclusive works.

So the new rules will be:

1) The "cpuset.cpus" is not empty and the list of CPUs are exclusive.
2) The parent cgroup is a partition root (can be an invalid one).
3) The "cpuset.cpus" is a subset of the parent's cpuset.cpus.allowed.
4) No child cgroup with cpuset enabled.

I think they are reasonable. What do you think?

Cheers,
Longman

