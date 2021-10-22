Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E949C437AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhJVQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhJVQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:31:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E717C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:29:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so4991367otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqO6MPhCN+utqzxEcAD0CART5/gTWW83G1fLe9ZWyTk=;
        b=OFETndE6AxxDqK+Q6grtX/SgeWQOvrmYu1J6l32Hychmr0qAVLaseFpxKWyBrcJ+Rc
         AhOObeKmzPifpPfFKBpER5J+HCPgf2/LDrmx0Dngvys6d0TAMF7pQgTx6FN9l1UwSShq
         M9tngBUKblYx679/mwZFUTFrgymgiS9jt3P3rj5dTXcebPdibnRbb4+kaf+KZpF96jEO
         Ui7Y88AQ/TBecak7VKlWAaaSJXs/ECeIHB7jK4UkxnXPE2XlB5WB5WNKR1sLjzuk0Gxh
         MR17UHbHdSk43LPEKElIBUADrm5jqVVXJI3+5nVk7ZOIpTFChxFneFnApsC6RDljP4xb
         awBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqO6MPhCN+utqzxEcAD0CART5/gTWW83G1fLe9ZWyTk=;
        b=AnltvuiNLippIgnHgeA+s8wfO5B0chnH3AIU+GIuR2/cwspMmF1Nx13M857OsYH/18
         L1295hG1qR4b0h7bJpx2B+Lr64flmpMDDdPZQP3/YoJ2N2j/dlqtgVIRbpyqdA+MsQYu
         U2J+tC9pckyTeY4YxF2NXk7sOzosqwjTM1Oy358Yz/HLZ3vMpNJKAdRtKGHaTY1Iqx9A
         RwacdCr0a5EglIf9HK7mluW3VSALGhSc+DJE8Br2rppAWvnV07bAlCEwOiD/++gu5iYD
         3AbLseFXyC2FqFBntQMmgsJaG+33drAJh8vOBpUFgE4oiiB4FVGJBW7BBbP/M/wyYJHv
         0eBg==
X-Gm-Message-State: AOAM531yEO3iVPxlgi+qbcapiN4EF1a8fa4hBmKt3AFE2UctqIduF5bJ
        U7/zpcrvCLJSsvbE8qlhbjyolpabqTkfxJO4oo9ovGovasuNFssN
X-Google-Smtp-Source: ABdhPJzvUCHQv3mCeZeGqaNEg2McyvaXYW5A2wsxyBp7DjeBofgUzMFHiJDa4vtHppumHXVEeTCqjSXQWMwPvCshNzY=
X-Received: by 2002:a05:6830:2905:: with SMTP id z5mr717899otu.137.1634920157232;
 Fri, 22 Oct 2021 09:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000062d0fc05cef24c57@google.com> <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <1491925661.1465925.1634919941738@privateemail.com>
In-Reply-To: <1491925661.1465925.1634919941738@privateemail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Oct 2021 18:29:05 +0200
Message-ID: <CACT4Y+bRDjZ=p_HCZK3odrjSfFa5LL8aeO8TpS_3DgY4w-7+=Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 at 18:25, Jordy Zomer <jordy@pwning.systems> wrote:
>
> After a quick scan, it appears to be a false-positive.
>
> This because nothing appears to be being freed.
>
> In any case, you probably don't want warnings everywhere.
>
> I believe we should probably do something along the lines of:
>
> if (refcount_read(&secretmem_users) == 0) {
>     refcount_set(&secretmem_users, 1);
> } else {
>     refcount_inc(&secretmem_users);
> }
>
> Does this appear to be a feasible patch? :)

I don't think multithreading work this way :)
Imagine 2 threads reading refcount_read(&secretmem_users) == 0 and
then both doing refcount_set(&secretmem_users, 1).

> Best Regards,
>
> Jordy
>
> > On 10/22/2021 11:07 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> >
> > On Fri, 22 Oct 2021 at 17:02, syzbot
> > <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    64222515138e Merge tag 'drm-fixes-2021-10-22' of git://ano..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=178e86c4b00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com
> >
> > +Mike, Jordy for secretmem.c
> >
> > > ------------[ cut here ]------------
> > > refcount_t: addition on 0; use-after-free.
> > > WARNING: CPU: 2 PID: 32193 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> > > Modules linked in:
> > > CPU: 2 PID: 32193 Comm: syz-executor.0 Not tainted 5.15.0-rc6-syzkaller #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > > RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> > > Code: 09 31 ff 89 de e8 f7 b9 9b fd 84 db 0f 85 36 ff ff ff e8 3a b2 9b fd 48 c7 c7 c0 65 e3 89 c6 05 6f 6c 7f 09 01 e8 7e 4a 19 05 <0f> 0b e9 17 ff ff ff e8 1b b2 9b fd 0f b6 1d 54 6c 7f 09 31 ff 89
> > > RSP: 0018:ffffc90009f9ff10 EFLAGS: 00010286
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > RDX: 0000000000040000 RSI: ffffffff815dbf58 RDI: fffff520013f3fd4
> > > RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
> > > R10: ffffffff815d5cce R11: 0000000000000000 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > FS:  00007f476a1e7700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b32c24000 CR3: 00000000494c4000 CR4: 0000000000150ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  __refcount_add include/linux/refcount.h:199 [inline]
> > >  __refcount_inc include/linux/refcount.h:250 [inline]
> > >  refcount_inc include/linux/refcount.h:267 [inline]
> > >  __do_sys_memfd_secret mm/secretmem.c:221 [inline]
> > >  __se_sys_memfd_secret mm/secretmem.c:194 [inline]
> > >  __x64_sys_memfd_secret+0x182/0x1e0 mm/secretmem.c:194
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > RIP: 0033:0x7f476cc71a39
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f476a1e7188 EFLAGS: 00000246 ORIG_RAX: 00000000000001bf
> > > RAX: ffffffffffffffda RBX: 00007f476cd74f60 RCX: 00007f476cc71a39
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 00007f476cccbe8f R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007ffc5b5eb85f R14: 00007f476a1e7300 R15: 0000000000022000
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000062d0fc05cef24c57%40google.com.
