Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121035ECA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhDNF4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhDNF4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:56:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB199C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:56:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e13so10530475qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpmBcb5+riYcQ09lMoWDWD17po/qBOnbM3ovsGdVcCI=;
        b=CZGYoCfV6X3u4WS3IyOIPOIfaLqdtwbBfhzw1cLbiY63OqV49QsU/vkWzpUSDypmdM
         JSg2VMRQ1G1SjOVn9LdYZBy3CBd6DjDFRx+62xU+/TOiAByV5nPCp/MxFKRhPT4pc4Bg
         GkcxC80nzLq4eXDE+uKZ1K593Od7H8vZcdL1XxRZ/8C8r9mUcJG1DhQTO79byTgAlYWH
         jmA3GzX66p9Wwg1AT4xyJTg6DhbbzVGRS4afb52z/E4R/ubku1WllHwHFCqYH/xAVysJ
         QeVgtRmUMvDR0AaJBC/uJEaCJBIeqC3BkB6Vo6ALVX6AFtM6aBP17HrANXe6nbTgRUlx
         Wl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpmBcb5+riYcQ09lMoWDWD17po/qBOnbM3ovsGdVcCI=;
        b=m/7hluwbMskYPSPnlrqCJJzFLT3nFCi/sAiFv80txoFVoOgYGnw18SrzJYO9YTvk0X
         p3rg2QvTmHljwR64x2dYOWMOX+5WTIXm4RC4MJyjp4VvFd+oKgtRSmx9ZhZQS3nGtXvB
         PSpvfjFHOdTwCuMRMD4sdPGsQl6BBrGhIdKb2ItQwLsVNylIjgIhmYsk3SLBHp75ehjP
         zrPW0tdCMQe3u8NCBj3HPnz23oUL3boP5G0Qb8vQafys9MjxVUjaGlRUMOMpWccGDNfc
         0J+e9tJECRbUYnPkTI7iZeVggUZ+Z6jYMoU0Y2Ib7H9f4IctWf7VvEcWT99YgYP/Cyu+
         FIIQ==
X-Gm-Message-State: AOAM532OxA5fkaVDReeXf6zeBsqz2/3dB0znn4CLktJjrOLPBpeuuXXy
        ZDkR+6bVp28yFnj0IuuWC1kN3dES/f3KRkleSIH7eg==
X-Google-Smtp-Source: ABdhPJyh9eOCRNmyeCJlLv8tMlSLBvToq5IFa6Z6IO7DjEqb5ZELI1ItA7hEiaKTPf0Qqn1qTFhbFdXl7omzzhO68Jk=
X-Received: by 2002:a05:620a:243:: with SMTP id q3mr16596179qkn.501.1618379784650;
 Tue, 13 Apr 2021 22:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009862e005bfe859c8@google.com>
In-Reply-To: <0000000000009862e005bfe859c8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Apr 2021 07:56:13 +0200
Message-ID: <CACT4Y+YxAC3uV8UFKFn3mDiCGdo=z9xwSKS_SK+rRA+8=4RpuQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in get_wchan
To:     syzbot <syzbot+0806291048161061627c@syzkaller.appspotmail.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>, chenhuang5@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 7:52 AM syzbot
<syzbot+0806291048161061627c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b2b3d18f riscv: Make NUMA depend on MMU
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b59d16d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81b3e7c68dad6e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0806291048161061627c
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0806291048161061627c@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in walk_stackframe arch/riscv/kernel/stacktrace.c:60 [inline]
> BUG: KASAN: use-after-free in get_wchan+0x156/0x196 arch/riscv/kernel/stacktrace.c:136
> Read of size 8 at addr ffffffe0058e3d90 by task syz-executor.0/4667
>
> CPU: 1 PID: 4667 Comm: syz-executor.0 Not tainted 5.12.0-rc5-syzkaller-00721-gb2b3d18fc20e #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffe000009706>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
> [<ffffffe002a5f182>] dump_backtrace+0x40/0x4e arch/riscv/kernel/stacktrace.c:113
> [<ffffffe002a5f1b2>] show_stack+0x22/0x2e arch/riscv/kernel/stacktrace.c:118
> [<ffffffe002a68a3e>] __dump_stack lib/dump_stack.c:79 [inline]
> [<ffffffe002a68a3e>] dump_stack+0x148/0x1d8 lib/dump_stack.c:120
> [<ffffffe0003bc802>] print_address_description.constprop.0+0x52/0x31e mm/kasan/report.c:232
> [<ffffffe0003bcd24>] __kasan_report mm/kasan/report.c:399 [inline]
> [<ffffffe0003bcd24>] kasan_report+0x16e/0x18c mm/kasan/report.c:416
> [<ffffffe0003bd588>] check_region_inline mm/kasan/generic.c:180 [inline]
> [<ffffffe0003bd588>] __asan_load8+0x6e/0x80 mm/kasan/generic.c:253
> [<ffffffe000009a98>] walk_stackframe arch/riscv/kernel/stacktrace.c:60 [inline]

If it's walking the stack of another task, then it needs to use
READ_ONCE_NOCHECK. See x86/arm64/s390 for examples:
https://elixir.bootlin.com/linux/v5.12-rc7/A/ident/READ_ONCE_NOCHECK

> [<ffffffe000009a98>] get_wchan+0x156/0x196 arch/riscv/kernel/stacktrace.c:136
> [<ffffffe000553364>] proc_pid_wchan+0x48/0xa4 fs/proc/base.c:390
> [<ffffffe000554458>] proc_single_show+0x9c/0x13c fs/proc/base.c:774
> [<ffffffe00045000c>] seq_read_iter+0x2e0/0x8f2 fs/seq_file.c:227
> [<ffffffe00045081e>] seq_read+0x200/0x298 fs/seq_file.c:159
> [<ffffffe0003f9210>] vfs_read+0x108/0x2ac fs/read_write.c:494
> [<ffffffe0003f9724>] ksys_read+0xb4/0x1b8 fs/read_write.c:634
> [<ffffffe0003f9850>] __do_sys_read fs/read_write.c:644 [inline]
> [<ffffffe0003f9850>] sys_read+0x28/0x36 fs/read_write.c:642
> [<ffffffe000005572>] ret_from_syscall+0x0/0x2
>
> The buggy address belongs to the page:
> page:ffffffcf0216b8c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x85ae3
> flags: 0xffe000000000000()
> raw: 0ffe000000000000 ffffffcf0216b8c8 ffffffcf0216b8c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffffffe0058e3c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffffffe0058e3d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffffffe0058e3d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                          ^
>  ffffffe0058e3e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffffffe0058e3e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009862e005bfe859c8%40google.com.
