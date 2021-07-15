Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849F03CAE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhGOV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:27:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:25:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m68so6648642qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DaVOmq+ky2aKlTbXjlJhgQnevRQejh0VwTRZ+HloBa8=;
        b=qJDnpRxofz2Hlo+gMfuGdUi8cOn0gUzAo5zLObGWaUn0j69A8qkGUB/TMXnj2zEmqq
         iFNypCFhhALMlb4j0IK3VcHsSgMzzEyOYFQLfLC840MWbZncLkhXNeXIhQ3dHDYJTg+L
         2gA1NNlElqRjk5d1DitMI7xjdRgYTs6aJDvLPWt7NSPYKSZ7M1aDkk8X4Qp0sV+3QPUX
         HGsqeS+g45r7KGArB9mkNTugXZntHaV0wL53qN0ywcN1qMhkVWB/3AbTYB2nwNyeiH94
         C8b2YJbcNhE9dWKbXFuYUHToxrz2PhK/bhhKYhCa38RYUZ2LJi/QOGQp73eei0sNX3vc
         QaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DaVOmq+ky2aKlTbXjlJhgQnevRQejh0VwTRZ+HloBa8=;
        b=i8vTG6XWz+1hTThsB5Nzj6dwr44bBRkzmXOWCFzWJGQSshINLLZeBAQwFhAXd4b/5a
         6dSHE/QN+oWbC3Eroh21LSzvHYyH8ymNftSh2gJ6hmvPLDkFgqZLFK4LbnpzEDyH/OPD
         McIQIgkr4VPuf5mvdMpXsHR6mkzeBdbdgEC+La3eZxS+Ltz7gyH+A2dSzMWJiy9+FqWh
         l0qQUDTOouf7SHiUzv9jDiLdheb7KaSxlyU3X0eh1mkACIwxu6ncGgQsPZ+G928uP+Yg
         4oCiasGN3s5OtiR38khgnqqPKpsZPzb/7y4JRZdcBDW3N0KeLUUjX1AM9eE4h4yQyhw9
         PBUQ==
X-Gm-Message-State: AOAM533hq0P51RO5akjbu53dtDf2HqTI+i7+dZhGyCeHaTxwCvCxGbIw
        w632Q98ant74kFjteHYJWxqOMQ==
X-Google-Smtp-Source: ABdhPJwCGg3Vz/WiK9xLxoYGia0a9otTss3FNqvg493xwQyPxZMjwBDtoYgzp5yfizE9X0EdnIxeUg==
X-Received: by 2002:a37:a8e:: with SMTP id 136mr5911478qkk.498.1626384302874;
        Thu, 15 Jul 2021 14:25:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 16sm2479145qty.15.2021.07.15.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:25:02 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:24:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     syzbot <syzbot+2e3ee45ea14cd0b81f26@syzkaller.appspotmail.com>
cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 munlock_vma_pages_range
In-Reply-To: <0000000000001e294505c72eec63@google.com>
Message-ID: <2613cb2-2a80-2077-c16e-9618dcb69c9f@google.com>
References: <0000000000001e294505c72eec63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98f7fdced2e0 Merge tag 'irq-urgent-2021-07-11' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13576e9c300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=da2203b984f4af9f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e3ee45ea14cd0b81f26
> compiler:       Debian clang version 11.0.1-2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2e3ee45ea14cd0b81f26@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at mm/mlock.c:482

Fixed by
023e1a8dd502 ("mm/rmap: fix new bug: premature return from page_mlock_one()")
which went into the tree soon after the HEAD shown above
(but was posted before any syzbot report, so contained no syzbot tag).

> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14373, name: syz-executor.5
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 PID: 14373 Comm: syz-executor.5 Tainted: G        W         5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1d3/0x29f lib/dump_stack.c:105
>  ___might_sleep+0x4e5/0x6b0 kernel/sched/core.c:9154
>  munlock_vma_pages_range+0xa80/0xf60 mm/mlock.c:482
>  mlock_fixup+0x40f/0x580 mm/mlock.c:552
>  apply_mlockall_flags mm/mlock.c:768 [inline]
>  __do_sys_munlockall+0x1ef/0x310 mm/mlock.c:810
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f448bc37188 EFLAGS: 00000246 ORIG_RAX: 0000000000000098
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007ffe7eb2d2ef R14: 00007f448bc37300 R15: 0000000000022000
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
