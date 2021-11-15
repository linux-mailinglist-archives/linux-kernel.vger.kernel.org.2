Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B744FFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhKOIT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbhKOISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:18:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C31C061766
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:15:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so12379516pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Zx0JexWN78+aLucFVGROnoItZj24Fq4poxKW9W1qD8=;
        b=P3UEjiz0e9jctqppDRNKPpPqmOnJUOsfCD3Z7bZIAuogOjp1r/10vJABJgqbxRZOax
         Rf8oBiHyLTwstsCQH4LgmdhRdGi4T50wnS9jxMEmCl4xdUz3Gzex6pzMZ1N2kABY7iqc
         jKLiDl0idL5bgx09ja5ZI5X5gs4dQz84F5Xw8MYM+Zmt47Ti3qTR9fNpFTcYJwMyDhG+
         TVogZgxANOJFcP7JDItvWDY2Q8h4ZUtP6wmlxHakaKBhuEi/eDZc/XiCE7YKh8C/CNn1
         yf8MIVd/Eq0E1k22/mmdQmfjCqy0UqqeCO7gFLW+WBJUzCQ6X+xcQNSa9SzJw95DqIQv
         CZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Zx0JexWN78+aLucFVGROnoItZj24Fq4poxKW9W1qD8=;
        b=O2CMKTTaKKrY/vC8Q+qwgFuyXORie+kM9PdGvX03mDAAG5bijpl+03yMG3qVap7yYw
         YyRwKRK1rh+xy7zoAnIClaJqVshOXlHUOCgMhiuaqDkeAGJlkFwiEX/JtCwViYSSHkow
         NykfEurOn170P5DP2zxLCIp2oRYIpBKLNkj6Y7av/6eiVUryPLlXfdoWz4v5t7fQeFWd
         rkikix1eJ3/NZEILDhSAcHm6Zj7nwIX9p3qF3xVVWkOHEJ06zuQdk85oXh7xsfj72UD2
         nJ6O0vBeN+WrCs17hsbPOdoVKj4tdAJclPTfsvnf/eRC1H41I09Awci3mg5eR9jYpROH
         ymjw==
X-Gm-Message-State: AOAM5304Q/u3gnbAjJ/2rqo3g7iDD7/7Urno2O/UbWmSH7g0wi6SCEZA
        SOoh8SikFka/AbLZrrGo8FpCcHN0lfxJSjR5Hdk=
X-Google-Smtp-Source: ABdhPJwMgEJgDaqhfmTRQ0zz/+Lh+L/1O9PpNf/4Uox4xCmvNcQhx4NuMzA0QBilvr1X844N8+/vgMmU5L+SSdY28rc=
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr62567482pjb.96.1636964150945;
 Mon, 15 Nov 2021 00:15:50 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000ff7d605d0b76901@google.com>
In-Reply-To: <0000000000000ff7d605d0b76901@google.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 15 Nov 2021 16:15:24 +0800
Message-ID: <CAEVVKH8FXmthqxmEP_0qhpT7uqfzgWhWAmJbKNEznm0TN6TmQw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __get_free_pages
To:     syzbot <syzbot+23a02c7df2cf2bc93fa2@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
8ab77458790

commit 0921cbb7e62f2aac73da86fff458814d9b0a846b (HEAD)
Author: Xiongwei Song <sxwjean@gmail.com>
Date:   Mon Nov 15 16:06:19 2021 +0800

    floppy: Add max size check for user space request

    We need to check the max request size that is from user space before
    allocating pages. If the request size exceeds the limit, return -EINVAL.

    Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c4267da716fe..52112ed59dd0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3081,6 +3081,8 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
        }
 }

+#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
+
 static int raw_cmd_copyin(int cmd, void __user *param,
                                 struct floppy_raw_cmd **rcmd)
 {
@@ -3108,7 +3110,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
        ptr->resultcode = 0;

        if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
-               if (ptr->length <= 0)
+               if (ptr->length <= 0 || ptr->length >= MAX_LEN)
                        return -EINVAL;
                ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
                fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);


Regards,
Xiongwei

On Sun, Nov 14, 2021 at 11:37 AM syzbot
<syzbot+23a02c7df2cf2bc93fa2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    debe436e77c7 Merge tag 'ext4_for_linus' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bca72ab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=23a02c7df2cf2bc93fa2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+23a02c7df2cf2bc93fa2@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 current_gfp_context include/linux/sched/mm.h:195 [inline]
> WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 __alloc_pages+0x45d/0x500 mm/page_alloc.c:5356
> Modules linked in:
> CPU: 3 PID: 16525 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:__alloc_pages+0x45d/0x500 mm/page_alloc.c:5344
> Code: be c9 00 00 00 48 c7 c7 20 4a 97 89 c6 05 62 32 a7 0b 01 e8 74 9a 42 07 e9 6a ff ff ff 0f 0b e9 a0 fd ff ff 40 80 e5 3f eb 88 <0f> 0b e9 18 ff ff ff 4c 89 ef 44 89 e6 45 31 ed e8 1e 76 ff ff e9
> RSP: 0018:ffffc90023b87850 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff92004770f0b RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000033 RDI: 0000000000010cc1
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff81bb4686 R11: 0000000000000001 R12: ffffffff902c1960
> R13: 0000000000000033 R14: 0000000000000000 R15: ffff88804cf64a30
> FS:  0000000000000000(0000) GS:ffff88802cd00000(0063) knlGS:00000000f44b4b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000000002c921000 CR3: 000000004f507000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
>  __get_free_pages+0x8/0x40 mm/page_alloc.c:5418
>  raw_cmd_copyin drivers/block/floppy.c:3113 [inline]
>  raw_cmd_ioctl drivers/block/floppy.c:3160 [inline]
>  fd_locked_ioctl+0x12e5/0x2820 drivers/block/floppy.c:3528
>  fd_ioctl drivers/block/floppy.c:3555 [inline]
>  fd_compat_ioctl+0x891/0x1b60 drivers/block/floppy.c:3869
>  compat_blkdev_ioctl+0x3b8/0x810 block/ioctl.c:662
>  __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf6eba549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f44b45fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000258
> RDX: 0000000020000400 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:   03 74 c0 01             add    0x1(%rax,%rax,8),%esi
>    4:   10 05 03 74 b8 01       adc    %al,0x1b87403(%rip)        # 0x1b8740d
>    a:   10 06                   adc    %al,(%rsi)
>    c:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
>   10:   10 07                   adc    %al,(%rdi)
>   12:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
>   16:   10 08                   adc    %cl,(%rax)
>   18:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
>   1c:   00 00                   add    %al,(%rax)
>   1e:   00 00                   add    %al,(%rax)
>   20:   00 51 52                add    %dl,0x52(%rcx)
>   23:   55                      push   %rbp
>   24:   89 e5                   mov    %esp,%ebp
>   26:   0f 34                   sysenter
>   28:   cd 80                   int    $0x80
> * 2a:   5d                      pop    %rbp <-- trapping instruction
>   2b:   5a                      pop    %rdx
>   2c:   59                      pop    %rcx
>   2d:   c3                      retq
>   2e:   90                      nop
>   2f:   90                      nop
>   30:   90                      nop
>   31:   90                      nop
>   32:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>   39:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000ff7d605d0b76901%40google.com.
