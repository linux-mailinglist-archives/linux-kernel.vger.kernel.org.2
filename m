Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE433D575
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhCPOGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbhCPOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:05:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A20C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:05:37 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l13so11687917qtu.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5J+gyvPR11CpUcHtxefCCU7xn5fdvKcAAyoiIUwLpU=;
        b=O2BttwNa3lO95Ob22hRtD5rhT/Hurr292UgUi9hmds+xod5J0t4Zbm3jKZusWfKein
         2HcnNXnX0Cki74KHANB7v2S2azsLI86j5Rd27U9Gz0cesJ4EgS3ybyhfly0bhz7ifcX+
         pouC8qmnFCM+F0U7fhdfAOefF3Qw9Z4JjIdC7fry8ZpD85n9QburjRJ9LCTc+OJMfQEG
         jQygFiX/PGQu8yiN0p5xbACzy7jV7vcJI+RnVqaPp0Q3mcinayP/sH9h5uZQsq/SeZwF
         ku29CsP03VKT/nCbFdUzKuXMRLXCupFI/9txJV7vZdnzbysJln5N0GvPof/FFppEttwb
         1c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5J+gyvPR11CpUcHtxefCCU7xn5fdvKcAAyoiIUwLpU=;
        b=NVuq5VQThnUoCDcTwEVXFTftB1KAxRfIKKBzBhkXjy6SYYbL1iiY9dB62BzI/F9Jl/
         JBmaR+BqpLQmOlHCttzVkWnE1fYUjnwCqAvKr7TUWzAgPoaIjmoh2kCjvJ01D76ItFKI
         ZRlABy268ojXqJrBhCgcNS5FgYhCkUT5q/PUgLN/x/CZOp2xxzfAtMqzae9JU3cpSgoQ
         2SjDc+Rpv8y9Fb2EFgnDW6Jv9t/G49ZrZ+7QWFOY6Pmvoo7xrmYpRiVCm1vIN+3HmMNO
         wv7CB1mEUlF0ybjmMRtdr0/tIxswlgr4rLh5BAA5DU8Gd8raSChzT6MlA7xgATap9tUH
         L1/w==
X-Gm-Message-State: AOAM533QBYBvNgxKPR+QSyCgOpMMQF+2RLYvryCJ7OUKyDQxO47nX4lW
        69PWX8wOu6Fx3Bbw7EwSZaDOf1DkwtlXvjm4WUxAoA==
X-Google-Smtp-Source: ABdhPJzR40N8y1AfMvwMfDuWH7CbynqglunnDC3+vtQWgR9MdHv+hsaxsK921Aj4z35MQYck6VlG2ALlIoa+i3rKtYM=
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr5912751qtw.43.1615903536277;
 Tue, 16 Mar 2021 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005ace4405bda4af71@google.com> <CACT4Y+ZJvG+H0Gz9x6cA5qz9=Bf8AdjXaJrQ3GLcwMTj3gPC=Q@mail.gmail.com>
 <CAK8P3a1Ea=NM02jfoWZtV7tbAHbhq7eoP1_SvqcPdRZ49+3dog@mail.gmail.com>
