Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE993C6DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhGMJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:54:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF51C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:51:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so1073861pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G05ynKIPKi1oJN3yPy5AvoQWFgL26tqGNRs3jXqC8rc=;
        b=lojnmhW3/8znkhXwT2Ii/0lUjlW2w6iU8/sdVvaA1XdQXCtQSX4VczJouOOjUBjUk+
         1W055avCpe50uIXM5ciFI5/V+873L8qktCGGOi3OdU1faN6KlKSZe0yIR19/mn5R385q
         ADhcrAyio2JuFQIGWgSIJIjgS00Zqct6+QXFN7vrD4J7votQMND/X30bPJkkT4+SJkgG
         YGTOj2brvc7HVgUAEJ4FiX4x/pAGBXDA3Rl4LVhRpGBObCKm2c7tICEa7Jc6fC2fKbqp
         wjIXl81AAuopB18v4nUL3ugCVDnk9QhMPgqrafBoDrV/RIxnlXYFJhT8StHm0rmjIGhz
         MO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G05ynKIPKi1oJN3yPy5AvoQWFgL26tqGNRs3jXqC8rc=;
        b=bChRG50rNd2UhsVoljhgylZYkBJxp2JUUUwE7CSExwDp2rCsHovP2mThyFCFpW/rKP
         Lv/rgL1QDjatFdEBQV4C7jaP1cSYHSIHWHmSAAt5V85ovYvaDN8/O9towSAVr3eot32V
         qxkKmzrAH+CR1MLH4bMGk9VzSnG4dFxgBLEKKtIKv5gWEaLh03gx4FKnU41OonQZyM6r
         rcqwjjqhS+tevxKUNF1Ubr7k4D3hQcznzF8ncdY0Sp0uolG7Z2LjrLrZcBrQ0MXaCHvm
         OqvjRjaFB4waZOhK2He72AHl6WGsM57VWPMt77oOGMDwjv2RZSrIypLmOl1i6K7iWeSz
         w42g==
X-Gm-Message-State: AOAM530wUaq7Hv0xeIUxNW763Fv+yrgxpfKF54P9jVxGNJzOp9llxuYM
        s9xkFJaDgvwiKUtaMSB4skU=
X-Google-Smtp-Source: ABdhPJxjmfELcFjcm6dLjJPmvc8BPKB9OKZbwX3P+C9VTJawYYF8QKIAC5aElBKzcD+Oz6Ecjmi8Fg==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr3570433pjb.99.1626169883669;
        Tue, 13 Jul 2021 02:51:23 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id f5sm18761261pfn.134.2021.07.13.02.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 02:51:23 -0700 (PDT)
Subject: Re: [syzbot] upstream test error: BUG: sleeping function called from
 invalid context in stack_depot_save
To:     Hillf Danton <hdanton@sina.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     syzbot <syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000009e7f6405c60dbe3b@google.com>
 <20210703041256.212-1-hdanton@sina.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <49b84cde-647d-c4ef-4eac-d99376bb600a@gmail.com>
