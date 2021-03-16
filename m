Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D233CF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhCPH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCPH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:59:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A06DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:59:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 30so9079865qva.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ond93pCr6waxZBJMQs8BaOSt8lF8DPOcwINSwpSZjqA=;
        b=Kc5RFIZ97SZEMzFph8JGA6tB4VK9ggB5gZKc3a9ijKcBqlSz1bHvGFhn/zWNgLIays
         II1SP9ahmnFNMgjbVVkecnHKf3WbyGY/W3RbNg8/Yhx4J0qEYTGIMV2fQnLoN49PUcQR
         RPQsKShnddrpKueySsmvDcb/NcEYjj/dPECZviRw+EJC7nqvO6wqkC2yMCyigaZLrwz/
         NaMqPrNXfz8R+qJOaihdDAImvAawfsK3w2Wm5JsboBo7gAklgViEHSBoDQ/u5Nie41XV
         TV057lJbpR3fBaiFlNJ6bXu/lB9z9dbemmCd8hs4TcQk4OqFYH0w5GxzzVSyHb8WBGh+
         tykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ond93pCr6waxZBJMQs8BaOSt8lF8DPOcwINSwpSZjqA=;
        b=hPznF5NgzAjlV7QcWPnV8kNB0EUSQbu9GwpPxVmRTpfUwnn7UoikNNrRzzwRqhpNYM
         UOiSfgj7cnxfCB3nMS3zM58CXg5qXjkH+Q/OFtwUgouFKdYcrlZkWzMFRyL15cujT3rO
         xZpsDytfLPBr0F2dV3myTteoyAGnY1LXKUqrQoVdTHu7Rj81PnjyJ8/0Xf9IudrpkP1W
         HzlpSeshCg/oXC/OsKdJpUr8qgaZ15WvB3essKtt3YdtohthAjHs5ItNKQDw1918RTd2
         IUFdPlCDkwoYlscvf9YAXsb5jaTdyxUI9dUXYJZlxVH/8YLqodC2/roRKj5RlY4pmX3W
         B+bQ==
X-Gm-Message-State: AOAM530hZVE6PS9Rn+iQhNTsCjk6xXO7xFdG+5F8k5xE+u7yV8kT8Dx8
        aZvgkaUFmWzFaV5JM9lUyXdYkmR42ermJ55TNrWKjw==
X-Google-Smtp-Source: ABdhPJzJQW6MWFhcAJwLea6jQsDJv0pIoULI83TosDFvBc9ieE7G3lZ56Bo1ZFxYmWEUovRDzsuYBoK4VTEli70hz8Q=
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr28831919qvq.37.1615881569217;
 Tue, 16 Mar 2021 00:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com>
In-Reply-To: <00000000000069802205bda22b7f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 08:59:17 +0100
Message-ID: <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 8:18 AM syzbot
<syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1e28eed1 Linux 5.12-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167535e6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0cee1f53de33ca3
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b06ef9b44d00d600183
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com

+arm32 maintainer
I think this is a real stack overflow on arm32, the stack is indeed deep.

