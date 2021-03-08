Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBE33138A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:36:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:36:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c19so8561137ljn.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IMlSX19wm22uxgx5mawOfCb1g4P2cONAUe+jywdvD64=;
        b=bglBxpGFZ1RlKReecTm2HNIntqsFBo4Aq+JtLOdBYc39PNUM2jLBw0iJiolb/J0WVM
         sUhDpmr7blj/sU/Dj1tYkpC3DlKp7EeUnZJpKtdsuNGhvLoiDa/OJtsKg4NEROASdO4L
         sdR3s3TbGkL3wNBXo71hpNfMBqhs8sHgQ+xrchEH666Sn/5JZMWN/dsEsmTm/ApFtzVa
         mGjOimudHi8e9zEc6HBHd+YvDKNPRhp9ufubJRyXDKd2cxyPfh/1b0cl7e8/YOFl5uCd
         rlXLXiSa5MgLivDplniyM+FpLkjfk0gRsKe6cgbS0sQB7ILvhWWEK6mVEYS0+/29tsTm
         L6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IMlSX19wm22uxgx5mawOfCb1g4P2cONAUe+jywdvD64=;
        b=Jdrq/7dgNc9N6lERHddfKXOpxMjHtNLWGRajVJBKXT23iyLzHaNfbI3IdK0CXSE+rF
         26UqbwtwXT+fhSxFpxHsesLBb1IJaCnaiXadT1H9oDvl8AYFapseOYZLJpd3GhH7lY9n
         bz7B2ITTa7WPi0fHpeQSFKlPTi7cmUor/+Ei0VvurnbZkjKPcuOeljCb1lnKdmGIZKzn
         5yiZP6V2GKOX7BsjlaU4SlrkFdHiE3FYAV1cKhHoj6xtVP42Kuj6+ySC6d0iekVWibVz
         iLS6arkYrg1PsH4lLXr0uZ5XnmRPGSCrUr5+dvwpq+4+Uacn8iRkx1V7OqY+6e14qaEA
         tSGg==
X-Gm-Message-State: AOAM530HkQbEzMdZIKPl/Ze68/q6vYPbHh6NOnOI6sQP+hHBqgmDFtpF
        J/78JMRMyi7Dnvp0iAdzn15DEEwEtXUgR873J2Y=
X-Google-Smtp-Source: ABdhPJzCNrQRcG7fGysskT//4+/lePKAaJ8Qxgh8c6RS+f03l1ctmmutY8mYLGW6BX9aI95ZoH8jhnJeQlOpTO290BY=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr15051583ljw.74.1615221382807;
 Mon, 08 Mar 2021 08:36:22 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Mon, 8 Mar 2021 22:06:10 +0530
Message-ID: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
Subject: kernel panic: Attempted to kill init!
To:     akpm@linux-foundation.org, dave@stgolabs.net,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, rppt@linux.vnet.ibm.com,
        sds@tycho.nsa.gov, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was running syzkaller and I found the following issue :
Head Commit : 27e543cca13fab05689b2d0d61d200a83cfb00b6 ( v5.11.2 )
Git Tree : stable

Console Logs:
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.2 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xb2/0xe4 lib/dump_stack.c:120
 panic+0x196/0x502 kernel/panic.c:231
 do_exit.cold+0x70/0x108 kernel/exit.c:794
 do_group_exit+0x78/0x120 kernel/exit.c:922
 get_signal+0x22e/0xd60 kernel/signal.c:2773
 arch_do_signal_or_restart+0xef/0x890 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x102/0x190 kernel/entry/common.c:201
 irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:307
 irqentry_exit+0x19/0x30 kernel/entry/common.c:395
 exc_page_fault+0xc3/0x240 arch/x86/mm/fault.c:1509
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
RIP: 0033:0x7feb52656f10
Code: Unable to access opcode bytes at RIP 0x7feb52656ee6.
RSP: 002b:00007ffec42704b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00005604dc566f40 RCX: 00007feb526872e3
RDX: 00007ffec4270640 RSI: 00007ffec4270770 RDI: 0000000000000007
RBP: 0000000000000007 R08: 35237084f6f94f9c R09: 0000000000001410
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffec4a6ed00
R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..

