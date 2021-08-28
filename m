Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4B3FA2BF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 03:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhH1BPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 21:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232763AbhH1BO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 21:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630113246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nj7lN9b3OW9PxFPw9p3QaG1rQrZn9spoM1KJO1HMw1U=;
        b=A4dzNDypRsANDa1pVg1DfcJKC3AeuzVqI/F2sN9U5WyLrRgudYokmWn6/FKp29JdUtpDNU
        OGw349B1vwMuvYMNMev+arKbHt1fAAgPZ1aRSdSemGsBd0tfpZTPP4W2ECt8avwlCJKjgq
        ekctGLWwbBEl2uru6xbRluuaPsqoHzE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-ZdXJXCLVN6q8Xt25nxMlhw-1; Fri, 27 Aug 2021 21:14:04 -0400
X-MC-Unique: ZdXJXCLVN6q8Xt25nxMlhw-1
Received: by mail-qv1-f71.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so1146281qvb.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 18:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nj7lN9b3OW9PxFPw9p3QaG1rQrZn9spoM1KJO1HMw1U=;
        b=QSabHgjDMmbDWqIQtiDmCPqlQpOcb4MXjnNyEbks+2h3LpL7JYzjsaWt3KVBYwEAIs
         f9YeiIxd6ok5GIqSsxngeFxN/jOI8jizPb3c33X2Cg24oZHulbtvZ7GFWnGb+dkiVO4t
         tGmdqIFR9bQZ7FgvIOFxqAUA7nyjXFcMzDPHK0BfEyEsKrqHmV4cW+6YQf6TRgCooH6V
         0CWMt7ZA8IUrRy3JLtIiDVyAVKLT84gOojvNieK0mNHQwZM4TKNXjjTre7NYPfB9sFEt
         KbCCoCNYa/0ecClim5+76zVm/TQnU/nIhv3TpRJPy5rOJk+j+dOnCEG1h7mv00/bcmuY
         YhQA==
X-Gm-Message-State: AOAM532TvAQv4dw9oyxyuACiG0MozrjwoimSOc64o5YRgMeXCUnrx9uS
        zq2lGhdfRk1Ty/hflZwcYooH4ic9UTeWUEeBDcrcj9zsvcm+rjU6aWR8WS1DpSyeyASHipamt62
        aaW4L7qDtX/CLo+Qv9td2ND3V
X-Received: by 2002:a37:652:: with SMTP id 79mr12078383qkg.197.1630113244161;
        Fri, 27 Aug 2021 18:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykNQoi0T51RsUXHOgq9qN2JS1S6X7N+wT1bH2pmiiItHjdiaYmsBmA5yoKxviFq81ypmmOdA==
X-Received: by 2002:a37:652:: with SMTP id 79mr12078348qkg.197.1630113243925;
        Fri, 27 Aug 2021 18:14:03 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 21sm6009570qkk.51.2021.08.27.18.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 18:14:02 -0700 (PDT)
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
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
 <YSl2yxEvnDrPxzUV@slm.duckdns.org>
Message-ID: <f1168ddc-cb67-ecfd-6644-4963c857a0a0@redhat.com>
Date:   Fri, 27 Aug 2021 21:14:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSl2yxEvnDrPxzUV@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 7:35 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Aug 27, 2021 at 06:50:10PM -0400, Waiman Long wrote:
>> The cpu exclusivity rule is due to the setting of CPU_EXCLUSIVE bit. This is
>> a pre-existing condition unless you want to change how the
>> cpuset.cpu_exclusive works.
>>
>> So the new rules will be:
>>
>> 1) The "cpuset.cpus" is not empty and the list of CPUs are exclusive.
> Empty cpu list can be considered an exclusive one.
It doesn't make sense to me to have a partition with no cpu configured 
at all. I very much prefer the users to set cpuset.cpus first before 
turning it into a partition.
>
>> 2) The parent cgroup is a partition root (can be an invalid one).
> Does this mean a partition parent can't stop being a partition if one or
> more of its children become partitions? If so, it violates the rule that a
> descendant shouldn't be able to restrict what its ancestors can do.

No. As I said in the documentation, transitioning from partition root to 
member is allowed. Against, it is illogical to allow a cpuset to become 
a potential partition if it parent is not even a partition root at all. 
In the case that the parent is reverted back to a member, the child 
partitions will stay invalid forever unless the parent become a valid 
partition again.

>
>> 3) The "cpuset.cpus" is a subset of the parent's cpuset.cpus.allowed.
> Why not just go by effective? This would mean that a parent can't withdraw
> CPUs from its allowed set once descendants are configured. Restrictions like
> this are fine when the entire hierarchy is configured by a single entity but
> become awkward when configurations are multi-tiered, automated and dynamic.

The original rule is to be based on effective cpus. However, to properly 
handle the case of allowing offlined cpus to be included in the 
partition, I have to change it to cpu_allowed instead. I can certainly 
change it back to effective if you prefer.

>
>> 4) No child cgroup with cpuset enabled.
> idk, maybe? I'm having a hard time seeing the point in adding these
> restrictions when the state transitions are asynchronous anyway. Would it
> help if we try to separate what's absoluately and technically necessary and
> what seems reasonable or high bar and try to justify why each of the latter
> should be added?

This rule is there mainly for ease of implementation. Otherwise, I need 
to add additional code to handle the conversion of child cpusets which 
can be rather complex and require a lot more debugging. This rule will 
no longer apply once the cpuset becomes a partition root.

Cheers,
Longman


