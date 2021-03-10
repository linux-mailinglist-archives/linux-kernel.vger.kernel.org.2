Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38708333671
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhCJHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhCJHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:33:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63304C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:33:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e7so31870112lft.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d25lunF52I2d+HwAf6vLh2UeB4dI+4X5OmemShJ2/Ss=;
        b=TAdzsQHqlfJrqSMB7FDoVHYA9xhamOZB1ElXiUimCcZJ1SVXFYSaNsfBdQ/HpXDRj2
         MwCgSMN+paV5GC4IdhDdzWwsHzleIN5qoVrMTPDvousD/WARE5k73RAtFWtGM2fzLoTA
         4rRLh4DMOWpCSB3fXd2i7eX6iNbwc6o///W1ywkvh+rvjwIP0UUUWU8qaNzT7ht+FWAI
         2YmXAxY0lJF6X01uIS8oR/Vh2Y1nElfibHyiMasjhyAp8XClK8fnIgAtbvx2ozWKO/r5
         jHegHOYsZJfeKMoqHKxoSrgwL9G9z1NOOhXbnXg6RmncoF2fdHTtAtMJLbSq48ZHthqO
         RC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d25lunF52I2d+HwAf6vLh2UeB4dI+4X5OmemShJ2/Ss=;
        b=ojNWcGUDOXUosg2J6wVUVtuzwo3SWlad4gZMXKP8jHU691ISfKcqxkPnfjTnVq7lTg
         4/Do/4whnp8a5HCYY8s63Ig5Dwgp07ttCztIdhnlRfqI6NcDF84yRm4p5mgG3qKDV9pG
         JazMNBzPpr947OzKu3DF2iD+faeZ7zTa4fHp6EkG8HGCMl3ZPR6EVZmy+TrajX0Seobr
         wchOUf1ei8VlWWlgP1dbscuTzXNNSRnkBOyxMXcx5pA6sy3clzfhu0fieItPi8SW6rSW
         LG39+bg9IwcQCUfrODrVqSFXWBG5ov4a4GE8b5x0sL5zOa2hId9CW5arVzMROWp/lW1u
         GgPA==
X-Gm-Message-State: AOAM533+L2nhf9fYz7jqhwkuv6KV2wtX+4ms4qfG7M6JWEwpe1q2RDZ7
        kDbmV/Z63aehJNlYpb+jzTzjEh/jlZ16EqgD4ow=
X-Google-Smtp-Source: ABdhPJyU8EKDZ+7+xGo5OXDAmXNLiyRKd/MFw+PQT4OjZC9Tbmx0Jgr90fPeCpJuVzm9Y0KAIXKYqEyi5oEOyglFBZU=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr1255454lfn.391.1615361598796;
 Tue, 09 Mar 2021 23:33:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk> <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
 <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk> <CACT4Y+Z==NtH2K6pxN8w90cbczffF+wYbcTgTdbBczeBk5n1aw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z==NtH2K6pxN8w90cbczffF+wYbcTgTdbBczeBk5n1aw@mail.gmail.com>
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Wed, 10 Mar 2021 13:03:07 +0530
Message-ID: <CAGyP=7dLJMX0JW4bKAhRWNNCzggGnc8twvnFOxdkduz7J5gJGw@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 8:36 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> FWIW the code looks reasonable:
>
> All code
> ========
>    0: 00 00                add    %al,(%rax)
>    2: 00 00                add    %al,(%rax)
>    4: 41 57                push   %r15
>    6: 41 56                push   %r14
>    8: 41 55                push   %r13
>    a: 41 54                push   %r12
>    c: 55                    push   %rbp
>    d: 53                    push   %rbx
>    e: 89 fd                mov    %edi,%ebp
>   10: 48 81 ec 48 01 00 00 sub    $0x148,%rsp
>   17: 64 48 8b 04 25 28 00 mov    %fs:0x28,%rax
>   1e: 00 00
>   20: 48 89 84 24 38 01 00 mov    %rax,0x138(%rsp)
>   27: 00
>   28: 31 c0                xor    %eax,%eax
>   2a:* e8 f5 bf f7 ff        callq  0xfffffffffff7c024 <-- trapping instruction
>   2f: 83 f8 01              cmp    $0x1,%eax
>   32: 0f 84 b7 00 00 00    je     0xef
>   38: 48                    rex.W
>   39: 8d                    .byte 0x8d
>   3a: 9c                    pushfq
>   3b: 40                    rex
>
> This is a PC-relative call to a reasonable address, right?
> I wonder if it always traps on this instruction or not. Maybe the
> executable is corrupted and has a page missing in the image or
> something similar. But also if we suspect a badly corrupted image, is
> it worth pursuing it?...

I copied over a new systemd binary from a fresh disk image generated
using  tools/create-image.sh in syzkaller (debootstrap) and the bug
was still reproducible.
root@sandbox:~# md5sum /lib/systemd/systemd
12b20bfd8321ef7884b4dbf974a91213  /lib/systemd/systemd
root@sandbox:~# md5sum /lib/systemd/systemd_orig
12b20bfd8321ef7884b4dbf974a91213  /lib/systemd/systemd_orig

root@sandbox:~# gcc -pthread hax.c -o repro
root@sandbox:~# ./repro
[  115.515840] got to 221
[  115.515853] got to 183
[  115.516400] got to 201
[  115.516935] got to 208
[  115.517475] got to 210
[  115.521008] got to 270
[  115.544984] systemd[1]: segfault at 7ffe972adfb8 ip
00005560fb079466 sp 00007ffe972adfc0 error 6 in
systemd[5560fafcd000+ed000]
[  115.546554] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
[  115.548575] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[  115.549352] CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.2+ #22
[  115.549994] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-1 04/01/2014
[  115.550834] Call Trace:
[  115.551090]  dump_stack+0xb2/0xe4
[  115.551438]  panic+0x196/0x502
[  115.551798]  do_exit.cold+0x70/0x108
[  115.552170]  do_group_exit+0x78/0x120
[  115.552552]  get_signal+0x22e/0xd60
[  115.552916]  arch_do_signal_or_restart+0xef/0x890
[  115.553407]  exit_to_user_mode_prepare+0x102/0x190
[  115.553920]  irqentry_exit_to_user_mode+0x9/0x20
[  115.554412]  irqentry_exit+0x19/0x30
[  115.554781]  exc_page_fault+0xc3/0x240
[  115.555168]  ? asm_exc_page_fault+0x8/0x30
[  115.555626]  asm_exc_page_fault+0x1e/0x30
[  115.556092] RIP: 0033:0x5560fb079466
[  115.556476] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
[  115.558399] RSP: 002b:00007ffe972adfc0 EFLAGS: 00010246
[  115.558947] RAX: 0000000000000000 RBX: 00005560fcaa7f40 RCX: 00007ff6fb1c22e3
[  115.559720] RDX: 00007ffe972ae140 RSI: 00007ffe972ae270 RDI: 0000000000000007
[  115.560475] RBP: 0000000000000007 R08: 431bde82d7b634db R09: 000000000000000b
[  115.561219] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe97aad190
[  115.561963] R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
[  115.562768] Kernel Offset: disabled
[  115.563148] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

For sanity, I created a new disk image altogether, made a replica of
the image and ran syzkaller on the first copy of the image to find a
new reproducer for this bug.
[NEW IMAGE]                     [NEW IMAGE REPLICA]
Used by syzkaller                Used for testing the reproducer manually
After discovering the new reproducer for this fresh image, I triggered
the new reproducer on the *untainted* replica of the image and the bug
was reproducible.
This would invalidate the assumption that the image/binaries on the
image are corrupted.
