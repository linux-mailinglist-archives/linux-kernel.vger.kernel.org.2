Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99D401F51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhIFRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243962AbhIFRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630950412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yy/d+dpM0hwuyQ8ts0heAqf8NyClBv+BSplS68XwY80=;
        b=VykkES8SiFuwEfy/HJJgzagDIfcgZns0ASyOAvM2ZydaeQ1Izz1vHxK/wc7ALIo7qK+eeU
        64Sz92oDsy7bEaKnC5KiW/rEvfF0IcRh+s/Oppji+eIhJ5LZo0Ne45BdeFPM/TknWGNBeU
        CMCXMr0AjxO6gY0cHuwFd0JnJW88PP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-z6nnj36-PYCTz0wXteye-Q-1; Mon, 06 Sep 2021 13:46:51 -0400
X-MC-Unique: z6nnj36-PYCTz0wXteye-Q-1
Received: by mail-wm1-f71.google.com with SMTP id p29-20020a1c545d000000b002f88d28e1f1so2570056wmi.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yy/d+dpM0hwuyQ8ts0heAqf8NyClBv+BSplS68XwY80=;
        b=J9J8n967TvkdIt1JH4Z5fTQJxoHSrYIVmBX8KA4RFoJqUmib58RNb9Mn9DMNh1Tn+X
         kzB6oqU7PsfKN/CE3FwSWKSTFUUfea5Zr6d6kbQkNCCv09M9CFTecDwYHX9j4ONUjJsa
         /7yzIexQkW0TJ009g/dDgc2opjUhm+Q4uO6vaS98IXcdlPPRvFVTq49TaG55UjSVY5lx
         H3ESj6Hr2xU3etv4WdCcFsMGQLwO5jv3NI8d89lpnAPEoX2tZQd+AsWy00UONPRxR0gj
         SUXBsOHmnFtLNcVXiUL2XClbdp86LM2SS/waSH9qwltMIo/8avAkC9TjI+VzsEToAZKQ
         IpZA==
X-Gm-Message-State: AOAM531iRuD6LDmTd1qyUp9lfcGwHFeEaqrDQWDhCjvv4WY39ngCTZvb
        Bds6NpKGZgKmIIRcESqUPtr5Yf2eByewk0REHIXrkhMRaYH9/9dV3HDXWGkNRcQtX72F5o2k/tT
        YMKn8g7tr5mJ7PuCfGCUzdOih
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr14441605wru.232.1630950410301;
        Mon, 06 Sep 2021 10:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRuKryyyH2QW7Qgl+joGoxSOAVw1ZsKVCdfgxmACzzryWxLN2sM+ZbFf95j9TzzTuFxMKdiQ==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr14441592wru.232.1630950410102;
        Mon, 06 Sep 2021 10:46:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id s205sm191448wme.4.2021.09.06.10.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:46:49 -0700 (PDT)
Subject: Re: [syzbot] BUG: soft lockup in handle_mm_fault (2)
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <00000000000063692b05cb493f6d@google.com>
 <20210906103309.f4152941a9a00a27f62dbc2b@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <59af1f1c-ae77-cfec-8d8c-32368f8ffdb6@redhat.com>
Date:   Mon, 6 Sep 2021 19:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210906103309.f4152941a9a00a27f62dbc2b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 19:33, Andrew Morton wrote:
> (cc's added)
> 
> On Sun, 05 Sep 2021 18:05:40 -0700 syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    49624efa65ac Merge tag 'denywrite-for-5.15' of git://githu..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eff4b3300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c598149362d97396
>> dashboard link: https://syzkaller.appspot.com/bug?extid=aa7a876b8108f1622bc3
>> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>> userspace arch: arm64
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com
>>
>> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:26449]
>> Modules linked in:
>> irq event stamp: 248
>> hardirqs last  enabled at (247): [<ffff8000145ed108>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
>> hardirqs last  enabled at (247): [<ffff8000145ed108>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
>> hardirqs last disabled at (248): [<ffff8000145ed0c0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
>> softirqs last  enabled at (182): [<ffff800010010964>] _stext+0x964/0xff8
>> softirqs last disabled at (41): [<ffff800010160f58>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
>> softirqs last disabled at (41): [<ffff800010160f58>] invoke_softirq kernel/softirq.c:439 [inline]
>> softirqs last disabled at (41): [<ffff800010160f58>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
>> CPU: 0 PID: 26449 Comm: syz-executor.1 Not tainted 5.14.0-syzkaller-09416-g49624efa65ac #0
>> Hardware name: linux,dummy-virt (DT)
>> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
>> lr : clear_highpage include/linux/highmem.h:181 [inline]
>> lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
>> sp : ffff800019be75e0
>> x29: ffff800019be75e0 x28: 0000000000000000 x27: 0000000000000000
>> x26: ffff000009d64940 x25: ffff6000013ac928 x24: 00000000000014c0
>> x23: ffff000009d63480 x22: fffffc0000173340 x21: ffff800015794a78
>> x20: dfff800000000000 x19: fffffc0000173300 x18: 0000000000000000
>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> x14: 1ffff0000337ce86 x13: 0000000000000013 x12: ffff7f800002e667
>> x11: 1fffff800002e666 x10: ffff7f800002e666 x9 : 0000000000000000
>> x8 : ffff600000b99a00 x7 : 0000000000000000 x6 : 000000000000003f
>> x5 : 0000000000000040 x4 : 1ffff00003060d98 x3 : 1fffe000013ac691
>> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005ccc880
>> Call trace:
>>   clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>>   kernel_init_free_pages mm/page_alloc.c:1283 [inline]
>>   post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
>>   prep_new_page mm/page_alloc.c:2436 [inline]
>>   get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
>>   __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
>>   alloc_pages_vma+0xbc/0x530 mm/mempolicy.c:2252
>>   alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:926
>>   do_anonymous_page mm/memory.c:3767 [inline]
>>   handle_pte_fault mm/memory.c:4556 [inline]
>>   __handle_mm_fault+0xbc4/0x2210 mm/memory.c:4693
>>   handle_mm_fault+0x1dc/0x4f0 mm/memory.c:4791
>>   __do_page_fault arch/arm64/mm/fault.c:499 [inline]
>>   do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:599
>>   do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:680
>>   do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:813
>>   el0_da+0x7c/0x2b0 arch/arm64/kernel/entry-common.c:481
>>   el0t_64_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:616
>>   el0t_64_sync+0x1a0/0x1a4 arch/arm64/kernel/entry.S:572

At first sight, looks unrelated. Being stuck in clear_page() is weird; 
we're running inside a VM ("dummy-virt"), whereby such stuck tasks in 
the guests are sometimes the result of the hypervisor being stuck (e.g., 
heavily overcommitted).

If we don't get a reproducer, that's most probably the root cause. Let's 
see.

-- 
Thanks,

David / dhildenb

