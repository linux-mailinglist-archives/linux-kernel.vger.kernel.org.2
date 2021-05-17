Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68B83823FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhEQGNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhEQGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:13:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA1C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:12:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id eb9so2566176qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK1oSAJYJrbzJScH6Ky3RLP1dEb180U5ObnJRYek8GU=;
        b=RWn//CLRC41W/y4oknYfIuouTCLXrwCiH43n9+iSpXV2fafQ3YLFngw9Ii5jSTCq1x
         kqTswpoQpxOudbdzVJxi+9O+IdicQpMIEsKxHu+YZDDiaxBb504DdzvIwXcZRSz60ev7
         kqVs4w89GJV+mMHPcqKOXav77LbimwSK+ksNLGLj4kjBoiebH01K+xrFfz1m9RDhsdxW
         nSQxj+/jaIqrQ+RMG6W70Za4YMeORMjLicSWBPcnf0rBFQOC5FXDJlAnkVS3mP2p5jH7
         PGTrCsRWH3WLf0xzO1tTgcZVmhP/V5hyybcs1TRxzcmvDVQgc+zfFO8RwRKYWa6eL2SP
         pHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK1oSAJYJrbzJScH6Ky3RLP1dEb180U5ObnJRYek8GU=;
        b=FWp5mcjb1zFV8Ee1xQ+aSNfiTGOoB8o9+gF6aQ14YdtF3Rnam7mRe0bk9PQ4h/4z30
         a5FObqS/p9ECMhCkbRpo0LaqHT+LUhxhMpGvxQBLZQuM+j5A31l8d7hy4t9il0Bi36HL
         zAnXbQ5tAk6mCogrs5zfEworjV/9Cz4M7gQmJD9mqgmwt0BMUu8wgmv+A42uXUENWYu2
         YdovV9buMMSDKCpV624lep0/y4+OkGbmbawb3G7w978dFUNe4pXdX35K6gx8AMqKP8dR
         oFOvLeSVIqbSDyQ0kY0yiNfZKsk7kCPrCtyI10/aB5/Hq2OgxSKobmT3OvZ827Jd/sb8
         88GQ==
X-Gm-Message-State: AOAM531xcMoHH103zvOiYuLXdosUt2LONOqs8E0nE83MO6py02NW+Iz/
        OxDp/4hOQBuycKvEDlQhoHllKzaUARf8rWz29LkrDg==
X-Google-Smtp-Source: ABdhPJyqwE0As9NDqAdHIO4Gr5fcdwM+4h59RTK5tj4A4nfInGjmLnwkDf0Ng+wY0Q8mjmJXibLM2O2RDNS9bjaSWfQ=
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr18066027qvb.13.1621231942491;
 Sun, 16 May 2021 23:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009653db05c1656b9b@google.com>
In-Reply-To: <0000000000009653db05c1656b9b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 08:12:11 +0200
Message-ID: <CACT4Y+a_J96M1HvKKq1AweGT_8nxkK+AuVP=YXCD3k8Das=ekA@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in kernfs_iop_getattr
To:     syzbot <syzbot+c26b2cb5301be7de9efc@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 6:30 AM syzbot
<syzbot+c26b2cb5301be7de9efc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d72cd4ad Merge tag 'scsi-misc' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123fbb85d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
> dashboard link: https://syzkaller.appspot.com/bug?extid=c26b2cb5301be7de9efc
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c26b2cb5301be7de9efc@syzkaller.appspotmail.com

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives

> =============================
> WARNING: suspicious RCU usage
> 5.12.0-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by systemd-udevd/4826.
>
> stack backtrace:
> CPU: 1 PID: 4826 Comm: systemd-udevd Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  ___might_sleep+0x114/0x6b0 kernel/sched/core.c:8304
>  __mutex_lock_common+0xce/0x2e50 kernel/locking/mutex.c:928
>  __mutex_lock kernel/locking/mutex.c:1096 [inline]
>  mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1111
>  kernfs_iop_getattr+0x89/0x310 fs/kernfs/inode.c:194
>  vfs_getattr fs/stat.c:134 [inline]
>  vfs_statx+0x1ba/0x3d0 fs/stat.c:199
>  vfs_fstatat fs/stat.c:217 [inline]
>  vfs_lstat include/linux/fs.h:3384 [inline]
>  __do_sys_newlstat fs/stat.c:372 [inline]
>  __se_sys_newlstat fs/stat.c:366 [inline]
>  __x64_sys_newlstat+0xd3/0x150 fs/stat.c:366
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f41b6750335
> Code: 69 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 31 db 2b 00 f7 d8 64 89
> RSP: 002b:00007ffe4d8d3b08 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000006
> RAX: ffffffffffffffda RBX: 00005601243f1120 RCX: 00007f41b6750335
> RDX: 00007ffe4d8d3b40 RSI: 00007ffe4d8d3b40 RDI: 00005601243f0120
> RBP: 00007ffe4d8d3c00 R08: 00007f41b6a0f228 R09: 0000000000001010
> R10: 00007f41b6a0eb58 R11: 0000000000000246 R12: 00005601243f0120
> R13: 00005601243f0134 R14: 000056012440253d R15: 0000560124402544
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009653db05c1656b9b%40google.com.
