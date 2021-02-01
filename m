Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8CF30AEA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBASAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBASAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:00:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F4C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:00:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c12so17615831wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hy6le2ut7Y6roUg62xnR//ga/Hyb82OjO/ET+eNm11Q=;
        b=rwiqPR+JJWhbzVoOhl34+JFJxWtRTDwa/xlROvpLhnjiLQMOXnhGdmUy/+l483wkPz
         t1arHcGsQ9PoU6ycQvQF6cKySDpH6F2GaE5S4KD+3hi/HYb90Y2f2FSAzGqYw0n1qJdc
         qKya1GW1sAKTrdR3Gvicyam+VzPrmpZCOq4UldPfa7+jHZ5F12dwxOKmKbqTInbx4VZf
         cbaJYKrC3kNiAj5hOJGdLgJjxOvaMZ3Ob6dFI0mVtevx3mWZ2dNvVL5Tu1AaeCLXlfZE
         CNWJCftxV/SJvcJbWPYvHRocWY+F0mepZbKsaz9Y128f6JrCSJ2MQwAZpGX+4VsfC1D+
         UCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hy6le2ut7Y6roUg62xnR//ga/Hyb82OjO/ET+eNm11Q=;
        b=AYaaMuR+pAbjjax11Ajb++f4mOdSli7+ziKh3vFDVVfIaINhEN8tQYZUpKA33Get8U
         bHyQ9vcUHIM9GyBwI1jmia5Oar+i2r4RwAs0U9UPaqpy5M+vhIP2pC0X7BK36rTTvptJ
         JgevmcMoTHpvtv9ZlGkww3O61pucCe8XIIICAuIpkLYJ0zfKEqg5j99eN4bkRSkJ0ZkH
         XMWSv3bOgBHx6vkKBNQjefsj/8bbCmx3l4ZPIWqSb43chbWx+M/fX/V1t9aNJOQBmroq
         BC6bbmL4vQPuUnKqv5ieQQ1gffTnDAnsM6+FFZx+ZQ/SEzipuJ+wfc3G2LzAKOYjnepk
         UhHg==
X-Gm-Message-State: AOAM531j+Dk0pbnGpp5yQEf++4J6Dsw5cukVwcseAFNKJBajgHeDclKp
        lIsA/WJ66hAccDzN5KenX5k=
X-Google-Smtp-Source: ABdhPJyMGyUUpp4l29fSd54f3CCIJ56SbMDE7aOkzCLdrGcWTsIt70Q75vFsd2r1HUJRwORm5CgfLQ==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr19127981wrz.86.1612202406742;
        Mon, 01 Feb 2021 10:00:06 -0800 (PST)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id m11sm70643wmc.15.2021.02.01.10.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 10:00:05 -0800 (PST)
Subject: Re: Very slow unlockall()
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
 <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
Date:   Mon, 1 Feb 2021 19:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 14:08, Vlastimil Babka wrote:
> On 1/8/21 3:39 PM, Milan Broz wrote:
>> On 08/01/2021 14:41, Michal Hocko wrote:
>>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>>> Hi,
>>>>
>>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>>> and someone tried to use it with hardened memory allocator library.
>>>>
>>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>>> is in munlockall().
>>>>
>>>> Here is a plain reproducer for the core without any external code - it takes
>>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>>
>>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>>> The real code of course does something more useful but the problem is the same.
>>>>
>>>> #include <stdio.h>
>>>> #include <stdlib.h>
>>>> #include <fcntl.h>
>>>> #include <sys/mman.h>
>>>>
>>>> int main (int argc, char *argv[])
>>>> {
>>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>>
>>>>         if (p == MAP_FAILED) return 1;
>>>>
>>>>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>>>>         printf("locked\n");
>>>>
>>>>         if (munlockall()) return 1;
>>>>         printf("unlocked\n");
>>>>
>>>>         return 0;
>>>> }

...

>> Today's Linus git - 5.11.0-rc2+ in my testing x86_64 VM (no extensive kernel debug options):
>>
>> # time ./lock
>> locked
>> unlocked
>>
>> real    0m4.172s
>> user    0m0.000s
>> sys     0m4.172s
> 
> The perf report would be more interesting from this configuration.

ok, I cannot run perf on that particular VM but tried the latest Fedora stable
kernel without debug options  - 5.10.12-200.fc33.x86_64

This is the report running reproducer above:

time:
real    0m6.123s
user    0m0.099s
sys     0m5.310s

perf:

# Total Lost Samples: 0
#
# Samples: 20K of event 'cycles'
# Event count (approx.): 20397603279
#
# Overhead  Command  Shared Object      Symbol                      
# ........  .......  .................  ............................
#
    47.26%  lock     [kernel.kallsyms]  [k] follow_page_mask
    20.43%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
    15.92%  lock     [kernel.kallsyms]  [k] follow_page
     7.40%  lock     [kernel.kallsyms]  [k] rcu_all_qs
     5.87%  lock     [kernel.kallsyms]  [k] _cond_resched
     3.08%  lock     [kernel.kallsyms]  [k] follow_huge_addr
     0.01%  lock     [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
     0.01%  lock     [kernel.kallsyms]  [k] ____fput
     0.01%  lock     [kernel.kallsyms]  [k] rmap_walk_file
     0.00%  lock     [kernel.kallsyms]  [k] page_mapped
     0.00%  lock     [kernel.kallsyms]  [k] native_irq_return_iret
     0.00%  lock     [kernel.kallsyms]  [k] _raw_spin_lock_irq
     0.00%  lock     [kernel.kallsyms]  [k] perf_iterate_ctx
     0.00%  lock     [kernel.kallsyms]  [k] finish_task_switch
     0.00%  perf     [kernel.kallsyms]  [k] native_sched_clock
     0.00%  lock     [kernel.kallsyms]  [k] native_write_msr
     0.00%  perf     [kernel.kallsyms]  [k] native_write_msr


m.
