Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D698D3F9299
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbhH0DCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244101AbhH0DCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630033295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4jOE7EOyJEUtyvbzwon/FpGiE9ELVYRNObVBK/Xg7Q=;
        b=I4Krasr7KLrpSkNAg5+wq0d12gkVocEvCi8tf7hTdukjeAEkUAfqn5kxGTkqOXW5nNLYdk
        msSqeFPon0VCAeMg2ZDyiapytq6S/fi3BlQwXBRlWx88tkcNHbscTjD2Asyjsw3GDeUVRY
        7NrOJNh0cw0jPjgPuCkYInW2FkoD0SY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-CBOKFDk1PE-Zw1uy9scu4A-1; Thu, 26 Aug 2021 23:01:33 -0400
X-MC-Unique: CBOKFDk1PE-Zw1uy9scu4A-1
Received: by mail-qv1-f71.google.com with SMTP id j11-20020a0cf9cb000000b00375f0642d2dso183194qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K4jOE7EOyJEUtyvbzwon/FpGiE9ELVYRNObVBK/Xg7Q=;
        b=Dtl60/E09nWIQYPv0pYNjLw0AVIC6CSmJRxTw0Q1WChDEKbDLHqki/4CT3ECysi/sL
         2DJOuT/a9ATVexonY8nN2kDFXMsGK3xw9tO+OwIISaefSk60DLlEuNI/QRshgqog07Ew
         iQUHZQk1GJj87EcU9UfZTdWyyw046f58XDJAj9fEzdKTEYjpFI9Evp1lDKNZobvef3EQ
         l8TpP9YEsHLTTO1aeI1fpCuhCrlJbsDz9dGAeaBdBRpEkKDN4i6R5QuuX5iLv2nBrsxK
         /PRsweR28SIpFITIVocApEH71wgs0gV9ozIEwcgSvLD7BFUlwRPW7DQ19CScdGmcM9i8
         6kmg==
X-Gm-Message-State: AOAM5334UkDtVg+CyDMSpsxKBCbGwdzXZw6iX5D5y9tM5xv50z+NQc7t
        7vpnCOMcACA+IBB1B1du5xpMPmpSr0EP6lK7riStPTwFxzbd8SXfvHCBtc1eiXPwU8t2uS3gatV
        GR92ZafM1Q3EPHmd1sQBWN82r
X-Received: by 2002:a05:620a:2492:: with SMTP id i18mr7242235qkn.57.1630033293055;
        Thu, 26 Aug 2021 20:01:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH38hLETGQM+sg7xDFhHxk8Ho4XlE30avAUmXfRuimCPma+GJB5ntZuUwdTw7Cewi7vQSA0g==
X-Received: by 2002:a05:620a:2492:: with SMTP id i18mr7242217qkn.57.1630033292764;
        Thu, 26 Aug 2021 20:01:32 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v128sm4003899qkh.27.2021.08.26.20.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:01:32 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com> <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
Message-ID: <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
Date:   Thu, 26 Aug 2021 23:01:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 1:35 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> Let's stop iterating on the patchset until we reach a consensus.
>
> On Wed, Aug 25, 2021 at 05:37:49PM -0400, Waiman Long wrote:
>>   	1) The "cpuset.cpus" is not empty and the list of CPUs are
>>   	   exclusive, i.e. they are not shared by any of its siblings.
> Part of it can be reached by cpus going offline.
>
>>   	2) The parent cgroup is a partition root.
> This condition can happen if a parent stop being a partition.
>
>> -	3) The "cpuset.cpus" is also a proper subset of the parent's
>> +	3) The "cpuset.cpus" is a subset of the parent's
>>   	   "cpuset.cpus.effective".
> This can happen if cpus go offline.
>
>>   	4) There is no child cgroups with cpuset enabled.  This is for
>>   	   eliminating corner cases that have to be handled if such a
>>   	   condition is allowed.
> This may make sense as a short cut for us but doesn't really stem from
> interface or behavior requirements.
>
> Of the four conditions listed, two are bogus (the states can be
> reached through a different path and the configuration success or
> failure can be timing dependent if configuration racaes against cpu
> hotplug operations) and one maybe makes sense half-way and one is more
> of a shortcut.
>
> Can't we just replace these with transitions to invalid state with
> proper explanation? That'd get rid of the error handling duplications
> from both the kernel and user side, make automated configurations
> which may race against hot plug operations reliable, and consistently
> provide users with why something failed.

What I am doing here is setting a high bar for transitioning from member 
to either "root" or "isolated". Once it becomes a partition, there are 
multiple ways that can make it invalid. I am fine with that. However, I 
am not sure it is a good idea to allow users to echo "root" to 
cpuset.cpus.partition anywhere in the cgroup hierarchy and require them 
to read it back to see if it succeed.

All the checking are done with cpuset_rwsem held. So there shouldn't be 
any racing. Of course, a hotplug can immediately follow and make the 
partition invalid.

Cheers,
Longman

