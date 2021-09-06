Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFCC402061
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhIFTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhIFTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630956012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEHc56k7ZFIBpjFDov8p4EWeaCiKlIL9gEWlSxoICMg=;
        b=bHSbcv4Qxi2XadRdSMcVO6ntveZCa0L/taEdEZ8sBdGHwED4+mOOaGNxM9/LLTFlRya7c7
        NDrbDB4MULH+Oz1jOuNyyBjwLNVy4h7aum06aQvykC7I4XGymbKW+S9uD/+bmvOSNHmM5T
        ql8TBHQFOXPXEGy+72WHqb4TdXYzk4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-XpKN5b-QO5a7b_Gtk0dHug-1; Mon, 06 Sep 2021 15:20:11 -0400
X-MC-Unique: XpKN5b-QO5a7b_Gtk0dHug-1
Received: by mail-wm1-f71.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so103554wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rEHc56k7ZFIBpjFDov8p4EWeaCiKlIL9gEWlSxoICMg=;
        b=MJ39k/UGSAtsYb+WWvJS518VIaRnCZwC3rLDX8rq7ij9hv6V5gxeZj61IbZ778y4JX
         9L2KvB1S/+H9TFnF9XLIqsqvU+1CbVuvl8z3ZNGen6c5KNcRC7jFKMkQXuzu7Ssb/4mN
         uPqPQGbxPzFGEHF8LzCwmcVZK23J10WMxQK0Q+he7OGosjCZyWv1UFmd+8qETm5b4CDD
         Wv/BLBZhosz+Ys+w9EDm+C9utKp9UTS9yXM/nPxlEjql6FY5FzvH/Yv7evvuniDFz2SJ
         IiT8FMA9jULxTV4t1azyPbzwr3orWODNd5L+K5ee53hgaL4ZC5aiKbZfAD49FB7sVLr4
         IcwQ==
X-Gm-Message-State: AOAM531zOTl5sMgRAmxlbW/L46odS9uUJ1AflYovGxxAgRI4BRTVCPFD
        Lz+6OQSZOnriiVH2IZ9pKeb+T6UvkClHWUHC3CteL6f6uKxEYcqk5VGJdausJw8MOMkQcud5y/S
        0PNWpyQUQGy0xC+ijUkQiqC7x
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr14911475wrx.335.1630956010357;
        Mon, 06 Sep 2021 12:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfNeKWWGiCxGjrk6wfcQ0gagAcVjp2TJJiioLGI6ohLpGWa/Ko6B9trweEm0tzFElvsoKgsw==
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr14911463wrx.335.1630956010093;
        Mon, 06 Sep 2021 12:20:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id r25sm7919454wrc.26.2021.09.06.12.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 12:20:09 -0700 (PDT)
