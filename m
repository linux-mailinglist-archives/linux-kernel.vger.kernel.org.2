Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1643E977D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhHKSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHKSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628705903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sdWMe6I8w2i60A4RZfVZLGm7Z1MFMDLriAO19Jv51I=;
        b=JqBB7ho0fwHMp+EBjpaj469CgxDExdtIhmR90HeYJicuSwziKiuds81VlneTnHOS52fcCE
        6dADURoEQa5MsKzytfkJwDthYmYyIyZTE2Wl+Pw2CNSh97L2mDAgbKWhkxDaTOrHyK5YNx
        EqD+uaWRi4G/7Tym5Dbe9y0Fvy1WoRk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-0oCi7J99MASP1LN1E-1XLA-1; Wed, 11 Aug 2021 14:18:20 -0400
X-MC-Unique: 0oCi7J99MASP1LN1E-1XLA-1
Received: by mail-qt1-f198.google.com with SMTP id h18-20020ac856920000b029025eb726dd9bso876631qta.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4sdWMe6I8w2i60A4RZfVZLGm7Z1MFMDLriAO19Jv51I=;
        b=nobjbppz2L50gEMX9h+TksxC//OgY23bMqh6/QDpk2qYWNbOuFWziNINnxpFplN7E3
         RnwpjKCwhB4w+xwmxXJvwjnkIlsUeq1dMtm2vVDqTTEu8NbC5TLzBBG+7aAhs4VssyrV
         ULuSBaKTs2wYNfq9cZpi3hGjhTbEsCZzHJ2ehYLlaIRA+1tXggA4K1aG2TF4Ap+Uit8h
         pjvzetlCKF5kEpMcB/7+wHhWyaHY3/8ElQvBb3DHkyfuKlosEk4DBi/CJW/5zt2NyzxZ
         5OtD8n1dRgo8IjuaH8xaHmhjmV57h8r/GAklUrAFFt+vc88+ZMpEqjA7FNpmOaJKidig
         iS9Q==
X-Gm-Message-State: AOAM531K5V+CfIa7OnkjbH2TljzUgardMPDEV3FS9kW8D/VcZSpqM7Oa
        B8N8m7kKtNqhvYRTsXM82IjzE9fGRUBurfG2iBQAvl5CHym84PuT28ebb04LEZK5QTNIHPUeG0V
        COvsBVWLw4IlQD8I9XxMuSCuJ
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr24540286qvb.13.1628705899517;
        Wed, 11 Aug 2021 11:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMRVK++tAy3NAo+jUnQ3F2vejRbQTm+/+F0mBpaBHrAr6FPUsKJ8ztdb4qjZs9fOBOrjGeWw==
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr24540261qvb.13.1628705899355;
        Wed, 11 Aug 2021 11:18:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id e18sm18303qtq.16.2021.08.11.11.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:18:18 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition root
 to distribute out all CPUs
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
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-5-longman@redhat.com>
 <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
Message-ID: <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
Date:   Wed, 11 Aug 2021 14:18:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 2:13 PM, Tejun Heo wrote:
> On Tue, Aug 10, 2021 at 11:06:05PM -0400, Waiman Long wrote:
>> Currently, a parent partition root cannot distribute all its CPUs to
>> child partition roots with no CPUs left. However in some use cases,
>> a management application may want to create a parent partition root as
>> a management unit with no task associated with it and has all its CPUs
>> distributed to various child partition roots dynamically according to
>> their needs. Leaving a cpu in the parent partition root in such a case is
>> now a waste.
>>
>> To accommodate such use cases, a parent partition root can now have
>> all its CPUs distributed to its child partition roots as long as:
>>   1) it is not the top cpuset; and
>>   2) there is no task directly associated with the parent.
>>
>> Once an empty parent partition root is formed, no new task can be moved
>> into it.
> The above are already enforced by cgroup2 core, right? No intermediate
> cgroup with controllers enabled can have processes. From controllers' POV,
> only leaves can have processes.
>
I don't think that is true. A task can reside anywhere in the cgroup 
hierarchy. I have encountered no problem moving tasks around.

Cheers,
Longman

