Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932342F73C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhJOPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhJOPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634312827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+Q0m93eDQUsQs996BqvSBuleHVWdL0Hp5smaHrBxAk=;
        b=eBVrbuDgxjnXaUnPuBKwpwgU0pnsn4fIgGJwYSfzb3wVYQTfO5i7J1woZxFmUaBiwigk/a
        d28rUgLbq6TvErbOvWSpU38hpzQtqxih8rRCXJExI01iJ1iORDiA1KGJUPTAAzeae208sI
        edjZlbP02yPp6toKpF7ihhmmsNHnMiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-f-t_n8O1PGKSalit9L18lQ-1; Fri, 15 Oct 2021 11:47:06 -0400
X-MC-Unique: f-t_n8O1PGKSalit9L18lQ-1
Received: by mail-wr1-f71.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so6103706wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/+Q0m93eDQUsQs996BqvSBuleHVWdL0Hp5smaHrBxAk=;
        b=xlRNtAjMrz/EqTOJu/0gB1mBy/t8kc8AaUcU+FWLFN4F88ZtGoCqdUgAPi9Dpomaaa
         dq59xZX9phGiMgIWpDHmA8kTNqMADAlmeL87FIDO66FVwwK8c1vmLfsmRAxqOJzqsHzQ
         /kqmNV3nErmduMQbB30iaOTeBCIzvAL61q4ODSjLm0B1qWpHafeS4jzsJvHU/SJdCjxO
         lQaxwqFDwkGno5IW3pSovPKu3GWREue0/59e2YOPgx//06Yh20ZnT3C4sssq96DBetNp
         baiLwIGuLSPhK+ikfaLGOX+YGwjnYk3L76tbopLzaOha0RfXtXxnKyMhbz9e38aXDS+Q
         rTSQ==
X-Gm-Message-State: AOAM532laTZMlb5agDdLHkjlrJInQnoxkUq9Z/mnwN1RK6dJlMgNUI/M
        zbBq9Ob7nluOy2PukGvFrf7n9tw+h2CoL/WWNBEwvk+fk0DMhfJGj3YaDHwNisRnzi7mb3JRYQO
        FwQuPKLPDZAggd4RxzphDYZAY
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr12990757wmq.67.1634312824940;
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ8cZ4RHjQrgJ/5N2T4Zi0Zesg0WM8aufR8Y+rPU6qtgwPr28uz+3Y80ilegTf+T+SZ91+/Q==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr12990737wmq.67.1634312824703;
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id w1sm10807575wmc.19.2021.10.15.08.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
Message-ID: <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Date:   Fri, 15 Oct 2021 17:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.21 17:45, Shuah Khan wrote:
> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>> On 18.09.21 00:45, Shuah Khan wrote:
>>> Hi David,
>>>
>>> I am running into the following warning when try to build this test:
>>>
>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>         |  ^~~~~~~
>>>
>>>
>>> I see that the following handling is in place. However there is no
>>> other information to explain why the check is necessary.
>>>
>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>
>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>
>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>
>>> I do see these defined in:
>>>
>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>
>>> Is this the case of missing include from madv_populate.c?
>>
>> Hi Shuan,
>>
>> note that we're including "#include <sys/mman.h>", which in my
>> understanding maps to the version installed on your system instead
>> of the one in our build environment.ing.
>>
>> So as soon as you have a proper kernel + the proper headers installed
>> and try to build, it would pick up MADV_POPULATE_READ and
>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>> that doesn't support it.
>>
>> See vm/userfaultfd.c where we do something similar.
>>
> 
> Kselftest is for testing the kernel with kernel headers. That is the
> reason why there is the dependency on header install.
> 
>>
>> As soon as we have a proper environment, it seems to work just fine:
>>
>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>> [root@vm-0 linux]# cat /etc/redhat-release
>> Fedora release 36 (Rawhide)
> 
> This is a distro release. We don't want to have dependency on headers
> from the distro to run selftests. Hope this makes sense.
> 
> I still see this on my test system running Linux 5.15-rc5.

Did you also install Linux headers? I assume no, correct?

-- 
Thanks,

David / dhildenb