Date:   Tue, 13 Jul 2021 17:51:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210703041256.212-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/21 12:12 pm, Hillf Danton wrote:
> On Thu, 1 Jul 2021 13:10:37 +0200 Dmitry Vyukov wrote:
>> On Thu, Jul 1, 2021 at 1:00 PM syzbot wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    dbe69e43 Merge tag 'net-next-5.14' of git://git.kernel.org..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1216d478300000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=47e4697be2f5b985
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e45919db2eab5e837646
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com
>>
>> +kasan-dev@ for for stack_depot_save warning
>>
>>> BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
>>> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8436, name: syz-fuzzer
>>> INFO: lockdep is turned off.
>>> irq event stamp: 0
>>> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>> hardirqs last disabled at (0): [<ffffffff814406db>] copy_process+0x1e1b/0x74c0 kernel/fork.c:2061
>>> softirqs last  enabled at (0): [<ffffffff8144071c>] copy_process+0x1e5c/0x74c0 kernel/fork.c:2065
>>> softirqs last disabled at (0): [<0000000000000000>] 0x0
>>> CPU: 1 PID: 8436 Comm: syz-fuzzer Tainted: G        W         5.13.0-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:79 [inline]
>>>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>>>   ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>>>   prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>>>   __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>>>   alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
>>>   stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>>>   save_stack+0x15e/0x1e0 mm/page_owner.c:120
>>>   __set_page_owner+0x50/0x290 mm/page_owner.c:181
>>>   prep_new_page mm/page_alloc.c:2445 [inline]
>>>   __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>>>   alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>>>   vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>>>   __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>>>   __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>>>   __vmalloc_node mm/vmalloc.c:2996 [inline]
>>>   vzalloc+0x67/0x80 mm/vmalloc.c:3066
>>>   n_tty_open+0x16/0x170 drivers/tty/n_tty.c:1914
>>>   tty_ldisc_open+0x9b/0x110 drivers/tty/tty_ldisc.c:464
>>>   tty_ldisc_setup+0x43/0x100 drivers/tty/tty_ldisc.c:781
>>>   tty_init_dev.part.0+0x1f4/0x610 drivers/tty/tty_io.c:1461
>>>   tty_init_dev include/linux/err.h:36 [inline]
>>>   tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
>>>   tty_open+0xb16/0x1000 drivers/tty/tty_io.c:2150
>>>   chrdev_open+0x266/0x770 fs/char_dev.c:414
>>>   do_dentry_open+0x4c8/0x11c0 fs/open.c:826
>>>   do_open fs/namei.c:3361 [inline]
>>>   path_openat+0x1c0e/0x27e0 fs/namei.c:3494
>>>   do_filp_open+0x190/0x3d0 fs/namei.c:3521
>>>   do_sys_openat2+0x16d/0x420 fs/open.c:1195
>>>   do_sys_open fs/open.c:1211 [inline]
>>>   __do_sys_openat fs/open.c:1227 [inline]
>>>   __se_sys_openat fs/open.c:1222 [inline]
>>>   __x64_sys_openat+0x13f/0x1f0 fs/open.c:1222
>>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> One of the quick fixes is move preparing new page out of the local lock (with
> irq disabled) if it is difficult to add changes in saving stack.
> 
> +++ x/mm/page_alloc.c
> @@ -5231,6 +5231,7 @@ unsigned long __alloc_pages_bulk(gfp_t g
>   	gfp_t alloc_gfp;
>   	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>   	int nr_populated = 0, nr_account = 0;
> +	LIST_HEAD(head);
>   
>   	if (unlikely(nr_pages <= 0))
>   		return 0;
> @@ -5308,17 +5309,29 @@ unsigned long __alloc_pages_bulk(gfp_t g
>   			break;
>   		}
>   		nr_account++;
> -
> -		prep_new_page(page, 0, gfp, 0);
> -		if (page_list)
> -			list_add(&page->lru, page_list);
> -		else
> -			page_array[nr_populated] = page;
> +		list_add(&page->lru, &head);
>   		nr_populated++;
>   	}
>   
>   	local_unlock_irqrestore(&pagesets.lock, flags);
>   
> +	list_for_each_entry(page, &head, lru)
> +		prep_new_page(page, 0, gfp, 0);
> +
> +	if (page_list)
> +		list_splice(&head, page_list);
> +	else {
> +		int i;
> +
> +		for (i = 0; i < nr_pages && !list_empty(&head); i++) {
> +			/* Skip existing pages */
> +			if (page_array[i])
> +				continue;
> +			page = list_first_entry(&head, struct page, lru);
> +			list_del_init(&page->lru);
> +			page_array[i] = page;
> +		}
> +	}
>   	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>   	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
>   
> 

I believe this particular bug should be fixed by Mel Gorman's patch that 
was added into Andrew Morton's -mm tree (mm/page_alloc: Avoid page 
allocator recursion with pagesets.lock held):
https://lore.kernel.org/lkml/20210708081434.GV3840@techsingularity.net/

With the patch, we avoid recursing into stack_depot_save while holding 
onto the local lock.

Best wishes,
Desmond
