Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731DF309EAC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhAaUJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhAaTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9EBC061756
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so10695028wmz.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+6IGa1lvhVvHwaYJw2IbacWbpY59Fb+lhv0QG13A0k=;
        b=si+ecLL8RTob+OKJmPovE+xToqGcvfKP26EHjHywDn3QCIkrw0Hpi7O8Fwq8Z6zf2H
         2oV2eP9jxNf6vh79wGmstozFVRexf0ZxuLaKFv1V7AgBzav0LJ7LmAAmHtmqdOxJjO7x
         fnLRRdLTQEYlnBW5QQa+fuJPdyYpPQnIajUrzWI104qB1OD4kfvKrIOMSpGV0hG31aBh
         czhVqDpi3dxzTbRraaGZ7ETFj2Pk6wO4OilNTHlcvURR+6puCBMcSCdQxtbSiATjcT/4
         nNHN+CBvXa+LOs+1X+JZbdy566tJI7I7TVaK97+hQA4We9Uq0m+2CD5gShg/l5JIoGWT
         2nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+6IGa1lvhVvHwaYJw2IbacWbpY59Fb+lhv0QG13A0k=;
        b=nWSTSajQdoP1ecPTbXfWIAevbmuhBYfjONEl/nYLJFA0YE2SAYw+PLI4oPtMAcXN/9
         9bpoEbJkhaKkNCQDKmKADtAjzjDIQDvi6pgL42kp65ZWM/H/Dyq/oHCgNnnzQzH/pLWF
         iPn0CWdHKqYIFOapDgmmee1wVErWEFACZ2KU9u7ZMk4g5UlaKjdTkuqJRtTbIv24X62s
         ilmFqR4wf96yR3SJT997jcnQEj5sqnDBs70NyBB/okh9xhnysggag3BQts5d2RZxKlro
         Bjvcd5z/95tFd4LVtf+yJ/OH/veQW8NQUvolHCsF/PBTbPMeB+Av5HPIdr3x6Upvh2z0
         r/Mg==
X-Gm-Message-State: AOAM531+EKm/tZl5u7Zg7Y+mH9ifNsRQJeciZDAmu9C5tD/dQi2YkN0u
        gDKNv1gm6lTc93q902ubIvetfNum95A=
X-Google-Smtp-Source: ABdhPJw65erEm9h5HmFHPpK0vjDJRlRiaM9t8lZRbCBk6UHsN0mVveCtUaPmxxMe01i8CkNyCLwwyA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr11985884wmi.159.1612113753146;
        Sun, 31 Jan 2021 09:22:33 -0800 (PST)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id q20sm1498560wmc.14.2021.01.31.09.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 09:22:32 -0800 (PST)
Subject: Re: Very slow unlockall()
From:   Milan Broz <gmazyland@gmail.com>
To:     linux-mm@kvack.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Michal Hocko <mhocko@suse.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
Message-ID: <36e72f8c-3e23-ec48-d8c5-402dc8cfb9c9@gmail.com>
Date:   Sun, 31 Jan 2021 18:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2021 15:39, Milan Broz wrote:
> On 08/01/2021 14:41, Michal Hocko wrote:
>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>> Hi,
>>>
>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>> and someone tried to use it with hardened memory allocator library.
>>>
>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>> is in munlockall().
>>>
>>> Here is a plain reproducer for the core without any external code - it takes
>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>
>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>> The real code of course does something more useful but the problem is the same.
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <fcntl.h>
>>> #include <sys/mman.h>
>>>
>>> int main (int argc, char *argv[])
>>> {
>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>>         if (p == MAP_FAILED) return 1;
>>>
>>>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>>>         printf("locked\n");
>>>
>>>         if (munlockall()) return 1;
>>>         printf("unlocked\n");
>>>
>>>         return 0;
>>> }
>>>
>>> In traceback I see that time is spent in munlock_vma_pages_range.
>>>
>>> [ 2962.006813] Call Trace:
>>> [ 2962.006814]  ? munlock_vma_pages_range+0xe7/0x4b0
>>> [ 2962.006814]  ? vma_merge+0xf3/0x3c0
>>> [ 2962.006815]  ? mlock_fixup+0x111/0x190
>>> [ 2962.006815]  ? apply_mlockall_flags+0xa7/0x110
>>> [ 2962.006816]  ? __do_sys_munlockall+0x2e/0x60
>>> [ 2962.006816]  ? do_syscall_64+0x33/0x40
>>> ...
>>>
>>> Or with perf, I see
>>>
>>> # Overhead  Command  Shared Object      Symbol                               
>>> # ........  .......  .................  .....................................
>>> #
>>>     48.18%  lock     [kernel.kallsyms]  [k] lock_is_held_type
>>>     11.67%  lock     [kernel.kallsyms]  [k] ___might_sleep
>>>     10.65%  lock     [kernel.kallsyms]  [k] follow_page_mask
>>>      9.17%  lock     [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
>>>      6.73%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
>>> ...
>>>
>>>
>>> Could please anyone check what's wrong here with the memory locking code?
>>> Running it on my notebook I can effectively DoS the system :)
>>>
>>> Original report is https://gitlab.com/cryptsetup/cryptsetup/-/issues/617
>>> but this is apparently a kernel issue, just amplified by usage of munlockall().
>>
>> Which kernel version do you see this with? Have older releases worked
>> better?
> 
> Hi,
> 
> I tried 5.10 stable and randomly few kernels I have built on testing VM (5.3 was the oldest),
> it seems to be very similar run time, so the problem is apparently old...(I can test some specific kernel version if it make any sense).
> 
> For mainline (reproducer above):
> 
> With 5.11.0-0.rc2.20210106git36bbbd0e234d.117.fc34.x86_64 (latest Fedora rawhide kernel build - many debug options are on)
> 
> # time ./lock 
> locked
> unlocked
> 
> real    0m32.287s
> user    0m0.001s
> sys     0m32.126s
> 
> 
> Today's Linus git - 5.11.0-rc2+ in my testing x86_64 VM (no extensive kernel debug options):
> 
> # time ./lock
> locked
> unlocked
> 
> real    0m4.172s
> user    0m0.000s
> sys     0m4.172s
> 
> m.

Hi,

so because there is no response, is this expected behavior of memory management subsystem then?

Thanks,
Milan



 

