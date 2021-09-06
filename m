Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4B402105
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhIFVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhIFVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 17:13:09 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFCC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 14:12:02 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso10250103otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3BYjk6UCABzgfhpa13DCMqGWNU4bi0bpYOlCKs8Hqko=;
        b=RYDLV28zbOwsoT+C4MSA2mk/XschIQgxME6ygbBF9hQSP9AN07edN49qCdlBYfpWCj
         vqNm0R56RFjSL00hX/gkhUNp/Kv1tqnlG2scR1qBioId9SDngpF9nNkSyi2lSBTFY2Jb
         S8Fs4VBsRK1PoGR0iozHcgQhFZ47N2iAVh4bbcj4EvmfvnHKoaspG4sMbhhISFPHQRx6
         67bp2hgRdMBIJ3WFRQrQ8Q+PnZSDMT556ELUPErcUMqUBNlHEDW9lNKrTrzzXCcOC9IP
         zJ6z+FwkuN4Yvp2h8fNzVPjluYFhMnY9kSZ6wWb1vJz2rFk/phd98fWUOhhNQqCjD+/I
         a0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BYjk6UCABzgfhpa13DCMqGWNU4bi0bpYOlCKs8Hqko=;
        b=Ej/6BqZlKbGjSooSivWP4HClDWqO8FKwhVN+MN53WBbuGHVF+K1bzUhtgqQrN4k9mb
         pkeIIaHRrpRhm6Q+YhmexbYO7jQyHNshMVrynK4cgvAtAEmxOnywd0JNXOyHRK2fG+Ai
         TNYRJ6znUuybhhgK2BOIhCZCFINPcJmqCAvHzpBY+eYUpYE7YBACa8EILB2WACsdkqEA
         DNEc3S8+2H+m3lOCHTJJtIe5l4SoXVDMJutptSuSYqoMhmiN6kIZSZTKUy6SDQRQedR6
         qoMpO27AcjS8twclSGXbclPnc9Apy4mJkSuzzvVAE6cjyPvnpxl0xioIROryPcey1k+L
         OPqw==
X-Gm-Message-State: AOAM532PXrEJ9ULSRqTaSD+05Cmq8iGbNWb2hSv0k8YMkez3yJuRhSqV
        5DadlFa0/XAa2iYobhP2bKshAGMyTlU=
X-Google-Smtp-Source: ABdhPJyDbbTB1Jg7fm/VhzQ0cgeuwrHgfighJ3aM3U3MrNSJBx2HqT4gAtixN1p4+CPB3Y/jM2wKaQ==
X-Received: by 2002:a05:6830:156:: with SMTP id j22mr11992646otp.75.1630962721982;
        Mon, 06 Sep 2021 14:12:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f33sm1968647otf.0.2021.09.06.14.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 14:12:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in handle_mm_fault (2)
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <00000000000063692b05cb493f6d@google.com>
 <20210906103309.f4152941a9a00a27f62dbc2b@linux-foundation.org>
 <59af1f1c-ae77-cfec-8d8c-32368f8ffdb6@redhat.com>
 <bc9f68b7-6db0-0d02-090e-1d28c2124ad6@roeck-us.net>
 <6d7ea31d-66af-84e5-1db0-9cbbb634f649@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8574c83d-9623-7c7e-9213-322d6b0064ca@roeck-us.net>
