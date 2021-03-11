Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3424337329
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhCKM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhCKM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:56:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l11so1748934wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0Un3tuFjczC1lxj+SCx66+iOtdLG9xhWBFonYOo1aWg=;
        b=IDMDv1gB3BCLpnTA5cMHxhqPselTXXeezm9MM0pC75U4c+nCsSmjVOF3mg3zgscPNI
         WrQ/MzDDVR5B/WDq0SuTtN1uVtbhq+xhpZiX92aoF86cQoy0a1zK4EfGkagqDgisiFR0
         CFmjJ74xvfWWNYUzGi7xheXhpvxpj7sGySsxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0Un3tuFjczC1lxj+SCx66+iOtdLG9xhWBFonYOo1aWg=;
        b=QMoWRPseT0lMGt6bCkdGBsEp+PocNoEoutILWWg3EjENMoWXFk6NLTOKpQNY0BKGy4
         ZtNBlAYZ/pH4X32ZjjXxXMjTR5MBOs/Ul3wfGuBQsZcp4WVvbvmka/PKeaXK3mO+wRym
         Vi8cv6esbu1knAIQxgP3XDUeZAscvGfLMAP3znkWY1EhS2K6UaWXHB5J3wFqLQ7BXHx+
         MMmLLJfWjxZ9IwCyj+Mr8sSGuxxFFhRx8BGLl+qhK+QpVTDHb9KtESzO2m+JFQ6oFZzu
         dqZOJAwR7n1kKlkcwUOObE7D736p0m/NBXpDAYWPTXAAZmCh05e3cvwhhVPHdPZPnc6K
         mn0g==
X-Gm-Message-State: AOAM533JEAJdfEif3My+c4IEFPfqszgFclI+Z+gNFzDu0JQlCi+Gafwg
        zWuah7a1Mgh1+jR9ugERv1EpTw==
X-Google-Smtp-Source: ABdhPJxGZhIUMOuTfzea6wtxz2oH95KxpoGxZsC2TvkbN8VtWi9mOv4KYiKI17nxSlbReZSj5ZLvgg==
X-Received: by 2002:a5d:6205:: with SMTP id y5mr8541064wru.238.1615467361317;
        Thu, 11 Mar 2021 04:56:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p18sm4697974wro.18.2021.03.11.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:56:00 -0800 (PST)
Date:   Thu, 11 Mar 2021 13:55:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     syzbot <syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com>,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        glider@google.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Subject: Re: KMSAN: kernel-infoleak in compat_drm_wait_vblank
Message-ID: <YEoTXp1fQ3XhxOV9@phenom.ffwll.local>
Mail-Followup-To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        syzbot <syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        glider@google.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
References: <00000000000056cda705bbe93d11@google.com>
 <79146a29-a05d-f5b9-e81b-bda1db95b952@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79146a29-a05d-f5b9-e81b-bda1db95b952@daenzer.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:37:18PM +0100, Michel Dänzer wrote:
> On 2021-02-22 10:15 a.m., syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=111e6312d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8e3b38ca92283e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=620cf21140fc7e772a5d
> > compiler:       Debian clang version 11.0.1-2
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com
> > 
> > =====================================================
> > BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
> > CPU: 1 PID: 26999 Comm: syz-executor.2 Not tainted 5.11.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:79 [inline]
> >   dump_stack+0x21c/0x280 lib/dump_stack.c:120
> >   kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
> >   kmsan_internal_check_memory+0x484/0x520 mm/kmsan/kmsan.c:437
> >   kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
> >   instrument_copy_to_user include/linux/instrumented.h:121 [inline]
> >   _copy_to_user+0x1ac/0x270 lib/usercopy.c:33
> >   copy_to_user include/linux/uaccess.h:209 [inline]
> >   compat_drm_wait_vblank+0x36f/0x450 drivers/gpu/drm/drm_ioc32.c:866
> >   drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
> >   __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
> >   __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
> >   __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
> >   do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
> >   __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
> >   do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
> >   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
> >   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > RIP: 0023:0xf7f47549
> > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > RSP: 002b:00000000f55415fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018643a
> > RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > 
> > Uninit was stored to memory at:
> >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
> >   kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
> >   __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
> >   compat_drm_wait_vblank+0x43c/0x450 drivers/gpu/drm/drm_ioc32.c:865
> >   drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
> >   __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
> >   __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
> >   __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
> >   do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
> >   __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
> >   do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
> >   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
> >   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > 
> > Local variable ----req@compat_drm_wait_vblank created at:
> >   compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849
> >   compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849
> > 
> > Bytes 12-15 of 16 are uninitialized
> > Memory access of size 16 starts at ffff88814ffe3c98
> > Data copied to user address 0000000020000100
> > =====================================================
> 
> compat_drm_wait_vblank would need to initialize
> 
> 	req.reply.tval_usec = req32.reply.tval_usec;
> 
> before calling drm_ioctl_kernel, since it's not aliased by any
> req.request.* member, and drm_wait_vblank_ioctl doesn't always write to
> it.

I've fixed this in

commit e926c474ebee404441c838d18224cd6f246a71b7
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon Feb 22 11:06:43 2021 +0100

    drm/compat: Clear bounce structures

Or at least tried to.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