To:     Guenter Roeck <linux@roeck-us.net>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [syzbot] BUG: soft lockup in handle_mm_fault (2)
Message-ID: <6d7ea31d-66af-84e5-1db0-9cbbb634f649@redhat.com>
Date:   Mon, 6 Sep 2021 21:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bc9f68b7-6db0-0d02-090e-1d28c2124ad6@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 20:53, Guenter Roeck wrote:
> On 9/6/21 10:46 AM, David Hildenbrand wrote:
>> On 06.09.21 19:33, Andrew Morton wrote:
>>> (cc's added)
>>>
>>> On Sun, 05 Sep 2021 18:05:40 -0700 syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com> wrote:
>>>
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    49624efa65ac Merge tag 'denywrite-for-5.15' of git://githu..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eff4b3300000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c598149362d97396
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=aa7a876b8108f1622bc3
>>>> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>>>> userspace arch: arm64
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com
>>>>
>>>> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:26449]
>>>> Modules linked in:
>>>> irq event stamp: 248
>>>> hardirqs last  enabled at (247): [<ffff8000145ed108>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
>>>> hardirqs last  enabled at (247): [<ffff8000145ed108>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
>>>> hardirqs last disabled at (248): [<ffff8000145ed0c0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
>>>> softirqs last  enabled at (182): [<ffff800010010964>] _stext+0x964/0xff8
>>>> softirqs last disabled at (41): [<ffff800010160f58>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
>>>> softirqs last disabled at (41): [<ffff800010160f58>] invoke_softirq kernel/softirq.c:439 [inline]
>>>> softirqs last disabled at (41): [<ffff800010160f58>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
>>>> CPU: 0 PID: 26449 Comm: syz-executor.1 Not tainted 5.14.0-syzkaller-09416-g49624efa65ac #0
>>>> Hardware name: linux,dummy-virt (DT)
>>>> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
>>>> lr : clear_highpage include/linux/highmem.h:181 [inline]
>>>> lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
>>>> sp : ffff800019be75e0
>>>> x29: ffff800019be75e0 x28: 0000000000000000 x27: 0000000000000000
>>>> x26: ffff000009d64940 x25: ffff6000013ac928 x24: 00000000000014c0
>>>> x23: ffff000009d63480 x22: fffffc0000173340 x21: ffff800015794a78
>>>> x20: dfff800000000000 x19: fffffc0000173300 x18: 0000000000000000
>>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>> x14: 1ffff0000337ce86 x13: 0000000000000013 x12: ffff7f800002e667
>>>> x11: 1fffff800002e666 x10: ffff7f800002e666 x9 : 0000000000000000
>>>> x8 : ffff600000b99a00 x7 : 0000000000000000 x6 : 000000000000003f
>>>> x5 : 0000000000000040 x4 : 1ffff00003060d98 x3 : 1fffe000013ac691
>>>> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005ccc880
>>>> Call trace:
>>>>    clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>>>>    kernel_init_free_pages mm/page_alloc.c:1283 [inline]
>>>>    post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
>>>>    prep_new_page mm/page_alloc.c:2436 [inline]
>>>>    get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
>>>>    __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
>>>>    alloc_pages_vma+0xbc/0x530 mm/mempolicy.c:2252
>>>>    alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:926
>>>>    do_anonymous_page mm/memory.c:3767 [inline]
>>>>    handle_pte_fault mm/memory.c:4556 [inline]
>>>>    __handle_mm_fault+0xbc4/0x2210 mm/memory.c:4693
>>>>    handle_mm_fault+0x1dc/0x4f0 mm/memory.c:4791
>>>>    __do_page_fault arch/arm64/mm/fault.c:499 [inline]
>>>>    do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:599
>>>>    do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:680
>>>>    do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:813
>>>>    el0_da+0x7c/0x2b0 arch/arm64/kernel/entry-common.c:481
>>>>    el0t_64_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:616
>>>>    el0t_64_sync+0x1a0/0x1a4 arch/arm64/kernel/entry.S:572
>>
>> At first sight, looks unrelated. Being stuck in clear_page() is weird; we're running inside a VM ("dummy-virt"), whereby such stuck tasks in the guests are sometimes the result of the hypervisor being stuck (e.g., heavily overcommitted).
>>
> Unrelated to your series, yes, because it was first reported after commit ebf435d3b51b
> ("Merge tag 'staging-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging")
> which predates your series.
> 
>> If we don't get a reproducer, that's most probably the root cause. Let's see.
>>
> 
> That seems unlikely. The problem was seen 8 times by now, starting September 2.

.. always in a similar setup? (even the same hypervisor involved ?)

I've seen these exact symptoms

a) when the hypervisor was heavily overcommitting
b) the hypervisor was using uffd (e.g., for psotcopy live migration) and 
not properly resolving faults in user space for the VM process

It would happen when the VM would first access some yet unpopulated page 
in the hypervisor.

But obviously, could be something else, especially once we spot it on 
real HW. But it smells like the VM is slow.


I can spot: 
https://groups.google.com/g/syzkaller-bugs/c/l6RsKu3FhT0/m/7we3AMNxAAAJ

"This is also due to arm64 removal of CMDLINE support.
syzbot sets watchdog_thresh=165, but this fired after 22s. "

and there, it was also "dummy-virt" ... so maybe really a 
slow/overloaded hypervisor.

-- 
Thanks,

David / dhildenb

