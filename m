Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E943507F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhJTQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJTQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634748234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyzSS0MRFovNakFggaeABNY+eZI3H3jDUHqxRRmWV0k=;
        b=Jx5j736jmjX+P1VzzqSriOl8G89edDLEyIVM4cqNArPOAy2OpzWf2JpFDdGQJY8b0n/oE9
        dtDij9LW//CKGsOJ5n6pdzpElZhiufxKcNYWA70NLOxwj3kDddVgGaxt2z/H0DBAvN6+fz
        OITAT5J1RHtZ+k775yPk9QvfhpEBHOE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-XTKqY3t3M-it2Nnx3kvkvA-1; Wed, 20 Oct 2021 12:43:53 -0400
X-MC-Unique: XTKqY3t3M-it2Nnx3kvkvA-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so4550017wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kyzSS0MRFovNakFggaeABNY+eZI3H3jDUHqxRRmWV0k=;
        b=VmP1+2GkH6zV9/Gh7vTGrG4bVJS2qt1hxnhiGrZepjGUq28j0V1qKvrb3CGzpahdCO
         EXatli75QUAQabKREREtV6NLfr3t00x3ZkTkrUJDQmvCF0rHsW0qFcsNKmWYi1XsjodN
         ZAuGMWchXxTIBzLwrhClhFyVgzYxlZtTwvRsbVUaEVw7hdiY4i6T8XynOFFdKXrrZPls
         gbLhkvCQe3p7VtoZIDE+U4xfB2RJAe0nXH46uNjiQqFhpoy1UnlW/Iblg3ZaC0FnyCc6
         F/ZAelqYRNLlTbsJ/9dtUQPTtQIct9Xg0nAugOdFlYbv2+KpuBa9KGBhBOga5S30pcT3
         cRaA==
X-Gm-Message-State: AOAM531jLagZED3OGAnFy9gdA+1msR1ybKWTMEynTwPspsxbNRmKrdYq
        5ymcoIBpDmPIg2jj5QLLTaHszIdapLI78VNugssUaLKY15tq1rmfP69oamY+Bhbeic+Qd47ax5e
        Dgogq3ihntUKqKZVx8ngvw0z2
X-Received: by 2002:a1c:44c:: with SMTP id 73mr14626326wme.45.1634748218264;
        Wed, 20 Oct 2021 09:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyskI6F6tpyfkeKyp/6lxfq7FKH295cWptvwtEdWAdiUXWIkhkaURm9qFvHAezwZNBEG4B8jw==
X-Received: by 2002:a1c:44c:: with SMTP id 73mr14626252wme.45.1634748217411;
        Wed, 20 Oct 2021 09:43:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id n17sm2380969wrq.11.2021.10.20.09.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:43:36 -0700 (PDT)
Message-ID: <7feaada9-7cc0-cb37-83ba-4e23d8ba3ade@redhat.com>
Date:   Wed, 20 Oct 2021 18:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [mm] 6128b3af2a: UBSAN:shift-out-of-bounds_in(null)
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20211019031407.GB7910@xsang-OptiPlex-9020>
 <87wnm9ovz2.fsf@disp2133> <99b496b7-c465-eac3-d7ad-18a615fe94a7@redhat.com>
 <20211020141341.GA22721@xsang-OptiPlex-9020>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211020141341.GA22721@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.21 16:13, Oliver Sang wrote:
> Hi, David, Hi, Eric,
> 
> On Wed, Oct 20, 2021 at 09:22:52AM +0200, David Hildenbrand wrote:
>> On 19.10.21 17:49, Eric W. Biederman wrote:
>>> kernel test robot <oliver.sang@intel.com> writes:
>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with clang-14):
>>>>
>>>> commit: 6128b3af2a5e42386aa7faf37609b57f39fb7d00 ("mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> I believe this failure is misattributed.  Perhaps your reproducer
>>> only intermittently reproduces the problem?
> 
> yes, we only reproduce the problem intermittently, those 9 instances are
> out of 115 runs.
> 8d0920bde5eb8ec7 6128b3af2a5e42386aa7faf3760
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :115          8%           9:115   dmesg.UBSAN:shift-out-of-bounds_in(null)    <--
> 
> 
>>>
>>> The change in question only contains
>>>
>>> 	flags &= ~MAP_DENYWRITE
>>>
>>> After all of the other users of MAP_DENYWRITE had been removed from the
>>> kernel.  So I don't see how it could possibly be responsible for the
>>> reported shift out of bounds problem.
>>>
>>> Eric
>>
>> Thanks for looking into this Eric while I spent the last couple of days
>> in bed feeling miserable. :)
>>
>>
>> So we get 9 new instances of "UBSAN:shift-out-of-bounds_in(null)" (NULL
>> pointer dereference) on 6128b3af2a compared to 6128b3af2a^ (8d0920bde5),
>> apparently inside ksys_mmap_pgoff() on 32bit.
>>
>> As we're dealing with a fuzzer, is there any reproducer as sometimes
>> provided by syzkaller? The report itself is not very helpful when
>> judging if that patch is actually responsible for what we're seeing.
>>
>> I agree with Eric that it's rather unlikely that when we stop masking
>> off a bit that's ignored throughout the kernel, that we suddenly trigger
>> a NULL pointer de-reference. But I learned that everything is possible ;)
> 
> 
> now we run parent 200 more times, the "UBSAN:shift-out-of-bounds_in(null)" (1)
> still cannot be reproduced on parent:
> 8d0920bde5eb8ec7 6128b3af2a5e42386aa7faf3760
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>             |             |             |
>          45:315        -11%           9:115   dmesg.BUG:kernel_NULL_pointer_dereference,address
>            :315          3%           8:115   dmesg.BUG:unable_to_handle_page_fault_for_address
>          45:315         -9%          17:115   dmesg.EIP:__ubsan_handle_shift_out_of_bounds <--(2)
>          45:315         -9%          17:115   dmesg.Kernel_panic-not_syncing:Fatal_exception
>          45:315         -9%          17:115   dmesg.Oops:#[##]
>            :315          3%           9:115   dmesg.UBSAN:shift-out-of-bounds_in(null)  <--(1)
>          45:315         -9%          17:115   dmesg.boot_failures
> 
> 
> however, from above (2), we found parent dmesg (attached) has similar
> Call Trace, which just does't have "UBSAN:shift-out-of-bounds_in(null)"
> things:
> [  272.487295][ T7295] BUG: kernel NULL pointer dereference, address: 0000000c
> [  272.488078][ T7295] #PF: supervisor read access in kernel mode
> [  272.488673][ T7295] #PF: error_code(0x0000) - not-present page
> [  272.489266][ T7295] *pde = 00000000
> [  272.489751][ T7295] Oops: 0000 [#1] SMP
> [  272.490165][ T7295] CPU: 1 PID: 7295 Comm: trinity-c2 Not tainted 5.14.0-00005-g8d0920bde5eb #1
> [  272.491122][ T7295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  272.492067][ T7295] EIP: __ubsan_handle_shift_out_of_bounds+0xe/0x350
> [  272.492760][ T7295] Code: 05 90 a6 c2 00 68 2a 54 00 68 2a 54 bd 4e 00 8d bd 4e 00 8d 00 00 66 90 00 00 66 90 57 56 83 ec 57 56 83 ec 89 c7 8b 48 89 c7 <8b> 48 8d\
>  b4 26 00 8d b4 26 00 75 b4 64 8b 75 b4 64 8b ca 83 bb 1c
> [  272.494890][ T7295] EAX: 00000000 EBX: c5d6cf38 ECX: 00000031 EDX: 00000000
> [  272.495686][ T7295] ESI: f138eb71 EDI: 00000000 EBP: f5a23f3c ESP: f5a23ec8
> [  272.496532][ T7295] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
> [  272.497383][ T7295] CR0: 80050033 CR2: 0000000c CR3: 3528d000 CR4: 000406d0
> [  272.498152][ T7295] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  272.498897][ T7295] DR6: fffe0ff0 DR7: 00000400
> [  272.499411][ T7295] Call Trace:
> [  272.499827][ T7295]  ? __lock_acquire+0x955/0xb80
> [  272.500361][ T7295]  ? rcu_lock_acquire+0x30/0x30
> [  272.500875][ T7295]  ? rcu_read_lock_sched_held+0x31/0x70
> [  272.501500][ T7295]  ksys_mmap_pgoff+0x1fd/0x290
> [  272.501990][ T7295]  __ia32_sys_mmap_pgoff+0x1c/0x30
> [  272.502512][ T7295]  do_int80_syscall_32+0x39/0x80
> [  272.503101][ T7295]  entry_INT80_32+0x10d/0x10d
> [  272.503624][ T7295] EIP: 0xb7f71a02
> [  272.504029][ T7295] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
> [  272.506044][ T7295] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: f138eb71
> [  272.506825][ T7295] ESI: c5d6cf38 EDI: ffffffff EBP: 00000000 ESP: bfca54d8
> [  272.507592][ T7295] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [  272.508417][ T7295] Modules linked in: aesni_intel crypto_simd qemu_fw_cfg autofs4
> [  272.509201][ T7295] CR2: 000000000000000c
> [  272.509704][ T7295] ---[ end trace 97b48cc676da14f9 ]---
> [  272.510293][ T7295] EIP: __ubsan_handle_shift_out_of_bounds+0xe/0x350
> [  272.511023][ T7295] Code: 05 90 a6 c2 00 68 2a 54 00 68 2a 54 bd 4e 00 8d bd 4e 00 8d 00 00 66 90 00 00 66 90 57 56 83 ec 57 56 83 ec 89 c7 8b 48 89 c7 <8b> 48 8d b4 26 00 8d b4 26 00 75 b4 64 8b 75 b4 64 8b ca 83 bb 1c
> [  272.513169][ T7295] EAX: 00000000 EBX: c5d6cf38 ECX: 00000031 EDX: 00000000
> [  272.513979][ T7295] ESI: f138eb71 EDI: 00000000 EBP: f5a23f3c ESP: f5a23ec8
> [  272.514800][ T7295] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
> [  272.515974][ T7295] CR0: 80050033 CR2: 0000000c CR3: 3528d000 CR4: 000406d0
> [  272.516787][ T7295] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  272.517619][ T7295] DR6: fffe0ff0 DR7: 00000400
> [  272.518105][ T7295] Kernel panic - not syncing: Fatal exception
> [  272.519566][ T7295] Kernel Offset: disabled
> 
> 
> as contrast, in fbc:
> [  126.758570][ T3293] ================================================================================
> [  126.758949][ T3293] UBSAN: shift-out-of-bounds in (null):0:0
> [  126.759174][ T3293] BUG: kernel NULL pointer dereference, address: 00000000
> [  126.759447][ T3293] #PF: supervisor read access in kernel mode
> [  126.759676][ T3293] #PF: error_code(0x0000) - not-present page
> [  126.759905][ T3293] *pde = 00000000
> [  126.760047][ T3293] Oops: 0000 [#1] SMP
> [  126.760205][ T3293] CPU: 1 PID: 3293 Comm: trinity-c4 Not tainted 5.14.0-00006-g6128b3af2a5e #1
> [  126.760541][ T3293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  126.760890][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
> [  126.761147][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66
> 83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
> [  126.761889][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
> [  126.762159][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
> [  126.762428][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [  126.762718][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
> [  126.762989][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  126.763259][ T3293] DR6: fffe0ff0 DR7: 00000400
> [  126.763436][ T3293] Call Trace:
> [  126.763562][ T3293]  ? rcu_lock_acquire+0x30/0x30
> [  126.763749][ T3293]  ? rcu_read_lock_sched_held+0x31/0x70
> [  126.763960][ T3293]  ksys_mmap_pgoff+0x1fc/0x290
> [  126.764146][ T3293]  __ia32_sys_mmap_pgoff+0x1c/0x30
> [  126.764343][ T3293]  do_int80_syscall_32+0x39/0x80
> [  126.764532][ T3293]  entry_INT80_32+0x10d/0x10d
> [  126.764709][ T3293] EIP: 0xb7fbda02
> [  126.764848][ T3293] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6
> 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
> [  126.765591][ T3293] EAX: ffffffda EBX: 00000000 ECX: 00001000 EDX: 55dd7eb6
> [  126.765859][ T3293] ESI: f0bd6374 EDI: ffffffff EBP: 00000000 ESP: bf9964d8
> [  126.766129][ T3293] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [  126.766419][ T3293] Modules linked in: aesni_intel crypto_simd qemu_fw_cfg autofs4
> [  126.766715][ T3293] CR2: 0000000000000000
> [  126.766894][ T3293] ---[ end trace e6000e119f0dc7f3 ]---
> [  126.767105][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
> [  126.767361][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66
> +83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
> [  126.768112][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
> [  126.768384][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
> [  126.768657][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [  126.768947][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
> [  126.769223][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  126.769496][ T3293] DR6: fffe0ff0 DR7: 00000400
> [  126.769680][ T3293] Kernel panic - not syncing: Fatal exception
> [  126.769946][ T3293] Kernel Offset: disabled
> 
> 
> basically, we just based on the diff to report out, but maybe need your education
> if this "UBSAN:shift-out-of-bounds_in(null)" diff really matter in this case.

The triggering code sequences are "ksys_mmap_pgoff+0x1fd/0x290" vs.
"ksys_mmap_pgoff+0x1fc/0x290", so my gut feeling is that we're dealing
with the same issue.

But I don't have an fully satisfactory explanation why we're getting
more often "address: 00000000" with that commit instead of via the
parent "address: 0000000c". Maybe simply because of changed code layout
"garbage" we're using to address is now "different garbage" :)


-- 
Thanks,

David / dhildenb

