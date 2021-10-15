Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8D42F7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhJOQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236447AbhJOQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634313977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrC9q6JDbWDVZCJPKvI06rgViOu2XQgIlwKssWrd25I=;
        b=VarrhiNW/8rNCXoSFAX7QT3grPXNRN2f0tcY0VDijAVj4aVWWEXer3MMd23f0X8FPrscXB
        LunBUkaZc4P/NJD3SKpF+9DkaIl1wlCOR7Z7ZGPpwHlCGqpP7w6w+RIwxm1ZNUNBeVLqoA
        R1zHXTe2DvyKUc6v5xXmdjUm0E9Op6A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-GKY_z4OhNKiW-XzcUg4R7g-1; Fri, 15 Oct 2021 12:06:16 -0400
X-MC-Unique: GKY_z4OhNKiW-XzcUg4R7g-1
Received: by mail-wm1-f72.google.com with SMTP id s25-20020a7bc399000000b0030da0f36afeso954923wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=rrC9q6JDbWDVZCJPKvI06rgViOu2XQgIlwKssWrd25I=;
        b=47GqNXk0GJt+4I1xCA5T/d+FbAfwJE7Md/YHZfIdVmu8M+cezvYfa8Nc7I/vZ3zz2L
         8mVphOjeW/5jgy/gY9NcbKSR3iBHQrUbiWYkFHuASH7GS31hFZ7zWqLAh5QypDMHuZhZ
         1h4sJFkKQfW2VMgKQvhTG41VR3+bq6Mg3HPD+gZxt9eDPHcC0YEiJYXww6plHI5r+TNp
         KzgrQEbDQGixrHa70as9OU0igOjVHH2ghD75niA+G28RzB2wvUL7je9afu+N8r3EsPwd
         ZU+4kbHiZTg9k0bsXGyFfB3r4ci/r0HuGzP0cu9IfMLYDB/ofI89TqZVe9eL7lO6oxUX
         l1NA==
X-Gm-Message-State: AOAM532Ac8ITFI/uYuBfsYCPJhlL6zeXHzDoIJo7HpQ8e/YJSAEM5MuI
        Nb2I07Bb74dTXRjpmqBuH7B+Zjw894iGUdrLsoHKnX5eyECvQYidpR8bTAXwA5D4aRSnio7FDEa
        2wqabeidPiguAU+QAi09G9ufl
X-Received: by 2002:adf:bbc3:: with SMTP id z3mr15712011wrg.10.1634313975080;
        Fri, 15 Oct 2021 09:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4vzOPVuGeVVQDXyj9oYyvV1iRD5QUO6KW0E1CPsqus5itvwHzwlRqplu+62KRvMoq/LwklA==
X-Received: by 2002:adf:bbc3:: with SMTP id z3mr15711977wrg.10.1634313974878;
        Fri, 15 Oct 2021 09:06:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id z2sm5273335wrn.89.2021.10.15.09.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:06:14 -0700 (PDT)
Message-ID: <77f4c6a9-141d-e103-7339-0055cc00f752@redhat.com>
Date:   Fri, 15 Oct 2021 18:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Organization: Red Hat
In-Reply-To: <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.21 17:47, David Hildenbrand wrote:
> On 15.10.21 17:45, Shuah Khan wrote:
>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>> Hi David,
>>>>
>>>> I am running into the following warning when try to build this test:
>>>>
>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>         |  ^~~~~~~
>>>>
>>>>
>>>> I see that the following handling is in place. However there is no
>>>> other information to explain why the check is necessary.
>>>>
>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>
>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>
>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>
>>>> I do see these defined in:
>>>>
>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>
>>>> Is this the case of missing include from madv_populate.c?
>>>
>>> Hi Shuan,
>>>
>>> note that we're including "#include <sys/mman.h>", which in my
>>> understanding maps to the version installed on your system instead
>>> of the one in our build environment.ing.
>>>
>>> So as soon as you have a proper kernel + the proper headers installed
>>> and try to build, it would pick up MADV_POPULATE_READ and
>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>> that doesn't support it.
>>>
>>> See vm/userfaultfd.c where we do something similar.
>>>
>>
>> Kselftest is for testing the kernel with kernel headers. That is the
>> reason why there is the dependency on header install.
>>
>>>
>>> As soon as we have a proper environment, it seems to work just fine:
>>>
>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>> [root@vm-0 linux]# cat /etc/redhat-release
>>> Fedora release 36 (Rawhide)
>>
>> This is a distro release. We don't want to have dependency on headers
>> from the distro to run selftests. Hope this makes sense.
>>
>> I still see this on my test system running Linux 5.15-rc5.
> 
> Did you also install Linux headers? I assume no, correct?
> 

What happens in your environment when compiling and running the
memfd_secret test?

If assume you'll see a "skip" when executing, because it might also
refer to the local version of linux headers and although it builds, it
really cannot build something "functional". It just doesn't add a
"#warning" to make that obvious.

-- 
Thanks,

David / dhildenb

