Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E940F361
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbhIQHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbhIQHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:38:52 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD4C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:37:31 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so2937184oon.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQOBAzx61rxkAJlbfySF/J/85hdhSWWhYmV+y8XbxvE=;
        b=pUoAu88SY8U1MOfSP6sDOznVRZ7O9qkqubIKlZmrDRC9OYjqM6aco+z6mu+vSNHYCx
         i8/CSdKH2JR1uPYrwJ66v7cKQr/ORNOdp4y+gVjf1RS69RQxPdaVM6+PGW6yflpvuSmN
         JmjyZxxTK2EkW4IldxIF3rZZMRNK8sy5BVJIZZ0Cft+LQVf7UDKX1qmQuJ8UrEvTXB2P
         z+gR5MYxtSB9roVemY75n8wRu3YscVtAaPGBDISBHiOfhoYOv1lY9MIifaXqrYZTH24O
         Z+HkLaoIrdTS7woh/cpiiU1Uyc+pSiR004I8M7ThOxfPHxmwSk26YeI6oAvvJU3ZnE2Q
         DdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQOBAzx61rxkAJlbfySF/J/85hdhSWWhYmV+y8XbxvE=;
        b=3k77clgaZvkq2kNqD0S8/clFm60evXq89urWXcdIEk+GAg4ZK8GrEH9SMBHnG3tGiU
         2QAqToSpfgUhMsdSyvgnYP3/N6tge4yLyym+zBLVV7OQdFcdrjOaNFvOe4iBIMcgGZZO
         EBOnnNOomkEzRDfjRW75vYZ1voYsi/3PwxaRQYLHU5zImKtOpLtHR/PaaKEMjMEkXPoz
         LMO/Nr6nCiqP99VfsYX4eyKUFUehTWGRz9Zf7dZ7PjM3z/WacPm+g4nRBfHOTbUJXTX6
         qidN22mlmxLyG9CRmMAmcV+5MFh5MrBo1Gcj65+VNRGwleduRXv1EPyYmJ7V+rDJd+08
         nA/Q==
X-Gm-Message-State: AOAM533uOO7i0SNoejyegaSYX4aiDbUJYnbcV0pKxH9R9aAW9G17rJb+
        ZNXa0WgRoa7OBLsfHupstfuUxlnlC3xXNSdG0dq8DA==
X-Google-Smtp-Source: ABdhPJzKu9jnN9LF4n9wXd3gr6Z0XobhD4/UPpM0onxRRWMNR54YLtcukQcBG9X8BDHtc+AfVCoSZGY6KAK8la/PBb0=
X-Received: by 2002:a4a:b64b:: with SMTP id f11mr7779543ooo.18.1631864250191;
 Fri, 17 Sep 2021 00:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006f0bec05cc2be7dc@google.com>
In-Reply-To: <0000000000006f0bec05cc2be7dc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 09:37:19 +0200
Message-ID: <CACT4Y+Y_o8LLXF5ZmEZka3ypfJBuM0JsyyyM=iy857HMN4YHvw@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in call_usermodehelper_exec_async
To:     syzbot <syzbot+c3963f4f025fa5dfb78b@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 09:30, syzbot
<syzbot+c3963f4f025fa5dfb78b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=135dbd12300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=548fbb1e84c1808e
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3963f4f025fa5dfb78b
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c3963f4f025fa5dfb78b@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [kworker/u4:5:21352]
> Modules linked in:
> irq event stamp: 196
> hardirqs last  enabled at (195): [<ffff80001457eb88>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:71
> hardirqs last disabled at (196): [<ffff80001457eb40>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:113
> softirqs last  enabled at (116): [<ffff8000100109a4>] _stext+0x9a4/0x1050
> softirqs last disabled at (51): [<ffff800010161d30>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (51): [<ffff800010161d30>] invoke_softirq kernel/softirq.c:439 [inline]
> softirqs last disabled at (51): [<ffff800010161d30>] __irq_exit_rcu+0x470/0x520 kernel/softirq.c:636
> CPU: 1 PID: 21352 Comm: kworker/u4:5 Not tainted 5.14.0-rc2-syzkaller-00001-g8cae8cd89f05 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
> lr : clear_highpage include/linux/highmem.h:184 [inline]
> lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1283
> sp : ffff800018c67380
> x29: ffff800018c67380 x28: 0000000000000000 x27: ffff00007fc11ec0
> x26: ffff00000fe7aef8 x25: ffff600001fcf5df x24: 00000000000014b8
> x23: ffff00000fe79a40 x22: fffffc0000171340 x21: ffff800015706c40
> x20: dfff800000000000 x19: fffffc0000171300 x18: ffff00006aa70bc8
> x17: ffff800055045000 x16: ffff800018598000 x15: ffff000010dd0600
> x14: 1ffff0000318ce3a x13: 0000000000000014 x12: ffff7f800002e267
> x11: 1fffff800002e266 x10: ffff7f800002e266 x9 : 0000000000000000
> x8 : ffff600000b89a00 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 1ffff0000304db70 x3 : 1fffe00001fcf349
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005c4ca40
> Call trace:
>  clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>  kernel_init_free_pages mm/page_alloc.c:1280 [inline]
>  post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2423
>  prep_new_page mm/page_alloc.c:2433 [inline]
>  get_page_from_freelist+0x1840/0x2310 mm/page_alloc.c:4166
>  __alloc_pages+0x1a8/0x2234 mm/page_alloc.c:5388
>  alloc_pages_vma+0xb4/0x4dc mm/mempolicy.c:2208
>  alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:939
>  do_anonymous_page mm/memory.c:3767 [inline]
>  handle_pte_fault mm/memory.c:4547 [inline]
>  __handle_mm_fault+0xcbc/0x25e4 mm/memory.c:4684
>  handle_mm_fault+0x1dc/0x4ec mm/memory.c:4782
>  faultin_page mm/gup.c:951 [inline]
>  __get_user_pages+0x3e4/0x744 mm/gup.c:1173
>  __get_user_pages_locked mm/gup.c:1359 [inline]
>  __get_user_pages_remote+0x10c/0x500 mm/gup.c:1865
>  get_user_pages_remote+0x28/0x40 mm/gup.c:1938
>  get_arg_page+0x9c/0x1bc fs/exec.c:220
>  copy_string_kernel+0x170/0x294 fs/exec.c:631
>  kernel_execve+0x1ac/0x380 fs/exec.c:1961
>  call_usermodehelper_exec_async+0x260/0x460 kernel/umh.c:112
>  ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:782

+linux-arm-kernels

This is caused by broken CONFIG_CMDLINE support on arm64, for context see:
https://lore.kernel.org/lkml/CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com/

syzbot should use 150s stall timeout, but it got's default 20s which
produces false positive flakes.

#syz dup: BUG: soft lockup in handle_mm_fault (2)