Syzkaller reproducer:
# {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1
Slowdown:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 Leak:false
NetInjection:false NetDevices:false NetReset:false Cgroups:false
BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false
VhciInjection:false Wifi:false IEEE802154:false Sysctl:false
UseTmpDir:false HandleSegv:false Repro:false Trace:false}
r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
open_by_handle_at(r0,
&(0x7f0000000000)=ANY=[@ANYBLOB="0a000000020000004b0d"], 0x2f00)


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[1] = {0xffffffffffffffff};

int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  intptr_t res = 0;
  memcpy((void*)0x200001c0, "./file0\000", 8);
  res = syscall(__NR_creat, 0x200001c0ul, 0ul);
  if (res != -1)
    r[0] = res;
  memcpy((void*)0x20000000, "\x0a\x00\x00\x00\x02\x00\x00\x00\x4b\x0d", 10);
  syscall(__NR_open_by_handle_at, r[0], 0x20000000ul, 0x2f00ul);
  return 0;
}

This reproducer only worked on the syzkaller instance disk image that
I was using. I am adding the syzkaller report from a second instance
for the same issue:
Report #2
Syzkaller hit 'kernel panic: Attempted to kill init!' bug.

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 1 PID: 1 Comm: systemd Not tainted 5.11.2 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xb9/0xef lib/dump_stack.c:120
 panic+0x196/0x502 kernel/panic.c:231
 do_exit.cold+0x89/0x113 kernel/exit.c:794
 do_group_exit+0x78/0x120 kernel/exit.c:922
 get_signal+0x230/0xd70 kernel/signal.c:2773
 arch_do_signal_or_restart+0xef/0x890 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x115/0x1a0 kernel/entry/common.c:201
 irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:307
 irqentry_exit+0x19/0x30 kernel/entry/common.c:395
 exc_page_fault+0xc3/0x240 arch/x86/mm/fault.c:1509
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
RIP: 0033:0x7f51a89bc320
Code: Unable to access opcode bytes at RIP 0x7f51a89bc2f6.
RSP: 002b:00007ffca659b7f8 EFLAGS: 00010246
RAX: 00007f51a9de3ee0 RBX: 00007ffca659b8a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00007ffca659b8a0 RDI: 0000000000000011
RBP: 0000000000000007 R08: 0000000000000008 R09: 0000559120f63478
R10: 0000559120f63440 R11: 0000000000000246 R12: 0000559120f63440
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..


Syzkaller reproducer:
# {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1
Slowdown:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 Leak:false
NetInjection:false NetDevices:false NetReset:false Cgroups:false
BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false
VhciInjection:false Wifi:false IEEE802154:false Sysctl:false
UseTmpDir:false HandleSegv:false Repro:false Trace:false}
r0 = creat(&(0x7f0000000040)='./file0\x00', 0x0)
open_by_handle_at(r0,
&(0x7f0000000080)=ANY=[@ANYBLOB="2700000001000000d10b"], 0x2f00)


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[1] = {0xffffffffffffffff};

int main(void)
{
syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
intptr_t res = 0;
memcpy((void*)0x20000040, "./file0\000", 8);
res = syscall(__NR_creat, 0x20000040ul, 0ul);
if (res != -1)
r[0] = res;
memcpy((void*)0x20000080, "\x27\x00\x00\x00\x01\x00\x00\x00\xd1\x0b", 10);
syscall(__NR_open_by_handle_at, r[0], 0x20000080ul, 0x2f00ul);
return 0;
}

If someone wants to trigger this on their syzkaller set-up, try
running the following syzkaller config:
 + enable_syscalls: ["creat","open_by_handle_at"],

A similar issue was also previously reported by syzkaller
https://groups.google.com/g/syzkaller-bugs/c/EFmi5gTSMx8/m/jpt3fMPLAwAJ
which was closed due to the lack of reproducibility.

Kernel build config :
https://gist.github.com/oswalpalash/18e847d6e24e3452bc811526fd6f76bb

Best Regards,
Palash
