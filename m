Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394542F803
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhJOQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbhJOQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:23:23 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A643C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f15so7732327ilu.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JD9eIQfx7k1D8AJiGxSA/qZszLEf/lWq41JF0CGsHnc=;
        b=XBh1AYl6Z1r4p3gWQhOZBe5NmXRrZGPEePuvl1tkLItP8ogdeT1JIHMv6J4ypbgcB5
         SpKBPFTbKmlpu8KZRAJXN0/eBAdrR92Q14CbuM9gYgnsPa701hcPCUilhIh6AmhDrMdf
         m7aJrxLjtnmsm7JDM1+ZMXRnWdKcQPHkEn+OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JD9eIQfx7k1D8AJiGxSA/qZszLEf/lWq41JF0CGsHnc=;
        b=z1jw0Nc86S+ORdmW9E4NgpK6JPiwga72iT+4KzELNybTzCx1OKk4KI2knr3trh9F5i
         BiSeQfKj0UlDfgPfDVq7K2REAwwbIHoAK4pjiZrfB0Es5Du/Q/J1dWUWZMF7z+uaKKEy
         MLicvW5ZmHvAkqF6TRPnLbIjFORgxmnoOg+XeDP9PHEQrISIba4O++ZPA19G0XNj0uMn
         wSmcN5CgBu1sXE+w9SO3/QVwIsP391ZIOPHnNwpYeFtKvxkYRmhf/Ri6KUgH2kY9LQ36
         Z45WYKJG5L0oB5dTtXR/Jqf2tDt7Rzouj7tPeQWf4iTom0KmTg5ybIsQgjCx0Mow6s3N
         3rfQ==
X-Gm-Message-State: AOAM531V/BNICqGY23sBKGUBvJ2lJ9amoj7LPyDxWpKGbtkmbknHVMjz
        2+utWQhoPRik6facYTa6jkvlhrGjJO/Sxw==
X-Google-Smtp-Source: ABdhPJwX1ojNcYex5/wXmXGz7SNMba+HK97Dowg2RYga2Ky0fGP18JVri/P5mvjGcE+ZRSkjBJGZig==
X-Received: by 2002:a92:c262:: with SMTP id h2mr4633246ild.204.1634314876039;
        Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v17sm2968857ilh.67.2021.10.15.09.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:21:15 -0700 (PDT)
Subject: Re: selftests/vm madv_populate.c test
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1be8c9d5-da76-9c92-01a4-b11a08edd88e@linuxfoundation.org>
Date:   Fri, 15 Oct 2021 10:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 9:47 AM, David Hildenbrand wrote:
> On 15.10.21 17:45, Shuah Khan wrote:
>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>> Hi David,
>>>>
>>>> I am running into the following warning when try to build this test:
>>>>
>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>      334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>          |  ^~~~~~~
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

I don't install it on my test system. Kselftest build does header install
in the source tree to compile tests with the headers so that the changes
to tests and new tests can be compiled with the kernel changes that might
include kernel header changes.

when I run "make kselftest-all TARGETS=vm", I see the following: (this
is on linux-next-20211012,

tools/testing/selftests/vm/madv_populate
madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
   334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
       |  ^~~~~~~

thanks,
-- Shuah
