Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAB3B8A42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhF3V6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:58:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47096 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhF3V6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:58:36 -0400
Received: by mail-io1-f69.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so2819526ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 14:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8k8N3rm2Flp6RdWwVhwp7SRE7KvVwqZjv7mb8X9ZK70=;
        b=FLK8+2zz+761u4Yw1jLS2I1POMDppJN1A7GBw4TmbggLVbng26Y5e8R1/H5YOH1q04
         xg3Oym+jD9MJ7l3XRYzWukOGPLvMq+/WL1doRNPXq4+NnpvmkI8K+2THmrgDJ9JhsL+4
         jmUAtpOi+QTWVYHK2t1dxjfdaMC60if55Sg++Mz1FSGRax1fZAsSiROFRw92OYRztBGg
         HLYY4wNALRkqB3QYRrIYyxzeRPPq07K85YazQyo3wU532zBIQrwVRK0j0wAJAiuhxLPQ
         eGRGBummobAaBx9T951fYA7hi3/mzFmVXZv8FAWJIi/NwRpDu/2GRzRgi4xpbb9CuOzs
         3V2g==
X-Gm-Message-State: AOAM530rebe0/xdErUGc8aDpySmOxdl57/ReoWAUVX6qTCTZ8/G4kh+U
        xWtZ0w4sijRDGNAY+7VEw9/WigOaTx/QNFAV0T5pSNJ84mcq
X-Google-Smtp-Source: ABdhPJwKJf7GchEgRMGZc9A2mlftTQqK5ALYVq8xhY4Pbw0NubOwQSdWEf+cycuVUgBQcj97lxlWgCglpScoCRnHbahnFyNVkyXF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:: with SMTP id w6mr26317682ill.92.1625090166346;
 Wed, 30 Jun 2021 14:56:06 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:56:06 -0700
In-Reply-To: <20210701003616.7c4c7c9c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017d93605c602cafd@google.com>
Subject: Re: [syzbot] possible deadlock in vmci_qp_broker_detach
From:   syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
To:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hdanton@sina.com, jhansen@vmware.com, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com, vdasa@vmware.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in vmci_ctx_destroy

INFO: task syz-executor.4:4967 blocked for more than 143 seconds.
      Tainted: G        W         5.13.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29136 pid: 4967 ppid:  8823 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xb39/0x5980 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 vmci_ctx_destroy+0x2db/0x3b0 drivers/misc/vmw_vmci/vmci_context.c:197
 vmci_host_close+0xef/0x170 drivers/misc/vmw_vmci/vmci_host.c:144
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
RSP: 002b:00007f4a80452188 EFLAGS: 00000246 ORIG_RAX: 0000000000000124
RAX: 0000000000000005 RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc7a5d942f R14: 00007f4a80452300 R15: 0000000000022000
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 1650 Comm: khungtaskd Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd4b/0xfb0 kernel/hung_task.c:294
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 25 Comm: kworker/u4:1 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy16 ieee80211_iface_work
RIP: 0010:__sanitizer_cov_trace_switch+0xb7/0xf0 kernel/kcov.c:321
Code: 00 48 39 f7 72 1b 48 83 c2 01 48 89 5c 30 e0 48 89 6c 30 e8 4c 89 5c 30 f0 4e 89 4c e8 20 48 89 10 48 83 c1 01 49 39 ca 75 95 <5b> 5d 41 5c 41 5d c3 48 83 f8 40 bb 07 00 00 00 0f 84 6c ff ff ff
RSP: 0018:ffffc90000dff340 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
RDX: 0000000000000000 RSI: ffff888010a2d580 RDI: 0000000000000003
RBP: 00000000000000f4 R08: ffffffff8a896c00 R09: ffffffff887bdca3
R10: 0000000000000020 R11: 00000000000000dd R12: ffff888010a2d580
R13: dffffc0000000000 R14: ffff88802abe2094 R15: ffff88802abe2093
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1f91962000 CR3: 0000000035ae5000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 _ieee802_11_parse_elems_crc+0x1e3/0x1f90 net/mac80211/util.c:1018
 ieee802_11_parse_elems_crc+0x89e/0xfe0 net/mac80211/util.c:1478
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2030 [inline]
 ieee80211_rx_mgmt_probe_beacon+0x17f/0x17b0 net/mac80211/ibss.c:1612
 ieee80211_ibss_rx_queued_mgmt+0xd82/0x15f0 net/mac80211/ibss.c:1642
 ieee80211_iface_work+0x761/0x9e0 net/mac80211/iface.c:1439
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


Tested on:

commit:         44046219 Merge tag 'for-5.14/drivers-2021-06-29' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d99918300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efdd5c8b8b556274
dashboard link: https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149e7918300000

