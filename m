Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4F3F4E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHWQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhHWQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D976F613D1;
        Mon, 23 Aug 2021 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629735646;
        bh=eFuViCuZ/4QXRqa53lnEIrBPuDIOWIQS2Xsbe0RscQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cY9IeYZRpOiQxny89tiyXjd9lRW0Bu3I3WOrMUUcai0igx/AgvQJAWe6R2Epro7PI
         zmHIAAQ2D3SvfpHtHUfYRG/TDmyb7kSqYldP61PQSjKctioFni1KwIcWjOcSm4CGjs
         gnXe+G069s2tFgT4vQOSdFUwj6Xedic17CwMHKuzNwoN7vmzgYD93FDFLgEEkEKK8j
         WhucA/61LCmedS+q5My6WJeiIU85Pctv4LheZslSk8rDbq525h1YPGd3/oJ2uFgd+z
         +AIRR02ca3eRmo15HZBdLzl2+q23XR/7WyP6a2DqsqzFP3OfRuLqkX0ULWYSRnk4oE
         /5xOXBiVi0Dwg==
Date:   Mon, 23 Aug 2021 18:20:43 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com>,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in dec_rlimit_ucounts
Message-ID: <20210823162043.vh7j2yqu6lknbprp@example.org>
References: <000000000000f2d84305c74bb986@google.com>
 <000000000000b1f4d305c9ef72ad@google.com>
 <20210820100916.oyjwyteskvbxwyvg@example.org>
 <878s0wtem7.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s0wtem7.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 08:44:32AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
> > On Thu, Aug 19, 2021 at 01:32:22PM -0700, syzbot wrote:
> >> syzbot has found a reproducer for the following issue on:
> >> 
> >> HEAD commit:    d6d09a694205 Merge tag 'for-5.14-rc6-tag' of git://git.ker..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16c8081e300000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=01985d7909f9468f013c
> >> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d0ec1e300000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1516c341300000
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com
> >> 
> >> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000004ca4cc
> >> RBP: 00000000004ca4c0 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004ca4cc
> >> R13: 00007fffffe0b62f R14: 00007f1054173400 R15: 0000000000022000
> >> ==================================================================
> >> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >> BUG: KASAN: use-after-free in atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
> >> BUG: KASAN: use-after-free in atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
> >> BUG: KASAN: use-after-free in dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:279
> >> Write of size 8 at addr ffff888025b8ef80 by task syz-executor668/8707
> >> 
> >> CPU: 1 PID: 8707 Comm: syz-executor668 Not tainted 5.14.0-rc6-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:88 [inline]
> >>  dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
> >>  print_address_description+0x66/0x3b0 mm/kasan/report.c:233
> >>  __kasan_report mm/kasan/report.c:419 [inline]
> >>  kasan_report+0x163/0x210 mm/kasan/report.c:436
> >>  check_region_inline mm/kasan/generic.c:135 [inline]
> >>  kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
> >>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >>  atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
> >>  atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
> >>  dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:279
> >>  release_task+0x2d3/0x1590 kernel/exit.c:191
> >
> > void release_task(struct task_struct *p)
> > {
> > ...
> > 	/* don't need to get the RCU readlock here - the process is dead and
> > 	 * can't be modifying its own credentials. But shut RCU-lockdep up */
> > 	rcu_read_lock();
> > 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> > 	rcu_read_unlock();
> > ...
> > }
> >
> > It looks like the ucounts have been released before this in the put_cred_rcu().
> 
> That should not be.
> 
> After that in release_task there is:
> 
> put_task_struct_rcu_user
>   delayed_put_task_struct
>      put_task_struct
>         __put_task_struct
>            exit_creds
>               put_cred
>                  __put_cred
>                     put_cred_rcu
>                        put_ucounts
> 
> So there very much should be a valid cred reference at that point.

I found the problem. This is a different problem and the fact that
syzkaller combined them in one thread misled me.

-- 
Rgrds, legion