> Kernel panic - not syncing: corrupted stack end detected inside scheduler
> CPU: 0 PID: 3263 Comm: syz-fuzzer Not tainted 5.12.0-rc3-syzkaller #0
> Hardware name: ARM-Versatile Express
> Backtrace:
> [<81802700>] (dump_backtrace) from [<81802974>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
>  r7:00000080 r6:60000093 r5:00000000 r4:82b58544
> [<8180295c>] (show_stack) from [<8180a048>] (__dump_stack lib/dump_stack.c:79 [inline])
> [<8180295c>] (show_stack) from [<8180a048>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
> [<81809f90>] (dump_stack) from [<81803508>] (panic+0x130/0x378 kernel/panic.c:231)
>  r7:81f4bdc0 r6:82a392a4 r5:00000000 r4:82c6b0d0
> [<818033d8>] (panic) from [<81820270>] (schedule_debug kernel/sched/core.c:4822 [inline])
> [<818033d8>] (panic) from [<81820270>] (__schedule+0xcb8/0xcc8 kernel/sched/core.c:4967)
>  r3:57ac6e9d r2:00040000 r1:81f5a53c r0:81f4bdc0
>  r7:00000001
> [<8181f5b8>] (__schedule) from [<8182046c>] (preempt_schedule_common+0x3c/0xac kernel/sched/core.c:5233)
>  r10:0000071f r9:ffefd000 r8:00000001 r7:81820510 r6:00000001 r5:81820510
>  r4:85888000
> [<81820430>] (preempt_schedule_common) from [<81820510>] (preempt_schedule+0x34/0x38 kernel/sched/core.c:5258)
>  r7:82c6a4e0 r6:00000001 r5:85888000 r4:df48d420
> [<818204dc>] (preempt_schedule) from [<8048c884>] (__kunmap_atomic include/linux/highmem-internal.h:114 [inline])
> [<818204dc>] (preempt_schedule) from [<8048c884>] (clear_highpage include/linux/highmem.h:204 [inline])
> [<818204dc>] (preempt_schedule) from [<8048c884>] (kernel_init_free_pages+0xc4/0xd0 mm/page_alloc.c:1212)
> [<8048c7c0>] (kernel_init_free_pages) from [<80492ce8>] (post_alloc_hook mm/page_alloc.c:2305 [inline])
> [<8048c7c0>] (kernel_init_free_pages) from [<80492ce8>] (prep_new_page mm/page_alloc.c:2311 [inline])
> [<8048c7c0>] (kernel_init_free_pages) from [<80492ce8>] (get_page_from_freelist+0x163c/0x1698 mm/page_alloc.c:3951)
>  r10:df48d3f0 r9:82bf89c0 r8:df48d3f0 r7:0000000b r6:00000002 r5:00000001
>  r4:df48d3f8 r3:00000001
> [<804916ac>] (get_page_from_freelist) from [<804933c8>] (__alloc_pages_nodemask+0x164/0x1850 mm/page_alloc.c:5001)
>  r10:00000000 r9:860a9a80 r8:00112cca r7:0000000b r6:00000081 r5:00000008
>  r4:00000000
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (__alloc_pages include/linux/gfp.h:525 [inline])
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (__alloc_pages_node include/linux/gfp.h:538 [inline])
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (alloc_pages_node include/linux/gfp.h:552 [inline])
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (alloc_pages include/linux/gfp.h:571 [inline])
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (__page_cache_alloc include/linux/pagemap.h:289 [inline])
> [<80493264>] (__alloc_pages_nodemask) from [<8042f0f8>] (page_cache_ra_unbounded+0xc4/0x294 mm/readahead.c:216)
>  r10:860a9a84 r9:860a9a80 r8:8588956c r7:0000000b r6:00000107 r5:85889688
>  r4:df48d3c0
> [<8042f034>] (page_cache_ra_unbounded) from [<8042f3c4>] (do_page_cache_ra+0xfc/0x150 mm/readahead.c:267)
>  r10:860a99ac r9:00000001 r8:00000020 r7:80000013 r6:8042f624 r5:85889688
>  r4:860a9908
> [<8042f2c8>] (do_page_cache_ra) from [<8042f624>] (ondemand_readahead+0x20c/0x47c mm/readahead.c:549)
>  r10:00000001 r9:000000fc r8:00000020 r7:000000dc r6:85889688 r5:00000000
>  r4:85aa8ea0
> [<8042f418>] (ondemand_readahead) from [<8042f958>] (page_cache_async_ra mm/readahead.c:607 [inline])
> [<8042f418>] (ondemand_readahead) from [<8042f958>] (page_cache_async_ra+0xc4/0x110 mm/readahead.c:581)
>  r10:85889818 r9:df4a4be0 r8:860a9a80 r7:85889714 r6:00000000 r5:85889688
>  r4:85aa8ea0
> [<8042f894>] (page_cache_async_ra) from [<80420d1c>] (page_cache_async_readahead include/linux/pagemap.h:863 [inline])
> [<8042f894>] (page_cache_async_ra) from [<80420d1c>] (filemap_readahead mm/filemap.c:2350 [inline])
> [<8042f894>] (page_cache_async_ra) from [<80420d1c>] (filemap_get_pages+0x254/0x648 mm/filemap.c:2391)
>  r7:85889714 r6:000000db r5:85889830 r4:000000dc
> [<80420ac8>] (filemap_get_pages) from [<804211d8>] (filemap_read+0xc8/0x4e0 mm/filemap.c:2458)
>  r10:85889818 r9:860a9908 r8:805ff484 r7:85889830 r6:00000000 r5:85889818
>  r4:85889830
> [<80421110>] (filemap_read) from [<80421788>] (generic_file_read_iter+0x198/0x234 mm/filemap.c:2609)
>  r10:00001000 r9:00000000 r8:805ff484 r7:00001000 r6:00000000 r5:85889818
>  r4:85889830
> [<804215f0>] (generic_file_read_iter) from [<805ff484>] (ext4_file_read_iter fs/ext4/file.c:130 [inline])
> [<804215f0>] (generic_file_read_iter) from [<805ff484>] (ext4_file_read_iter+0x54/0x118 fs/ext4/file.c:113)
>  r10:00001000 r9:00000000 r8:00001000 r7:85889888 r6:860a9908 r5:85889830
>  r4:85889818
> [<805ff430>] (ext4_file_read_iter) from [<804da4fc>] (__kernel_read+0x130/0x314 fs/read_write.c:454)
>  r7:85889888 r6:00000000 r5:00000000 r4:85aa8dc0
> [<804da3cc>] (__kernel_read) from [<8073774c>] (integrity_kernel_read+0x20/0x28 security/integrity/iint.c:191)
>  r9:00000000 r8:00400000 r7:83685000 r6:00000000 r5:85aa8dc0 r4:000db000
> [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_calc_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)
>  r10:860a99ac r9:00000000 r8:00000001 r7:00000013 r6:832fab90 r5:8570f900
>  r4:85aa8dc0
> [<8073ad08>] (ima_calc_file_hash) from [<8073c1a8>] (ima_collect_measurement+0x224/0x260 security/integrity/ima/ima_api.c:252)
>  r10:860a3344 r9:860a99c4 r8:858796e8 r7:00000003 r6:00000000 r5:858796e8
>  r4:85aa8dc0
> [<8073bf84>] (ima_collect_measurement) from [<80739458>] (process_measurement+0x46c/0x7b0 security/integrity/ima/ima_main.c:330)
>  r10:00000000 r9:860a99c4 r8:858796e8 r7:00000001 r6:00000001 r5:00000000
>  r4:85aa8dc0
> [<80738fec>] (process_measurement) from [<80739814>] (ima_file_check+0x78/0xa0 security/integrity/ima/ima_main.c:499)
>  r10:00000000 r9:00000000 r8:85aa8dc0 r7:00000000 r6:00000000 r5:85889d48
>  r4:00000006
> [<8073979c>] (ima_file_check) from [<804ec878>] (do_open fs/namei.c:3367 [inline])
> [<8073979c>] (ima_file_check) from [<804ec878>] (path_openat+0x20c/0x10f8 fs/namei.c:3498)
>  r7:85889e58 r6:82a3c59c r5:85889f20 r4:00020002
> [<804ec66c>] (path_openat) from [<804ef6ec>] (do_filp_open+0x7c/0x12c fs/namei.c:3525)
>  r10:00000142 r9:85888000 r8:80200224 r7:00000001 r6:85889f20 r5:85889e58
>  r4:85889f58
> [<804ef670>] (do_filp_open) from [<804d7a6c>] (do_sys_openat2+0xa8/0x160 fs/open.c:1187)
>  r7:ffffff9c r6:00000009 r5:8361b000 r4:85889f58
> [<804d79c4>] (do_sys_openat2) from [<804d7f10>] (do_sys_open fs/open.c:1203 [inline])
> [<804d79c4>] (do_sys_openat2) from [<804d7f10>] (__do_sys_openat fs/open.c:1219 [inline])
> [<804d79c4>] (do_sys_openat2) from [<804d7f10>] (sys_openat+0xa4/0xcc fs/open.c:1214)
>  r7:00000142 r6:00000000 r5:03af21c0 r4:ffffff9c
> [<804d7e6c>] (sys_openat) from [<80200060>] (ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64)
> Exception stack(0x85889fa8 to 0x85889ff0)
> 9fa0:                   00000000 00000000 ffffff9c 03af21c0 000a0002 000001a4
> 9fc0: 00000000 00000000 00000000 00000142 00000005 7fff6f7f 00c000e0 00a1f128
> 9fe0: 03af21c3 00e4cb78 00012368 000b7738
>  r5:00000000 r4:00000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Rebooting in 1 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000069802205bda22b7f%40google.com.