Date:   Mon, 6 Sep 2021 14:11:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d7ea31d-66af-84e5-1db0-9cbbb634f649@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 12:20 PM, David Hildenbrand wrote:
> On 06.09.21 20:53, Guenter Roeck wrote:
>> On 9/6/21 10:46 AM, David Hildenbrand wrote:
>>> On 06.09.21 19:33, Andrew Morton wrote:
>>>> (cc's added)
>>>>
>>>> On Sun, 05 Sep 2021 18:05:40 -0700 syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com> wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    49624efa65ac Merge tag 'denywrite-for-5.15' of git://githu..
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eff4b3300000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c598149362d97396
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=aa7a876b8108f1622bc3
>>>>> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>>>>> userspace arch: arm64
>>>>>
>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com
>>>>>
>>>>> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:26449]
>>>>> Modules linked in:
>>>>> irq event stamp: 248
>>>>> hardirqs last  enabled at (247): [<ffff8000145ed108>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
>>>>> hardirqs last  enabled at (247): [<ffff8000145ed108>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
>>>>> hardirqs last disabled at (248): [<ffff8000145ed0c0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
>>>>> softirqs last  enabled at (182): [<ffff800010010964>] _stext+0x964/0xff8
>>>>> softirqs last disabled at (41): [<ffff800010160f58>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
>>>>> softirqs last disabled at (41): [<ffff800010160f58>] invoke_softirq kernel/softirq.c:439 [inline]
>>>>> softirqs last disabled at (41): [<ffff800010160f58>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
>>>>> CPU: 0 PID: 26449 Comm: syz-executor.1 Not tainted 5.14.0-syzkaller-09416-g49624efa65ac #0
>>>>> Hardware name: linux,dummy-virt (DT)
>>>>> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
>>>>> lr : clear_highpage include/linux/highmem.h:181 [inline]
>>>>> lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
>>>>> sp : ffff800019be75e0
>>>>> x29: ffff800019be75e0 x28: 0000000000000000 x27: 0000000000000000
>>>>> x26: ffff000009d64940 x25: ffff6000013ac928 x24: 00000000000014c0
>>>>> x23: ffff000009d63480 x22: fffffc0000173340 x21: ffff800015794a78
>>>>> x20: dfff800000000000 x19: fffffc0000173300 x18: 0000000000000000
>>>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>> x14: 1ffff0000337ce86 x13: 0000000000000013 x12: ffff7f800002e667
>>>>> x11: 1fffff800002e666 x10: ffff7f800002e666 x9 : 0000000000000000
>>>>> x8 : ffff600000b99a00 x7 : 0000000000000000 x6 : 000000000000003f
>>>>> x5 : 0000000000000040 x4 : 1ffff00003060d98 x3 : 1fffe000013ac691
>>>>> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005ccc880
>>>>> Call trace:
>>>>>    clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>>>>>    kernel_init_free_pages mm/page_alloc.c:1283 [inline]
>>>>>    post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
>>>>>    prep_new_page mm/page_alloc.c:2436 [inline]
>>>>>    get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
>>>>>    __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
>>>>>    alloc_pages_vma+0xbc/0x530 mm/mempolicy.c:2252
>>>>>    alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:926
>>>>>    do_anonymous_page mm/memory.c:3767 [inline]
>>>>>    handle_pte_fault mm/memory.c:4556 [inline]
>>>>>    __handle_mm_fault+0xbc4/0x2210 mm/memory.c:4693
>>>>>    handle_mm_fault+0x1dc/0x4f0 mm/memory.c:4791
>>>>>    __do_page_fault arch/arm64/mm/fault.c:499 [inline]
>>>>>    do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:599
>>>>>    do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:680
>>>>>    do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:813
>>>>>    el0_da+0x7c/0x2b0 arch/arm64/kernel/entry-common.c:481
>>>>>    el0t_64_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:616
>>>>>    el0t_64_sync+0x1a0/0x1a4 arch/arm64/kernel/entry.S:572
>>>
>>> At first sight, looks unrelated. Being stuck in clear_page() is weird; we're running inside a VM ("dummy-virt"), whereby such stuck tasks in the guests are sometimes the result of the hypervisor being stuck (e.g., heavily overcommitted).
>>>
>> Unrelated to your series, yes, because it was first reported after commit ebf435d3b51b
>> ("Merge tag 'staging-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging")
>> which predates your series.
>>
>>> If we don't get a reproducer, that's most probably the root cause. Let's see.
>>>
>>
>> That seems unlikely. The problem was seen 8 times by now, starting September 2.
> 
> .. always in a similar setup? (even the same hypervisor involved ?)
> 
> I've seen these exact symptoms
> 
> a) when the hypervisor was heavily overcommitting
> b) the hypervisor was using uffd (e.g., for psotcopy live migration) and not properly resolving faults in user space for the VM process
> 
> It would happen when the VM would first access some yet unpopulated page in the hypervisor.
> 
> But obviously, could be something else, especially once we spot it on real HW. But it smells like the VM is slow.
> 
> 
> I can spot: https://groups.google.com/g/syzkaller-bugs/c/l6RsKu3FhT0/m/7we3AMNxAAAJ
> 
> "This is also due to arm64 removal of CMDLINE support.
> syzbot sets watchdog_thresh=165, but this fired after 22s. "
> 
> and there, it was also "dummy-virt" ... so maybe really a slow/overloaded hypervisor.
> 
Ah yes, obviously that error is not new. I stand corrected.

Thanks,
Guenter
