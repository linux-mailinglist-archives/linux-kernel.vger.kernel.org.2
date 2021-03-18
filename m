Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D8340E50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhCRTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhCRTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:34:28 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id by2so3801190qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHWc+9paIoDWKhQDFQzfEWCvxztwOe9Bfis8yySP4PM=;
        b=lK7zqWA/Lv+6zWiZl58NgPGF0GXOk+bdmx41H9TPhpYuhY57N8c0DnCCngIpJkEznH
         zpqedVCzSZZF4uMw4ugGcA6DBgUC7aHkYKa0gWdnho8xUOVWrHiEz+MdMac+UUeDH+8N
         Rekd1Hl2G0R0eJSCnt5e/bz1ILfEpQ1n1DtYBAQdB5r15nC2/QLbdgX0Hmijkfftx9N3
         3QUAXtoMemNfyB0euwap0Fo6LVFIqvPjauwqavpXTUqwEJUIX1GOY2fR7nLkgGBbSKBh
         bbxGSNi8MxcIMVqNRH6lT6UYVkBtZTEbW5zDMCGzyWuOxSpOoLsoUrKY70eqGQ/uP1TP
         UkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHWc+9paIoDWKhQDFQzfEWCvxztwOe9Bfis8yySP4PM=;
        b=oz2sWk1ryi1hHu9zXsNwTvCD/AguKQxub3dOwhYwRFGk36wMNkRXY7zrG6RSDlUbMP
         79ZDOnMMWjMZTnfxU/dl1GNgHkZe50OVBgV3mz1euUHEAZYPJbEFME6phfJuds+JMscb
         mm/ljylF0oqYuSONw7uPpL4kBwW4DtDTjEWL1Q4i35dKE6QtsCNxXEtj96eGPPU3Kstl
         OMMq0RbfVLwIIb3reSCc7PTZgeJE1b/8aKcUnbrYjYBsypqwns3hYp5Qqb8fSuaP4plE
         Q9RwL7aW6RS/IZcIO6vCfgLxWfkm9nvel5WZ0sTiXv+tTxUP648vCxbsQQt9orexwl/I
         Yuog==
X-Gm-Message-State: AOAM532JvAZPdb65LqXikmQkvWYxLkysJnyC6z/uLTB3GX9QzAtEHPCc
        Df6OeWNT9yk+gjIc+toViS5MyfxCcF5N2KWn6GQ8rumaPNtprg==
X-Google-Smtp-Source: ABdhPJwIYBJyOg+lFGLytkT1q5QjlPOdelWYM4ig+cLSIRfmI/0nftCT2wrKhgZJdNEUQsQBVQl+vItL3rk93tKTpG0=
X-Received: by 2002:ad4:410d:: with SMTP id i13mr5869119qvp.44.1616096067800;
 Thu, 18 Mar 2021 12:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce4c9505bdd4a48f@google.com>
In-Reply-To: <000000000000ce4c9505bdd4a48f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 20:34:16 +0100
Message-ID: <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in do_wp_page (4)
To:     syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 8:31 PM syzbot
<syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]

+Will, arm

If I am reading this commit correctly, this is caused by:

commit cae118b6acc309539b33339e846cbb19187c164c
Author: Will Deacon
Date:   Wed Mar 3 13:49:27 2021 +0000
    arm64: Drop support for CMDLINE_EXTEND

syzbot passes lots of critical things in CONFIG_CMDLINE:
https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
but also wants the bootloader args to be appended.
What is the way to do it now?




> Modules linked in:
> irq event stamp: 10067468
> hardirqs last  enabled at (10067467): [<ffff8000143de478>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:59
> hardirqs last disabled at (10067468): [<ffff8000143deb40>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:101
> softirqs last  enabled at (10067362): [<ffff8000100109e0>] _stext+0x9e0/0x1084
> softirqs last disabled at (10067297): [<ffff80001015976c>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (10067297): [<ffff80001015976c>] invoke_softirq kernel/softirq.c:228 [inline]
> softirqs last disabled at (10067297): [<ffff80001015976c>] __irq_exit_rcu+0x46c/0x510 kernel/softirq.c:422
> CPU: 0 PID: 3684 Comm: syz-executor.1 Not tainted 5.12.0-rc3-syzkaller-00036-gbf152b0b41dc #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
> lr : clear_highpage include/linux/highmem.h:203 [inline]
> lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1212
> sp : ffff00000c6cf4a0
> x29: ffff00000c6cf4a0 x28: fffffc0000180b00
> x27: ffff00007fc13ec0 x26: ffff00000b709458
> x25: ffff6000016e128b x24: 0000000000001458
> x23: ffff00000b708000 x22: fffffc0000180b40
> x21: ffff8000154e2938 x20: dfff800000000000
> x19: fffffc0000180b00 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 1fffe000018d9e5e
> x13: 0000000000000001 x12: ffff7f8000030167
> x11: 1fffff8000030166 x10: ffff7f8000030166
> x9 : 0000000000000000 x8 : ffff600000c05a00
> x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 1ffff00002fa5748
> x3 : 1fffe000016e1001 x2 : 0000000000000004
> x1 : 0000000000000040 x0 : ffff00000602ce00
> Call trace:
>  clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>  post_alloc_hook+0x130/0x1fc mm/page_alloc.c:2305
>  prep_new_page mm/page_alloc.c:2311 [inline]
>  get_page_from_freelist+0x2024/0x2a40 mm/page_alloc.c:3951
>  __alloc_pages_nodemask+0x2a0/0x24dc mm/page_alloc.c:5001
>  alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2240
>  wp_page_copy+0x198/0x16e0 mm/memory.c:2853
>  do_wp_page+0x1d8/0xbbc mm/memory.c:3160
>  handle_pte_fault mm/memory.c:4336 [inline]
>  __handle_mm_fault+0x1020/0x21d4 mm/memory.c:4453
>  handle_mm_fault+0x1cc/0x4dc mm/memory.c:4551
>  __do_page_fault arch/arm64/mm/fault.c:507 [inline]
>  do_page_fault+0x228/0x880 arch/arm64/mm/fault.c:591
>  do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:805
>  el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:308
>  el0_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:435
>  el0_sync+0x170/0x180 arch/arm64/kernel/entry.S:699
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ce4c9505bdd4a48f%40google.com.
