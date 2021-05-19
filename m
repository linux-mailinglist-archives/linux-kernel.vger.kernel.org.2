Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898B8388713
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhESGBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhESGBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:01:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9271C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:00:22 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s12so136189qta.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JiXzyzkPMTe/8wWnjTU2U3zrx0gRkcj4O9Y3f0td/xA=;
        b=XcTQosF7mDtFSYBPQ93Ovbnf2+yHnChKIUPuSaJQJ2U2AbVJauzLS9KmD/MvS/uGeE
         Dh0JLX9uuSpQry1/VsOrgAwMtqveQPvYDDV3L5vkaTrp9VH+5LXkG4gubcxaWyzp6McZ
         aznBYL0FfJw2Lxu73PA8pO0f5F0vG5FVu5a+745h+0igKdWcj/XjbBGuO7Us0kjvIIr1
         D+JaYotPOuR1KvjfM/OMdDs3U9xSwClR+m8XVo9KujJ4L+bHCv/jYlFnsM1v6obg8aKJ
         5FchMn3KMsKy91jE4nyB1m87hjBFA5FAEyI32br/C1eGuJITzmeJ/98ITDmBtMHRvwd8
         QK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JiXzyzkPMTe/8wWnjTU2U3zrx0gRkcj4O9Y3f0td/xA=;
        b=DILHzvAy42xN/qpsNEH2BBlWlMT1wdEFFTXNeZFBIEzXE/klSljDcwXJilaL/tub0k
         bi7o10g5b31I9S2I9qCh83k1MFEsDemmCvP2ipmkigphuh5oXmuifeeB3ZZG4HzBTo62
         glGWOAnS2L658thyfIj/gONNHB6PEAyMeJNAXYjTEJbSOKFFqZSwX+wwe7QhB0/AZPWj
         yNvdnb2UGzhp/U5MCFaN812JgH5/P+vRiQtRfXueKcTMxLI1F6KCATpc0tlgZJOUHk4q
         +zXQOJ1jjhLjx2TZTNRgLOqNrOOh3zn4Q10BYcDJ0X1JAERKiGaRN3+4iJ3ugTU6bUhN
         NcDA==
X-Gm-Message-State: AOAM533olyIrzYKsY48QzKZZqwkOfpvmOH+/wUlBXduoMZ6jbSkdSzkw
        cxcH4qPtkLzLmbIjAXDa/r6fIJQRU3EvWYpy8I7jJw==
X-Google-Smtp-Source: ABdhPJwBrUNqxjuCjf+yv05aRStj7Nh4c6QWtUGepErv83OCyLAqXTvidGZDIOJfaTe1l2HMEYYAzlhbsTOda4fWzb0=
X-Received: by 2002:ac8:7c8a:: with SMTP id y10mr9169590qtv.337.1621404021607;
 Tue, 18 May 2021 23:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b2f48705c2a00f67@google.com>
In-Reply-To: <000000000000b2f48705c2a00f67@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 May 2021 08:00:10 +0200
Message-ID: <CACT4Y+adxfahPVwLxj=Grp7Uvu0grWK9-ecVMiOBo_uGUPnqiQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in handle_mm_fault
To:     syzbot <syzbot+44b5132ce1d2d712a574@syzkaller.appspotmail.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 9:53 PM syzbot
<syzbot+44b5132ce1d2d712a574@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d07f6ca9 Linux 5.13-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1772d265d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2302c3f03979672
> dashboard link: https://syzkaller.appspot.com/bug?extid=44b5132ce1d2d712a574
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+44b5132ce1d2d712a574@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:13795]

This is the issue with arm64 not using CONFIG_CMDLINE, the timeout
should be 10x larger.

#syz dup: BUG: soft lockup in do_wp_page (4)

> Modules linked in:
> irq event stamp: 2262
> hardirqs last  enabled at (2261): [<ffff8000144b1da8>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:63
> hardirqs last disabled at (2262): [<ffff8000144b2470>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:105
> softirqs last  enabled at (2200): [<ffff8000100109e0>] _stext+0x9e0/0x1084
> softirqs last disabled at (2117): [<ffff80001015e8d4>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (2117): [<ffff80001015e8d4>] invoke_softirq kernel/softirq.c:440 [inline]
> softirqs last disabled at (2117): [<ffff80001015e8d4>] __irq_exit_rcu+0x494/0x550 kernel/softirq.c:637
> CPU: 0 PID: 13795 Comm: syz-executor.1 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
> lr : clear_highpage include/linux/highmem.h:203 [inline]
> lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1238
> sp : ffff8000199874c0
> x29: ffff8000199874c0 x28: ffff00007fc13ec0 x27: 0000000000000000
> x26: ffff00000b47af00 x25: ffff60000168f5e0 x24: 00000000000014c0
> x23: ffff00000b479a40 x22: fffffc0000185bc0 x21: ffff80001560e558
> x20: dfff800000000000 x19: fffffc0000185b80 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 1ffff00003330e62 x13: 0000000000000001 x12: ffff7f8000030b77
> x11: 1fffff8000030b76 x10: ffff7f8000030b76 x9 : 0000000000000000
> x8 : ffff600000c2de00 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 1ffff000030ec350 x3 : 1fffe0000168f349
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff00000616ef40
> Call trace:
>  clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>  post_alloc_hook+0x108/0x21c mm/page_alloc.c:2350
>  prep_new_page mm/page_alloc.c:2358 [inline]
>  get_page_from_freelist+0x1998/0x235c mm/page_alloc.c:3994
>  __alloc_pages+0x1a8/0x21e0 mm/page_alloc.c:5200
>  alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2236
>  wp_page_copy+0x198/0x1720 mm/memory.c:2896
>  do_wp_page+0x1d8/0xbbc mm/memory.c:3203
>  handle_pte_fault mm/memory.c:4385 [inline]
>  __handle_mm_fault+0x10c8/0x26f0 mm/memory.c:4502
>  handle_mm_fault+0x1cc/0x4e0 mm/memory.c:4600
>  __do_page_fault arch/arm64/mm/fault.c:507 [inline]
>  do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:607
>  do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:821
>  el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:306
>  el0_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:427
>  el0_sync+0x198/0x1c0 arch/arm64/kernel/entry.S:734
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b2f48705c2a00f67%40google.com.
