Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF54252EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhJGMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbhJGMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:25:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E1C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:23:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q205so6511661iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2JAbOu4iCNPv9BCnS4VkAc1VHOsGgK+od/5CGdbnoE4=;
        b=c/2iJMPmyHifXAI4ghchmsdw0yB600iusn6r+7ZQpzRV+SDvov6y6P2wzpygNZMzzi
         AQScjxMmXW9h2Wj3At5QqjwqnQhtSW1/6/qHo+2xMCskzg+4fO30ujqBVrMA1NOuuD6p
         tBmCnct+Hyh4xmxa3TD9jvUoYVSjjKSdx8mktjv5qr4lqw3lxWaz3pE7bdpFNeAYA7+2
         YJmukbtcLrL8vxOabEipyoLwuRU/n4jJs+nMqbvdunGgUWLPmBvgmdin5Q9+ZPy07zsY
         xmWwwkm+IuP7xhNKyNX+FcOXZISfR/LQrInH5I9HjV3JBANqZcQQY8XomSinOUFMzTgk
         UC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JAbOu4iCNPv9BCnS4VkAc1VHOsGgK+od/5CGdbnoE4=;
        b=1l24g2falvJpePFSi4GvHUYUS+s29a9GGBURL26wqulgjU6qQuqug2qvtoomtelIsO
         rl0reA2Fe7F/tK4NRUtE4LJe8z4nCheTwjyWGxIUPfpBEs+iyZo74r7ybS0T79Rmg0/J
         6uOAYg6TyuG4liTZZmKKcuN8XoZiWE4FXp6len69khG7FkvvFDRcylWdvh8WipMSsu4s
         O93i0JuiJybdxhiqgPpZv/Tb2mtg/+W7NSx6wxc4flRX98AaFMcGDnikqjOSUvsl3j1t
         HUniAL6rmOORpNLTn3IvGkDAYBqru1lpdWWMbVrkmaV1Nuc408gxPTu346yxNeya/tvj
         AWeQ==
X-Gm-Message-State: AOAM532OLFdrmtdQ/9h1XrQ5inYuoUcplaL8/AatsfIlHIlBnTP3G3eT
        +NrAW0vxvQ5oIwPb5yn0D4Pzng==
X-Google-Smtp-Source: ABdhPJxmUTWfz6LVHLv+t/Z3t4R+wcxwrc8vUIes4XMWLaZ7YTb/qWmi4eM1YxV+zIbtKuq66alGOA==
X-Received: by 2002:a6b:c94b:: with SMTP id z72mr2780152iof.101.1633609394330;
        Thu, 07 Oct 2021 05:23:14 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b6sm12703433iod.55.2021.10.07.05.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 05:23:13 -0700 (PDT)
Subject: Re: kernel BUG in block_invalidatepage
To:     Hao Sun <sunhao.th@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <CACkBjsZh7DCs+N+R=0+mnNqFZW8ck5cSgV4MpGM6ySbfenUJ+g@mail.gmail.com>
 <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31d403da-5940-064d-53cc-11423a9031d8@kernel.dk>
Date:   Thu, 7 Oct 2021 06:23:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 12:40 AM, Hao Sun wrote:
> Hello,
> 
> This crash can still be triggered repeatedly on the latest kernel.
> 
> HEAD commit: 60a9483534ed Merge tag 'warning-fixes-20211005'
> git tree: upstream
> kernel config: https://drive.google.com/file/d/1u-ncYGLkq3xqdlNQYJz8-G6Fhf3H-moP/view?usp=sharing
> 
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1514!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 3 PID: 25416 Comm: syz-executor Not tainted 5.15.0-rc4+ #22
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 fs/buffer.c:1514
> Code: ff ff e8 b4 fd d6 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 b1 25 84 e8 8b 1b c5 02 e9 c9 fe ff ff e8 91 fd d6 ff <0f> 0b
> e8 8a fd d6 ff 0f 0b e8 83 fd d6 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000538fa70 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0004518000 RCX: 0000000000000000
> RDX: ffff88810dd2a280 RSI: ffffffff8160943f RDI: ffffea0004518000
> RBP: ffffea0004518000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000538f908 R11: 0000000000000001 R12: ffffffff816091c0
> R13: ffffc9000538fb78 R14: 0000000000000000 R15: ffffc9000538fb00
> FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020590008 CR3: 000000000588a000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  do_invalidatepage mm/truncate.c:157 [inline]
>  truncate_cleanup_page+0x15c/0x280 mm/truncate.c:176
>  truncate_inode_pages_range+0x169/0xc20 mm/truncate.c:325
>  kill_bdev.isra.16+0x28/0x30 block/bdev.c:77
>  blkdev_flush_mapping+0x4c/0x130 block/bdev.c:658
>  blkdev_put_whole+0x54/0x60 block/bdev.c:689
>  blkdev_put+0x6f/0x210 block/bdev.c:953
>  blkdev_close+0x26/0x30 block/fops.c:460
>  __fput+0xdf/0x380 fs/file_table.c:280
>  task_work_run+0x86/0xd0 kernel/task_work.c:164
>  exit_task_work include/linux/task_work.h:32 [inline]
>  do_exit+0x4f1/0x11c0 kernel/exit.c:825
>  do_group_exit+0x57/0xe0 kernel/exit.c:922
>  get_signal+0x1d0/0x10b0 kernel/signal.c:2868
>  arch_do_signal_or_restart+0xa9/0x860 arch/x86/kernel/signal.c:865
>  handle_signal_work kernel/entry/common.c:148 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>  exit_to_user_mode_prepare+0xf2/0x280 kernel/entry/common.c:207
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
>  do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4196af
> Code: Unable to access opcode bytes at RIP 0x419685.
> RSP: 002b:00007faeee07b9c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000004196af
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000003 R15: 000000002059c040
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace bb86c370c06fa387 ]---
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 fs/buffer.c:1514
> Code: ff ff e8 b4 fd d6 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 b1 25 84 e8 8b 1b c5 02 e9 c9 fe ff ff e8 91 fd d6 ff <0f> 0b
> e8 8a fd d6 ff 0f 0b e8 83 fd d6 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000538fa70 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0004518000 RCX: 0000000000000000
> RDX: ffff88810dd2a280 RSI: ffffffff8160943f RDI: ffffea0004518000
> RBP: ffffea0004518000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000538f908 R11: 0000000000000001 R12: ffffffff816091c0
> R13: ffffc9000538fb78 R14: 0000000000000000 R15: ffffc9000538fb00
> FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f397f798010 CR3: 0000000012392000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554

Some more details would be nice here... What's being run to trigger
this?

-- 
Jens Axboe

