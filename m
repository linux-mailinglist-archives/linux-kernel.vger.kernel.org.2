Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF42532BFE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383657AbhCCSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:13:59 -0500
Received: from mail.netline.ch ([148.251.143.178]:53231 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384231AbhCCPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:38:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 9A5EB2A6045;
        Wed,  3 Mar 2021 16:37:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 34ZwQl79IsgD; Wed,  3 Mar 2021 16:37:21 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id E38C22A6042;
        Wed,  3 Mar 2021 16:37:20 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1lHTYs-001za5-F3; Wed, 03 Mar 2021 16:37:18 +0100
To:     syzbot <syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com>,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        glider@google.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
References: <00000000000056cda705bbe93d11@google.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: KMSAN: kernel-infoleak in compat_drm_wait_vblank
Message-ID: <79146a29-a05d-f5b9-e81b-bda1db95b952@daenzer.net>
Date:   Wed, 3 Mar 2021 16:37:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <00000000000056cda705bbe93d11@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-22 10:15 a.m., syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=111e6312d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8e3b38ca92283e
> dashboard link: https://syzkaller.appspot.com/bug?extid=620cf21140fc7e772a5d
> compiler:       Debian clang version 11.0.1-2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
> CPU: 1 PID: 26999 Comm: syz-executor.2 Not tainted 5.11.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0x21c/0x280 lib/dump_stack.c:120
>   kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
>   kmsan_internal_check_memory+0x484/0x520 mm/kmsan/kmsan.c:437
>   kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
>   instrument_copy_to_user include/linux/instrumented.h:121 [inline]
>   _copy_to_user+0x1ac/0x270 lib/usercopy.c:33
>   copy_to_user include/linux/uaccess.h:209 [inline]
>   compat_drm_wait_vblank+0x36f/0x450 drivers/gpu/drm/drm_ioc32.c:866
>   drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
>   __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
>   __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
>   __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
>   do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
>   __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
>   do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
>   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
>   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf7f47549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f55415fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018643a
> RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Uninit was stored to memory at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>   kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>   __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
>   compat_drm_wait_vblank+0x43c/0x450 drivers/gpu/drm/drm_ioc32.c:865
>   drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
>   __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
>   __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
>   __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
>   do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
>   __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
>   do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
>   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
>   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Local variable ----req@compat_drm_wait_vblank created at:
>   compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849
>   compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849
> 
> Bytes 12-15 of 16 are uninitialized
> Memory access of size 16 starts at ffff88814ffe3c98
> Data copied to user address 0000000020000100
> =====================================================

compat_drm_wait_vblank would need to initialize

	req.reply.tval_usec = req32.reply.tval_usec;

before calling drm_ioctl_kernel, since it's not aliased by any req.request.* member, and drm_wait_vblank_ioctl doesn't always write to it.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
