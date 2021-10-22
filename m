Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED8843799F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhJVPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhJVPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:10:10 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8AC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:07:52 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id y145-20020a4a4597000000b002b7d49905acso1206518ooa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoMfgdK37qjGFnYk00ya3OQL9xVUBJpgRRYwx0+5Vro=;
        b=JHOFiG4rd/ZeejLA/Fvm3+hPIDnjFR+o4C4b65P0Al7A6hhFnXdQIEMUdwXHvYkCpX
         tFTMXw1FiMIiuysbbNvvF9VNl72veIL5gVk25U4yn2MqD5Avs+x+4BY1+Qj+1Ad83ROY
         ai+CPTfc5bc45eS51eqNjBLw6RZa4X+2LTAJ7T6YhudHmBocfybJFOF7LjsOCQg+ZV//
         5+113d3ztunynR6AtyesaU0Nqso9QB0lD3Al6/ECDJmq44KF+tU8t72tmazf0yYOx/JH
         tqBMUGwvXag4U109+9YTXJZfgMBMQ2+i2PqV+NmYiUryJ7ijru656drcmFcER8JDxpWr
         m8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoMfgdK37qjGFnYk00ya3OQL9xVUBJpgRRYwx0+5Vro=;
        b=tYysfMKs8VQA3cB0yvuYV621Fgyz0UkFXZa0d6YOJ2nqF0oE6DDIxM6NHcA/KCJuhU
         J0IggjERwUrERxdyGvsz6U0nfUwmMaqcHAPrFPw0rZd1L5mNjwbkqeZQXezunwfSWTO8
         Qn62VVAyeV1Ez5Yh4YF9UPYKu17HI8BIJ8fvgwRAq0wdX9sntxgejkkX6tA02rXaHnBT
         lGwORg9DmCEThwr9PpD29vG3hAKMoS2mhaYBR+teHLFhUou1eIIm9BqsDU1D1SIDcECZ
         9Zk5JIzAO+fdVpdWOlHi8IJivTGDIlOoV/5v/Gm/6QSfQRSxngH2LPcK11EhAzFqnJDK
         6EmA==
X-Gm-Message-State: AOAM530b/W9EJqo4mdpxK0qC+PNDhYMOXRqLbfpDnOl6Izcu34ZFPV+I
        kzebrk9uzo2buDkAVEmbMSADoSwFyk54RZnMH2KSfQ==
X-Google-Smtp-Source: ABdhPJy1F4Rf9LTc/XWo9q23M4iXcRiaC3ed2qiiYZ7yJafE97lNXO5BXzOjh5Xi6BAiSaVpDDp06mH4WRkFxjVanXs=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr458660oot.18.1634915271824;
 Fri, 22 Oct 2021 08:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000062d0fc05cef24c57@google.com>
In-Reply-To: <00000000000062d0fc05cef24c57@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Oct 2021 17:07:40 +0200
Message-ID: <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
To:     syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>,
        Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 at 17:02, syzbot
<syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    64222515138e Merge tag 'drm-fixes-2021-10-22' of git://ano..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=178e86c4b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
> dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com

+Mike, Jordy for secretmem.c

> ------------[ cut here ]------------
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 2 PID: 32193 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> Modules linked in:
> CPU: 2 PID: 32193 Comm: syz-executor.0 Not tainted 5.15.0-rc6-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> Code: 09 31 ff 89 de e8 f7 b9 9b fd 84 db 0f 85 36 ff ff ff e8 3a b2 9b fd 48 c7 c7 c0 65 e3 89 c6 05 6f 6c 7f 09 01 e8 7e 4a 19 05 <0f> 0b e9 17 ff ff ff e8 1b b2 9b fd 0f b6 1d 54 6c 7f 09 31 ff 89
> RSP: 0018:ffffc90009f9ff10 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff815dbf58 RDI: fffff520013f3fd4
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815d5cce R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f476a1e7700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b32c24000 CR3: 00000000494c4000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __refcount_add include/linux/refcount.h:199 [inline]
>  __refcount_inc include/linux/refcount.h:250 [inline]
>  refcount_inc include/linux/refcount.h:267 [inline]
>  __do_sys_memfd_secret mm/secretmem.c:221 [inline]
>  __se_sys_memfd_secret mm/secretmem.c:194 [inline]
>  __x64_sys_memfd_secret+0x182/0x1e0 mm/secretmem.c:194
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f476cc71a39
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f476a1e7188 EFLAGS: 00000246 ORIG_RAX: 00000000000001bf
> RAX: ffffffffffffffda RBX: 00007f476cd74f60 RCX: 00007f476cc71a39
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007f476cccbe8f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc5b5eb85f R14: 00007f476a1e7300 R15: 0000000000022000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000062d0fc05cef24c57%40google.com.