In-Reply-To: <CAK8P3a1Ea=NM02jfoWZtV7tbAHbhq7eoP1_SvqcPdRZ49+3dog@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 15:05:24 +0100
Message-ID: <CACT4Y+YaYihq7uzXCQXhDF6B2vE1vavNLvQ6-eyu+XKmqshtLw@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in video_usercopy (2)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     syzbot <syzbot+142888ffec98ab194028@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 2:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 16, 2021 at 11:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Mar 16, 2021 at 11:18 AM syzbot
> > <syzbot+142888ffec98ab194028@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
>
> This tree seems to be missing fb18802a338b ("media: v4l: ioctl: Fix memory
> leak in video_usercopy"), which rewrote that function partly and might
> fix the problem.

As far as I see the bug happens before any of the code changed by
fb18802a338b is invoked.

> > > Local variable ----sbuf@video_usercopy created at:
> > >  video_usercopy+0xaa/0x3d30 drivers/media/v4l2-core/v4l2-ioctl.c:3285
> > >  video_usercopy+0xaa/0x3d30 drivers/media/v4l2-core/v4l2-ioctl.c:3285
> > > =====================================================
> > > =====================================================
> > > BUG: KMSAN: uninit-value in check_fmt+0x864/0x1070 drivers/media/v4l2-core/v4l2-ioctl.c:963
> > > CPU: 0 PID: 19595 Comm: syz-executor.4 Tainted: G    B             5.11.0-rc7-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:79 [inline]
> > >  dump_stack+0x21c/0x280 lib/dump_stack.c:120
> > >  kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
> > >  __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
> > >  check_fmt+0x864/0x1070 drivers/media/v4l2-core/v4l2-ioctl.c:963
> > >  v4l_prepare_buf+0xbf/0x1d0 drivers/media/v4l2-core/v4l2-ioctl.c:2107
> > >  __video_do_ioctl+0x15cd/0x1d20 drivers/media/v4l2-core/v4l2-ioctl.c:2993
> > >  video_usercopy+0x2313/0x3d30 drivers/media/v4l2-core/v4l2-ioctl.c:3345
> > >  video_ioctl2+0x9f/0xb0 drivers/media/v4l2-core/v4l2-ioctl.c:3391
> > >  v4l2_ioctl+0x255/0x290 drivers/media/v4l2-core/v4l2-dev.c:360
> > >  v4l2_compat_ioctl32+0x2c6/0x370 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1248
> > >  __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
> > >  __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
> > >  __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
> > >  do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
> > >  __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
> > >  do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
> > >  do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
> > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > RIP: 0023:0xf7fec549
> > > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > > RSP: 002b:00000000f55e65fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c050565d
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >
> > > Local variable ----sbuf@video_usercopy created at:
> > >  video_usercopy+0xaa/0x3d30 drivers/media/v4l2-core/v4l2-ioctl.c:3285
> > >  video_usercopy+0xaa/0x3d30 drivers/media/v4l2-core/v4l2-ioctl.c:3285
> > > =====================================================
> >
> > I did not get to the very bottom of this, but I looked at this a bit.
> > It seems to be related to some unfortunate interaction of compat
> > syscall and CONFIG_COMPAT_32BIT_TIME. It seems that in this case
> > nothing at all is copied from userspace because cmd gets messed up or
> > something. Perhaps VIDIOC_QUERYBUF is translated into
> > VIDIOC_QUERYBUF_TIME32 instead of VIDIOC_QUERYBUF32_TIME32 and then
> > this gets into compat syscall path and v4l2_compat_get_user does not
> > recognize the command, copies nothing but returns 0.
>
> User space would be calling VIDIOC_QUERYBUF32_TIME32 here,
> if it's built against glibc, though with a musl based user space, you
> would get called with VIDIOC_QUERYBUF32.
>
> What I notice in get_v4l2_buffer32_time32(), is that we do a full
> copy_from_user() to the stack of this function, and then copy the
> members individually to the output v4l2_buffer structure:
>
>         struct v4l2_buffer32_time32 vb32;
>         if (copy_from_user(&vb32, arg, sizeof(vb32)))
>                 return -EFAULT;
>         *vb = (struct v4l2_buffer) {
>                 .index          = vb32.index,
>                 .type           = vb32.type,
>                 .bytesused      = vb32.bytesused,
>                 .flags          = vb32.flags,
>                 .field          = vb32.field,
>                 .timestamp.tv_sec       = vb32.timestamp.tv_sec,
>                 .timestamp.tv_usec      = vb32.timestamp.tv_usec,
>                 .timecode       = vb32.timecode,
>                 .sequence       = vb32.sequence,
>                 .memory         = vb32.memory,
>                 .m.offset       = vb32.m.offset,
>                 .length         = vb32.length,
>                 .request_fd     = vb32.request_fd,
>         };
>
> This struct assignment will however leave any padding
> fields uninitialized. There is padding between 'field' and
> 'timestamp.  Could that trigger a KMSAN bug?
>
>         Arnd
